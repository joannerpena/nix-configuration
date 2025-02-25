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
   git clone https://github.com/joannerpena/nix-configuration nix-darwin
   cd nix-darwin
   ```

2. **Install Nix (if not already installed):**

   Follow the instructions from the [official Nix installation guide](https://nixos.org/download.html).

3. **Install Rosetta**

   ```bash
   softwareupdate --install-rosetta --agree-to-license
   ```

4. **Set up Nix Darwin:**

   ```bash
   nix --extra-experimental-features 'nix-command flakes' run nix-darwin -- switch --flake ~/.config/nix-darwin
   ```

5. **Apply the configuration:**

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
