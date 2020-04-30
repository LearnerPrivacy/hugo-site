#!/bin/sh

# If a command fails then the deploy stops
set -e

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

# Build the project.
hugo -t lp-dream 

# Go To Public folder
cd public

# Add changes to git.
git add .

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master

cd ..
echo "Updating theme repo..."
cd theme/lp-dream
git add .
git commit -m "$msg"
git push

echo "Updating main repo..."
cd ../..
git add .
git commit -m "$msg"
git push origin master

