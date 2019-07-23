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
   '(
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
     (ranger :variables
             ranger-show-preview t)
     ;; Language stuff
     lsp
     (python :variables python-fill-column 79)
     traad
     ;; lsp
     ;; ipython-notebook https://github.com/syl20bnr/spacemacs/issues/10980
     (ruby :variables ruby-test-runner 'rspec)
     html
     yaml
     (markdown :variables markdown-live-preview-engine 'vmd)
     (javascript :variables
                 javascript-import-tool 'import-js
                 javascript-backend 'tern
                 javascript-fmt-tool 'prettier)
     import-js
     prettier
     react
     emacs-lisp
     chrome
     perl5
     haskell
     typescript
     sql

     ;; Misc
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom
            shell-default-full-span nil
            shell-pop-in-hook (
                               )
            shell-default-shell 'multiterm)
     (org :variables
          org-projectile-file "TODO.org"
          org-enable-github-support t
          org-enable-reveal-js-support t
          org-enable-bootstrap-support t)
     pandoc
     emoji
     command-log
     theming
     multiple-cursors

     ;; Email
     (mu4e :variables
           mu4e-installation-path "~/share/emacs/site-lisp/mu4e")

     ;; Themes
     themes-megapack
     colors
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
     org-bullets
     )

   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages
   '(
     mu4e-maildirs-extension
     vi-tilde-fringe
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
   dotspacemacs-themes '(sanityinc-tomorrow-eighties
                         sanityinc-tomorrow-day
                         apropospriate-dark
                         apropospriate-light
                         oldlace
                         planet
                         smyx
                         spacegray
                         tango
                         poet
                         underwater
                         twilight-anti-bright
                         doom-one-light
                         doom-spacegrey
                         doom-city-lights
                         )

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

   ;; If non-nil, the paste transient-state is enabled. While enabled, after you
   ;; paste something, pressing `C-j' and `C-k' several times cycles through the
   ;; elements in the `kill-ring'. (default nil)
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

  ;; Day/Night theming: from https://lepisma.github.io/2017/10/28/ricing-org-mode/
  (defmacro set-pair-faces (themes consts faces-alist)
    "Macro for pair setting of custom faces.
  THEMES name the pair (theme-one theme-two). CONSTS sets the variables like
    ((sans-font \"Some Sans Font\") ...). FACES-ALIST has the actual faces
  like:
    ((face1 theme-one-attr theme-two-atrr)
    (face2 theme-one-attr nil           )
    (face3 nil            theme-two-attr)
    ...)"
    (defmacro get-proper-faces ()
      `(let* (,@consts)
        (backquote ,faces-alist)))

    `(setq theming-modifications
          ',(mapcar (lambda (theme)
                      `(,theme ,@(cl-remove-if
                                  (lambda (x) (equal x "NA"))
                                  (mapcar (lambda (face)
                                            (let ((face-name (car face))
                                                  (face-attrs (nth (cl-position theme themes) (cdr face))))
                                              (if face-attrs
                                                  `(,face-name ,@face-attrs)
                                                "NA"))) (get-proper-faces)))))
                    themes)))

  (set-pair-faces
  ;; Themes to use
  (sanityinc-tomorrow-eighties sanityinc-tomorrow-day)

  ;; Variables
  (
    (bg-white           "#fbf8ef")
    (bg-light           "#222425")
    (bg-dark            "#1c1e1f")
    (bg-darker          "#1c1c1c")
    (fg-white           "#ffffff")
    (shade-white        "#efeae9")
    (fg-light           "#655370")
    (dark-cyan          "#008b8b")
    (region-dark        "#2d2e2e")
    (region             "#39393d")
    (slate              "#8FA1B3")
    (keyword            "#f92672")
    (comment            "#525254")
    (builtin            "#fd971f")
    (purple             "#9c91e4")
    (doc                "#727280")
    (type               "#66d9ef")
    (string             "#b6e63e")
    (gray-dark          "#999")
    (gray               "#bbb")

    (sans-font          "DejaVu Sans")
    (serif-font         "Merriweather")
    (et-font            "EtBembo")
    (sans-mono-font     "DejaVu Sans Mono")
    (serif-mono-font    "Verily Serif Mono"))

  ;; Theme Settings
  ((variable-pitch
    (:family ,sans-font)
    (:family ,et-font
     :background nil
     :foreground ,bg-dark
     :height 1.7))

   ;; Org Mode Theming
   (org-document-title
    (:inherit variable-pitch
     :height 1.3
     :weight normal
     :foreground ,gray)
    (:inherit nil
     :family ,et-font
     :height 1.8
     :foreground ,bg-dark
     :underline nil))

   (org-document-info
    (:foreground ,gray
     :slant italic)
    (:height 1.2
     :slant italic))

   (org-level-1
    (:inherit variable-pitch
     :height 1.3
     :weight bold
     :foreground ,keyword
     :background ,bg-dark)
    (:inherit nil
     :family ,et-font
     :height 1.6
     :weight normal
     :slant normal
     :foreground ,bg-dark))

   (org-level-2
    (:inherit variable-pitch
     :weight bold
     :height 1.2
     :foreground ,gray
     :background ,bg-dark)
    (:inherit nil
     :family ,et-font
     :weight normal
     :height 1.3
     :slant italic
     :foreground ,bg-dark))

   (org-level-3
    (:inherit variable-pitch
     :weight bold
     :height 1.1
     :foreground ,slate
     :background ,bg-dark)
    (:inherit nil
     :family ,et-font
     :weight normal
     :slant italic
     :height 1.2
     :foreground ,bg-dark))

    (org-level-4
     (:inherit variable-pitch
      :weight bold
      :height 1.1
      :foreground ,slate
      :background ,bg-dark)
     (:inherit nil
      :family ,et-font
      :weight normal
      :slant italic
      :height 1.1
      :foreground ,bg-dark))

    (org-level-5
     (:inherit variable-pitch
      :weight bold
      :height 1.1
      :foreground ,slate
      :background ,bg-dark)
     nil)

    (org-level-6
     (:inherit variable-pitch
      :weight bold
      :height 1.1
      :foreground ,slate
      :background ,bg-dark)
     nil)

    (org-level-7
     (:inherit variable-pitch
      :weight bold
      :height 1.1
      :foreground ,slate
      :background ,bg-dark)
     nil)

    (org-level-8
     (:inherit variable-pitch
      :weight bold
      :height 1.1
      :foreground ,slate
      :background ,bg-dark)
     nil)

    (org-headline-done
     (:strike-through t)
     (:family ,et-font
      :strike-through t))

    (org-quote
     (:background ,bg-dark)
     nil)

    (org-block
     (:background ,bg-dark)
     (:background nil
      :foreground ,bg-dark))

    (org-block-begin-line
     (:background ,bg-dark)
     (:background nil
      :height 0.8
      :family ,sans-mono-font
      :foreground ,slate))

    (org-block-end-line
     (:background ,bg-dark)
     (:background nil
      :height 0.8
      :family ,sans-mono-font
      :foreground ,slate))

    (org-document-info-keyword
     (:foreground ,comment)
     (:height 0.8
      :foreground ,gray))

    (org-link
     (:underline nil
      :weight normal
      :foreground ,slate)
     (:foreground ,bg-dark))

    (org-special-keyword
     (:height 0.9
      :foreground ,comment)
     (:family ,sans-mono-font
      :height 0.8))

    (org-todo
     (:foreground ,builtin
      :background ,bg-dark)
     nil)

    (org-done
     (:inherit variable-pitch
      :foreground ,dark-cyan
      :background ,bg-dark)
     nil)

    (org-agenda-current-time
     (:foreground ,slate)
     nil)

    (org-hide
     nil
     (:foreground ,bg-white))

    (org-indent
     (:inherit org-hide)
     (:inherit (org-hide fixed-pitch)))

    (org-time-grid
     (:foreground ,comment)
     nil)

    (org-warning
     (:foreground ,builtin)
     nil)

    (org-date
     nil
     (:family ,sans-mono-font
      :height 0.8))

    (org-agenda-structure
     (:height 1.3
      :foreground ,doc
      :weight normal
      :inherit variable-pitch)
     nil)

    (org-agenda-date
     (:foreground ,doc
      :inherit variable-pitch)
     (:inherit variable-pitch
      :height 1.1))

    (org-agenda-date-today
     (:height 1.5
      :foreground ,keyword
      :inherit variable-pitch)
     nil)

    (org-agenda-date-weekend
     (:inherit org-agenda-date)
     nil)

    (org-scheduled
     (:foreground ,gray)
     nil)

    (org-upcoming-deadline
     (:foreground ,keyword)
     nil)

    (org-scheduled-today
     (:foreground ,fg-white)
     nil)

    (org-scheduled-previously
     (:foreground ,slate)
     nil)

    (org-agenda-done
     (:inherit nil
      :strike-through t
      :foreground ,doc)
     (:strike-through t
      :foreground ,doc))

    (org-ellipsis
     (:underline nil
      :foreground ,comment)
     (:underline nil
      :foreground ,comment))

    (org-tag
     (:foreground ,doc)
     (:foreground ,doc))

    (org-table
     (:background nil)
     (:family ,serif-mono-font
      :height 0.9
      :background ,bg-white))

    (org-code
     (:inherit font-lock-builtin-face)
     (:inherit nil
      :family ,serif-mono-font
      :foreground ,comment
      :height 0.9)))))

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
                js-indent-level 2
                ;; web-mode
                css-indent-offset 2
                js2-indent-switch-body t
                js-switch-indent-offset 2
                web-mode-markup-indent-offset 2
                web-mode-css-indent-offset 2
                web-mode-code-indent-offset 2
                web-mode-attr-indent-offset 2)

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

  (with-eval-after-load 'markdown-mode
    (remove-hook 'markdown-mode-hook 'spacemacs//cleanup-org-tables-on-save))

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Appearance
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;; Pretty
  ;; (highlight-tail-mode)
  ;; (mode-icons-mode)
  (spacemacs/enable-transparency)

  (load-file "~/.emacs.d/private/local/minimal-fringes/minimal-fringes.el")
  (spacemacs/toggle-truncate-lines-on)

  ;; Fill column indicator
  (turn-on-fci-mode)

  (setq powerline-default-separator 'nil)

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

  ;; Hooks
  ;; (defun add-hooks (hooks fun)
  ;;  "Add FUN to all the HOOKS."
  ;;  (dolist (hook hooks)
  ;;   (add-hook hook fun)))

  ;; (add-hooks '(text-mode-hook
  ;;              prog-mode-hook
  ;;              ranger-mode-hook
  ;;              ibuffer-mode-hook
  ;;              comint-mode-hook)
  ;;            (lambda () (setq line-spacing 0.1)))

  ;; (add-hooks '(cfw:calendar-mode-hook
  ;;              text-mode-hook
  ;;              org-agenda-mode-hook
  ;;              slack-mode-hook
  ;;              ibuffer-mode-hook
  ;;              magit-status-mode-hook
  ;;              magit-popup-mode-hook
  ;;              magit-log-mode-hook
  ;;              magit-diff-mode-hook
  ;;              comint-mode-hook
  ;;              eshell-mode-hook
  ;;              slime-repl-mode-hook
  ;;              process-menu-mode-hook
  ;;              mu4e-view-mode-hook
  ;;              mu4e-main-mode-hook)
  ;;            (lambda () (progn
  ;;                        (setq left-margin-width 2)
  ;;                        (setq right-margin-width 2)
  ;;                        (set-window-buffer nil (current-buffer)))))

  ;; (add-hooks '(cfw:calendar-mode-hook
  ;;              text-mode-hook
  ;;              org-agenda-mode-hook
  ;;              slack-mode-hook
  ;;              ibuffer-mode-hook
  ;;              magit-status-mode-hook
  ;;              magit-log-mode-hook
  ;;              magit-diff-mode-hook
  ;;              comint-mode-hook
  ;;              eshell-mode-hook
  ;;              slime-repl-mode-hook
  ;;              process-menu-mode-hook
  ;;              mu4e-view-mode-hook
  ;;              mu4e-main-mode-hook)
  ;;            (lambda () (setq header-line-format " ")))

  ;; (add-hooks '(text-mode-hook
  ;;              cfw:calendar-mode-hook)
  ;;            (lambda () (spacemacs/disable-hl-line-mode)))


  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Mode preferences
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;; web-mode indents
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)

  (setq traad-server-program "~/bin/anaconda3/bin/traad")

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Documentation
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;; Markdown

  ;; Use soft wrapping
  (add-hook 'markdown-mode-hook
            (lambda ()
              "Soft wrapping"
              (set-fill-column 72)
              (auto-fill-mode 0)
              (visual-fill-column-mode)
              (setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))
              (visual-line-mode)))


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
        mu4e-update-interval 600)

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
        smtpmail-auth-credentials '(("ballard.amazon.com" 1587 "ANT\\anntoinw" (shell-command-to-string "pass 'Amazon/Corp Password'")))
        send-mail-function 'smtpmail-send-it)


  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Org
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (add-hook 'org-mode-hook (lambda () (electric-indent-local-mode -1)))

  (setq org-startup-indented t
        org-bullets-bullet-list '(" ") ;; no bullets, needs org-bullets package
        org-ellipsis "  " ;; folding symbol
        org-pretty-entities t
        org-hide-emphasis-markers t
        ;; show actually italicized text instead of /italicized text/
        org-agenda-block-separator ""
        org-fontify-whole-heading-line t
        org-fontify-done-headline t
        org-fontify-quote-and-verse-blocks t
        org-fontify-emphasized-text t
        ;; https://github.com/syl20bnr/spacemacs/issues/9692
        org-adapt-indentation nil)


  ;; Auto-revert all org mode files
  ((org-mode . ((eval . (auto-revert-mode 1)))))

  (setq org-agenda-files (list "~/Org/work.org"
                               "~/Org/todo.org"
                               "~/Org/notes.org")
        org-directory "~/Org"
        org-default-notes-file "~/Org/notes.org")

  (setq org-todo-keywords
        '((sequence "TODO" "IN-PROGRESS" "|" "DONE" "CANCELLED")))


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
       "* NOTE: %? %u
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

  (push (org-projectile-project-todo-entry) org-capture-templates)

  (setq org-refile-targets '((nil :maxlevel . 6)
                             (org-agenda-files :maxlevel . 6)))

  (setq diary-file "~/Org/diary")

  ;; Google Calendar Org Sync
  (require 'org-gcal)
  (setq org-gcal-client-id "242871172486-9kit9k6i57rhvkb606vu1u0u8tue0fnu.apps.googleusercontent.com"
        org-gcal-client-secret "gk98O6fxvpi6xsbA1VdQ6c2R"
        org-gcal-file-alist '(("anntoin@gmail.com" .  "~/Org/calendar.org")))

  ;; Handy functions
  (defun merge-lines-with-prefix ()
    "Merge the next line into the current line keeping a common prefix"
    (interactive)
    (save-excursion
      (let (current-line next-line prefix)
        (setq current-line
              (buffer-substring (line-beginning-position) (line-end-position)))
        (kill-whole-line)
        (setq next-line
              (buffer-substring (line-beginning-position) (line-end-position)))
        (kill-whole-line)
        (setq prefix (fill-common-string-prefix current-line next-line))
        (insert
         (concat current-line " " (substring next-line (length prefix)) "\n")))))
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
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#d6d6d6" "#c82829" "#718c00" "#eab700" "#4271ae" "#8959a8" "#3e999f" "#4d4d4c"))
 '(ansi-term-color-vector
   [unspecified "#FFFFFF" "#d15120" "#5f9411" "#d2ad00" "#6b82a7" "#a66bab" "#6b82a7" "#505050"])
 '(auth-source-save-behavior nil)
 '(beacon-color "#c82829")
 '(cursor-type (quote bar))
 '(evil-want-Y-yank-to-eol nil)
 '(fci-rule-character-color "#d9d9d9")
 '(fci-rule-color "#d6d6d6")
 '(flycheck-color-mode-line-face-to-color (quote mode-line-buffer-id))
 '(frame-background-mode (quote light))
 '(js2-strict-missing-semi-warning nil)
 '(linum-format " %5i ")
 '(package-selected-packages
   (quote
    (import-js grizzl lsp-ui lsp-treemacs treemacs pfuture helm-lsp company-lsp tide typescript-mode add-node-modules-path zenburn-theme yasnippet-snippets web-mode tao-theme solarized-theme seti-theme ruby-hash-syntax poet-theme org-projectile org-download org-brain minimal-theme kaolin-themes json-navigator json-mode hlint-refactor hl-todo helm-xref gruvbox-theme google-translate eyebrowse evil-visual-mark-mode evil-nerd-commenter evil-magit eval-sexp-fu emojify editorconfig dumb-jump dracula-theme doom-themes doom-modeline eldoc-eval diff-hl define-word darktooth-theme cython-mode cyberpunk-theme counsel-projectile counsel swiper ivy color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized centered-cursor-mode apropospriate-theme alect-themes aggressive-indent ace-window ace-link anaconda-mode smartparens flycheck company projectile window-purpose imenu-list helm helm-core avy magit git-commit inf-ruby simple-httpd powerline f virtualenvwrapper dash visual-fill-column evil goto-chg org-plus-contrib hydra zen-and-art-theme yapfify yaml-mode xterm-color ws-butler writeroom-mode with-editor winum white-sand-theme which-key web-beautify volatile-highlights vmd-mode uuidgen use-package unfill undo-tree underwater-theme ujelly-theme twilight-theme twilight-bright-theme twilight-anti-bright-theme traad toxi-theme toc-org tangotango-theme tango-plus-theme tango-2-theme tagedit tabbar-ruler symon sunny-day-theme sublime-themes subatomic256-theme subatomic-theme string-inflection spaceline-all-the-icons spacegray-theme soothe-theme soft-stone-theme soft-morning-theme soft-charcoal-theme smyx-theme smeargle slim-mode shrink-path shell-pop seeing-is-believing scss-mode sass-mode rvm ruby-tools ruby-test-mode ruby-refactor rubocop rspec-mode robe rjsx-mode reverse-theme restart-emacs rebecca-theme rbenv ranger rake rainbow-mode rainbow-identifiers rainbow-delimiters railscasts-theme pyvenv pytest pyenv-mode py-isort purple-haze-theme pug-mode project-explorer professional-theme prettier-js popwin planet-theme pippel pipenv pip-requirements phoenix-dark-pink-theme phoenix-dark-mono-theme persp-mode password-generator paradox pandoc-mode ox-twbs ox-reveal ox-pandoc ox-gfm overseer origami orgit organic-green-theme org-present org-pomodoro org-mime org-gcal org-category-capture org-bullets open-junk-file omtose-phellack-theme oldlace-theme occidental-theme obsidian-theme noctilux-theme neotree naquadah-theme nameless mwim mustang-theme multi-term mu4e-alert move-text monokai-theme monochrome-theme molokai-theme moe-theme mmm-mode minitest material-theme markdown-toc majapahit-theme magit-svn magit-gitflow madhat2r-theme macrostep lush-theme lorem-ipsum livid-mode live-py-mode link-hint light-soap-theme json-snatcher json-reformat js2-refactor js-doc jbeans-theme jazz-theme ir-black-theme inkpot-theme indent-guide importmagic impatient-mode hungry-delete hindent highlight-parentheses highlight-numbers highlight-indentation highlight hierarchy heroku-theme hemisu-theme helm-themes helm-swoop helm-pydoc helm-purpose helm-projectile helm-org-rifle helm-mu helm-mode-manager helm-make helm-hoogle helm-gitignore helm-git-grep helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag hc-zenburn-theme haskell-snippets gruber-darker-theme grandshell-theme gotham-theme golden-ratio gnuplot gmail-message-mode gitignore-templates gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe git-gutter-fringe+ gh-md gandalf-theme fuzzy font-lock+ flyspell-correct-helm flymd flycheck-pos-tip flycheck-haskell flx-ido flatui-theme flatland-theme fill-column-indicator farmhouse-theme fancy-battery eziam-theme expand-region exotica-theme excorporate evil-visualstar evil-unimpaired evil-tutor evil-surround evil-org evil-numbers evil-mc evil-matchit evil-lisp-state evil-lion evil-indent-plus evil-iedit-state evil-goggles evil-exchange evil-escape evil-ediff evil-cleverparens evil-args evil-anzu espresso-theme eshell-z eshell-prompt-extras esh-help emoji-cheat-sheet-plus emmet-mode elisp-slime-nav edit-server dotenv-mode django-theme diminish darkokai-theme darkmine-theme darkburn-theme dakrone-theme company-web company-tern company-statistics company-plsense company-ghci company-emoji company-cabal company-anaconda command-log-mode column-enforce-mode color-identifiers-mode coffee-mode cmm-mode clues-theme clean-aindent-mode chruby cherry-blossom-theme busybee-theme bundler bubbleberry-theme browse-at-remote birds-of-paradise-plus-theme badwolf-theme autothemer auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile anti-zenburn-theme ample-zen-theme ample-theme afternoon-theme ace-jump-helm-line ac-ispell)))
 '(pdf-view-midnight-colors (quote ("#282828" . "#f2e5bc")))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#c82829")
     (40 . "#f5871f")
     (60 . "#eab700")
     (80 . "#718c00")
     (100 . "#3e999f")
     (120 . "#4271ae")
     (140 . "#8959a8")
     (160 . "#c82829")
     (180 . "#f5871f")
     (200 . "#eab700")
     (220 . "#718c00")
     (240 . "#3e999f")
     (260 . "#4271ae")
     (280 . "#8959a8")
     (300 . "#c82829")
     (320 . "#f5871f")
     (340 . "#eab700")
     (360 . "#718c00"))))
 '(vc-annotate-very-old-color nil)
 '(when
      (or
       (not
        (boundp
         (quote ansi-term-color-vector)))
       (not
        (facep
         (aref ansi-term-color-vector 0)))))
 '(window-divider-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil))))
 '(org-agenda-current-time ((t (:foreground "#8FA1B3"))))
 '(org-agenda-date ((t (:foreground "#727280" :inherit variable-pitch))))
 '(org-agenda-date-today ((t (:height 1.5 :foreground "#f92672" :inherit variable-pitch))))
 '(org-agenda-date-weekend ((t (:inherit org-agenda-date))))
 '(org-agenda-done ((t (:inherit nil :strike-through t :foreground "#727280"))))
 '(org-agenda-structure ((t (:height 1.3 :foreground "#727280" :weight normal :inherit variable-pitch))))
 '(org-block ((t (:background "#1c1e1f"))))
 '(org-block-begin-line ((t (:background "#1c1e1f"))))
 '(org-block-end-line ((t (:background "#1c1e1f"))))
 '(org-code ((t (:inherit font-lock-builtin-face))))
 '(org-date ((t (:family "DejaVu Sans Mono" :height 0.8))))
 '(org-document-info ((t (:foreground "#bbb" :slant italic))))
 '(org-document-info-keyword ((t (:foreground "#525254"))))
 '(org-document-title ((t (:inherit variable-pitch :height 1.3 :weight normal :foreground "#bbb"))))
 '(org-done ((t (:inherit variable-pitch :foreground "#008b8b" :background "#1c1e1f"))))
 '(org-ellipsis ((t (:underline nil :foreground "#525254"))))
 '(org-headline-done ((t (:strike-through t))))
 '(org-hide ((t (:foreground "#fbf8ef"))))
 '(org-indent ((t (:inherit org-hide))))
 '(org-level-1 ((t (:inherit variable-pitch :height 1.3 :weight bold :foreground "#f92672" :background "#1c1e1f"))))
 '(org-level-2 ((t (:inherit variable-pitch :weight bold :height 1.2 :foreground "#bbb" :background "#1c1e1f"))))
 '(org-level-3 ((t (:inherit variable-pitch :weight bold :height 1.1 :foreground "#8FA1B3" :background "#1c1e1f"))))
 '(org-level-4 ((t (:inherit variable-pitch :weight bold :height 1.1 :foreground "#8FA1B3" :background "#1c1e1f"))))
 '(org-level-5 ((t (:inherit variable-pitch :weight bold :height 1.1 :foreground "#8FA1B3" :background "#1c1e1f"))))
 '(org-level-6 ((t (:inherit variable-pitch :weight bold :height 1.1 :foreground "#8FA1B3" :background "#1c1e1f"))))
 '(org-level-7 ((t (:inherit variable-pitch :weight bold :height 1.1 :foreground "#8FA1B3" :background "#1c1e1f"))))
 '(org-level-8 ((t (:inherit variable-pitch :weight bold :height 1.1 :foreground "#8FA1B3" :background "#1c1e1f"))))
 '(org-link ((t (:underline nil :weight normal :foreground "#8FA1B3"))))
 '(org-quote ((t (:background "#1c1e1f"))))
 '(org-scheduled ((t (:foreground "#bbb"))))
 '(org-scheduled-previously ((t (:foreground "#8FA1B3"))))
 '(org-scheduled-today ((t (:foreground "#ffffff"))))
 '(org-special-keyword ((t (:height 0.9 :foreground "#525254"))))
 '(org-table ((t (:background nil))))
 '(org-tag ((t (:foreground "#727280"))))
 '(org-time-grid ((t (:foreground "#525254"))))
 '(org-todo ((t (:foreground "#fd971f" :background "#1c1e1f"))))
 '(org-upcoming-deadline ((t (:foreground "#f92672"))))
 '(org-warning ((t (:foreground "#fd971f"))))
 '(variable-pitch ((t (:family "DejaVu Sans")))))
)
