#!/bin/sh

# Use this script to deal with submodule errors
# with Git. Generally avoid committing files when the
# Go server is running.

rm .gitmodules
rm -rf .git/modules
echo -e "\033[0;32mRemove entry for submodule from git config file. Opening file in 2secs..\033[0m"
sleep 2
vim .git/config
rm -rf public
git add . && git commit -m "cleaning index"
git submodule add git@github.com:nishanttotla/nishanttotla.github.com.git public
./release.sh
git add .gitmodule
git commit -m "Added the submodule back"
