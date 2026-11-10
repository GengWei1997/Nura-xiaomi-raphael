#!/bin/bash
set -e  # 遇到错误立即退出

cd ~/.local/var/pmbootstrap/cache_git/pmaports

git reset --hard HEAD
git clean -fd

pmbootstrap pull
