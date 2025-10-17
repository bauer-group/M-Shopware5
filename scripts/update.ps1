# Update repository and all submodules (Windows PowerShell)
# Supports Git LFS

$ErrorActionPreference = "Stop"

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "Updating X-Shopware5 Repository" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan

# Check if git lfs is installed
$gitLfsInstalled = $false
try {
    git lfs version | Out-Null
    $gitLfsInstalled = $true
    Write-Host "Git LFS detected" -ForegroundColor Green
} catch {
    Write-Host "Warning: Git LFS is not installed. LFS files will not be updated." -ForegroundColor Yellow
    Write-Host "Install Git LFS from: https://git-lfs.github.com/" -ForegroundColor Yellow
}

# Get current branch
$currentBranch = git branch --show-current

# Update main repository
Write-Host ""
Write-Host "Step 1/3: Pulling main repository..." -ForegroundColor White
git pull origin $currentBranch

# Fetch all submodule updates
Write-Host ""
Write-Host "Step 2/3: Fetching all submodule updates..." -ForegroundColor White
git submodule update --init --recursive --remote

# Pull LFS files
Write-Host ""
Write-Host "Step 3/3: Updating LFS files..." -ForegroundColor White
if ($gitLfsInstalled) {
    git lfs pull
    git submodule foreach --recursive 'git lfs pull || exit 0'
}

Write-Host ""
Write-Host "=========================================" -ForegroundColor Green
Write-Host "Update completed successfully!" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Green
