#!/bin/bash
# Clone X-Shopware5 repository with all submodules (Linux/Mac)
# Supports Git LFS

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

REPO_URL="${1}"
TARGET_DIR="${2}"

# Validate repository URL
if [ -z "$REPO_URL" ]; then
    echo -e "${RED}Error: Repository URL is required${NC}"
    echo "Usage: $0 <repository-url> [target-directory]"
    echo "Example: $0 https://github.com/user/repo.git my-folder"
    exit 1
fi

# Extract repo name from URL for default directory
REPO_NAME=$(basename -s .git "$REPO_URL")
TARGET_DIR="${TARGET_DIR:-$REPO_NAME}"

echo -e "${CYAN}=========================================${NC}"
echo -e "${CYAN}Cloning $REPO_NAME${NC}"
echo -e "${CYAN}=========================================${NC}"

# Check if git lfs is installed
if ! command -v git-lfs &> /dev/null; then
    echo -e "${YELLOW}Warning: Git LFS is not installed. LFS files will not be downloaded.${NC}"
    echo "Install Git LFS from: https://git-lfs.github.com/"
else
    echo -e "${GREEN}Git LFS detected${NC}"
fi

# Clone repository
echo ""
echo "Step 1/3: Cloning main repository to $TARGET_DIR..."
git clone "$REPO_URL" "$TARGET_DIR"

cd "$TARGET_DIR"

# Initialize and update submodules
echo ""
echo "Step 2/3: Initializing and updating all submodules..."
echo "This may take a while as there are many submodules..."
git submodule update --init --recursive --jobs 4

# Pull LFS files
echo ""
echo "Step 3/3: Downloading LFS files..."
if command -v git-lfs &> /dev/null; then
    git lfs pull
    git submodule foreach --recursive 'git lfs pull || true'
fi

echo ""
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}Clone completed successfully!${NC}"
echo -e "${GREEN}Location: $(pwd)${NC}"
echo -e "${GREEN}=========================================${NC}"
