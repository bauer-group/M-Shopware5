# Clone a repository with all submodules (Windows PowerShell)
# Supports Git LFS

param(
    [Parameter(Position=0, Mandatory=$true)]
    [string]$RepoUrl,

    [Parameter(Position=1)]
    [string]$TargetDir
)

$ErrorActionPreference = "Stop"

# Validate repository URL
if ([string]::IsNullOrWhiteSpace($RepoUrl)) {
    Write-Host "Error: Repository URL is required" -ForegroundColor Red
    Write-Host "Usage: .\clone.ps1 <repository-url> [target-directory]"
    Write-Host "Example: .\clone.ps1 https://github.com/user/repo.git my-folder"
    exit 1
}

# Extract repo name from URL for default directory
$repoName = [System.IO.Path]::GetFileNameWithoutExtension($RepoUrl)
if ([string]::IsNullOrWhiteSpace($TargetDir)) {
    $TargetDir = $repoName
}

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "Cloning $repoName" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan

# Check if git lfs is installed
$gitLfsInstalled = $false
try {
    git lfs version | Out-Null
    $gitLfsInstalled = $true
    Write-Host "Git LFS detected" -ForegroundColor Green
} catch {
    Write-Host "Warning: Git LFS is not installed. LFS files will not be downloaded." -ForegroundColor Yellow
    Write-Host "Install Git LFS from: https://git-lfs.github.com/" -ForegroundColor Yellow
}

# Clone repository
Write-Host ""
Write-Host "Step 1/3: Cloning main repository to $TargetDir..." -ForegroundColor White
git clone $RepoUrl $TargetDir

Set-Location $TargetDir

# Initialize and update submodules
Write-Host ""
Write-Host "Step 2/3: Initializing and updating all submodules..." -ForegroundColor White
Write-Host "This may take a while as there are many submodules..." -ForegroundColor Gray
git submodule update --init --recursive --jobs 4

# Pull LFS files
Write-Host ""
Write-Host "Step 3/3: Downloading LFS files..." -ForegroundColor White
if ($gitLfsInstalled) {
    git lfs pull
    git submodule foreach --recursive 'git lfs pull || exit 0'
}

Write-Host ""
Write-Host "=========================================" -ForegroundColor Green
Write-Host "Clone completed successfully!" -ForegroundColor Green
Write-Host "Location: $(Get-Location)" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Green
