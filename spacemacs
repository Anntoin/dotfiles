;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs

   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused

   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t

   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()

   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(haskell
     ;; Essentials
     spell-checking
     syntax-checking
     version-control
     (git :variables
          magit-revision-show-gravatars nil)
     (auto-completion :variables
                      auto-completion-enable-snippets-in-popup t
                      auto-completion-enable-sort-by-usage t)
     better-defaults

     ;; Navigation
     helm
     neotree

     ;; Language stuff
     (python :variables python-fill-column 79)
     traad
     ;; lsp
     ;; ipython-notebook https://github.com/syl20bnr/spacemacs/issues/10980
     (ruby :variables ruby-test-runner 'rspec)
     html
     yaml
     (markdown :variables markdown-live-preview-engine 'vmd)
     javascript ;; supports coffeescript too :)
     react
     emacs-lisp
     chrome
     perl5

     ;; Misc
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom
            shell-default-full-span nil
            shell-pop-in-hook (
                               )
            shell-default-shell 'multiterm)
     (org :variables
          org-enable-github-support t
          org-enable-bootstrap-support t)
     pandoc
     emoji
     command-log

     ;; Email
     (mu4e :variables
           mu4e-installation-path "~/share/emacs/site-lisp/mu4e")

     ;; Themes
     themes-megapack
     (colors :variables
             colors-enable-nyan-cat-progress-bar t)
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages
   '(
     writeroom-mode
     excorporate
     ;;  evil-mu4e
     ;; Google Calendar Sync
     org-gcal
     request
     alert
     ;; highlight-tail
     ;; mode-icons
     all-the-icons
     ;; selectric-mode
     ;; centered-window-mode
     project-explorer
     ;; col-highlight
     tabbar-ruler
     ;; minimal-fringes
     coffee-mode
     )

   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages
   '(
     mu4e-maildirs-extension
   )

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil then enable support for the portable dumper. You'll need
   ;; to compile Emacs 27 from source following the instructions in file
   ;; EXPERIMENTAL.org at to root of the git repository.
   ;; (default nil)
   dotspacemacs-enable-emacs-pdumper nil

   ;; File path pointing to emacs 27.1 executable compiled with support
   ;; for the portable dumper (this is currently the branch pdumper).
   ;; (default "emacs-27.0.50")
   dotspacemacs-emacs-pdumper-executable-file "emacs-27.0.50"

   ;; Name of the Spacemacs dump file. This is the file will be created by the
   ;; portable dumper in the cache directory under dumps sub-directory.
   ;; To load it when starting Emacs add the parameter `--dump-file'
   ;; when invoking Emacs 27.1 executable on the command line, for instance:
   ;;   ./emacs --dump-file=~/.emacs.d/.cache/dumps/spacemacs.pdmp
   ;; (default spacemacs.pdmp)
   dotspacemacs-emacs-dumper-dump-file "spacemacs.pdmp"

   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t

   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. (default nil)
   dotspacemacs-use-spacelpa nil

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default nil)
   dotspacemacs-verify-spacelpa-archives t

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim

   ;; If non-nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil

   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official

   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'markdown-mode

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(material
                         material-light)

   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `vim-powerline' and `vanilla'. The first three
   ;; are spaceline themes. `vanilla' is default Emacs mode-line. `custom' is a
   ;; user defined themes, refer to the DOCUMENTATION.org for more info on how
   ;; to create your own spaceline theme. Value can be a symbol or list with\
   ;; additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(spacemacs :separator nil)

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state t

   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.
   dotspacemacs-default-font '("DejaVu Sans Mono"
                               :size 10
                               :weight normal
                               :width normal
                               :powerline-scale 1.0)

   ;; The leader key (default "SPC")
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"

   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"

   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"

   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","

   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"

   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil

   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil

   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1

   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache

   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5

   ;; If non-nil, the paste transient-state is enabled. While enabled, pressing
   ;; `p' several times cycles through the elements in the `kill-ring'.
   ;; (default nil)
   dotspacemacs-enable-paste-transient-state nil

   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.3
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line.
   ;; If you use Emacs as a daemon and wants unicode characters only in GUI set
   ;; the value to quoted `display-graphic-p'. (default t)
   dotspacemacs-mode-line-unicode-symbols t

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers nil

   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'origami
   ;; dotspacemacs-folding-method 'evil
   ;; If non-nil `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; If non-nil, start an Emacs server if one is not already running.
   ;; (default nil)
   dotspacemacs-enable-server nil

   ;; Set the emacs server socket location.
   ;; If nil, uses whatever the Emacs default is, otherwise a directory path
   ;; like \"~/.emacs.d/server\". It has no effect if
   ;; `dotspacemacs-enable-server' is nil.
   ;; (default nil)
   dotspacemacs-server-socket-dir nil

   ;; If non-nil,advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server t
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%I@%S"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs nil))

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."
  ;; https://github.com/syl20bnr/spacemacs/issues/10894
  (add-to-list 'default-frame-alist
               '(font . "DejaVu Sans Mono-10"))
  ;; (setenv "WORKON_HOME" "/home/local/ANT/anntoinw/bin/anaconda3/envs")
  )

(defun dotspacemacs/user-load ()
  "Library to load while dumping.
This function is called while dumping Spacemacs configuration. You can
`require' or `load' the libraries of your choice that will be included
in the dump."
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Behaviour
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;; No lockfiles scattered around everywhere
  (setq create-lockfiles nil)

  ;; Follow symlinks
  (setq vc-follow-symlinks t)

  ;; base64 woes
  (setq tramp-copy-size-limit nil)
  (setq tramp-inline-compress-start-size nil)

  ;; Tramp verbosity
  (setq tramp-verbose 6)

  ;; reload files when they change on disk,
  ;; e.g. org files edited by another process
  (global-auto-revert-mode)

  ;; Evil modes
  (evil-set-initial-state 'Custom-mode 'normal)

  ;; Company mode auto completion
  ;; (global-company-mode)

  ;; Open buffer in selected windows
  (setq ido-default-buffer-method 'selected-window)

  ;; Refresh Magit after saving a file, if more powerful version is needed see magit-filenotify
  ;; (add-hook 'after-save-hook 'magit-after-save-refresh-status)

  ;; Use agignore
  (setq helm-ag-use-agignore t)

  ;; Spacemacs for editing git commits
  (global-git-commit-mode t)

  ;; Center when only one window open
  ;; (centered-window-mode t)

  ;; Even windows
  (setq window-combination-resize nil)

  ;; Javascript Options
  (setq-default js2-basic-offset 2
                js-indent-level 2)

  ;; Auto-close compliation window
  (setq compilation-finish-functions 'compile-autoclose)
  (defun compile-autoclose (buffer string)
    (cond ((string-match "finished" string)
           (bury-buffer "*compilation*")
           (winner-undo)
           (message "Build successful."))
          (t
           (message "Compilation exited abnormally: %s" string))))

  ;; Fix for neotree when switching between projects
  (setq projectile-switch-project-action 'neotree-projectile-action)

  ;; Enable persistent undo
  ;; May have issues, see https://github.com/syl20bnr/spacemacs/issues/774
  (unless (file-exists-p (concat spacemacs-cache-directory "undo"))
    (make-directory (concat spacemacs-cache-directory "undo")))
  (setq undo-tree-auto-save-history t
        undo-tree-history-directory-alist
        `(("." . ,(concat spacemacs-cache-directory "undo"))))

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Appearance
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;; Pretty
  ;; (highlight-tail-mode)
  ;; (mode-icons-mode)
  (spacemacs/enable-transparency)


  (load-file "~/.emacs.d/private/local/minimal-fringes/minimal-fringes.el")
  (spacemacs/toggle-truncate-lines-on)
  ;; (spacemacs/toggle-vi-tilde-fringe-off)

  ;; Fill column indicator
  (turn-on-fci-mode)

  (setq powerline-default-separator 'nil)

  ;; Multicursors
  (global-evil-mc-mode  1)

  ;; Tabbar
  ;; (setq tabbar-ruler-global-tabbar t)
  ;; (require 'tabbar-ruler)
  ;; (tabbar-ruler-group-by-projectile-project)

  ;; Tabbar settings
  ;; (set-face-attribute
  ;; 'tabbar-default nil
  ;; :background "gray20"
  ;; :foreground "gray20"
  ;; :box '(:line-width 1 :color "gray20" :style nil))
  ;; (set-face-attribute
  ;; 'tabbar-unselected nil
  ;; :background "gray30"
  ;; :foreground "white"
  ;; :box '(:line-width 2 :color "gray30" :style nil))
  ;; (set-face-attribute
  ;; 'tabbar-selected nil
  ;; :background "gray75"
  ;; :foreground "black"
  ;; :box '(:line-width 2 :color "gray75" :style nil))
  ;; (set-face-attribute
  ;; 'tabbar-highlight nil
  ;; :background "white"
  ;; :foreground "black"
  ;; :underline nil
  ;; :box '(:line-width 2 :color "white" :style nil))
  ;; (set-face-attribute
  ;; 'tabbar-button nil
  ;; :box '(:line-width 1 :color "gray20" :style nil))
  ;; (set-face-attribute
  ;; 'tabbar-separator nil
  ;; :background "gray20"
  ;; :height 0.4)


  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Mode preferences
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;; web-mode indents
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)

  (setq traad-server-program "~/bin/anaconda3/bin/traad")

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Email
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;; Using mbsync see config in ~/.mbsyncrc
  (setq mu4e-maildir "~/.mail/anntoinw@amazon.com"
        mu4e-get-mail-command "mbsync -V -a amazon"
        mu4e-headers-include-related t ;; Conversation style threads
        mu4e-change-filenames-when-moving t
        mu4e-sent-folder "/Sent Items"
        mu4e-drafts-folder "/Drafts"
        ;; mu4e-refile-folder "/Local Archive"
        mu4e-trash-folder  "/Deleted Items"
        mu4e-view-show-images t
        mu4e-view-show-addresses t
        message-kill-buffer-on-exit t
        mu4e-compose-dont-reply-to-self t
        mu4e-index-cleanup nil
        mu4e-index-lazy-check t
        mu4e-index-update-in-background t
        mu4e-index-update-error-warning t
        mu4e-update-interval 240)

  ;; Bookmarks
  (require 'mu4e-utils)
  ;; (mu4e-bookmark-define "date:today..now AND maildir:/Inbox" "Today" "t")
  ;; (mu4e-bookmark-define "date:7d..now AND maildir:/Inbox" "This Week" "w")
  ;; (mu4e-bookmark-define "flag:unread AND NOT flag:trashed AND maildir:/Inbox" "Unread" "u")

  ;; Composing Mail

  ;; Using soft wrapping
  (add-hook 'mu4e-compose-mode-hook
            (lambda ()
              "Soft wrapping"
              (set-fill-column 72)
              (auto-fill-mode 0)
              (visual-fill-column-mode)
              (setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))
              (visual-line-mode)))

  ;; Viewing Mail
  (add-hook 'mu4e-view-mode-hook
            (lambda ()
              "Soft wrapping"
              (set-fill-column 72)
              (auto-fill-mode 0)
              (visual-fill-column-mode)
              (setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))
              (visual-line-mode)))

  ;; enable inline images
  (setq mu4e-view-show-images t)
  ;; use imagemagick, if available
  (when (fboundp 'imagemagick-register-types)
    (imagemagick-register-types))

  (require 'mu4e-contrib)
  (setq mu4e-html2text-command 'mu4e-shr2text)
  ;; (setq mu4e-html2text-command "w3m -T text/html")

  ;; Prefer html emails
  ;; (setq mu4e-view-prefer-html t)

  ;; View html emails with webkit
  ;; works only for emacs with xwidget support
  (defun my-mu4e-action-view-with-xwidget (msg)
    "View the body of the message inside xwidget-webkit."
    (unless (fboundp 'xwidget-webkit-browse-url)
      (mu4e-error "No xwidget support available"))
    (let* ((html (mu4e-message-field msg :body-html))
           (txt (mu4e-message-field msg :body-txt))
           (tmpfile (format "%s%x.html" temporary-file-directory (random t))))
      (unless (or html txt)
        (mu4e-error "No body part for this message"))
      (with-temp-buffer
        ;; simplistic -- but note that it's only an example...
        (insert (or html (concat "<pre>" txt "</pre>")))
        (write-file tmpfile)
        (xwidget-webkit-browse-url (concat "file://" tmpfile) t))))

  ;; (add-to-list 'mu4e-view-actions
  ;;              '("xViewXWidget" . my-mu4e-action-view-with-xwidget) t)

  ;; Smart(ish) re-file
  (setq mu4e-refile-folder
    (lambda (msg)
      (cond
        ;; messages to the Mailing list folders are archived to /Local/Archive/Mailing List/<list-name>...
        ((string-match "Mailing List" (mu4e-message-field msg :maildir))
          (concat "/Local Archive" (mu4e-message-field msg :maildir)))
        ;; messages to the CC'd folders are archived to /Local/Archive/Mailing List/<list-name>...
        ((string-match "CC" (mu4e-message-field msg :maildir))
         (concat "/Local Archive" (mu4e-message-field msg :maildir)))
        ;; messages sent by me go to the sent folder
        ((find-if
          (lambda (addr) (mu4e-message-contact-field-matches msg :from addr))
          mu4e-user-mail-address-list)
         mu4e-sent-folder)
        ;; important to have a catch-all at the end!
       (t  "/Local Archive"))))

  ;; Sending Mail

  ;; Appears to be needed with emacs > 25
  (setq message-send-mail-function 'smtpmail-send-it)
  ;; (setq send-mail-function 'smtpmail-send-it)

  (setq user-mail-address "anntoinw@amazon.com"
        smtpmail-local-domain "amazon.com"
        smtpmail-smtp-user "ANT\\anntoinw"
        smtpmail-smtp-server "ballard.amazon.com"
        smtpmail-stream-type 'starttls
        smtpmail-smtp-service 1587
        smtpmail-auth-credentials  "~/.authinfo"
        send-mail-function 'smtpmail-send-it)


  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Org
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;; Auto-revert all org mode files
  ((org-mode . ((eval . (auto-revert-mode 1)))))

  (setq org-agenda-files (list "~/Org/work.org"
                               "~/Org/todo.org"
                               "~/Org/notes.org")
        org-directory "~/Org"
        org-default-notes-file "~/Org/notes.org")

  (setq org-todo-keywords
        '((sequence "TODO" "IN-PROGRESS" "|" "DONE" "CANCELLED")))

  (setq org-bullets-bullet-list '("■" "◆" "▲" "▶"))

  (require 'org-mu4e)
  (setq org-mu4e-link-query-in-headers-mode nil)

  ;; Org Capture
  (require 'org-capture)
  (require 'org-protocol)

  (defadvice org-capture
    (after make-full-window-frame activate)
    "Advise capture to be the only window when used as a popup"
    (if (equal "emacs-capture" (frame-parameter nil 'name))
        (delete-other-windows)))

  (defadvice org-capture-finalize
    (after delete-capture-frame activate)
    "Advise capture-finalize to close the frame"
    (if (equal "emacs-capture" (frame-parameter nil 'name))
        (delete-frame)))

  (setq org-capture-templates
    '(("t" "todo" entry (file+headline "~/Org/work.org" "Tasks")
       "* TODO: %?
        SCHEDULED: %^t
        %a\n")
      ("n" "work note" entry (file+headline "~/Org/work.org" "Notes")
       "* NOTE: %?
        %^g
        %a\n")
      ("j" "work journal" entry (file+olp+datetree "~/Org/journal.org")
       "* %?
        %^g
        %a\n" :empty-lines 1)
      ("o" "other note" entry (file+headline "~/Org/notes.org" "Notes")
       "* NOTE: %?
        %^g
        %a\n")))

  (setq org-refile-targets '((nil :maxlevel . 6)
                             (org-agenda-files :maxlevel . 6)))

  (setq diary-file "~/Org/diary")

  ;; Google Calendar Org Sync
  (require 'org-gcal)
  (setq org-gcal-client-id "242871172486-9kit9k6i57rhvkb606vu1u0u8tue0fnu.apps.googleusercontent.com"
        org-gcal-client-secret "gk98O6fxvpi6xsbA1VdQ6c2R"
        org-gcal-file-alist '(("anntoin@gmail.com" .  "~/Org/calendar.org")))
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(neo-show-hidden-files nil)
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(excorporate-configuration
   (quote
    ("anntoin@amazon.com" . "https://ballard.amazon.com/ews/exchange.asmx")))
 '(highlight-changes-colors (quote ("#FD5FF0" "#AE81FF")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   (quote
    (("#49483E" . 0)
     ("#679A01" . 20)
     ("#4BBEAE" . 30)
     ("#1DB4D0" . 50)
     ("#9A8F21" . 60)
     ("#A75B00" . 70)
     ("#F309DF" . 85)
     ("#49483E" . 100))) t)
 '(hl-bg-colors
   (quote
    ("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors
   (quote
    ("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(hl-sexp-background-color "#efebe9")
 '(magit-diff-use-overlays nil)
 '(markdown-command "pandoc")
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(package-selected-packages
   (quote
    (org-category-capture diminish memoize goto-chg treemacs-evil treemacs pfuture winum unfill madhat2r-theme fuzzy soap-client autothemer pcache org ntlm undo-tree ein websocket all-the-icons font-lock+ wgrep smex ivy-hydra flyspell-correct-ivy counsel-projectile counsel swiper ivy minitest hide-comnt yapfify uuidgen rake py-isort pug-mode org-projectile org-download mwim mu4e-alert ht livid-mode skewer-mode simple-httpd live-py-mode link-hint git-link flyspell-correct-helm flyspell-correct evil-visual-mark-mode evil-unimpaired evil-ediff eshell-z dumb-jump darkokai-theme column-enforce-mode color-identifiers-mode tabbar-ruler tabbar col-highlight vline web-mode web-beautify tagedit slim-mode scss-mode sass-mode less-css-mode json-mode json-snatcher json-reformat js2-refactor multiple-cursors js2-mode js-doc jade-mode helm-css-scss haml-mode emmet-mode company-web web-completion-data company-tern dash-functional tern coffee-mode rvm ruby-tools ruby-test-mode rubocop rspec-mode robe rbenv chruby bundler inf-ruby project-explorer es-windows es-lib centered-window-mode sublimity selectric-mode mode-icons highlight-tail org-gcal request-deferred deferred excorporate url-http-ntlm fsm evil-mu4e rcirc-notify rcirc-color writeroom-mode visual-fill-column pyvenv pytest pyenv-mode py-yapf pip-requirements hy-mode helm-pydoc cython-mode company-anaconda anaconda-mode pythonic f eyebrowse ranger rainbow-mode rainbow-identifiers yaml-mode zonokai-theme zen-and-art-theme underwater-theme ujelly-theme twilight-theme twilight-bright-theme twilight-anti-bright-theme tronesque-theme toxi-theme tao-theme tangotango-theme tango-plus-theme tango-2-theme sunny-day-theme sublime-themes subatomic256-theme subatomic-theme stekene-theme spacegray-theme soothe-theme soft-stone-theme soft-morning-theme soft-charcoal-theme smyx-theme seti-theme reverse-theme railscasts-theme purple-haze-theme professional-theme planet-theme phoenix-dark-pink-theme phoenix-dark-mono-theme pastels-on-dark-theme organic-green-theme omtose-phellack-theme oldlace-theme occidental-theme obsidian-theme noctilux-theme niflheim-theme naquadah-theme mustang-theme monochrome-theme molokai-theme moe-theme minimal-theme material-theme majapahit-theme lush-theme light-soap-theme jbeans-theme jazz-theme ir-black-theme inkpot-theme heroku-theme hemisu-theme hc-zenburn-theme gruvbox-theme gruber-darker-theme grandshell-theme gotham-theme gandalf-theme flatui-theme flatland-theme firebelly-theme farmhouse-theme espresso-theme dracula-theme django-theme darktooth-theme darkmine-theme darkburn-theme dakrone-theme cyberpunk-theme colorsarenice-theme color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized clues-theme cherry-blossom-theme busybee-theme bubbleberry-theme birds-of-paradise-plus-theme badwolf-theme apropospriate-theme anti-zenburn-theme ample-zen-theme ample-theme alect-themes afternoon-theme zenburn-theme monokai-theme solarized-theme paradox hydra company-statistics adaptive-wrap xterm-color toc-org smeargle shell-pop orgit org-repo-todo org-present org-pomodoro alert log4e gntp org-plus-contrib org-bullets multi-term mmm-mode markdown-toc markdown-mode magit-gitflow htmlize helm-gitignore request helm-flyspell helm-company helm-c-yasnippet gnuplot gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-gutter-fringe+ git-gutter-fringe fringe-helper git-gutter+ git-gutter gh-md flycheck-pos-tip flycheck evil-magit magit magit-popup git-commit with-editor eshell-prompt-extras esh-help diff-hl company-quickhelp pos-tip company auto-yasnippet yasnippet auto-dictionary ac-ispell auto-complete ws-butler window-numbering volatile-highlights vi-tilde-fringe spaceline s powerline smooth-scrolling restart-emacs rainbow-delimiters popwin persp-mode pcre2el spinner page-break-lines open-junk-file neotree move-text macrostep lorem-ipsum linum-relative leuven-theme info+ indent-guide ido-vertical-mode hungry-delete hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation help-fns+ helm-themes helm-swoop helm-projectile helm-mode-manager helm-make projectile pkg-info epl helm-flx helm-descbinds helm-ag google-translate golden-ratio flx-ido flx fill-column-indicator fancy-battery expand-region exec-path-from-shell evil-visualstar evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state smartparens evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-args evil-anzu anzu eval-sexp-fu highlight elisp-slime-nav define-word clean-aindent-mode buffer-move bracketed-paste auto-highlight-symbol auto-compile packed dash aggressive-indent ace-window ace-link ace-jump-helm-line helm avy helm-core popup async quelpa package-build use-package which-key bind-key bind-map evil spacemacs-theme)))
 '(paradox-github-token t)
 '(pos-tip-background-color "#A6E22E")
 '(pos-tip-foreground-color "#272822")
 '(safe-local-variable-values (quote ((mote . emacs-lisp))))
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(tabbar-ruler-excluded-buffers
   (quote
    ("*Messages*" "*Completions*" "*ESS*" "*Packages*" "*log-edit-files*" "*helm-mini*" "*helm-mode-describe-variable*" "*multiterm-1*")))
 '(tabbar-separator (quote (0.5)))
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(tramp-copy-size-limit nil)
 '(tramp-inline-compress-start-size nil)
 '(tramp-verbose 6)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#F92672")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#E6DB74")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#A6E22E")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#A1EFE4")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#66D9EF"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (unspecified "#272822" "#49483E" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0"))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(evil-want-Y-yank-to-eol nil)
 '(excorporate-configuration
   (quote
    ("anntoin@amazon.com" . "https://ballard.amazon.com/ews/exchange.asmx")))
 '(highlight-changes-colors (quote ("#FD5FF0" "#AE81FF")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   (quote
    (("#49483E" . 0)
     ("#679A01" . 20)
     ("#4BBEAE" . 30)
     ("#1DB4D0" . 50)
     ("#9A8F21" . 60)
     ("#A75B00" . 70)
     ("#F309DF" . 85)
     ("#49483E" . 100))) t)
 '(hl-bg-colors
   (quote
    ("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors
   (quote
    ("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(hl-sexp-background-color "#efebe9")
 '(magit-diff-use-overlays nil)
 '(markdown-command "pandoc")
 '(neo-show-hidden-files nil)
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(package-selected-packages
   (quote
    (intero hlint-refactor hindent helm-hoogle haskell-snippets flycheck-haskell dante lcr company-ghci company-ghc ghc haskell-mode company-cabal cmm-mode org-category-capture diminish memoize goto-chg treemacs-evil treemacs pfuture winum unfill madhat2r-theme fuzzy soap-client autothemer pcache org ntlm undo-tree ein websocket all-the-icons font-lock+ wgrep smex ivy-hydra flyspell-correct-ivy counsel-projectile counsel swiper ivy minitest hide-comnt yapfify uuidgen rake py-isort pug-mode org-projectile org-download mwim mu4e-alert ht livid-mode skewer-mode simple-httpd live-py-mode link-hint git-link flyspell-correct-helm flyspell-correct evil-visual-mark-mode evil-unimpaired evil-ediff eshell-z dumb-jump darkokai-theme column-enforce-mode color-identifiers-mode tabbar-ruler tabbar col-highlight vline web-mode web-beautify tagedit slim-mode scss-mode sass-mode less-css-mode json-mode json-snatcher json-reformat js2-refactor multiple-cursors js2-mode js-doc jade-mode helm-css-scss haml-mode emmet-mode company-web web-completion-data company-tern dash-functional tern coffee-mode rvm ruby-tools ruby-test-mode rubocop rspec-mode robe rbenv chruby bundler inf-ruby project-explorer es-windows es-lib centered-window-mode sublimity selectric-mode mode-icons highlight-tail org-gcal request-deferred deferred excorporate url-http-ntlm fsm evil-mu4e rcirc-notify rcirc-color writeroom-mode visual-fill-column pyvenv pytest pyenv-mode py-yapf pip-requirements hy-mode helm-pydoc cython-mode company-anaconda anaconda-mode pythonic f eyebrowse ranger rainbow-mode rainbow-identifiers yaml-mode zonokai-theme zen-and-art-theme underwater-theme ujelly-theme twilight-theme twilight-bright-theme twilight-anti-bright-theme tronesque-theme toxi-theme tao-theme tangotango-theme tango-plus-theme tango-2-theme sunny-day-theme sublime-themes subatomic256-theme subatomic-theme stekene-theme spacegray-theme soothe-theme soft-stone-theme soft-morning-theme soft-charcoal-theme smyx-theme seti-theme reverse-theme railscasts-theme purple-haze-theme professional-theme planet-theme phoenix-dark-pink-theme phoenix-dark-mono-theme pastels-on-dark-theme organic-green-theme omtose-phellack-theme oldlace-theme occidental-theme obsidian-theme noctilux-theme niflheim-theme naquadah-theme mustang-theme monochrome-theme molokai-theme moe-theme minimal-theme material-theme majapahit-theme lush-theme light-soap-theme jbeans-theme jazz-theme ir-black-theme inkpot-theme heroku-theme hemisu-theme hc-zenburn-theme gruvbox-theme gruber-darker-theme grandshell-theme gotham-theme gandalf-theme flatui-theme flatland-theme firebelly-theme farmhouse-theme espresso-theme dracula-theme django-theme darktooth-theme darkmine-theme darkburn-theme dakrone-theme cyberpunk-theme colorsarenice-theme color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized clues-theme cherry-blossom-theme busybee-theme bubbleberry-theme birds-of-paradise-plus-theme badwolf-theme apropospriate-theme anti-zenburn-theme ample-zen-theme ample-theme alect-themes afternoon-theme zenburn-theme monokai-theme solarized-theme paradox hydra company-statistics adaptive-wrap xterm-color toc-org smeargle shell-pop orgit org-repo-todo org-present org-pomodoro alert log4e gntp org-plus-contrib org-bullets multi-term mmm-mode markdown-toc markdown-mode magit-gitflow htmlize helm-gitignore request helm-flyspell helm-company helm-c-yasnippet gnuplot gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-gutter-fringe+ git-gutter-fringe fringe-helper git-gutter+ git-gutter gh-md flycheck-pos-tip flycheck evil-magit magit magit-popup git-commit with-editor eshell-prompt-extras esh-help diff-hl company-quickhelp pos-tip company auto-yasnippet yasnippet auto-dictionary ac-ispell auto-complete ws-butler window-numbering volatile-highlights vi-tilde-fringe spaceline s powerline smooth-scrolling restart-emacs rainbow-delimiters popwin persp-mode pcre2el spinner page-break-lines open-junk-file neotree move-text macrostep lorem-ipsum linum-relative leuven-theme info+ indent-guide ido-vertical-mode hungry-delete hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation help-fns+ helm-themes helm-swoop helm-projectile helm-mode-manager helm-make projectile pkg-info epl helm-flx helm-descbinds helm-ag google-translate golden-ratio flx-ido flx fill-column-indicator fancy-battery expand-region exec-path-from-shell evil-visualstar evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state smartparens evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-args evil-anzu anzu eval-sexp-fu highlight elisp-slime-nav define-word clean-aindent-mode buffer-move bracketed-paste auto-highlight-symbol auto-compile packed dash aggressive-indent ace-window ace-link ace-jump-helm-line helm avy helm-core popup async quelpa package-build use-package which-key bind-key bind-map evil spacemacs-theme)))
 '(paradox-github-token t)
 '(pos-tip-background-color "#A6E22E")
 '(pos-tip-foreground-color "#272822")
 '(safe-local-variable-values (quote ((mote . emacs-lisp))))
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(tabbar-ruler-excluded-buffers
   (quote
    ("*Messages*" "*Completions*" "*ESS*" "*Packages*" "*log-edit-files*" "*helm-mini*" "*helm-mode-describe-variable*" "*multiterm-1*")))
 '(tabbar-separator (quote (0.5)))
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(tramp-copy-size-limit nil nil (tramp))
 '(tramp-inline-compress-start-size nil nil (tramp))
 '(tramp-verbose 6 nil (tramp))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#F92672")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#E6DB74")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#A6E22E")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#A1EFE4")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#66D9EF"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (unspecified "#272822" "#49483E" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0"))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil)))))
)

