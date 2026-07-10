# 博客内容替换与文章上传说明

这份文档说明两件事：

1. 如何替换现在网页中显示的内容。
2. 如何给三个子内容系统添加和上传文章。

项目基于 Hugo，所有页面内容主要由 `hugo.yaml`、`content/`、`static/images/` 和少量样式文件控制。

---

## 一、如何替换现在网页中显示的内容

### 1. 修改网站名称、域名和基础信息

文件位置：

```text
hugo.yaml
```

常用字段：

```yaml
baseurl: https://ergou.github.io/
title: "二狗君のBlog"
```

说明：

| 字段 | 作用 |
|---|---|
| `baseurl` | 正式部署后的站点地址 |
| `title` | 浏览器标题、侧边栏站点名等位置使用的网站名称 |
| `locale` | 语言地区 |
| `timeZone` | 时间地区 |

如果以后换 GitHub Pages 仓库，例如 `yourname.github.io`，需要同步修改：

```yaml
baseurl: https://yourname.github.io/
```

---

### 2. 修改左侧栏头像、副标题和站点图标

文件位置：

```text
hugo.yaml
```

相关配置：

```yaml
params:
  favicon: /images/二狗君.png

  sidebar:
    subtitle: "记录生活，留住美好"
    emojiImage: /images/二狗君.png
    avatar:
      enabled: true
      local: false
      src: /images/二狗君.png
```

说明：

| 字段 | 作用 |
|---|---|
| `params.favicon` | 浏览器标签页图标 |
| `sidebar.subtitle` | 左侧栏站点副标题 |
| `sidebar.avatar.src` | 左侧栏头像 |
| `sidebar.emojiImage` | 头像旁的小图标 |

图片建议放在：

```text
static/images/
```

例如：

```text
static/images/avatar-new.png
```

然后写成：

```yaml
src: /images/avatar-new.png
```

---

### 3. 修改封面页个人卡片内容

文件位置：

```text
hugo.yaml
```

搜索 `homepage`，会看到类似配置：

```yaml
params:
  homepage:
    profile:
      enabled: true
      title: "二狗君のBlog"
      subtitle: "记录生活，留住美好"
      imageUrl: "/images/二狗君.png"
      background: "/images/cover-background.jpg"
      buttons:
        - name: 生活记录
          url: /posts/
        - name: 读书笔记
          url: /notes/
        - name: 摄影集
          url: /photography/
```

可替换内容：

| 字段 | 作用 |
|---|---|
| `title` | 封面个人卡片主标题 |
| `subtitle` | 封面个人卡片副标题 |
| `imageUrl` | 封面头像 |
| `background` | 封面背景图 |
| `buttons.name` | 按钮文字 |
| `buttons.url` | 按钮跳转地址 |

封面背景图建议放在：

```text
static/images/cover-background.jpg
```

---

### 4. 修改导航菜单

文件位置：

```text
hugo.yaml
```

菜单配置一般在：

```yaml
menu:
  main:
```

示例：

```yaml
menu:
  main:
    - identifier: posts
      name: 生活记录
      url: /posts/
      weight: 10
      params:
        icon: edit
```

说明：

| 字段 | 作用 |
|---|---|
| `identifier` | 菜单唯一标识 |
| `name` | 页面上显示的菜单文字 |
| `url` | 点击跳转地址 |
| `weight` | 排序，数字越小越靠前 |
| `params.icon` | 菜单图标 |

---

### 5. 修改关于页面

文件位置：

```text
content/about.md
```

这里可以修改：

- 自我介绍文字
- 友链示例
- 留言说明
- 关于页面正文内容

Markdown 示例：

```markdown
Hi，我是二狗君。

这里记录生活、阅读、摄影和一些零碎想法。
```

---

### 6. 修改三个子内容页面的标题和描述

这类文字来自各栏目目录下的 `_index.md` 文件。

例如你提到的这句：

```text
这里是思想的旷野，记录生活的点滴与思考。
```

位置是：

```text
content/posts/_index.md
```

当前内容类似：

```yaml
---
title: "生活记录"
description: "这里是思想的旷野，记录生活的点滴与思考。"
---
```

修改方式：

```yaml
---
title: "生活记录"
description: "这里写你想显示的新介绍文字。"
---
```

三个子内容页面对应关系：

| 页面 | 文件位置 | 可修改内容 |
|---|---|---|
| 生活记录 | `content/posts/_index.md` | `title`、`description` |
| 读书笔记 | `content/notes/_index.md` | `title`、`description` |
| 摄影集 | `content/photography/_index.md` | `title`、`description` |

