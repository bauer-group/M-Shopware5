# Check status of repository and all submodules (Windows PowerShell)

# Get repository name from git remote
try {
    $remoteUrl = git config --get remote.origin.url
    $repoName = [System.IO.Path]::GetFileNameWithoutExtension($remoteUrl)
} catch {
    $repoName = "Repository"
}

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "$repoName Status" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan

# Get current branch
$currentBranch = git branch --show-current

# Main repository status
Write-Host ""
Write-Host "Main Repository:" -ForegroundColor Cyan
Write-Host "Branch: $currentBranch"
git status --short

# Check if main repo is behind
$behind = git rev-list HEAD..origin/$currentBranch --count 2>$null
if ($behind -gt 0) {
    Write-Host "Your branch is behind by $behind commit(s)" -ForegroundColor Yellow
}

# Submodule status
Write-Host ""
Write-Host "Submodules:" -ForegroundColor Cyan

$cleanCount = 0
$dirtyCount = 0

git submodule foreach --quiet 'git status --porcelain' | Out-String -Stream | ForEach-Object {
    $line = $_.Trim()
    if ($line -match "^Entering '(.+)'$") {
        $currentSubmodule = $matches[1]
        $submoduleBranch = git -C $currentSubmodule branch --show-current

        # Check if this submodule has changes
        $hasChanges = git -C $currentSubmodule status --porcelain

        if ([string]::IsNullOrWhiteSpace($hasChanges)) {
            Write-Host "[OK] $currentSubmodule ($submoduleBranch)" -ForegroundColor Green
            $cleanCount++
        } else {
            Write-Host "[!] $currentSubmodule ($submoduleBranch) - uncommitted changes" -ForegroundColor Yellow
            git -C $currentSubmodule status --short | ForEach-Object { Write-Host "  $_" }
            $dirtyCount++
        }
    }
}

# Summary
Write-Host ""
Write-Host "=========================================" -ForegroundColor Cyan
if ($dirtyCount -eq 0) {
    Write-Host "All submodules are clean" -ForegroundColor Green
} else {
    Write-Host "$dirtyCount submodule(s) with uncommitted changes" -ForegroundColor Yellow
}
Write-Host "=========================================" -ForegroundColor Cyan
