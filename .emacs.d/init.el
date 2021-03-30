;; -*- lexical-binding: t -*-

(setq package-check-signature nil)
(require 'package)

;; package repositories
;; also set priority. Mainly to prefer Melpa Stable over Melpa.
(setq package-archives
      '(("gnu"          . "http://elpa.gnu.org/packages/")
        ("marmalade"    . "http://marmalade-repo.org/packages/")
        ("melpa"        . "http://melpa.milkbox.net/packages/")
        ("melpa-stable" . "http://stable.melpa.org/packages/")
        ("org"          . "https://orgmode.org/elpa/"))
      package-archive-priorities
      '(("melpa-stable" . 10)
	    ("gnu"          . 5)
	    ("marmalade"    . 3)
	    ("melpa"        . 0)))

;; Hack for using a different set of repositories when ELPA is down
;; As soon as MELPA is back up again, comment out the section again.
;(setq package-archives
;      '(("melpa" . "https://raw.githubusercontent.com/d12frosted/elpa-mirror/master/melpa/")
;        ("org"   . "https://raw.githubusercontent.com/d12frosted/elpa-mirror/master/org/")
;        ("gnu"   . "https://raw.githubusercontent.com/d12frosted/elpa-mirror/master/gnu/")))


;; list of packages to install
;; whenever you install a new package, you should add it here.
;; The variable package-selected-packages should be updated automatically when you install a new package,
;; but to have your changes sync accross machines, you will need to manually update this variable.
(setq package-selected-packages
      '(which-key
        evil
        evil-collection
        dracula-theme
        rainbow-delimiters
        counsel
        ivy-rich
        helpful
        general
        crux
        elixir-mode
        exec-path-from-shell
        alchemist
        projectile
        use-package
        counsel-projectile
        ))

;; execute all of your package autoloads (among other things)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
;; install packages from your user-installed packages list
(package-install-selected-packages)

