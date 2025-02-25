{
  description = "Fullstack nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    mac-app-util.url = "github:hraban/mac-app-util";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    }; 
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, mac-app-util, nix-homebrew, homebrew-bundle, homebrew-core, homebrew-cask, nixpkgs }:
  let
    configuration = { pkgs, config, ... }: {
      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs; [
        # CLI tools
        vim
        tree
        mkalias
        git
        yarn
        ddev
        fontconfig
        freetype
        gettext
        gh
        maven
        mysql84
        mongosh
        jdk17
        openssh
        pyenv
        python39
        starship
        subversion
        wp-cli
        yarn

        # Browsers
        arc-browser
        google-chrome
        firefox
        firefox-devedition
        brave

        # Development tools
        code-cursor
        vscode
        filezilla
        warp-terminal
        jetbrains.idea-community
        jetbrains.pycharm-community

        # Databases
        mongodb-compass
        sequelpro
        tableplus

        # DevOps
        docker
        postman
        
        # IM & Social
        discord
        slack

        # Utilities
        github-desktop
        gitkraken
        imageoptim
        keka
        utm

        # Productivity
        _1password-gui
        obsidian

        # Misc
        spotify
      ];

      homebrew = {
        enable = true;
        brews = [
          "nvm"
          "mas"
          "php"
          "composer"
          "curl"
          "lando-cli"
        ];
        casks = [
          "adobe-acrobat-reader"
          "alfred"
          "figma"
          "local"
          "notion"
          "onyx"
          "sourcetree"
          "masscode"
          # "docker" Docker Desktop if pkg don't work
        ];
        taps = {
          "homebrew/homebrew-core" = homebrew-core;
          "homebrew/homebrew-cask" = homebrew-cask;
          "homebrew/homebrew-bundle" = homebrew-bundle;
        };
        # Mac App Store apps
        masApps = {
          "Messanger" = 1480068668;
          "WhatsApp" = 310633997;
          "SparkAI" = 6445813049;
          "Giphy" = 668208984;
          "Windows App" = 1295203466;
          "Jira Cloud" = 1006972087;
          "ColorSlurp" = 1287239339;
          "Gametrack" = 1136800740;
          "Unsplash Wallpapers" = 1284863847;
          "Evernote" = 406056744;
          "CleanMyDrive 2" = 523620159;
        };
        onActivation = {
          autoUpdate = true;
          cleanup = "zap";
          upgrade = true;
        };
      };

      fonts.packages = with pkgs; [
        nerdfonts
        nerd-fonts.jetbrains-mono
        fira-code
        fira-code-symbols
        jetbrains-mono
        mononoki
        roboto
        roboto-mono
        roboto-mono-nerd
      ];

      security = {
        pam.enableSudoTouchIdAuth = true;
      };

      system.defaults = {
        dock.autohide = true; # Hide dock
        finder.AppleShowAllExtensions = true; # Show all file extensions
        screencapture.location = "~/Pictures/screenshots"; # Set location of screenshots
        screensaver.askForPasswordDelay = 10; # Ask for password after 10 seconds
      };

      # Auto upgrade nix package and the daemon service
      services.nix-daemon.enable = true;
      nix.settings.auto-optimise-store = true;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;
      programs.zsh.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake
    darwinConfigurations = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration
        mac-app-util.darwinModules.default
        nix-homebrew.darwinModules.homebrew{
          nix-homebrew = {
            enable = true;
            # Enable Rosetta 2 for Apple Silicon Macs
            enableRosetta = true;
            # Automatically migrate existing formulae and casks to the new package manager
            autoMigrate = true;
          };
        };
      ];
    };
  };
}
