{ self, config, lib, pkgs, userSettings, inputs, system, ... }:

{
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
  home.stateVersion = "24.05"; # Please read the comment before changing.
  
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
    bat htop freshfetch eza direnv
    tofi rofi-wayland waybar networkmanager_dmenu
    foot firefox brave lxqt.pcmanfm-qt geany-with-vte
    onlyoffice-bin nomacs gimp emacs-gtk signal-desktop xournalpp transmission-qt
    lxqt.lxqt-archiver unzip unrar p7zip pulseaudio lxqt.pavucontrol-qt jq 
    python311Packages.python-lsp-server python311Packages.ipython 
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" "DroidSansMono" "FiraCode" ]; }) lohit-fonts.devanagari
    texliveFull texlab
    libsForQt5.qtstyleplugin-kvantum libsForQt5.qt5ct qt6Packages.qtstyleplugin-kvantum qt6Packages.qt6ct
    libnotify wl-clipboard swaybg hyprlock
    # Screenshot
    grim slurp swappy
    lxqt.lxqt-menu-data lxqt.lxqt-policykit
    # Games
    lutris protonup-qt ioquake3
  ]) ++ (with self.inputs.nix-alien.packages.${system}; [nix-alien]);

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

  programs.foot = {
    enable = true;
    settings = {
      main = {font = "JetBrainsMono Nerd Font :size=16";};
      colors = {
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

  home.file."doomEmacs" = {
    enable = true;
    source = ./dotfiles/doom;
    target = ".config/doom";
    recursive = true;
  };

  home.file."waybar" = {
    enable = true;
    source = ./dotfiles/waybar;
    target = ".config/waybar";
    recursive = true;
  };

  home.file."rofi" = {
    enable = true;
    source = ./dotfiles/rofi;
    target = ".config/rofi";
    recursive = true;
  };

  home.file."swappy" = {
    enable = true;
    source = ./dotfiles/swappy;
    target = ".config/swappy";
    recursive = true;
  };

  programs.mpv = {
    enable = true;
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

  programs.neovim = {
    enable = true;
    extraConfig = ''
      set number
      set relativenumber
      set mouse=nv
      set linebreak
      set breakindent
      set incsearch
      set ignorecase
      set smartcase
      set scrolloff=4
      set tabstop=4
      set shiftwidth=4
      set expandtab
      set cursorline
      let mapleader = ' '
      let maplocalleader = ' '
      filetype plugin indent on
      syntax on
      hi MatchParen cterm=bold ctermbg=none ctermfg=red   
      set clipboard=unnamedplus
      " let g:tex_flavor = "latex"

      noremap <C-h> <C-w>h
      noremap <C-j> <C-w>j
      noremap <C-k> <C-w>k
      noremap <C-l> <C-w>l
      noremap <C-up> <C-W>+
      noremap <C-down> <C-W>-
      noremap <C-right> <C-W>>
      noremap <C-left> <C-W><
      
      " Surround
      function! Surround()
          let sur = nr2char(getchar())
          if sur == "(" || sur == ")"
              exe "normal! gv\"sd\<Esc>i(\<Esc>\"spa)"
          elseif sur == "[" || sur == "]"
              exe "normal! gv\"sd\<Esc>i[\<Esc>\"spa]"
          elseif sur == "{" || sur == "}"
              exe "normal! gv\"sd\<Esc>i{\<Esc>\"spa}"
          else
              exe "normal! gv\"sd\<Esc>i" . sur . "\<esc>\"spa" . sur
          endif
      endfunction
      
      vnoremap s :call Surround()<CR>
      
      " Find files using Telescope command-line sugar.
      nnoremap <leader>fr <cmd>Telescope oldfiles<cr>
      nnoremap <leader>ff <cmd>Telescope find_files<cr>
      nnoremap <leader>ht <cmd>Telescope colorscheme<cr>
      nnoremap <leader>fg <cmd>Telescope live_grep<cr>
      nnoremap <leader>fb <cmd>Telescope buffers<cr>
      nnoremap <leader>fh <cmd>Telescope help_tags<cr>
    '';
    plugins = with pkgs.vimPlugins; [
      # lightline-vim
      {plugin = lightline-vim; config = "set noshowmode";}
      {
        plugin = vim-code-dark;
        config = ''
          let base16colorspace=256
          set termguicolors
          colorscheme codedark
        '';
      }
    ];
    coc = {
      enable = true;
      pluginConfig = ''
        " Enter should select the coc.completion candidate
        inoremap <expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"
        function! s:check_back_space() abort
          let col = col('.') - 1
          return !col || getline('.')[col - 1]  =~ '\s'
        endfunction
        
        " Insert <tab> when previous text is space, refresh completion if not.
        inoremap <silent><expr> <TAB>
          \ coc#pum#visible() ? coc#pum#next(1):
          \ <SID>check_back_space() ? "\<Tab>" :
          \ coc#refresh()
        inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
      '';
    };
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
      name = "kvantum";
    };
  };

  xdg.configFile = {
    kvantum = {
      target = "Kvantum/kvantum.kvconfig";
      text = lib.generators.toINI { } {
        General.theme = "MateriaDark";
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

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ",preferred,auto,1";
      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      "$mainMod" = "SUPER";
      exec-once = [
        "~/.config/hypr/scripts/bg.sh"
        "mako"
        "waybar"
        "lxqt-policykit-agent"
        "hyprctl setcursor Quintom_Snow 24"
      ];
      bind = [
        "$mainMod, Return, exec, foot"
        "$mainMod, v, exec, alacritty"
        "$mainMod_SHIFT, Return, exec, firefox"
        "$mainMod_CONTROL, Return, exec, firefox --private-window"
        "$mainMod+ALT, Return, exec, brave --tor"
        "$mainMod, t, exec, emacs || geany"
        "$mainMod, q, killactive,"
        "$mainMod, e, exec, pcmanfm-qt"
        "$mainMod, space, exec,rofi -show combi"
        "$mainMod, P, pseudo, # dwindle"
        "$mainMod, d, togglesplit, # dwindle"
        "$mainMod_SHIFT, o, exec, rofi-open # dwindle"
        "$mainMod_SHIFT, p, exec, ~/.config/hypr/scripts/display.sh # dwindle"
        "$mainMod, w, togglegroup,"
        "$mainMod, s, changegroupactive,"
        "$mainMod, f, fullscreen,"
        "$mainMod_SHIFT, f, togglefloating,"

        # Move focus with mainMod + arrow keys
        "$mainMod, left,  movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up,    movefocus, u"
        "$mainMod, down,  movefocus, d"
        "$mainMod, h,     movefocus, l"
        "$mainMod, l,     movefocus, r"
        "$mainMod, k,     movefocus, u"
        "$mainMod, j,     movefocus, d"

        # Move window to direction

        "$mainMod_CONTROL, h,    moveintogroup, l"
        "$mainMod_CONTROL, j,    moveintogroup, d"
        "$mainMod_CONTROL, k,    moveintogroup, u"
        "$mainMod_CONTROL, l,    moveintogroup, r"
        
        "$mainMod_SHIFT, left,    movewindoworgroup, l"
        "$mainMod_SHIFT, right,   movewindoworgroup, r"
        "$mainMod_SHIFT, up,      movewindoworgroup, u"
        "$mainMod_SHIFT, down,    movewindoworgroup, d"
        "$mainMod_SHIFT, h,       movewindoworgroup, l"
        "$mainMod_SHIFT, j,       movewindoworgroup, d"
        "$mainMod_SHIFT, k,       movewindoworgroup, u"
        "$mainMod_SHIFT, l,       movewindoworgroup, r"

      ] ++ (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
              "$mainMod SHIFT, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
            ]
          )
          10)
      );
    };
    extraConfig = ''
# ###########################
# xdg-ninja specifications #
# ###########################
env = XDG_DATA_HOME,$HOME/.local/share
env = XDG_CONFIG_HOME,$HOME/.config
env = XDG_STATE_HOME,$HOME/.local/state
env = XDG_CACHE_HOME,$HOME/.cache

env = MANROFFOPT,"-c"
env = MANPAGER,sh -c 'col -bx | bat -l man -p'

# $HOME/.bash_history
env = HISTFILE,$HOME/.local/state/bash/history

# $HOME/.nv
env = CUDA_CACHE_PATH,$HOME/.cache/nv

# $HOME/.gnupg
env = GNUPGHOME,$HOME/.local/share/gnupg

# $HOME/.gtkrc-2.0
env = GTK2_RC_FILES,$HOME/.config/gtk-2.0/gtkrc

# $HOME/.keras
env = KERAS_HOME,$HOME/.local/state/keras

# $HOME/.lesshst
env = LESSHISTFILE,$HOME/.cache/less/history

# $HOME/.python_history
# env = PYTHONSTARTUP,$HOME/.config/python/pythonrc

# $HOME/.texlive/texmf-var
env = TEXMFVAR,$HOME/.cache/texlive/texmf-var

# # $HOME/.Xauthority
# env = XAUTHORITY,$XDG_RUNTIME_DIR/Xauthority

# $HOME/.histfile
env = HISTFILE,$HOME/.local/state/zsh/history

# $HOME/.ipython
env = IPYTHONDIR,$HOME/.config/ipython

# $HOME/.jupyter
env = JUPYTER_CONFIG_DIR,$HOME/.config/jupyter

# $HOME/.nuget/packages
env = NUGET_PACKAGES,$HOME/.cache/NuGetPackages

# $HOME/.w3m
env = W3M_DIR,$HOME/.local/share/w3m

# $HOME/.zshrc
# this line is added in /etc/zsh/zshenv
# env = ZDOTDIR,$HOME/.config/zsh

# env = PATH,$HOME/.local/bin:$PATH
env = NOTES_DIR,$HOME/doc/notes
# env = EDITOR,nvim
# env = QT_QPA_PLATFORMTHEME,qt5ct

# From Hyprnd Wiki
# env = GDK_BACKEND,wayland;x11
# env = QT_QPA_PLATFORM,wayland;xcb
# env = SDL_VIDEODRIVER,wayland
# env = CLUTTER_BACKEND,wayland
env = XDG_CURRENT_DESKTOP,Hyprland
env = XDG_SESSION_TYPE,wayland
env = XDG_SESSION_DESKTOP,Hyprland
env = QT_AUTO_SCREEN_SCALE_FACTOR,1
env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1

# Don't use NVIDIA
# env = WLR_DRM_DEVICES,/dev/dri/card1
# Loads firefox quickly
env = MOZ_ENABLE_WAYLAND,1
env = WLR_NO_HARDWARE_CURSORS,1
env = TERMINAL,foot
input {
    kb_layout = us,in
    kb_variant =
    kb_model =
    kb_options = ctrl:swapcaps
    kb_rules =

    follow_mouse = 1

    touchpad {
        natural_scroll = yes
        scroll_factor = 0.5
    }

    sensitivity = 0 # -1.0 - 1.0, 0 means no modification.

    tablet {
        output  = HDMI-A-1
    }
}

bindl = ALT_L,SHIFT_L,exec,~/.config/waybar/scripts/lang.sh 1 > /dev/null && pkill -SIGRTMIN+13 waybar
bindr = CAPS,Caps_Lock,exec,pkill -SIGRTMIN+13 waybar

general {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more

    gaps_in = 5
    gaps_out = 5
    border_size = 2
    col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
    col.inactive_border = rgba(595959aa)

    layout = dwindle
    resize_on_border = true
    hover_icon_on_border = true
}

decoration {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more

    rounding = 7

    blur {
        enabled = true
        size = 3
        passes = 1
        new_optimizations = true
    }

    drop_shadow = yes
    shadow_range = 4
    shadow_render_power = 3
    col.shadow = rgba(1a1a1aee)
}

animations {
    enabled = yes

    # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

    bezier = myBezier, 0.05, 0.9, 0.1, 1.05

    animation = windows, 1, 5, myBezier
    animation = windowsOut, 1, 5, default, popin 80%
    animation = border, 1, 5, default
    animation = borderangle, 1, 5, default
    animation = fade, 1, 5, default
    animation = workspaces, 1, 5, default
}

dwindle {
    # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
    pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
    force_split = 2
    preserve_split = true
}

master {
    # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
    new_status = slave
}

gestures {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more
    workspace_swipe = on
}

# Example per-device config
# See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
device {
    name = epic-mouse-v1
    sensitivity = -0.5
}

# Example windowrule v1
# windowrule = float, ^(kitty)$
# Example windowrule v2
# windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
windowrulev2 = float,class:^(lxqt-policykit-agent)$
windowrulev2 = float,title:^(Removable medium is inserted)$
windowrulev2 = float,class:^(lxqt-archiver)$,title:^(Progress)$
windowrulev2 = float,class:^(firefox)$,title:^(Close Firefox)$
windowrulev2 = float,class:^(myfloat)$
windowrulev2 = float,title:^(Copy Files)$

# See https://wiki.hyprland.org/Configuring/Window-Rules/ for more


# Hyprland modes aka
# RESIZE Mode
bind=$mainMod,R,submap,resize

# will start a submap called "resize"
submap=resize

# sets repeatable binds for resizing the active window
binde=,l,resizeactive,10 0
binde=,h,resizeactive,-10 0
binde=,k,resizeactive,0 -10
binde=,j,resizeactive,0 10

binde=CTRL,l,resizeactive,50 0
binde=CTRL,h,resizeactive,-50 0
binde=CTRL,k,resizeactive,0 -50
binde=CTRL,j,resizeactive,0 50
# use reset to go back to the global submap
bind=,escape,submap,reset

# will reset the submap, meaning end the current one and return to the global one
submap=reset


# POWEROFF Mode
bind=$mainMod_SHIFT,x,submap,(l)ock (L)ogout (P)oweroff (R)eboot

# will start a submap called "resize"
submap=(l)ock (L)ogout (P)oweroff (R)eboot

# sets repeatable binds for resizing the active window
binde=,l,exec,hyprlock
binde=SHIFT,l,exit,
binde=SHIFT,p,exec,poweroff
binde=SHIFT,r,exec,reboot

# use reset to go back to the global submap
binde=,l,submap,reset
binde=SHIFT,l,submap,reset
binde=SHIFT,p,submap,reset
binde=SHIFT,r,submap,reset
bind=,escape,submap,reset

# will reset the submap, meaning end the current one and return to the global one
submap=reset
bind = $mainMod,x,exec,hyprlock

# SCREENSHOT Mode
bind=$mainMod,Print,submap,(s)creen (f)ull (a)rea

# will start a submap called "resize"
submap=(s)creen (f)ull (a)rea

# sets repeatable binds for resizing the active window
bind=,s,exec,grim -o $(hyprctl -j monitors | jq -r '.[] | select(.focused) | .name') ~/pic/$(date +Screenshot_%Y%m%d_%H%M%S.png) && notify-send "Screenshot" "Saved in ~/pic/$(date +Screenshot_%Y%m%d_%H%M%S.png)"
bind=,f,exec,grim ~/pic/$(date +Screenshot_%Y%m%d_%H%M%S.png) && notify-send "Screenshot" "Saved in ~/pic/$(date +Screenshot_%Y%m%d_%H%M%S.png)"
bind=,a,exec,grim -g "$(slurp)" - | swappy -f - && notify-send "Screenshot" "Saved in ~/pic/$(date +Screenshot_%Y%m%d_%H%M%S.png)"

# use reset to go back to the global submap
bind=,s,submap,reset
bind=,f,submap,reset
bind=,a,submap,reset
bind=,escape,submap,reset

# will reset the submap, meaning end the current one and return to the global one
submap=reset
bind = ,Print,exec,grim ~/pic/$(date +Screenshot_%Y%m%d_%H%M%S.png)


# Gaming Mode
# bind=$mainMod,G,submap,(1)RVGL (2)Quake3 (3)0AD (4)Lutris
bind=$mainMod,G,exec,lutris

#  # will start the submap
#  submap=(1)RVGL (2)Quake3 (3)0AD (4)Lutris
#  
#  # sets binds for opening the games
#  binde=,1,execr,(cd ~/pc/games/rvgl_full_linux_original; NIX_LD_LIBRARY_PATH=./lib/lib64 nix-alien-ld ./rvgl.64)
#  binde=,2,exec,~/dwn/quake-iii-arena/ioquake3.x86_64
#  binde=,3,exec,0ad
#  binde=,4,exec,lutris
#  
#  # use reset to go back to the global submap
#  binde=,1,submap,reset
#  binde=,2,submap,reset
#  binde=,3,submap,reset
#  binde=,4,submap,reset
#  bind=,escape,submap,reset
#  
#  # will reset the submap, meaning end the current one and return to the global one
#  submap=reset


bind=$mainMod_SHIFT,d,submap,(c)lose, (C)lose all, (i)nformation, (h)istory
submap=(c)lose, (C)lose all, (i)nformation, (h)istory
bind=,c,exec,makoctl dismiss
bind=SHIFT,c,exec,makoctl dismiss --all
# bind=,i,exec,makoctl menu bemenu -l 10 --fn "JetBrainsMono Nerd Font 20"
bind=,i,exec,makoctl menu rofi -dmenu -p "Select Action: "
bind=,h,exec,makoctl history

bind=,c,submap,reset
bind=SHIFT,c,submap,reset
bind=,i,submap,reset
bind=,h,submap,reset
bind=,escape,submap,reset

# will reset the submap, meaning end the current one and return to the global one
submap=reset


# FREQUENT APPS
bind=$mainMod,o,submap,(1)Signal, (2)Transmission, (3)OBS, (4) Virt Manager

submap=(1)Signal, (2)Transmission, (3)OBS, (4) Virt Manager
bind=,1,exec,signal-desktop
bind=,2,exec,transmission-qt
bind=,3,exec,obs
bind=,4,exec,virt-manager
bind=,1,submap,reset
bind=,2,submap,reset
bind=,3,submap,reset
bind=,4,submap,reset
bind=,escape,submap,reset

# will reset the submap, meaning end the current one and return to the global one
submap=reset

# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
# bind = $mainMod, space, exec,bemenu-run -l 20 -i --line-height 25 --fn "JetBrainsMono Nerd Font 14" --tb \##4e9cb0 --tf \##1e1e1e --hb \##f0c674 --hf \##1e1e1e
# bind = $mainMod, space, exec,tofi-drun
# Moves the active workspace to a monitor
bind = $mainMod_SHIFT, period, movecurrentworkspacetomonitor, r
bind = $mainMod_SHIFT, comma,  movecurrentworkspacetomonitor, l
bind = $mainMod SHIFT, M, swapactiveworkspaces, eDP-1 HDMI-A-1

# Clamping Workspaces to monitor
workspace = 1, monitor:eDP-1
workspace = 2, monitor:eDP-1
workspace = 4, monitor:eDP-1
workspace = 3, monitor:HDMI-A-1
workspace = 5, monitor:HDMI-A-1
workspace = 6, monitor:HDMI-A-1

# Scroll through existing workspaces with mainMod + scroll
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

# Move/resize windows with mainMod + LMB/RMB and dragging
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

# Volume Control
binde=, XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5% ; pkill -SIGRTMIN+11 waybar
binde=, XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5% ; pkill -SIGRTMIN+11 waybar
binde=, XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle ; pkill -SIGRTMIN+11 waybar

# Keyboard Brightness Control
binde=, XF86KbdBrightnessUp,   exec, ~/.config/waybar/scripts/keyboard_bl.sh 'inc'
binde=, XF86KbdBrightnessDown, exec, ~/.config/waybar/scripts/keyboard_bl.sh 'dec'

# Alt Shift changes keyboard layout
bind=ALT,SHIFT,exec,pkill -SIGRTMIN+13 waybar

# Screen Brightness Control
binde=, XF86MonBrightnessUp,   exec, ~/.config/waybar/scripts/amd_bl.sh 4 && pkill -SIGRTMIN+12 waybar
binde=, XF86MonBrightnessDown, exec, ~/.config/waybar/scripts/amd_bl.sh 5 && pkill -SIGRTMIN+12 waybar
    '';
  };

  home.file."hyprScripts" = {
    enable = true;
    source = ./dotfiles/hypr/scripts;
    target = ".config/hypr/scripts";
    recursive = true;
  };

  home.file."hyprlock" = {
    enable = true;
    source = ./dotfiles/hypr/hyprlock.conf;
    target = ".config/hypr/hyprlock.conf";
  };

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
      desktop = "${config.home.homeDirectory}/desktop";
      documents = "${config.home.homeDirectory}/doc";
      download = "${config.home.homeDirectory}/dwn";
      music = "${config.home.homeDirectory}/music";
      pictures = "${config.home.homeDirectory}/pic";
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
    userName = userSettings.username ;
    userEmail = userSettings.useremail;
  };

  services = {
    mako = {
      enable = true;
      sort = "-time";
      layer = "overlay";
      textColor = "#d4d4d4";
      width = 300;
      height = 500;
      borderSize = 2;
      borderRadius = 15;
      icons = false;
      maxIconSize = 64;
      defaultTimeout = 10000;
      ignoreTimeout = true;
      font = "JetBrainsMono Nerd Font 11";
      borderColor = "#88c0d0";
      backgroundColor = "#151515";
      extraConfig = ''
      [urgency=low]
      border-color=#f0c674
      
      [urgency=normal]
      border-color=#569cd6
      
      [urgency=high]
      border-color=#f44747
      default-timeout=59800
        '';
    };

    syncthing = {
      enable = true;
    };
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
      manager = {
        show_hidden = false;
        sort_by = "alphabetical";
        sort_dir_first = false;
        sort_reverse = false;
      };
    };
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    dotDir = ".config/zsh";
    history.path = "${config.xdg.dataHome}/zsh/zsh_history";
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
    ls = "eza --color=auto --icons";
    ll = "eza -lh --color=auto --icons";
    lt = "eza --tree --icons --level=2";
    lsa = "eza -a --color=auto --icons";
    lla = "eza -lha --color=auto --icons";
    yz = "yazi";
    vim = "nvim";
    cp = "cp -i";
    grep = "grep --colour=auto";
    egrep = "egrep --colour=auto";
    fgrep = "fgrep --colour=auto";
    btop = "btop --utf-force";
    cmatrix = "cmatrix -ba";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
