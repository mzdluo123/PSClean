# PSClean

> 一键清理常用开发环境及常见软件本地缓存

## 功能特性

- 支持清理 Node.js、Python、Java、C#、PHP、Golang、Rust、C++ 等开发环境缓存
- 支持清理 VSCode、Edge、Chrome、QQ、网易云音乐等常见软件缓存
- 支持通配符批量匹配多用户/多配置缓存目录
- 提供 `-dryRun` 模式，仅预览将要删除的缓存路径

## 环境要求

- Windows 10/11
- PowerShell 5.1 及以上版本（建议以管理员权限运行）

## 脚本文件

- `clean.ps1`：主脚本文件，位于项目根目录

## 使用方法

```powershell
# 直接执行，清理所有缓存
.\clean.ps1

# 仅预览将要删除的缓存路径，不执行实际删除
.\clean.ps1 -dryRun
```

## 参数说明

| 参数     | 说明                           |
| -------- | ------------------------------ |
| `-dryRun` | 列出将要删除的缓存路径，不进行实际删除 |

## 支持清理的缓存路径

- **Node.js**
  - `%LocalAppData%\npm-cache`
  - `%LocalAppData%\Yarn\cache`
- **Python**
  - `%LocalAppData%\uv\cache`
  - `%LocalAppData%\pip\Cache`
  - `%UserProfile%\pipx\.cache`
- **Java**
  - `%USERPROFILE%\.m2\repository`
  - `%USERPROFILE%\.m2\build-cache`
  - `%USERPROFILE%\.gradle\caches`
- **C#**
  - `%USERPROFILE%\.nuget\packages`
- **PHP**
  - `%LocalAppData%\Composer\cache`
- **Golang**
  - `%USERPROFILE%\go\pkg\mod`
  - `%USERPROFILE%\go\cache`
- **Rust**
  - `%USERPROFILE%\.cargo\registry`
  - `%USERPROFILE%\.cargo\git`
- **C++ (vcpkg)**
  - `%LocalAppData%\vcpkg\downloads`
  - `%LocalAppData%\vcpkg\archives`
  - `%LocalAppData%\vcpkg\registries`
- **VSCode**
  - `%AppData%\Code\Cache`
  - `%AppData%\Code\CachedData`
  - `%AppData%\Code\User\workspaceStorage`
- **Edge & Chrome 浏览器**
  - 缓存、代码缓存、GPUCache、Media Cache、Storage、Service Worker CacheStorage、JumpListIcons、Crashpad、ShaderCache 等目录
  - 支持 `Profile*` 通配符匹配多用户配置
- **QQ (Electron 应用)**
  - `%AppData%\QQ\*cache`
  - `%AppData%\QQ\Partitions\**\*Cache`
  - `%AppData%\QQ\miniapp\temps`
- **网易云音乐**
  - `%LocalAppData%\Netease\CloudMusic\Cache`
  - `%LocalAppData%\Netease\CloudMusic\webapp*\*cache`
- **Windows 系统常见缓存**
  - `%LocalAppData%\Temp`、`%Temp%`、`%SystemRoot%\Temp`
  - `%USERPROFILE%\AppData\Local\Microsoft\Windows\INetCache`
  - `%USERPROFILE%\AppData\Local\Microsoft\Windows\WER`
  - `%USERPROFILE%\AppData\Local\Microsoft\Windows\WebCache`
  - `%USERPROFILE%\AppData\Local\CrashDumps`
  - `%USERPROFILE%\AppData\Local\D3DSCache`
  - `%USERPROFILE%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_*`
  - `%USERPROFILE%\AppData\Local\Microsoft\Windows\Explorer\iconcache_*`
  - `%USERPROFILE%\AppData\Local\Microsoft\Windows\Explorer\*.db`
  - `%USERPROFILE%\AppData\Local\Microsoft\Windows\Explorer\*.log`
  - `%USERPROFILE%\AppData\Local\Microsoft\Windows\Explorer\*.tmp`
  - `%USERPROFILE%\.cache`

## 注意事项

- 建议先使用 `-dryRun` 参数预览，将要删除的路径清单
- 删除操作不可逆，务必确认无误后再执行
- 部分系统或软件缓存目录可能需要管理员权限

## 贡献指南

欢迎提交 Issue 或 Pull Request，一起完善脚本功能和支持更多缓存目录。

## 许可证

本项目采用 MIT 许可证，详情见 [LICENSE](LICENSE) 文件。
