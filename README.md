<div align="center">
    <img src="https://daiderd.com/nix-darwin/images/nix-darwin.png" width="200px" alt="logo"/>
</div>

# My Nix Darwin Configuration

This repository contains my personal configuration for [Nix Darwin](https://daiderd.com/nix-darwin/), a macOS system configuration tool built on top of [Nix](https://nixos.org/). It allows me to declaratively manage my macOS setup, including system settings, installed packages, and custom dotfiles.

## 🚀 Features

- Declarative macOS configuration
- Automated package management with Nix
- Custom dotfiles and scripts
- System preferences managed through code

## 📦 Installation

1. **Clone this repository:**

   ```bash
   git clone https://github.com/your-username/your-repo-name.git
   cd your-repo-name
   ```

2. **Install Nix (if not already installed):**

   Follow the instructions from the [official Nix installation guide](https://nixos.org/download.html).

3. **Set up Nix Darwin:**

   ```bash
   nix run github:LnL7/nix-darwin
   ```

4. **Apply the configuration:**

   ```bash
   darwin-rebuild switch --flake .
   ```

## 🔧 Usage

- To apply new changes:

  ```bash
  darwin-rebuild switch --flake .
  ```

- To update your system:
  ```bash
  nix flake update
  ```

## 📄 License

This project is licensed under the [MIT License](LICENSE).

---

Happy Hacking! 🤘
