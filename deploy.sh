#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$REPO_DIR"

if ! gh auth status &>/dev/null; then
  echo "GitHub 未登录，请先运行: gh auth login"
  exit 1
fi

if ! gh repo view HonkerAcmen/HonkerAcmen &>/dev/null; then
  gh repo create HonkerAcmen --public --description "GitHub Profile" --source=. --remote=origin --push
else
  git remote remove origin 2>/dev/null || true
  git remote add origin "https://github.com/HonkerAcmen/HonkerAcmen.git"
  git push -u origin main
fi

echo "✅ Profile 已发布: https://github.com/HonkerAcmen"
echo "👉 手动触发 snake workflow: gh workflow run snake.yml -R HonkerAcmen/HonkerAcmen"
