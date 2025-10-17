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

# Check for changes in submodules
Write-Host ""
Write-Host "Step 1/4: Checking for submodule changes..." -ForegroundColor White
$hasSubmoduleChanges = $false
git submodule foreach --quiet 'git status --porcelain' | ForEach-Object {
    if ($_.Trim()) {
        $hasSubmoduleChanges = $true
    }
}

# Commit and push submodules if there are changes
if ($hasSubmoduleChanges) {
    Write-Host ""
    Write-Host "Step 2/4: Committing and pushing submodule changes..." -ForegroundColor White
    git submodule foreach "
        `$status = git status --porcelain
        if (`$status) {
            Write-Host 'Processing submodule:' `$name
            git add -A
            git commit -m '$CommitMessage' 2>`$null
            git push origin `$(git branch --show-current)
        }
    "
} else {
    Write-Host ""
    Write-Host "Step 2/4: No submodule changes to push" -ForegroundColor White
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
