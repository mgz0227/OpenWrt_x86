[![Build OpenWrt](https://github.com/mgz0227/OpenWrt_x86/actions/workflows/Openwrt-AutoBuild.yml/badge.svg)](https://github.com/mgz0227/OpenWrt_x86/actions/workflows/Openwrt-AutoBuild.yml)

# MeowWrt x86 构建配置

本仓库保存 x86 固件的配置、补丁和 GitHub Actions 自动构建流程，不包含完整的 OpenWrt 源码，也不是 OpenWrt 官方发布固件。

## 源码组合

| 目标 | 基线 | 内核相关源码 | 状态 |
| --- | --- | --- | --- |
| `x86_64` | `openwrt-25.12` | OpenWrt `main`，当前为 6.18 | 实验性混合构建 |

`x86_64` 会从 OpenWrt 官方 `main` 显式同步 target、toolchain 和内核相关 package 目录，并从 OpenWrt 官方 packages `master` 同步配套内核包。该组合保留了本仓库原有的 6.18 功能，但不属于 OpenWrt 官方支持的版本升级路径。每次 Release 会记录基线、内核源码和内核 package 提交，便于复查。

上游版本由 [`devices/common/settings.ini`](devices/common/settings.ini) 管理。OpenWrt 当前的构建要求和标准步骤以 [OpenWrt 官方 README](https://github.com/openwrt/openwrt/blob/openwrt-25.12/README.md) 与 [Build System Setup](https://openwrt.org/docs/guide-developer/build-system/install-buildsystem) 为准。

## GitHub Actions 构建

1. Fork 本仓库并启用 Actions。
2. 在 Actions 页面运行 **Repo Dispatcher**。
3. 仓库仅构建 `x86_64`；也可以直接运行 **Build OpenWrt**。
4. 定时任务按 `Asia/Shanghai` 每天 12:00 触发。

可选参数：

| 参数 | 作用 |
| --- | --- |
| `pkg` | 在构建前触发 OP-Packages 更新 |
| `nocache` | 清理构建缓存 |
| `noser` | 跳过服务器部署 |
| `notg` | 跳过 Telegram 通知 |
| `cw` | Repo Dispatcher 先取消正在运行的工作流 |

参数可以用空格组合，例如 `pkg nocache`。

### Secrets

所有密钥均为可选；不配置时仍可生成 Actions Artifact。

| Secret | 用途 |
| --- | --- |
| `TOKEN_MGZ0227` | 触发 OP-Packages、发布 Release、清理旧记录 |
| `APK_PRIVATE_KEY` / `APK_PUBLIC_KEY` | 自定义 APK 签名密钥，必须成对配置 |
| `SSH_PRIVATE_KEY` | 启用服务器部署 |
| `HOST` / `PORT` | 主服务器地址与端口 |
| `SERVER_HOST` / `SERVER_PORT` | 次服务器地址与端口 |
| `SERVER_USERNAME` | SSH 用户名 |
| `TELEGRAM_TOKEN` / `TELEGRAM_CHAT_ID` | Telegram 构建结果通知 |

`TOKEN_MGZ0227` 应使用满足实际 API 调用的最小权限。工作流中的第三方 Action 已固定到完整提交，并由 Dependabot 每周检查更新。

## 本地构建

OpenWrt 官方要求使用 GNU/Linux、BSD 或 macOS 以及区分大小写的文件系统；Cygwin 不受支持。本仓库的自动流程还会拉取外部 feed 和覆盖目录，因此建议先以 Actions 流程作为可复现基准。

官方基础流程为：

```bash
./scripts/feeds update -a
./scripts/feeds install -a
make menuconfig
make
```

完整依赖列表请查阅 OpenWrt 官方文档，不要直接照搬过时发行版的软件包名。

## 使用与安全

- 默认 LAN 地址：`192.168.3.1`
- 管理用户：`root`
- 本仓库不会写入固定的 root 密码。首次登录后应立即设置强密码。
- 首次使用建议全新安装，不建议跨来源保留配置升级。
- 不要把 LuCI、SSH 或 APK 软件源管理接口直接暴露到 WAN。

默认选装内容包括 APK 软件包管理、OpenClash、DDNS-GO 和 AdGuard Home。实际进入固件的包以构建产物中的 `*.config` 和 `*.buildinfo` 为准。

## 仓库约定

- `devices/common/patches/*.patch`：构建时启用。
- `*.patch.b`、`*.bak`：历史停用补丁，不参与构建。
- 所有启用补丁必须无 reject、无冲突标记地应用，否则构建立即失败。
- Shell、YAML、INI 和 patch 文件统一使用 LF。

## 致谢

- [OpenWrt](https://github.com/openwrt/openwrt)
- [ImmortalWrt](https://github.com/immortalwrt/immortalwrt)
- [Lean's OpenWrt](https://github.com/coolsnowwolf/lede)
- [P3TERX Actions-OpenWrt](https://github.com/P3TERX/Actions-OpenWrt)
- [GitHub Actions](https://docs.github.com/actions)
