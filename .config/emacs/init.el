;; Package setup
(require 'package)
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

;; Install packages if missing
(dolist (pkg '(evil neotree org))
  (unless (package-installed-p pkg)
    (package-install pkg)))

;; Evil mode
(require 'evil)
(evil-mode 1)
(tab-bar-mode 1)

;; NERDTree-like file tree
(require 'neotree)
(setq neo-show-hidden-files t)
(global-set-key (kbd "<f8>") #'neotree-toggle)
(define-key evil-normal-state-map (kbd "C-e") #'neotree-toggle)
(with-eval-after-load 'neotree
  ;; Match common NERDTree habits in tree buffer.
  (define-key neotree-mode-map (kbd "q") #'neotree-hide)
  (define-key neotree-mode-map (kbd "C-e") #'neotree-hide)
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
  (evil-define-key 'normal neotree-mode-map (kbd "o") #'neotree-enter)
  (evil-define-key 'normal neotree-mode-map (kbd "t") #'my/neotree-open-in-new-tab))

;; Org mode defaults
(require 'org)
;; Start Org buffers in folded "overview" state
(setq org-startup-folded 'overview)
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
