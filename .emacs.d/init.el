(package-initialize)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))


;; set japanese mozc to zenkaku-hankaku as global key
(add-to-list 'load-path "/usr/share/emacs24/site-lisp/emacs-mozc")
(require 'mozc)
(setq default-input-method "japanese-mozc")
(global-set-key [zenkaku-hankaku] 'toggle-input-method)

(set-frame-font "ricty-13")

;;; package
 (require 'package)
 (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
 (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)
;;(require 'melpa)

;;; add load-path
(setq load-path (append
		 '("~/.emacs.d/lisp"
		   "~/.emacs.d/packages"
		   "~/.emacs.d/elpa")
		 load-path))

;;; proxy
 (setq url-proxy-services '(("http" . "http://proxy.uec.ac.jp:8080")))
 (setq url-proxy-services '(("https" . "http://proxy.uec.ac.jp:8080")))

;;; window size
(set-frame-size (selected-frame) 110 50)

;;; window theme
(load-theme 'wombat t)

;;; paren mode mixed
(setq show-paren-style 'mixed)
;;; No backup files
(setq make-backup-files nil)
;;; delete if emacs shutdown
(setq delete-auto-save-files t)
;;; not display scratch massages
(setq inhibit-startup-message t)

;;; not display column, line, scrollbar
(column-number-mode t)
(line-number-mode t)
(set-scroll-bar-mode nil)

;;; display full path on the titlebar
(setq frame-title-format
      (format "%%f- Emacs@%s" (system-name)))

;;; emphasize paren
(show-paren-mode t)
(setq show-paren-delay 0)
(setq show-paren-style 'expression)
(set-face-background 'show-paren-match-face nil)


;;; Stop Cursor blink
(blink-cursor-mode 0)

;;; not showing toolbars
(tool-bar-mode -1)
(menu-bar-mode -1)

;;; UTF-8
;;; from http://qiita.com/ironsand/items/a53797bd48170104aa74
(prefer-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)

;;; Paren settings
(show-paren-mode t)
(electric-pair-mode t)
(global-font-lock-mode t)

;;; Ignore case
(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)

;;; Line and column number
(global-linum-mode t)
(set-face-attribute 'linum nil
		    :foreground "#ffffff"
		    :height 0.9)
(setq linum-format: "%4d: ")

;;; tranparancy
(set-frame-parameter (selected-frame) 'alpha '(0.97))

;;; python-mode indent
(add-hook 'python-mode-hook
    '(lambda ()
        (setq python-indent 4)
        (setq indent-tabs-mod nil)
        (define-key (current-local-map) "\C-h" 'python-backspace)
    ))


;;; aspell
(setq-default ispell-program-name "aspell")
(eval-after-load "ispell"
'(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))
;;
(global-set-key (kbd "C-M-$") 'ispell-complete-word)

(mapc
(lambda (hook)
(add-hook hook 'flyspell-prog-mode))
'(
c-mode-common-hook
emacs-lisp-mode-hook
))
(mapc
(lambda (hook)
(add-hook hook
'(lambda () (flyspell-mode 1))))
'(
yatex-mode-hook
))

;;; jedi.el settings
 (add-hook 'python-mode-hook' jedi:setup)
 (setq jedi:complete-on-dot t)

;;(eval-after-load "python"
;;  '(define-key python-mode-map "\C-cx" 'jedi-direx:pop-to-buffer))
;;(add-hook 'jedi-mode-hook 'jedi-direx:setup)

;; tabbar settings
;;(tabbar-mode 1)


;;(tabbar-mwheel-mode nil)                  ;; マウスホイール無効
;;(setq tabbar-buffer-groups-function nil)  ;; グループ無効
;;(setq tabbar-use-images nil)              ;; 画像を使わない

;;----- キーに割り当てる
;;(global-set-key (kbd "<C-tab>") 'tabbar-forward-tab)
;;(global-set-key (kbd "<C-iso-lefttab>") 'tabbar-backward-tab)


;;----- 左側のボタンを消す
;;(dolist (btn '(tabbar-buffer-home-button
;;               tabbar-scroll-left-button
;;               tabbar-scroll-right-button))
;;  (set btn (cons (cons "" nil)
;;                 (cons "" nil))))

;;----- タブのセパレーターの長さ
;;(setq tabbar-separator '(2.0))

;; elscreen
(require 'elscreen)
(elscreen-start)
(global-set-key (kbd "<C-tab>") 'elscreen-next)
(global-set-key (kbd "<C-iso-lefttab>") 'elscreen-previous)
(global-set-key (kbd "\C-zt") 'elscreen-create)
(global-set-key (kbd "\C-zw") 'elscreen-kill)

;;; タブの先頭に[X]を表示しない
(setq elscreen-tab-display-kill-screen nil)
;;; header-lineの先頭に[<->]を表示しない
(setq elscreen-tab-display-control nil)
;;; バッファ名・モード名からタブに表示させる内容を決定する(デフォルト設定)
(setq elscreen-buffer-to-nickname-alist
      '(("^dired-mode$" .
         (lambda ()
           (format "Dired(%s)" dired-directory)))
        ("^Info-mode$" .
         (lambda ()
           (format "Info(%s)" (file-name-nondirectory Info-current-file))))
        ("^mew-draft-mode$" .
         (lambda ()
           (format "Mew(%s)" (buffer-name (current-buffer)))))
        ("^mew-" . "Mew")
        ("^irchat-" . "IRChat")
        ("^liece-" . "Liece")
        ("^lookup-" . "Lookup")))
(setq elscreen-mode-to-nickname-alist
      '(("[Ss]hell" . "shell")
        ("compilation" . "compile")
        ("-telnet" . "telnet")
        ("dict" . "OnlineDict")
        ("*WL:Message*" . "Wanderlust")))

;; pyflakes
(flymake-mode t)
(require 'flymake-python-pyflakes)
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)

;; hook imenu on python-mode
(add-hook 'python-mode-hook' imenu-list-minor-mode)

;; allocate M-x revert-buffer to M-r
(defun revert-buffer-no-confirm (&optional force-reverting)
  "Interactive call to revert-buffer. Ignoring the auto-save
 file and not requesting for confirmation. When the current buffer
 is modified, the command refuses to revert it, unless you specify
 the optional argument: force-reverting to true."
  (interactive "P")
  ;;(message "force-reverting value is %s" force-reverting)
  (if (or force-reverting (not (buffer-modified-p)))
      (revert-buffer :ignore-auto :noconfirm)
    (error "The buffer has been modified")))
(global-set-key (kbd "<f5>") 'revert-buffer-no-confirm)
