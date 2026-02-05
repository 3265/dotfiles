;; Package setup
(require 'package)
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

;; Install packages if missing
(defun my/install-package-if-missing (pkg)
  (unless (package-installed-p pkg)
    (condition-case err
        (package-install pkg)
      (error
       (message "Skipping package install for %s: %s" pkg (error-message-string err))))))

(dolist (pkg '(evil neotree org))
  (my/install-package-if-missing pkg))

;; Evil mode
(setq evil-want-C-u-scroll t)
(require 'evil)
(evil-mode 1)
(tab-bar-mode 1)
(global-set-key (kbd "C-c r") #'eval-buffer)
(global-set-key (kbd "C-s") #'save-buffer)

;; `C-t h/l` to move between tabs, similar to terminal/vim habits.
(define-prefix-command 'my/tab-prefix-map)
(global-set-key (kbd "C-t") #'my/tab-prefix-map)
(define-key my/tab-prefix-map (kbd "h") #'tab-bar-switch-to-prev-tab)
(define-key my/tab-prefix-map (kbd "l") #'tab-bar-switch-to-next-tab)
(define-key my/tab-prefix-map (kbd "C-h") #'tab-bar-switch-to-prev-tab)
(define-key my/tab-prefix-map (kbd "C-l") #'tab-bar-switch-to-next-tab)
(evil-define-key 'normal 'global (kbd "C-t") #'my/tab-prefix-map)

;; Keep working tree clean: disable backup/auto-save/lock files.
(setq make-backup-files nil   ; stops `filename~`
      auto-save-default nil   ; stops `#filename#`
      create-lockfiles nil)   ; stops `.#filename`

;; Dark-mode friendly UI (GUI/terminal, including daemon-created frames).
(defun my/apply-dark-theme (&optional frame)
  (with-selected-frame (or frame (selected-frame))
    (setq frame-background-mode 'dark)
    (mapc #'disable-theme custom-enabled-themes)
    (load-theme 'tango-dark t)))

(my/apply-dark-theme)
(add-hook 'after-make-frame-functions #'my/apply-dark-theme)

;; Use Hack Nerd Font in GUI Emacs when available.
(when (display-graphic-p)
  (let ((hack-font (or (car (seq-filter (lambda (name)
                                          (find-font (font-spec :family name)))
                                        '("Hack Nerd Font Mono"
                                          "Hack Nerd Font")))
                       "Hack Nerd Font")))
    (set-face-attribute 'default nil :family hack-font :height 150)
    (set-face-attribute 'fixed-pitch nil :family hack-font :height 150)
    (set-face-attribute 'variable-pitch nil :family hack-font :height 150)))

;; NERDTree-like file tree
(require 'neotree)
(setq neo-show-hidden-files t)
(setq neo-hidden-regexp-list
      (append neo-hidden-regexp-list '("^#.*#$" "~$" "^\\.#")))
(global-set-key (kbd "<f8>") #'neotree-toggle)
(define-key evil-normal-state-map (kbd "C-e") #'neotree-toggle)
(with-eval-after-load 'neotree
  ;; Match common NERDTree habits in tree buffer.
  (define-key neotree-mode-map (kbd "q") #'neotree-hide)
  (define-key neotree-mode-map (kbd "C-e") #'neotree-hide)
  (define-key neotree-mode-map (kbd "RET") #'neotree-enter)
  (define-key neotree-mode-map (kbd "<return>") #'neotree-enter)
  (define-key neotree-mode-map (kbd "o") #'neotree-enter)
  (defun my/neotree-open-in-new-tab ()
    (interactive)
    (let ((path (neo-buffer--get-filename-current-line)))
      (when (and path (file-regular-p path))
        (tab-bar-new-tab)
        (find-file path))))
  (define-key neotree-mode-map (kbd "t") #'my/neotree-open-in-new-tab)
  ;; Evil normal state overrides many single-key bindings (like "t").
  (evil-define-key 'normal neotree-mode-map (kbd "q") #'neotree-hide)
  (evil-define-key 'normal neotree-mode-map (kbd "C-e") #'neotree-hide)
  (evil-define-key 'normal neotree-mode-map (kbd "RET") #'neotree-enter)
  (evil-define-key 'normal neotree-mode-map (kbd "<return>") #'neotree-enter)
  (evil-define-key 'normal neotree-mode-map (kbd "o") #'neotree-enter)
  (evil-define-key 'normal neotree-mode-map (kbd "t") #'my/neotree-open-in-new-tab))

;; Org mode defaults
(require 'org)
;; Start Org buffers in folded "overview" state
(setq org-startup-folded 'overview)
(with-eval-after-load 'org
  ;; Improve Org readability.
  (setq org-startup-indented t
        org-hide-emphasis-markers t
        org-pretty-entities t
        org-ellipsis "...")
  (add-hook 'org-mode-hook #'org-indent-mode)
  (add-hook 'org-mode-hook #'visual-line-mode)
  (when (require 'org-modern nil t)
    (add-hook 'org-mode-hook #'org-modern-mode))
  (set-face-attribute 'org-level-1 nil :weight 'bold :height 1.2)
  (set-face-attribute 'org-level-2 nil :weight 'bold :height 1.12)
  (set-face-attribute 'org-level-3 nil :weight 'bold :height 1.06)
  (set-face-attribute 'org-block nil :background "#1f1f1f" :extend t)
  (set-face-attribute 'org-block-begin-line nil :foreground "#8a8a8a" :extend t)
  (set-face-attribute 'org-block-end-line nil :foreground "#8a8a8a" :extend t)
  ;; In Org buffers, TAB reveals/cycles the subtree at point.
  (define-key org-mode-map (kbd "TAB") #'org-cycle)
  (define-key org-mode-map (kbd "<tab>") #'org-cycle)
  (define-key org-mode-map (kbd "<backtab>") #'org-shifttab)
  (evil-define-key 'normal org-mode-map (kbd "TAB") #'org-cycle)
  (evil-define-key 'normal org-mode-map (kbd "<tab>") #'org-cycle)
  (evil-define-key 'normal org-mode-map (kbd "<backtab>") #'org-shifttab))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
