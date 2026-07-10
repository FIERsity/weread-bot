# WeRead Bot

A Python automation toolkit for controlled WeRead web-reading sessions. It supports multiple accounts, configurable reading strategies, scheduled or daemon execution, run statistics, notifications, Docker, and GitHub Actions.

This repository is derived from [funnyzak/weread-bot](https://github.com/funnyzak/weread-bot) and [findmover/wxread](https://github.com/findmover/wxread). See the repository history and license for attribution.

## Features

- Single- and multi-account execution
- Sequential, smart-random, and random reading modes
- Configuration through YAML, environment variables, or CLI options
- Validation, dry runs, execution history, and summary reports
- Optional notifications and containerized deployment

## Quick start

```bash
git clone https://github.com/FIERsity/weread-bot.git
cd weread-bot
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
cp config.example.yaml config.yaml
python weread-bot.py --validate-config --config config.yaml
python weread-bot.py --dry-run --config config.yaml
python weread-bot.py --config config.yaml
```

Provide a valid WeRead web request through `WEREAD_CURL_STRING` or `WEREAD_CURL_BASH_FILE_PATH`. Treat captured requests as credentials: never share or commit them.

For detailed configuration and deployment instructions, see [docs/README.md](docs/README.md).

## Responsible use

This project is intended for personal learning and testing. Automated activity may violate platform rules or trigger account restrictions. Use conservative settings, protect authentication material, and accept all account and data risks.

## License

MIT. Upstream attribution is retained in accordance with the license.

---

## 中文

一个用于微信读书网页会话的 Python 自动化工具，支持多账号、阅读策略、定时或守护运行、统计报告、消息通知、Docker 与 GitHub Actions。

本仓库基于 [funnyzak/weread-bot](https://github.com/funnyzak/weread-bot) 与 [findmover/wxread](https://github.com/findmover/wxread) 整理开发，来源与许可信息见提交历史及许可证。

### 快速开始

```bash
git clone https://github.com/FIERsity/weread-bot.git
cd weread-bot
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
cp config.example.yaml config.yaml
python weread-bot.py --validate-config --config config.yaml
python weread-bot.py --dry-run --config config.yaml
python weread-bot.py --config config.yaml
```

通过 `WEREAD_CURL_STRING` 或 `WEREAD_CURL_BASH_FILE_PATH` 提供有效请求。抓包内容等同于账号凭据，请勿分享或提交。详细配置见 [docs/README.md](docs/README.md)。

本项目仅供个人学习与测试。自动化行为可能违反平台规则或触发账号限制，请谨慎设置并自行承担风险。
