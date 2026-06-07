{ self, config, lib, pkgs, userSettings, inputs, system, ... }:

{
  imports = [
    inputs.ignis.homeManagerModules.default
    inputs.zen-browser.homeModules.beta
    # or inputs.zen-browser.homeModules.twilight
    # or inputs.zen-browser.homeModules.twilight-official
    inputs.noctalia.homeModules.default
  ];

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

  # ZEN BETA BROWSER
  programs.zen-browser = {
    enable = true;
  };
  

  # IGNIS
  programs.ignis = {
    enable = true; 
    # addToPythonEnv = true;
    services = {
      # bluetooth.enable = true;
      # recorder.enable = true;
      audio.enable = true;
      network.enable = true;
    };
    sass = {
      enable = true;
      useDartSass = true;
    };
  };

  # Noctalia shell
  programs.noctalia-shell.enable = true;
  
  
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
    bat htop eza direnv stow neovim
    eww tofi rofi waybar networkmanager_dmenu 
    foot brave lxqt.pcmanfm-qt geany-with-vte thunderbird-bin celestia
    onlyoffice-desktopeditors libreoffice-fresh nomacs gimp emacs-pgtk signal-desktop xournalpp transmission_4-qt mpv
    lxqt.lxqt-archiver unzip unrar p7zip pwvucontrol jq 
    python312Packages.python-lsp-server python312Packages.ipython python312Packages.python
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
  ]) ++ (with self.inputs.nix-alien.packages.${system}; [nix-alien]) ++ ([inputs.noctalia-qs.packages.${system}.quickshell]);

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
        package = pkgs.nerd-fonts.jetbrains-mono;
      };
      sizes = {
        terminal = 14;
      };
    };
    cursor = {
      name = "Quintom_Snow";
      package = pkgs.quintom-cursor-theme;
      size = 15;
    };
    opacity = {
      terminal = 0.9;
    };
    targets.btop.enable = false;
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "TTY";
      theme_background = false;
      truecolor = true;
      force_tty = false;
      proc_sorting = "memory";
      vim_keys = true;
    };
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "$HOME/.config/fastfetch/nix.txt";
        padding = {right = 1;};
      };
      modules = [
        "break" "title" "separator"
        # "os"
        "host" "kernel" "uptime"
        # "packages"
        "shell" "display"
        # "de" "wm" "wmtheme" "theme" "icons" "font" "cursor"
        "terminal" "terminalfont" "cpu" "gpu"
        # "memory" "swap" "disk"
        "localip"
        # "battery" "poweradapter" "locale"
        "break" "colors"
      ];
    };
  };

  programs.foot = {
    enable = true;
    settings = {
      main = {font = "JetBrainsMono Nerd Font :size=13";};
      colors-dark = {
        alpha = "0.9";
        background = "1e1e1e";
        foreground = "d4d4d4";
        regular0 = "505050";  # black
        regular1 = "f44747";  # red
        regular2 = "608b4e";  # green
        regular3 = "d7ba7d";  # yellow
        regular4 = "569cd6";  # blue
        regular5 = "c586c0";  # magenta
        regular6 = "9cdcfe";  # cyan
        regular7 = "e9e9e9";  # white
        dim0 = "505050";   # bright black
        dim1 = "d16969";   # bright red
        dim2 = "b5c3a8";   # bright green
        dim3 = "c39178";   # bright yellow
        dim4 = "4ec9b0";   # bright blue
        dim5 = "646695";   # bright magenta
        dim6 = "9cdcfe";   # bright cyan
        dim7 = "ffffff";   # bright white
      };
    };
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 13;
    };
    settings = {
      background_opacity = 0.95;
      narrow_symbol = "U+0900-U+097F 2";
      symbol_map = "U+0900-U+097F Yatra One";
      enable_audio_bell = false;
    };
  };

  home.file."doomEmacs" = {
    enable = false;
    source = ./dotfiles/doom;
    target = ".config/doom";
    recursive = true;
  };

  home.file."waybar" = {
    enable = false;
    source = ./dotfiles/waybar;
    target = ".config/waybar";
    recursive = true;
  };

  home.file."rofi" = {
    enable = false;
    source = ./dotfiles/rofi;
    target = ".config/rofi";
    recursive = true;
  };

  home.file."swappy" = {
    enable = false;
    source = ./dotfiles/swappy;
    target = ".config/swappy";
    recursive = true;
  };

  programs.mpv = {
    enable = false;
    bindings = {
      WHEEL_UP = "add volume 5";
      WHEEL_DOWN = "add volume -5";
      WHEEL_LEFT = "seek -10";
      WHEEL_RIGHT = "seek 10";
      RIGHT = "seek  10";
      LEFT = "seek -10";
      "Shift+RIGHT" =  "seek  3";
      "Shift+LEFT" = "seek -3";
      "Ctrl+RIGHT" = "seek  60";
      "Ctrl+LEFT" = "seek -60";
      UP = "add volume 5";
      DOWN = "add volume -5";
      "Ctrl+Shift+LEFT" = "sub-step -1";
      "Ctrl+Shift+RIGHT" = "sub-step 1";
      PGUP = "add chapter 1";
      PGDWN = "add chapter -1";
      "Shift+PGUP" = "seek 600";
      "Shift+PGDWN" = "seek -600";
      SPACE = "cycle pause";
      "[" = "add speed -0.1";
      "]" = "add speed 0.1";
      "{" = "multiply speed 0.5";
      "}" = "multiply speed 2.0";
      "q" = "quit";
      "Q" = "quit-watch-later";
      "p" = "cycle pause";
      "." = "frame-step";
      "," = "frame-back-step";
      ">" = "playlist-next";
      "<" = "playlist-prev";
      "o" = "show-progress";
      "P" = "show-progress";
      "m" = "cycle mute";
      "v" = "cycle sub-visibility";
      "j" = "cycle sub";
      "J" = "cycle sub down";
      "b" = "cycle audio";
      "f" = "cycle fullscreen";
      "s" = "screenshot";
      "S" = "screenshot video";
    };
    config = {keep-open = "yes";};
  };

  # programs.neovim = {
  #   enable = true;
  #   extraConfig = ''
  #     set number
  #     set relativenumber
  #     set mouse=nv
  #     set linebreak
  #     set breakindent
  #     set incsearch
  #     set ignorecase
  #     set smartcase
  #     set scrolloff=4
  #     set tabstop=4
  #     set shiftwidth=4
  #     set expandtab
  #     set cursorline
  #     let mapleader = ' '
  #     let maplocalleader = ' '
  #     filetype plugin indent on
  #     syntax on
  #     hi MatchParen cterm=bold ctermbg=none ctermfg=red   
  #     set clipboard=unnamedplus
  #     " let g:tex_flavor = "latex"

  #     noremap <C-h> <C-w>h
  #     noremap <C-j> <C-w>j
  #     noremap <C-k> <C-w>k
  #     noremap <C-l> <C-w>l
  #     noremap <C-up> <C-W>+
  #     noremap <C-down> <C-W>-
  #     noremap <C-right> <C-W>>
  #     noremap <C-left> <C-W><
      
  #     " Surround
  #     function! Surround()
  #         let sur = nr2char(getchar())
  #         if sur == "(" || sur == ")"
  #             exe "normal! gv\"sd\<Esc>i(\<Esc>\"spa)"
  #         elseif sur == "[" || sur == "]"
  #             exe "normal! gv\"sd\<Esc>i[\<Esc>\"spa]"
  #         elseif sur == "{" || sur == "}"
  #             exe "normal! gv\"sd\<Esc>i{\<Esc>\"spa}"
  #         else
  #             exe "normal! gv\"sd\<Esc>i" . sur . "\<esc>\"spa" . sur
  #         endif
  #     endfunction
      
  #     vnoremap s :call Surround()<CR>
      
  #     " Find files using Telescope command-line sugar.
  #     nnoremap <leader>fr <cmd>Telescope oldfiles<cr>
  #     nnoremap <leader>ff <cmd>Telescope find_files<cr>
  #     nnoremap <leader>ht <cmd>Telescope colorscheme<cr>
  #     nnoremap <leader>fg <cmd>Telescope live_grep<cr>
  #     nnoremap <leader>fb <cmd>Telescope buffers<cr>
  #     nnoremap <leader>fh <cmd>Telescope help_tags<cr>
  #   '';
  #   plugins = with pkgs.vimPlugins; [
  #     # lightline-vim
  #     {plugin = lightline-vim; config = "set noshowmode";}
  #     {
  #       plugin = vim-code-dark;
  #       config = ''
  #         let base16colorspace=256
  #         set termguicolors
  #         colorscheme codedark
  #       '';
  #     }
  #   ];
  #   coc = {
  #     enable = true;
  #     pluginConfig = ''
  #       " Enter should select the coc.completion candidate
  #       inoremap <expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"
  #       function! s:check_back_space() abort
  #         let col = col('.') - 1
  #         return !col || getline('.')[col - 1]  =~ '\s'
  #       endfunction
        
  #       " Insert <tab> when previous text is space, refresh completion if not.
  #       inoremap <silent><expr> <TAB>
  #         \ coc#pum#visible() ? coc#pum#next(1):
  #         \ <SID>check_back_space() ? "\<Tab>" :
  #         \ coc#refresh()
  #       inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
  #     '';
  #   };
  # };

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

  xdg.configFile."hyprScripts" = {
    enable = false;
    source = ./dotfiles/hypr/scripts;
    target = "hypr/scripts";
    recursive = true;
  };

  home.file."hyprlock" = {
    enable = false;
    source = ./dotfiles/hypr/hyprlock.conf;
    target = ".config/hypr/hyprlock.conf";
  };

  home.file."hyprmonitors" = {
    enable = false;
    source = ./dotfiles/hypr/default-monitors.conf;
    target = ".config/hypr/default-monitors.conf";
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

  programs.zathura = {
    enable = true;
  #   options = {
  #     font = "JetBrainsMono Nerd Font 14";
  #     first-page-column = 1;
  #     notification-error-bg =   "#1e1e1e"; # bg
  #     notification-error-fg =   "#f44747"; # bright:red
  #     notification-warning-bg = "#1e1e1e"; # bg
  #     notification-warning-fg = "#d7ba7d"; # bright:yellow
  #     notification-bg =         "#1e1e1e"; # bg
  #     notification-fg =         "#608b4e"; # bright:green
  #     completion-bg =           "#0f1011"; # bg2
  #     completion-fg =           "#e1e1e1"; # fg
  #     completion-group-bg =     "#3c3836"; # bg1
  #     completion-group-fg =     "#928374"; # gray
  #     completion-highlight-bg = "#569cd6"; # bright:blue
  #     completion-highlight-fg = "#0f1011"; # bg2
  #     # Define the color in index mode
  #     index-bg =                    "#0f1011"; # bg2
  #     index-fg =                    "#e1e1e1"; # fg
  #     index-active-bg =             "#569cd6"; # bright:blue
  #     index-active-fg =             "#0f1011"; # bg2
  #     inputbar-bg =                 "#282828"; # bg
  #     inputbar-fg =                 "#e1e1e1"; # fg
  #     statusbar-bg =                "#0f1011"; # bg2
  #     statusbar-fg =                "#e1e1e1"; # fg
  #     highlight-color =             "#00ff00"; # bright:yellow
  #     highlight-active-color =      "#00fa9a"; # bright:orange
  #     highlight-transparency =      "0.4";
  #     default-bg =                  "#1e1e1e"; # bg
  #     default-fg =                  "#e1e1e1"; # fg
  #     render-loading =              true;
  #     render-loading-bg =           "#1e1e1e"; # bg
  #     render-loading-fg =           "#e1e1e1"; # fg
  #     recolor-lightcolor =          "#1e1e1e"; # bg
  #     recolor-darkcolor =           "#e1e1e1"; # fg
  #   };
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
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
