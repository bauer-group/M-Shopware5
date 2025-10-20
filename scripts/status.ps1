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

# Get all submodules
$submodules = git submodule status | ForEach-Object {
    if ($_ -match '^\s*[+-]?[0-9a-f]+\s+(.+?)\s+') {
        $matches[1]
    }
}

foreach ($submodule in $submodules) {
    # Get branch name
    $submoduleBranch = git -C $submodule branch --show-current 2>$null
    if ([string]::IsNullOrWhiteSpace($submoduleBranch)) {
        $submoduleBranch = "detached HEAD"
    }

    # Check if this submodule has changes
    $hasChanges = git -C $submodule status --porcelain 2>$null

    if ([string]::IsNullOrWhiteSpace($hasChanges)) {
        Write-Host "[OK] $submodule ($submoduleBranch)" -ForegroundColor Green
        $cleanCount++
    } else {
        Write-Host "[!] $submodule ($submoduleBranch) - uncommitted changes" -ForegroundColor Yellow
        git -C $submodule status --short | ForEach-Object { Write-Host "  $_" }
        $dirtyCount++
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
