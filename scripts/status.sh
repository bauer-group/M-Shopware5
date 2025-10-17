#!/bin/bash
# Check status of repository and all submodules (Linux/Mac)

# Get repository name from git remote
REPO_NAME=$(basename -s .git $(git config --get remote.origin.url) 2>/dev/null || echo "Repository")

echo "========================================="
echo "$REPO_NAME Status"
echo "========================================="

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Main repository status
echo ""
echo -e "${CYAN}Main Repository:${NC}"
echo "Branch: $(git branch --show-current)"
git status --short

# Check if main repo is behind
BEHIND=$(git rev-list HEAD..origin/$(git branch --show-current) --count 2>/dev/null)
if [ "$BEHIND" -gt 0 ]; then
    echo -e "${YELLOW}Your branch is behind by $BEHIND commit(s)${NC}"
fi

# Submodule status
echo ""
echo -e "${CYAN}Submodules:${NC}"
CLEAN_COUNT=0
DIRTY_COUNT=0

git submodule foreach --quiet '
    STATUS=$(git status --porcelain)
    BRANCH=$(git branch --show-current)

    if [ -z "$STATUS" ]; then
        echo -e "'"${GREEN}"'✓'"${NC}"' $name ('"${BRANCH}"')"
        exit 0
    else
        echo -e "'"${YELLOW}"'⚠'"${NC}"' $name ('"${BRANCH}"') - uncommitted changes"
        git status --short | sed "s/^/  /"
        exit 1
    fi
' && CLEAN_COUNT=$((CLEAN_COUNT + 1)) || DIRTY_COUNT=$((DIRTY_COUNT + 1))

# Summary
echo ""
echo "========================================="
if [ $DIRTY_COUNT -eq 0 ]; then
    echo -e "${GREEN}All submodules are clean${NC}"
else
    echo -e "${YELLOW}$DIRTY_COUNT submodule(s) with uncommitted changes${NC}"
fi
echo "========================================="
