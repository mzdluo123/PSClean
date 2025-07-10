#
<#
.SYNOPSIS
  一键清理常用开发环境及常用软件缓存。

.DESCRIPTION
  本脚本可批量清理 Node.js、Python、Java、C#、PHP、Golang、Rust、C++ 等开发环境的缓存，以及 VSCode、Edge、Chrome、QQ、网易云音乐等常见软件的本地缓存目录。
  支持通配符批量匹配多用户/多配置缓存。
  可通过 -dryRun 参数预览将要清理的所有缓存路径，不会实际删除文件，便于安全检查。

.PARAMETER dryRun
  仅预览将要删除的缓存路径，不做实际删除操作。

.EXAMPLE
  # 实际清理所有缓存
  .\clean.ps1

  # 仅预览将要清理的缓存
  .\clean.ps1 -dryRun

.NOTES
  需以有权限的用户运行，部分缓存目录可能需要管理员权限。
#>
param(
  [switch]$dryRun
)

# 定义缓存路径列表
$paths = @(
  # nodejs
  "$env:LocalAppData\npm-cache",
  "$env:LocalAppData\Yarn\cache",
  # python
  "$env:LocalAppData\uv\cache",
  "$env:LocalAppData\pip\Cache",
  # java
  "$env:USERPROFILE\.m2\repository",
  "$env:USERPROFILE\.m2\build-cache",
  "$env:USERPROFILE\.gradle\caches",
  # c#
  "$env:USERPROFILE\.nuget\packages",
  # php
  "$env:LocalAppData\Composer\cache",
  # golang
  "$env:USERPROFILE\go\pkg\mod",
  "$env:USERPROFILE\go\cache",
  # rust
  "$env:USERPROFILE\.cargo\registry",
  "$env:USERPROFILE\.cargo\git",
  # cpp
  "$env:LocalAppData\vcpkg\downloads",
  "$env:LocalAppData\vcpkg\archives",
  "$env:LocalAppData\vcpkg\registries",
  # vscode
  "$env:AppData\Code\Cache",
  "$env:AppData\Code\CachedData",
  "$env:AppData\Code\User\workspaceStorage",
  # edge
  "$env:LocalAppData\Microsoft\Edge\User Data\Default\Cache",
  "$env:LocalAppData\Microsoft\Edge\User Data\Default\Code Cache",
  "$env:LocalAppData\Microsoft\Edge\User Data\Default\GPUCache",
  # edge 其他缓存
  "$env:LocalAppData\Microsoft\Edge\User Data\Default\Media Cache",
  "$env:LocalAppData\Microsoft\Edge\User Data\Default\Storage",
  "$env:LocalAppData\Microsoft\Edge\User Data\Default\Service Worker\CacheStorage",
  "$env:LocalAppData\Microsoft\Edge\User Data\Default\JumpListIcons",
  "$env:LocalAppData\Microsoft\Edge\User Data\Crashpad",
  "$env:LocalAppData\Microsoft\Edge\User Data\ShaderCache",
  "$env:LocalAppData\Microsoft\Edge\User Data\Profile*\Cache",
  "$env:LocalAppData\Microsoft\Edge\User Data\Profile*\Code Cache",
  "$env:LocalAppData\Microsoft\Edge\User Data\Profile*\GPUCache",
  # chrome
  "$env:LocalAppData\Google\Chrome\User Data\Default\Cache",
  "$env:LocalAppData\Google\Chrome\User Data\Default\Code Cache",
  "$env:LocalAppData\Google\Chrome\User Data\Default\GPUCache",
  # chrome 其他缓存
  "$env:LocalAppData\Google\Chrome\User Data\Default\Media Cache",
  "$env:LocalAppData\Google\Chrome\User Data\Default\Storage",
  "$env:LocalAppData\Google\Chrome\User Data\Default\Service Worker\CacheStorage",
  "$env:LocalAppData\Google\Chrome\User Data\Default\JumpListIcons",
  "$env:LocalAppData\Google\Chrome\User Data\Crashpad",
  "$env:LocalAppData\Google\Chrome\User Data\ShaderCache",
  "$env:LocalAppData\Google\Chrome\User Data\Profile*\Cache",
  "$env:LocalAppData\Google\Chrome\User Data\Profile*\Code Cache",
  "$env:LocalAppData\Google\Chrome\User Data\Profile*\GPUCache",
  # QQ electron 应用缓存（递归多层目录）
  "$env:AppData\QQ\*cache",
  "$env:AppData\QQ\Partitions\**\*Cache",
  "$env:AppData\QQ\miniapp\temps"

  # 网易云音乐缓存
  "$env:LocalAppData\Netease\CloudMusic\Cache",
  "$env:LocalAppData\Netease\CloudMusic\webapp*\*cache",

  # Windows 系统常见缓存
  "$env:LocalAppData\Temp",
  "$env:Temp",
  "$env:SystemRoot\Temp",
  "$env:USERPROFILE\AppData\Local\Microsoft\Windows\INetCache",
  "$env:USERPROFILE\AppData\Local\Microsoft\Windows\WER",
  "$env:USERPROFILE\AppData\Local\Microsoft\Windows\WebCache",
  "$env:USERPROFILE\AppData\Local\CrashDumps",
  "$env:USERPROFILE\AppData\Local\D3DSCache",
  "$env:USERPROFILE\AppData\Local\Microsoft\Windows\Explorer\thumbcache_*",
  "$env:USERPROFILE\AppData\Local\Microsoft\Windows\Explorer\iconcache_*",
  "$env:USERPROFILE\AppData\Local\Microsoft\Windows\Explorer\*.db",
  "$env:USERPROFILE\AppData\Local\Microsoft\Windows\Explorer\*.log",
  "$env:USERPROFILE\AppData\Local\Microsoft\Windows\Explorer\*.tmp"

)

foreach ($p in $paths) {
  # 使用 Resolve-Path 来处理可能存在的通配符，它会返回所有匹配的实际路径
  $resolvedPaths = Get-ChildItem -Recurse -Path $p -ErrorAction SilentlyContinue

  if ($resolvedPaths) {
    # 遍历所有解析出来的真实路径
    foreach ($actualPath in $resolvedPaths) {
      $path = $actualPath.FullName
      if (Test-Path $path) {
        if ($dryRun) {
          Write-Host "[Dry-Run] 将要删除缓存：$path"
        } else {
          Write-Host "正在删除缓存：$path"
          Remove-Item -LiteralPath $path -Recurse -Force -ErrorAction SilentlyContinue
        }
      }
    }
  }
  else {
    # 如果 Resolve-Path 未找到任何路径，则说明原始模式没有匹配项
    if ($dryRun) {
      Write-Host "[Dry-Run] 未找到路径：$p，跳过。"
    } else {
      Write-Host "未找到路径：$p，跳过。"
    }
  }
}

if ($dryRun) {
  Write-Host "[Dry-Run] 所有缓存清理目标已列出，无实际删除。"
} else {
  Write-Host "所有缓存清理完成！"
}