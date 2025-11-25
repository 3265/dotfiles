;; パッケージ設定
(require 'package)
(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; ネイティブコンパイルの warning を黙らせる
(when (boundp 'native-comp-async-report-warnings-errors)
  (setq native-comp-async-report-warnings-errors 'silent))

;; 起動時にカレントディレクトリを Dired で開く
(setq inhibit-startup-screen t)         ;; スタートアップ画面を消す
;; (setq initial-buffer-choice default-directory)

;; バックアップファイル（~ が付くやつ）を作らない
(setq make-backup-files nil)

;; 自動保存ファイル（#...#）も作らない
(setq auto-save-default nil)

;; ロックファイル（.#filename）もいらないなら
(setq create-lockfiles nil)

;; for orgmode calendar format
(setq system-time-locale "C")

;; agenda用
(setq org-agenda-restore-windows-after-quit t)         ;; q で元のレイアウトを復元

;; install Evil / Evil-collection
(unless (package-installed-p 'evil)
  (package-install 'evil))
(unless (package-installed-p 'evil-collection)
  (package-install 'evil-collection))

;; evil settings
(setq evil-want-keybinding nil)
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
  ;; コマンド間違い用
  (evil-ex-define-cmd "W"  'evil-write)
  (evil-ex-define-cmd "Q"  'evil-quit)
  (evil-ex-define-cmd "WQ" 'evil-save-and-close)
  (evil-ex-define-cmd "Wq" 'evil-save-and-close)
  ;; enterでファイルを開けるように
  (evil-define-key 'normal dired-mode-map
    ;; evilでもDiredでenterでファイルを開けるようにする
    (kbd "RET") 'dired-find-file
  )
  
  ;; imenu-listを自動で閉じるための処理
  (defun my/close-imenu-before-evil-quit (&rest _args)
  "evil-quit の前に imenu-list のウィンドウがあれば閉じる。"
  (when (and (boundp 'imenu-list-buffer-name)
             (get-buffer-window imenu-list-buffer-name)
             (fboundp 'imenu-list-quit-window))
    (with-selected-window (get-buffer-window imenu-list-buffer-name)
      (imenu-list-quit-window))))

  ;; :q / :q! / evil-quit が呼ばれる前に必ず実行
  (advice-add 'evil-quit :before #'my/close-imenu-before-evil-quit)
)


(require 'evil-collection)
(evil-collection-init 'org)

;; Org 基本設定
(require 'org)
(global-set-key (kbd "C-c a") 'org-agenda)
(setq org-agenda-files
      (append
       (directory-files-recursively "~/Dropbox/org" "\\.org\\'")))

;; outline on right pane
(use-package imenu-list
  :ensure t
  :bind (("C-c i" . imenu-list-smart-toggle))
  :init
  (setq imenu-list-position 'right
        imenu-list-size 0.5         ;; フレーム幅の30%
        )
        ;; imenu-list-auto-resize t)
  :hook
  (org-mode . imenu-list-minor-mode)) ;; ← .org を開いたときだけ自動ON

;; theme
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t)
)