;; set up use-package
(require 'use-package)
(setq use-package-always-ensure t)

;; show line numbers in margin
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

;; disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(setq-default indent-tabs-mode nil)

;; set default tab char's display width to 4 spaces
(setq-default tab-width 4)

;; show cursor position within line
(column-number-mode 1)

;; sort results of apropos by relevancy
(setq apropos-sort-by-scores t)

;; add homebrew stuff to exec-path
(add-to-list 'exec-path "/usr/local/bin")

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; setup which-keys
;; which-keys brings up a completions menu after pressing a leader key 
(require 'which-key)
(which-key-mode)
(setq which-key-idle-delay 0.3) ; delay time for which-key menu popup

;; show paren matching
(show-paren-mode 1)

;; always insert left/right brackets together.
(electric-pair-mode 1)

;; make cursor movement stop in between camelCase words.
(global-subword-mode 1)

;; set up evil mode
; init stuff needs to appear before (require 'evil)
(setq evil-want-integration t)
(setq evil-want-C-u-scroll t)
(setq evil-want-keybinding nil)
(require 'evil)
(evil-mode 1)

;; evil-collection assumes evil-want-keybinding is set to nil and evil-want-integration is set to t before loading evil and evil-collection
(when (require 'evil-collection nil t)
  (evil-collection-init))

;; use visual line motions even outside of visual-line-mode buffers
(evil-global-set-key 'motion "j" 'evil-next-visual-line)
(evil-global-set-key 'motion "k" 'evil-previous-visual-line)

;; add to load path (this is where "require" looks for files, similar to PATH on unix)
(add-to-list 'load-path "~/.emacs.d/elisp-files")

;; load key-chord then define "fd" to enter normal mode
;load a file named key-chord.el from some directory in the load-path (e.g. "~/.emacs.d/elisp-files")
(require 'key-chord)
(key-chord-mode 1)
(key-chord-define-global "fd" 'evil-normal-state)

;; set font size (the value is in 1/10pt, so 100 will give you 10pt, etc.)
(set-face-attribute 'default nil :height 160)

;; color theme
;(load-theme 'manoj-dark)
(load-theme 'dracula t)

;; enable rainbow-delimiters in programming modes
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; It is common for Emacs modes like Buffer Menu, Ediff, and others to define key bindings for RET and SPC. Since these are motion commands, Evil places its key bindings for these in evil-motion-state-map. However, these commands are fairly worthless to a seasoned Vim user, since they do the same thing as j and l commands. Thus it is useful to remove them from evil-motion-state-map so as when modes define them, RET and SPC bindings are available directly.
(defun my-move-key (keymap-from keymap-to key)
  "Moves key binding from one keymap to another, deleting from the old location. "
  (define-key keymap-to key (lookup-key keymap-from key))
  (define-key keymap-from key nil))
(my-move-key evil-motion-state-map evil-normal-state-map (kbd "RET"))
(my-move-key evil-motion-state-map evil-normal-state-map " ")

;; remove startup welcome screen
(setq inhibit-startup-message t)

(scroll-bar-mode -1)  ; disable visual scrollbar
(tool-bar-mode -1)    ; disable toolbar

;; Set up visual bell (flash the mode-line instead of default visual bell which is obnoxious)
(setq ring-bell-function
      (lambda ()
        (let ((orig-fg (face-foreground 'mode-line)))
          (set-face-foreground 'mode-line "#F2804F")
          (run-with-idle-timer 0.1 nil
                               (lambda (fg) (set-face-foreground 'mode-line fg))
                               orig-fg))))

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Ivy
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(setq ivy-count-format "(%d/%d) ")
(define-key ivy-minibuffer-map (kbd "C-j") 'ivy-next-line)
(define-key ivy-minibuffer-map (kbd "C-k") 'ivy-previous-line)
(define-key ivy-switch-buffer-map (kbd "C-k") 'ivy-previous-line)
(define-key ivy-switch-buffer-map (kbd "C-d") 'ivy-switch-buffer-kill)
(define-key ivy-reverse-i-search-map (kbd "C-k") 'ivy-previous-line)
(define-key ivy-reverse-i-search-map (kbd "C-d") 'ivy-reverse-i-search-kill)

;; Counsel
(counsel-mode 1)

;; Swiper
(global-set-key (kbd "C-s") 'swiper-isearch)

;; ivy-rich adds doc strings to ivy/counsel buffers
(require 'ivy-rich)
(ivy-rich-mode 1)
(setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line)

;; Helpful is an alternative to the built-in Emacs help that provides more contextual information and improved UI
;; here we set it up to integrate with counsel
(setq counsel-describe-function-function #'helpful-callable)
(setq counsel-describe-variable-function #'helpful-variable)
;; change describe-key keybindings to call helpful-key instead
(global-set-key (kbd "C-h k") #'helpful-key)
;; Lookup the current symbol at point. C-c C-d is a common keybinding for this in lisp modes.
(global-set-key (kbd "C-c C-d") #'helpful-at-point)
;; Look up *C*ommands.
;;
;; By default, C-h C is bound to describe `describe-coding-system'. I
;; don't find this very useful, but it's frequently useful to only
;; look at interactive functions.
(global-set-key (kbd "C-h C") #'helpful-command)

;; crux
(require 'crux)

;; General (leader-key bindings)
(require 'general)
(general-def :states '(normal motion) "SPC" nil) ; have to unbind space first before we can use it as a prefix key
(general-create-definer ewh/leader-keys
  :keymaps '(normal insert visual emacs)
  :prefix "SPC"
  :global-prefix "C-SPC")

(ewh/leader-keys
  ; toggles
  "t"  '(:ignore t :which-key "toggles")
  "tt" '(counsel-load-theme :which-key "choose theme")

  ; files
  "f"  '(:ignore t :which-key "files")
  "ff" '(counsel-find-file :which-key "find file")
  "fi" '(crux-find-user-init-file :which-key "open emacs init file")
  "fr" '(crux-rename-file-and-buffer :which-key "Rename the current buffer and its visiting file if any")

  ; buffers
  "b"  '(:ignore t :which-key "buffers")
  "bs" '(ivy-switch-buffer :which-key "switch buffer")
  "bn" '(next-buffer :which-key "next buffer")
  "bp" '(previous-buffer :which-key "previous buffer")
  "bk" '(kill-buffer :which-key "kill buffer")
  "bx" '(kill-current-buffer :which-key "kill current buffer")
  "ba" '(crux-kill-other-buffers :which-key "kill all other buffers")
  "bl" '(list-buffers :which-key "list buffers")

  ; windows
  "w"  '(:ignore t :which-key "windows")
  "wj" '(evil-window-down :which-key "window down")
  "wk" '(evil-window-up :which-key "window up")
  "wh" '(evil-window-left :which-key "window left")
  "wl" '(evil-window-right :which-key "window right")
  "ws" '(evil-window-split :which-key "split window")
  "wv" '(evil-window-vsplit :which-key "vertical split window")
  "wq" '(evil-quit :which-key "quit window")
  "wo" '(delete-other-windows :which-key "delete other windows")


  ; help
  "h"  '(:ignore t :which-key "help")
  "hk" '(helpful-key :which-key "describe key")
  "hf" '(counsel-describe-function :which-key "describe function")
  "hv" '(counsel-describe-variable :which-key "describe variable")
  "ha" '(counsel-apropos :which-key "apropos")

  ; eval
  "e"  '(:ignore t :which-key "eval")
  "eb" '(eval-buffer :which-key "eval buffer")
  "er" '(eval-region :which-key "eval region")

  ; shell
  "s"  '(:ignore t :which-key "shell")
  "ss" '(shell :which-key "open shell")
  "se" '(eshell :which-key "open eshell")
  "st" '(term :which-key "open terminal emulator")

  ; misc
  "m"  '(:ignore t :which-key "misc")
  "mx" '(counsel-M-x :which-key "M-x")
  "mq" '(fill-paragraph :which-key "fill-paragraph")
  )

;; set up PATH
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))
(when (daemonp)
  (exec-path-from-shell-initialize))

;; alchemist (elixir integration)
(require 'alchemist)

;; Projectile
(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :init
  (ewh/leader-keys
   "p" '(:keymap projectile-command-map :package projectile :which-key "projectile"))
  ;; NOTE: Set this to the folder where you keep your projects
  (when (file-directory-p "~/dev")
    (setq projectile-project-search-path '("~/dev")))
  ; load dired first thing upon switching projects
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package org)