字段说明：

| 字段 | 显示位置 |
|---|---|
| `title` | 子内容页面顶部标题，例如“生活记录” |
| `description` | 标题下方的介绍文字，例如“这里是思想的旷野...” |

---

### 7. 修改页面底部统计和版权信息

文件位置：

```text
layouts/partials/footer/footer.html
```

常见内容包括：

- `© 2026 二狗君のBlog`
- 运行天数
- 总字数
- 总文章数
- 浏览量统计

如果只想改名称，搜索：

```text
二狗君のBlog
```

然后替换即可。

---

### 8. 修改样式外观

主要样式文件：

```text
assets/scss/modules/_homepage.scss   # 封面页样式
assets/scss/modules/_layout.scss     # 子页面布局、卡片、侧边栏、归档样式
assets/scss/modules/_article.scss    # 文章元信息、正文相关样式
assets/scss/modules/_photography.scss # 摄影集样式
assets/scss/custom.scss              # 样式模块入口
```

常见修改：

| 想改的内容 | 推荐文件 |
|---|---|
| 封面背景、个人卡片、按钮大小 | `_homepage.scss` |
| 左侧栏、右侧栏、卡片颜色、列表布局 | `_layout.scss` |
| 文章底部日期/地点信息 | `_article.scss` |
| 摄影集图片布局 | `_photography.scss` |

---

## 二、三个子内容系统如何添加文章

本项目有三个主要子内容系统：

| 页面 | 内容目录 | 页面地址 |
|---|---|---|
| 生活记录 | `content/posts/` | `/posts/` |
| 读书笔记 | `content/notes/` | `/notes/` |
| 摄影集 | `content/photography/` | `/photography/` |

新增文章的核心步骤：

1. 在对应目录下新增一个 `.md` 文件。
2. 填写文章开头的 front matter。
3. 把图片放到 `static/images/` 下。
4. 在文章中用 `/images/...` 引用图片。
5. 本地启动 Hugo 检查效果。
6. 确认无误后提交并推送到 GitHub。

---

## 三、生活记录：样例文章与上传方式

### 1. 文件位置

```text
content/posts/weekend-walk.md
```

### 2. 样例文章

```markdown
---
title: "周末散步记录"
date: 2026-07-02T10:30:00+08:00
description: "一次普通但舒服的周末散步。"
image: "/images/posts/weekend-walk/cover.jpg"
cover:
  image: "/images/posts/weekend-walk/cover.jpg"
location: "洛阳"
---

今天下午天气很好，沿着河边慢慢走了一圈。

![河边风景](/images/posts/weekend-walk/01.jpg)

风不大，阳光也不刺眼，很适合把脑子放空。
```

### 3. 图片上传位置

建议为每篇生活记录单独建文件夹：

```text
static/images/posts/weekend-walk/
```

放入：

```text
cover.jpg
01.jpg
02.jpg
```

文章中引用：

```markdown
![图片说明](/images/posts/weekend-walk/01.jpg)
```

### 4. 字段说明

| 字段 | 作用 |
|---|---|
| `title` | 卡片标题 |
| `date` | 卡片底部日期和星期来源 |
| `description` | 标题下方备注 |
| `image` | 卡片图片 |
| `cover.image` | 卡片封面图 |
| `location` | 卡片底部地点 |

---

## 四、读书笔记：样例文章与上传方式

### 1. 文件位置

```text
content/notes/human-stars.md
```

### 2. 样例文章

```markdown
---
title: "人类群星闪耀时"
date: 2026-07-02T09:00:00+08:00
description: "历史关键时刻中的人物选择与命运转折。"
author: "斯蒂芬·茨威格"
cover:
  image: "/images/books/human-stars.jpg"
---

这本书最吸引我的地方，是它没有把历史写成冰冷的结论，而是把人放回到具体的时刻里。

## 摘录

> 一个真正具有世界历史意义的时刻，一定要经过漫长岁月的酝酿。

## 感想

很多决定在发生时看似偶然，但背后往往有长时间的积累。
```

### 3. 封面图上传位置

建议放在：

```text
static/images/books/
```

例如：

```text
static/images/books/human-stars.jpg
```

文章中填写：

```yaml
cover:
  image: "/images/books/human-stars.jpg"
```

### 4. 字段说明

