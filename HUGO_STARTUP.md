# 如何启动 Hugo 服务开启页面预览

本文记录本项目在本地启动 Hugo 预览服务的方法。

## 1. 进入项目根目录

项目根目录是包含 `hugo.yaml` 的目录。

在 Trae/PowerShell 中执行命令时，应把工作目录设置到项目根目录。

## 2. 启动本地预览服务

推荐使用 Hugo 的完整路径，避免系统 PATH 未配置导致命令找不到：

```powershell
& "C:\Users\13214\AppData\Local\Hugo\hugo.exe" server --gc
```

启动成功后，终端会显示类似：

```text
Web Server is available at http://localhost:1313/
```

然后在浏览器打开：

```text
http://localhost:1313/
```

## 3. 端口被占用时

如果 `1313` 端口被占用，换一个端口启动：

```powershell
& "C:\Users\13214\AppData\Local\Hugo\hugo.exe" server --gc -p 1324
```

对应访问：

```text
http://localhost:1324/
```

## 4. 只构建不预览

如果只想检查项目是否能正常构建，执行：

```powershell
& "C:\Users\13214\AppData\Local\Hugo\hugo.exe" --gc
```

构建成功后，静态文件会生成到 `public/` 目录。

## 5. 注意事项

1. Hugo 服务必须保持终端运行，关闭终端后页面会打不开。
2. 每次修改后，先确认 Hugo 构建成功，再打开页面检查效果。
3. 如果页面打不开，优先检查终端里是否还有 `hugo server` 正在运行。
