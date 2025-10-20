# Push changes to repository and all modified submodules (Windows PowerShell)

param(
    [Parameter(Position=0)]
    [string]$CommitMessage
)

$ErrorActionPreference = "Stop"

# Get repository name from git remote
try {
    $remoteUrl = git config --get remote.origin.url
    $repoName = [System.IO.Path]::GetFileNameWithoutExtension($remoteUrl)
} catch {
    $repoName = "Repository"
}

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "Pushing $repoName Changes" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan

# Get commit message
if ([string]::IsNullOrWhiteSpace($CommitMessage)) {
    Write-Host "No commit message provided." -ForegroundColor Yellow
    $CommitMessage = Read-Host "Enter commit message"
}

if ([string]::IsNullOrWhiteSpace($CommitMessage)) {
    Write-Host "Error: Commit message cannot be empty" -ForegroundColor Red
    exit 1
}

# Get current branch
$currentBranch = git branch --show-current

# Get all submodules
Write-Host ""
Write-Host "Step 1/4: Checking for submodule changes..." -ForegroundColor White

$submodules = git submodule status | ForEach-Object {
    if ($_ -match '^\s*[+-]?[0-9a-f]+\s+(.+?)\s+') {
        $matches[1]
    }
}

# Process each submodule
Write-Host ""
Write-Host "Step 2/4: Committing and pushing submodule changes..." -ForegroundColor White
$processedCount = 0
$updatedSubmodules = @()

foreach ($submodule in $submodules) {
    $status = git -C $submodule status --porcelain 2>$null

    if (-not [string]::IsNullOrWhiteSpace($status)) {
        Write-Host "Processing submodule: $submodule" -ForegroundColor Yellow

        # Get current branch
        $submoduleBranch = git -C $submodule branch --show-current 2>$null

        # If in detached HEAD state, try to checkout main branch
        if ([string]::IsNullOrWhiteSpace($submoduleBranch)) {
            Write-Host "  Submodule is in detached HEAD state, attempting to checkout main branch..." -ForegroundColor Yellow

            # Try to find the default branch
            $defaultBranch = git -C $submodule symbolic-ref refs/remotes/origin/HEAD 2>$null | ForEach-Object { $_ -replace 'refs/remotes/origin/', '' }

            if ([string]::IsNullOrWhiteSpace($defaultBranch)) {
                # Fallback: try common branch names
                $defaultBranch = "main"
                $branchExists = git -C $submodule rev-parse --verify $defaultBranch 2>$null
                if (-not $branchExists) {
                    $defaultBranch = "master"
                }
            }

            git -C $submodule checkout $defaultBranch 2>$null
            $submoduleBranch = git -C $submodule branch --show-current 2>$null

            if ([string]::IsNullOrWhiteSpace($submoduleBranch)) {
                Write-Host "  Error: Could not checkout a branch, skipping push" -ForegroundColor Red
                continue
            }

            Write-Host "  Checked out branch: $submoduleBranch" -ForegroundColor Green
        }

        # Add all changes
        git -C $submodule add -A

        # Commit changes
        git -C $submodule commit -m $CommitMessage 2>&1 | Out-Null

        # Push changes
        git -C $submodule push origin $submoduleBranch
        $processedCount++
        $updatedSubmodules += $submodule

        Write-Host "  Committed and pushed successfully" -ForegroundColor Green
    }
}

if ($processedCount -eq 0) {
    Write-Host "No submodule changes to push" -ForegroundColor Gray
} else {
    Write-Host "Pushed changes to $processedCount submodule(s)" -ForegroundColor Green

    # Update submodule references in main repository
    Write-Host ""
    Write-Host "Updating submodule references in main repository..." -ForegroundColor Cyan
    foreach ($submodule in $updatedSubmodules) {
        # Stage the updated submodule reference
        git add $submodule
        Write-Host "  Updated reference for: $submodule" -ForegroundColor Green
    }
}

# Update main repository submodule references
Write-Host ""
Write-Host "Step 3/4: Committing main repository changes..." -ForegroundColor White
git add -A
git diff --staged --quiet
if ($LASTEXITCODE -ne 0) {
    git commit -m $CommitMessage
} else {
    Write-Host "No changes to commit in main repository" -ForegroundColor Gray
}

# Push main repository
Write-Host ""
Write-Host "Step 4/4: Pushing main repository..." -ForegroundColor White
git push origin $currentBranch

Write-Host ""
Write-Host "=========================================" -ForegroundColor Green
Write-Host "Push completed successfully!" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Green
