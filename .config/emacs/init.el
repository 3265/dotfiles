;; パッケージ設定
(require 'package)
(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; 起動時にカレントディレクトリを Dired で開く
(setq inhibit-startup-screen t)         ;; スタートアップ画面を消す
(setq initial-buffer-choice default-directory)

;; for orgmode calendar format
(setq system-time-locale "C")

;; Evil / Evil-collection
(setq evil-want-keybinding nil)
(unless (package-installed-p 'evil)
  (package-install 'evil))
(unless (package-installed-p 'evil-collection)
  (package-install 'evil-collection))

(with-eval-after-load 'evil
  (define-key evil-insert-state-map (kbd "<escape>") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-[") 'evil-normal-state)
)

(require 'evil)
;; page down
(setq evil-want-C-d-scroll t) 
(evil-mode 1)

(with-eval-after-load 'evil
  ;; page up
  (define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
  (define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up)
  (evil-ex-define-cmd "W"  'evil-write)
  (evil-ex-define-cmd "Q"  'evil-quit)
  (evil-ex-define-cmd "WQ" 'evil-save-and-close)
  (evil-ex-define-cmd "Wq" 'evil-save-and-close)
  (evil-define-key 'normal dired-mode-map
    ;; evilでもDiredでenterでファイルを開けるようにする
    (kbd "RET") 'dired-find-file
  )
)


(require 'evil-collection)
(evil-collection-init 'org)

;; Org 基本設定
(require 'org)
(global-set-key (kbd "C-c a") 'org-agenda)
(setq org-agenda-files '("~/org"))

;; 
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t)
)

