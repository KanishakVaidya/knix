{ self, config, lib, pkgs, userSettings, inputs, system, ... }:

{
  imports = [ ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = userSettings.username;
  home.homeDirectory = "/home/${userSettings.username}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = (with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    hyprland
    bat htop btop eza direnv stow neovim ripgrep
    eww tofi rofi waybar networkmanager_dmenu 
    foot brave lxqt.pcmanfm-qt geany-with-vte thunderbird-bin celestia zathura
    onlyoffice-desktopeditors libreoffice-fresh nomacs gimp emacs-pgtk signal-desktop xournalpp transmission_4-qt mpv
    lxqt.lxqt-archiver unzip unrar p7zip pwvucontrol jq 
    python312Packages.python
    nerd-fonts.jetbrains-mono nerd-fonts.droid-sans-mono nerd-fonts.fira-code lohit-fonts.devanagari
    # (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" "DroidSansMono" "FiraCode" ]; })
    texliveFull texlab
    libsForQt5.qtstyleplugin-kvantum libsForQt5.qt5ct qt6Packages.qtstyleplugin-kvantum qt6Packages.qt6ct nwg-displays
    libnotify wl-clipboard swaybg swaylock hyprlock hyprsunset
    # Screenshot
    grim slurp swappy hyprshot
    lxqt.lxqt-menu-data lxqt.lxqt-policykit
    # Games
    wineWow64Packages.waylandFull
    lutris protonup-qt ioquake3
    # spell check
    # Also setting up a sessionVariable DICPATH, otherwise hunspell don't know where to find dictionaries
    hunspell hunspellDicts.en_US  # Read comment above before removing this
  ]) ++ (with self.inputs.nix-alien.packages.${system}; [nix-alien]); # ++ ([inputs.noctalia-qs.packages.${system}.quickshell]);

  stylix = {
    enable = false;
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/default-dark.yaml";
    base16Scheme = {
      base00 = "151515";
      base01 = "202020";
      base02 = "404040";
      base03 = "505050";
      base04 = "a0a0a0";
      base05 = "d4d4d4";
      base06 = "e9e9e9";
      base07 = "ffffff";
      base08 = "f44747";
      base09 = "de935f";
      base0A = "d7ba7d";
      base0B = "608b4e";
      base0C = "9cdcfe";
      base0D = "569cd6";
      base0E = "c586c0";
      base0F = "d16969";
    };
    # base16Scheme = {base00 = "262626"; base01 = "343434"; base02 = "373737"; base03 = "666666"; base04 = "888888"; base05 = "e4e4e4"; base06 = "f5f5f5"; base07 = "ffffff"; base08 = "f44747"; base09 = "ffaf00"; base0A = "d7ba7d"; base0B = "4ec9b0"; base0C = "0a7aca"; base0D = "5c6bf8"; base0E = "ddb6f2"; base0F = "d16969";};
    image = /home/keshav/.local/share/backgrounds/000.jpg;
    targets = {
      # gtk.enable = true;
      # kde.enable = true; 
      firefox.enable = true;
    };
    polarity = "dark";
    fonts = {
      monospace = {
        name = "JetBrainsMono Nerd Font";
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" "DroidSansMono" "CascadiaCode" "FiraCode" ]; };
      };
      sizes = {
        terminal = 14;
      };
    };
    cursor = {
      name = "Quintom_Snow";
      package = pkgs.quintom-cursor-theme;
      size = 12;
    };
    opacity = {
      terminal = 0.9;
    };
    targets.btop.enable = false;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  fonts.fontconfig.enable = true;

  # GTK and QT

  home.pointerCursor = {
    name = "Quintom_Snow";
    package = pkgs.quintom-cursor-theme;
  };
  
  gtk = {
    enable = true;
    theme = {
      package = pkgs.materia-theme;
      name = "Materia-dark";
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style = {
      package = pkgs.materia-kde-theme;
      # name = "kvantum";
    };
  };

  xdg.configFile = {
    kvantum = {
      target = "Kvantum/kvantum.kvconfig";
      text = lib.generators.toINI { } {
        General.theme = "MateriaDark";
        Hacks.transparent_pcmanfm_sidepane = true;
        libreoffice.theme = "KvAdapta";
      };
    };

    qt5ct = {
      target = "qt5ct/qt5ct.conf";
      text = lib.generators.toINI { } {
        Appearance = {
          icon_theme = "Papirus-Dark";
          style = "kvantum";
        };
      };
    };

    qt6ct = {
      target = "qt6ct/qt6ct.conf";
      text = lib.generators.toINI { } {
        Appearance = {
          icon_theme = "Papirus-Dark";
          style = "kvantum";
        };
      };
    };
  };

  # wayland.windowManager.hyprland.enable = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # shells
  programs.bash = {
    enable = true;
    bashrcExtra = ''
    PS1="\[\e[35;1m\][\[\e[0;94;3m\]\u\[\e[0m\] \[\e[33;1m\]@\[\e[0m\] \[\e[94;3m\]\w\[\e[0;35;1m\]]\[\e[0m\] "
    '';
  };

  xdg = {
    # enable = true;
    # binHome = "${config.home.homeDirectory}/.local/bin";
    userDirs = {
      enable = true;
      createDirectories = true;
      setSessionVariables = false;  # home-manager warning asked to put this
      desktop = "${config.home.homeDirectory}/desktop";
      documents = "${config.home.homeDirectory}/doc";
      download = "${config.home.homeDirectory}/dwn";
      music = "${config.home.homeDirectory}/music";
      pictures = "${config.home.homeDirectory}/pic";
      projects = "${config.home.homeDirectory}/prj";
      publicShare = "${config.home.homeDirectory}/shared";
      templates = "${config.home.homeDirectory}/templates";
      videos = "${config.home.homeDirectory}/vid";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user.name =  userSettings.username;
      user.email = userSettings.useremail;
    };
  };

  services = {
    mako = {
      enable = true;
      settings={
        sort = "-time";
        layer = "overlay";
        text-color = "#d4d4d4";
        width = 300;
        height = 500;
        border-size = 2;
        border-radius = 15;
        icons = false;
        max-icon-size = 64;
        default-timeout = 10000;
        ignore-timeout = true;
        font = "JetBrainsMono Nerd Font 11";
        border-color = "#88c0d0";
        background-color = "#151515";
        group-by="app-name";
        "urgency=low" = {border-color = "#f0c674";};
        "urgency=normal" = {border-color = "#569cd6";};
        "urgency=high" = {
          border-color = "#f44747";
          progress-color = "over #f44747";
          default-timeout = 59800;
        };
        "app-name=wp-vol" = {
          height = 25;
          width = 300;
          layer = "overlay";
          history = 0;
          anchor = "top-right";
          ignore-timeout = 0;
          format = "<b>%s</b> %b";
          text-alignment = "center";
          margin = 0;
          padding = 0;
          outer-margin = 0;
        };
      };
    };

    syncthing.enable = false;

    kanshi.enable = true;
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-pipewire-audio-capture
    ];
  };

  programs.yazi = {
    enable = true;
    settings = {
      mgr = {
        show_hidden = false;
        sort_by = "alphabetical";
        sort_dir_first = false;
        sort_reverse = false;
      };
    };
    shellWrapperName = "y";
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    dotDir = "${config.xdg.configHome}/zsh";
    history.path = "${config.xdg.dataHome}/zsh/zsh_history";
    initContent = ''
      ${pkgs.fastfetch}/bin/fastfetch
    '';
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = false;
    settings = {
      add_newline = false;
      format=''
      $directory$hostnameॐ $git_branch$git_status$git_state$git_commit $fill $cmd_duration
      $character
      '';
      line_break = {
        disabled = false;
      };
      character = {
        success_symbol = "[❯](#00dd00)";
        error_symbol = "[❯](#ee0000)";
        vimcmd_symbol = "[❮](#00dd00)";
      };
      directory = {
        style = "bold cyan";
        home_symbol = "~";
        truncate_to_repo = false;
      };
      fill = {
        symbol = " ";
      };
      hostname = {
        ssh_only = true;
        ssh_symbol = "肋";
        format = "[$ssh_symbol](bold purple)[$hostname](bold yellow) ";
        disabled = false;
      };
    };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/keshav/etc/profile.d/hm-session-vars.sh
  #

  home.shellAliases = {
    ls = "eza --color=auto --icons=never";
    ll = "eza -lh --color=auto --icons=always";
    lt = "eza --tree --icons=always --level=2";
    lsa = "eza -a --color=always --icons=never";
    lla = "eza -lha --color=auto --icons=always";
    yz = "yazi";
    vim = "nvim";
    cp = "cp -i";
    grep = "grep --colour=auto";
    egrep = "egrep --colour=auto";
    fgrep = "fgrep --colour=auto";
    cmatrix = "cmatrix -ba";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    XDG_DATA_HOME = "${config.home.homeDirectory}/.local/share";
    XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
    XDG_STATE_HOME = "${config.home.homeDirectory}/.local/state";
    MANROFFOPT = "-c";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    # HISTFILE = "${config.home.homeDirectory}/.local/state/bash/history";
    CUDA_CACHE_PATH = "${config.home.homeDirectory}/.cache/nv";
    GTK2_RC_FILES = "${config.home.homeDirectory}/.config/gtk-2.0/gtkrc";
    KERAS_HOME = "${config.home.homeDirectory}/.local/state/keras";
    LESSHISTFILE = "${config.home.homeDirectory}/.cache/less/history";
    TEXMFVAR = "${config.home.homeDirectory}/.cache/texlive/texmf-var";
    HISTFILE = "${config.home.homeDirectory}/.local/state/zsh/history";
    IPYTHONDIR = "${config.home.homeDirectory}/.config/ipython";
    JUPYTER_CONFIG_DIR = "${config.home.homeDirectory}/.config/jupyter";
    NUGET_PACKAGES = "${config.home.homeDirectory}/.cache/NuGetPackages";
    W3M_DIR = "${config.home.homeDirectory}/.local/share/w3m";
    NOTES_DIR = "${config.home.homeDirectory}/doc/notes";

    # Adding otherwise hunspell doesn't know where are the dictionaries
    DICPATH = "${pkgs.hunspellDicts.en_US}/share/hunspell";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
