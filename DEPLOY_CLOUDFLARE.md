# Cloudflare Pages 部署说明

本项目通过 Cloudflare Pages 自动构建和部署。

---

## 一、首次部署（在 Cloudflare 控制台操作）

### 1. 进入 Cloudflare Pages

打开 https://dash.cloudflare.com/

左侧菜单选择 **Workers 和 Pages** → 点击 **创建** → 选择 **Pages** 标签 → 点击 **连接到 Git**。

### 2. 授权并选择仓库

1. 授权 Cloudflare 访问你的 GitHub 账号
2. 选择仓库：`0Giorno/ergou.github.io`
3. 点击 **开始设置**

### 3. 配置构建设置

按下表填写：

| 配置项 | 值 |
|---|---|
| 项目名称 | `ergou-blog`（或任意名称，会决定 `*.pages.dev` 域名） |
| 生产分支 | `main` |
| 框架预设 | Hugo |
| 构建命令 | `hugo --gc --minify` |
| 构建输出目录 | `public` |

### 4. 配置环境变量（关键）

展开 **环境变量（高级）**，添加：

| 变量名 | 值 |
|---|---|
| `HUGO_VERSION` | `0.163.2` |
| `HUGO_ENV` | `production` |

说明：

- `HUGO_VERSION` 必须和本地版本一致，本项目使用 `0.163.2+extended`
- Cloudflare Pages 会自动使用 Hugo extended 版本（支持 SCSS）

### 5. 保存并部署

点击 **保存并部署**。首次构建大约需要 1-2 分钟。

### 6. 访问站点

部署成功后，Cloudflare 会给你一个域名：

```text
https://ergou-blog.pages.dev
```

（具体域名取决于你填的项目名称）

---

## 二、后续更新

以后每次本地修改完，执行：

```powershell
git add .
git commit -m "描述本次修改"
git push
```

Cloudflare Pages 检测到 `main` 分支有新提交，会自动重新构建部署。

---

## 三、绑定自定义域名（可选）

如果你想用自己的域名，例如 `blog.ergou.com`：

1. 进入 Cloudflare Pages 项目 → **自定义域** → **设置自定义域**
2. 输入你的域名
3. 按提示在域名 DNS 添加 CNAME 记录指向 `*.pages.dev`
4. 如果域名也在 Cloudflare 管理，会自动配置

绑定后建议把 `hugo.yaml` 里的 `baseurl` 改成正式域名：

```yaml
baseurl: https://blog.ergou.com/
```

然后 `git push` 重新部署即可。

---

## 四、本地预览与线上一致

本地预览使用：

```powershell
& "C:\Users\13214\AppData\Local\Hugo\hugo.exe" server --gc
```

线上构建命令是 `hugo --gc --minify`，比本地多了 `--minify`（压缩 HTML/CSS/JS），其余一致。

---

## 五、常见问题

### 1. 构建失败：Hugo 版本不匹配

确认环境变量 `HUGO_VERSION` 设为 `0.163.2`。

### 2. 样式丢失 / SCSS 报错

Cloudflare Pages 默认使用 Hugo extended 版本，支持 SCSS。如果样式丢失，检查 `HUGO_VERSION` 是否正确。

### 3. 图片不显示

确认图片放在 `static/images/` 下，文章中用 `/images/...` 引用。

### 4. 部署后页面空白

检查 `baseurl` 是否设为 `/`，不要写成 `https://ergou.github.io/`。

---

## 六、当前项目配置

| 项 | 值 |
|---|---|
| Hugo 版本 | 0.163.2+extended |
| 主题 | hugo-theme-stack（已内嵌，非 submodule） |
| baseurl | `/`（适配 Cloudflare Pages 多域名） |
| 构建命令 | `hugo --gc --minify` |
| 输出目录 | `public` |
| 仓库 | https://github.com/0Giorno/ergou.github.io |
