#!/bin/bash
# Push changes to repository and all modified submodules (Linux/Mac)

set -e

echo "========================================="
echo "Pushing X-Shopware5 Repository Changes"
echo "========================================="

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Get commit message from argument or prompt
COMMIT_MSG="$1"
if [ -z "$COMMIT_MSG" ]; then
    echo -e "${YELLOW}No commit message provided.${NC}"
    echo -n "Enter commit message: "
    read COMMIT_MSG
fi

if [ -z "$COMMIT_MSG" ]; then
    echo -e "${RED}Error: Commit message cannot be empty${NC}"
    exit 1
fi

# Check for changes in submodules
echo ""
echo "Step 1/4: Checking for submodule changes..."
SUBMODULE_CHANGES=false
git submodule foreach --quiet '
    if [ -n "$(git status --porcelain)" ]; then
        echo "Changes detected in: $name"
        exit 1
    fi
' && echo "No uncommitted changes in submodules" || SUBMODULE_CHANGES=true

# Commit and push submodules if there are changes
if [ "$SUBMODULE_CHANGES" = true ]; then
    echo ""
    echo "Step 2/4: Committing and pushing submodule changes..."
    git submodule foreach '
        if [ -n "$(git status --porcelain)" ]; then
            echo "Processing submodule: $name"
            git add -A
            git commit -m "'"$COMMIT_MSG"'" || true
            git push origin $(git branch --show-current)
        fi
    '
else
    echo ""
    echo "Step 2/4: No submodule changes to push"
fi

# Update main repository submodule references
echo ""
echo "Step 3/4: Committing main repository changes..."
git add -A
if git diff --staged --quiet; then
    echo "No changes to commit in main repository"
else
    git commit -m "$COMMIT_MSG"
fi

# Push main repository
echo ""
echo "Step 4/4: Pushing main repository..."
git push origin $(git branch --show-current)

echo ""
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}Push completed successfully!${NC}"
echo -e "${GREEN}=========================================${NC}"