| 字段 | 作用 |
|---|---|
| `title` | 书名，显示在卡片右侧上方 |
| `author` | 作者，显示在书名后面 |
| `description` | 备注，显示在书名下方 |
| `date` | 笔记创建时间，卡片底部显示到年、月 |
| `cover.image` | 左侧书籍封面图 |

---

## 五、摄影集：样例文章与上传方式

### 1. 文件位置

```text
content/photography/summer-trip.md
```

### 2. 样例文章

```markdown
---
title: "夏日旅行影像"
date: 2026-07-02T18:00:00+08:00
description: "一次夏天旅行中的照片记录。"
image: "/images/photography/summer-trip/cover.jpg"
cover:
  image: "/images/photography/summer-trip/cover.jpg"
locations:
  - "云南"
---

![照片一](/images/photography/summer-trip/01.jpg)

![照片二](/images/photography/summer-trip/02.jpg)

![照片三](/images/photography/summer-trip/03.jpg)
```

### 3. 图片上传位置

建议每组摄影集单独建一个文件夹：

```text
static/images/photography/summer-trip/
```

放入：

```text
cover.jpg
01.jpg
02.jpg
03.jpg
```

文章中引用：

```markdown
![照片一](/images/photography/summer-trip/01.jpg)
```

### 4. 字段说明

| 字段 | 作用 |
|---|---|
| `title` | 摄影集标题 |
| `date` | 卡片底部日期，显示到年、月 |
| `description` | 摄影集备注 |
| `image` | 摄影集卡片封面 |
| `cover.image` | 摄影集卡片封面 |
| `locations` | 卡片底部地点，支持列表 |

### 5. 页面布局

摄影集文章页面有两种布局可选：

**布局一：全屏布局（默认推荐）**

在 front matter 中添加：

```yaml
layout: "fullscreen"
```

效果：
- 顶部有导航栏（头像 + 站名居中 + 三个子系统入口在右侧）
- 封面图占满全宽，标题左对齐在图片底部
- 正文居中 800px
- 底部有上一篇 / 下一篇导航卡片
- 去掉了左右侧栏、标签、评论、版权声明

**布局二：经典布局（原设计保留）**

不在 front matter 中写 `layout` 字段，或写 `layout: "single"`，则使用经典布局。

效果：
- 保留左侧栏（头像、菜单）和右侧栏
- 文章标题在正文顶部
- 底部有标签、评论、版权声明

**模板文件：**

| 布局 | 模板文件 |
|---|---|
| 全屏布局 | `layouts/photography/fullscreen.html` |
| 经典布局 | `layouts/photography/single.html` |
| 全屏样式 | `assets/scss/modules/_photo-fullscreen.scss` |

当前所有摄影集文章都使用 `layout: "fullscreen"`。如果要切换回经典布局，删除文章 front matter 中的 `layout: "fullscreen"` 行即可。

---

## 六、本地预览

保存文章后，启动 Hugo：

```powershell
& "C:\Users\13214\AppData\Local\Hugo\hugo.exe" server --gc
```

终端会显示类似：

```text
Web Server is available at http://localhost:1313/
```

打开对应页面：

```text
生活记录：http://localhost:1313/posts/
读书笔记：http://localhost:1313/notes/
摄影集：http://localhost:1313/photography/
```

如果端口不是 `1313`，以终端实际显示为准。

---

## 七、上传文章到 GitHub

确认本地预览没问题后，再提交到 GitHub。

### 1. 查看改动

```powershell
git status
```

### 2. 添加本次新增或修改的文件

建议添加具体文件，不要直接 `git add .`。

示例：

```powershell
git add content/posts/weekend-walk.md
git add static/images/posts/weekend-walk/cover.jpg
git add static/images/posts/weekend-walk/01.jpg
```

### 3. 提交

```powershell
git commit -m "add weekend walk post"
```

### 4. 推送

```powershell
git push
```

推送后，GitHub Pages 会自动构建部署。部署完成后，正式网址会显示新文章。

---

## 八、常见注意事项

1. 文件名建议使用英文、数字和短横线，例如 `summer-trip.md`。
2. 图片路径必须从 `/images/` 开始，因为 `static/images/` 会被 Hugo 映射为网页根路径 `/images/`。
3. `date` 建议使用完整格式：`2026-07-02T10:30:00+08:00`。
4. `draft: true` 的文章不会正式显示；想显示文章就不要写 `draft: true`，或改为 `draft: false`。
5. 每次修改后先本地预览，确认页面能打开再上传。
