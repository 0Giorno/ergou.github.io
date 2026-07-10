# 博客更新与同步部署说明

本文档说明：本地修改博客后，如何让线上页面同步更新。

---

## 一、核心原理

```text
本地修改 → git push 到 GitHub → Cloudflare Pages 自动构建 → 线上更新
```

你不需要同时推送两个地方。**只需要 git push 一次**，Cloudflare Pages 会自动检测到 GitHub 仓库有新提交，自动重新构建并部署。

---

## 二、日常更新流程

### 1. 本地修改

无论是哪种修改，都在本地项目目录操作：

```text
d:\我的博客\My_blog\My_blog\V3\suxilan.github.io-main\suxilan.github.io-main
```

常见修改场景：

| 修改内容 | 涉及文件 |
|---|---|
| 新增/修改文章 | `content/posts/`、`content/notes/`、`content/photography/` |
| 新增图片 | `static/images/` |
| 修改博客设计 | `assets/scss/modules/` 下的样式文件 |
| 修改模板 | `layouts/` 下的 html 文件 |
| 修改配置 | `hugo.yaml` |

### 2. 本地预览（可选但推荐）

修改后先本地预览确认效果：

```powershell
& "C:\Users\13214\AppData\Local\Hugo\hugo.exe" server --gc
```

打开浏览器访问 `http://localhost:1313/`（端口以终端显示为准）确认无误。

### 3. 提交并推送

```powershell
# 查看改了哪些文件
git status

# 添加改动的文件（建议指定具体文件，不要用 git add .）
git add content/posts/新文章.md
git add static/images/新图片.jpg

# 提交
git commit -m "描述本次修改内容"

# 推送到 GitHub
git push
```

### 4. Cloudflare 自动部署

推送后，Cloudflare Pages 会自动：

1. 检测到 GitHub 仓库有新提交（通常几秒内）
2. 拉取最新代码
3. 执行 `bash build.sh` 构建
4. 部署到线上

整个过程大约 1-2 分钟，无需手动操作。

### 5. 验证线上更新

构建完成后，访问你的 Cloudflare Pages 域名确认更新。

也可以在 Cloudflare 控制台查看构建状态：

```text
Cloudflare Dashboard → Workers 和 Pages → 你的项目 → Deployments
```

---

## 三、各类操作的具体示例

### 示例 1：新增一篇生活记录

```powershell
# 1. 创建文章
# 在 content/posts/ 下新建 my-weekend.md

# 2. 图片放到 static/images/posts/my-weekend/

# 3. 本地预览
& "C:\Users\13214\AppData\Local\Hugo\hugo.exe" server --gc

# 4. 提交推送
git add content/posts/my-weekend.md
git add static/images/posts/my-weekend/
git commit -m "add: 周末生活记录"
git push
```

### 示例 2：修改博客样式

```powershell
# 1. 修改样式文件，例如 assets/scss/modules/_homepage.scss

# 2. 本地预览
& "C:\Users\13214\AppData\Local\Hugo\hugo.exe" server --gc

# 3. 提交推送
git add assets/scss/modules/_homepage.scss
git commit -m "style: 调整封面卡片大小"
git push
```

### 示例 3：修改博客配置

```powershell
# 1. 修改 hugo.yaml

# 2. 本地预览
& "C:\Users\13214\AppData\Local\Hugo\hugo.exe" server --gc

# 3. 提交推送
git add hugo.yaml
git commit -m "config: 修改站点副标题"
git push
```

### 示例 4：替换头像

```powershell
# 1. 把新头像放到 static/images/avatar.png（覆盖旧文件）

# 2. 本地预览
& "C:\Users\13214\AppData\Local\Hugo\hugo.exe" server --gc

# 3. 提交推送
git add static/images/avatar.png
git commit -m "update: 替换头像"
git push
```

---

## 四、注意事项

### 1. 只需推送到 GitHub

```text
git push  →  GitHub  →  Cloudflare 自动构建
```

不需要手动操作 Cloudflare，也不需要同时推送两个地方。

### 2. 推送失败怎么办

国内访问 GitHub 不稳定，`git push` 可能超时失败：

```text
fatal: unable to access ... Connection was aborted
```

解决方法：

- 开启代理/VPN 后重试 `git push`
- 或配置 git 走代理：

```powershell
# 设置代理（根据你的代理端口修改）
git config --global http.proxy http://127.0.0.1:7890
git config --global https.proxy http://127.0.0.1:7890

# 推送成功后可以取消代理
git config --global --unset http.proxy
git config --global --unset https.proxy
```

### 3. 构建失败怎么办

如果 Cloudflare 构建失败，到控制台查看构建日志：

```text
Cloudflare Dashboard → Workers 和 Pages → 你的项目 → Deployments → 点击失败的部署 → View build
```

常见原因：

| 错误 | 原因 | 解决 |
|---|---|---|
| Hugo 版本太旧 | 环境变量未设置 | 确认 `HUGO_VERSION=0.163.2` |
| SCSS 编译失败 | 用了标准版 Hugo | 确认构建命令是 `bash build.sh` |
| 模板渲染错误 | 代码语法错误 | 查看日志定位具体文件 |

### 4. 本地预览和线上一致

| 项 | 本地 | 线上 |
|---|---|---|
| Hugo 版本 | 0.163.2+extended | 0.163.2+extended（build.sh 下载） |
| 构建命令 | `hugo server --gc` | `hugo --gc --minify` |
| 差异 | 无 `--minify` 压缩 | 有 `--minify` 压缩 HTML/CSS/JS |

本地预览看到的效果和线上基本一致。

### 5. 图片路径规范

- 图片放在 `static/images/` 下
- 文章中用 `/images/...` 引用
- 文件名用英文、数字、短横线，避免中文（中文文件名可能导致线上加载失败）

---

## 五、快速参考

```powershell
# 启动本地预览
& "C:\Users\13214\AppData\Local\Hugo\hugo.exe" server --gc

# 提交推送（三步）
git add <修改的文件>
git commit -m "描述"
git push

# 查看状态
git status

# 查看历史
git log --oneline -5
```

---

## 六、当前部署配置

| 项 | 值 |
|---|---|
| 代码仓库 | https://github.com/0Giorno/ergou.github.io |
| 部署平台 | Cloudflare Pages |
| 构建命令 | `bash build.sh` |
| 构建脚本 | `build.sh`（自动下载 Hugo extended 0.163.2） |
| 输出目录 | `public` |
| 生产分支 | `main` |
| 环境变量 | `HUGO_VERSION=0.163.2`、`HUGO_ENV=production` |
