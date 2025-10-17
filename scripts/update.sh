#!/bin/bash
# Update repository and all submodules (Linux/Mac)
# Supports Git LFS

set -e

echo "========================================="
echo "Updating X-Shopware5 Repository"
echo "========================================="

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if git lfs is installed
if ! command -v git-lfs &> /dev/null; then
    echo -e "${YELLOW}Warning: Git LFS is not installed. LFS files will not be updated.${NC}"
    echo "Install Git LFS from: https://git-lfs.github.com/"
else
    echo -e "${GREEN}Git LFS detected${NC}"
fi

# Update main repository
echo ""
echo "Step 1/3: Pulling main repository..."
git pull origin $(git branch --show-current)

# Fetch all submodule updates
echo ""
echo "Step 2/3: Fetching all submodule updates..."
git submodule update --init --recursive --remote

# Pull LFS files
echo ""
echo "Step 3/3: Updating LFS files..."
if command -v git-lfs &> /dev/null; then
    git lfs pull
    git submodule foreach --recursive 'git lfs pull || true'
fi

echo ""
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}Update completed successfully!${NC}"
echo -e "${GREEN}=========================================${NC}"
