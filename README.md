[![Build OpenWrt](https://github.com/mgz0227/OpenWrt_x86/actions/workflows/Openwrt-AutoBuild.yml/badge.svg)](https://github.com/mgz0227/OpenWrt_x86/actions/workflows/Openwrt-AutoBuild.yml)

# Linux Kernel Release Timeline (v7.0–v7.3)

| Version | Stage         | Start Date  | End Date    |
|----------|--------------|------------|------------|
| v7.0     | Merge Window | 2026-02-09 | 2026-02-21 |
| v7.0     | -rc1         | 2026-02-22 |            |
| v7.0     | Final Release| 2026-04-12 |            |
| v7.1     | Merge Window | 2026-04-13 | 2026-04-25 |
| v7.1     | -rc1         | 2026-04-26 |            |
| v7.1     | Final Release| 2026-06-14 |            |
| v7.2     | Merge Window | 2026-06-15 | 2026-06-27 |
| v7.2     | -rc1         | 2026-06-28 |            |
| v7.2     | Final Release| 2026-08-16 |            |
| v7.3     | Merge Window | 2026-08-17 | 2026-08-29 |
| v7.3     | -rc1         | 2026-08-30 |            |
| v7.3     | Final Release| 2026-10-18 |            |


## 1. **固件**

固件生成有2种方式：GitHub编译、本地化编译。

可根据需要选择任意一种进行固件生成。


## 2. **编译**
### 2.1 **GitHub编译**

+ 将仓库进行fork

+ 按需添加相关环境参数REPO_TOKEN、SCKEY、TELEGRAM_CHAT_ID

+ Actions页面选择 Repo Dispatcher 点击 Run workflow
### 2.2 **GitHub结合浏览器插件编译**
请在支持油猴的浏览器中安装 [脚本](https://greasyfork.org/scripts/407616-github-actions-trigger/code/Github%20Actions%20Trigger.user.js) ,仓库右上角会出现 x86_64 Actions,K2P Actions等按钮,点击对应按钮即可.更多玩法 [repo-dispatcher](https://github.com/tete1030/github-repo-dispatcher)

## 3. **使用**

### 3.1 **后台**

+ 登录地址 192.168.3.1 (若后台无法打开，请尝试插拔交换wan、lan网线顺序。)

+ 默认用户 root

+ 默认密码 root



## 4. **注意事项**

+ 第一次使用请采用全新安装,避免出现升级失败以及其他一些可能的Bug.

+ 云编译需要 [在此](https://github.com/settings/tokens) 创建个token,然后在此仓库Settings->Secrets中添加个名字为REPO_TOKEN的Secret,填入token值,否者无法触发编译。

+ 在仓库Settings->Secrets中分别添加 PPPOE_USERNAME, PPPOE_PASSWD 可设置默认拨号账号密码

+ 在仓库Settings->Secrets中添加 SCKEY 可通过[Server酱](http://sc.ftqq.com) 推送编译结果到微信。

+ 在仓库Settings->Secrets中添加 TELEGRAM_CHAT_ID, TELEGRAM_TOKEN 可推送编译结果到Telegram Bot. [教程](https://longnight.github.io/2018/12/12/Telegram-Bot-notifications)

+ DIY云编译教程参考: [Read the details in my blog (in Chinese) | 中文教程](https://p3terx.com/archives/build-openwrt-with-github-actions.html)


+ 默认插件包含: Opkg 软件包管理、openclash、ddns-go、adblock（广告拦截）。
其他插件请自行在 后台->软件包 中安装,系统升级不会丢失插件.每次系统升级完成连接网络后,会自动安装所有已自选安装的插件。



## Acknowledgments


- [OpenWrt](https://github.com/openwrt/openwrt)
- [Lean's OpenWrt](https://github.com/coolsnowwolf/lede)
- [ImmortalWrt](https://github.com/immortalwrt/immortalwrt)
- [P3TERX](https://github.com/P3TERX/Actions-OpenWrt/blob/master/LICENSE)
- [GitHub Actions](https://github.com/features/actions)


