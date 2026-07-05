#!/bin/bash
# Cloudflare Pages 构建脚本
# 手动下载 Hugo extended 版本（Cloudflare 默认安装的是标准版，不支持 SCSS）

set -e

HUGO_VERSION=0.163.2

echo "==> 下载 Hugo extended ${HUGO_VERSION}"
wget -q -O /tmp/hugo.tar.gz \
  "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.tar.gz"

tar -xzf /tmp/hugo.tar.gz -C /tmp
chmod +x /tmp/hugo

echo "==> Hugo 版本:"
/tmp/hugo version

echo "==> 开始构建"
/tmp/hugo --gc --minify

echo "==> 构建完成"
