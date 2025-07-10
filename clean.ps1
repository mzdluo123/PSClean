<#
.SYNOPSIS
  一键清理常用缓存。
#>
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
  "$env:AppData\QQ\Cache",
  "$env:AppData\QQ\GPUCache",
  "$env:AppData\QQ\Code Cache",
  "$env:AppData\QQ\Partitions\**\*Cache",
  "$env:AppData\QQ\miniapp\temps"
  
)

foreach ($p in $paths) {
  # 使用 Resolve-Path 来处理可能存在的通配符，它会返回所有匹配的实际路径
  $resolvedPaths = Get-ChildItem -Recurse -Path $p -ErrorAction SilentlyContinue

  if ($resolvedPaths) {
    # 遍历所有解析出来的真实路径
    foreach ($actualPath in $resolvedPaths) {
      if (Test-Path $actualPath) {
        Write-Host "正在删除缓存：$actualPath"
        # Remove-Item -LiteralPath $actualPath -Recurse -Force -ErrorAction SilentlyContinue
      }
    }
  }
  else {
    # 如果 Resolve-Path 未找到任何路径，则说明原始模式没有匹配项
    Write-Host "未找到路径：$p，跳过。"
  }
}

Write-Host "所有缓存清理完成！"