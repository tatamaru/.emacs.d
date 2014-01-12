;packageのロード設定
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))

(package-initialize)


(add-to-list 'load-path "~/.emacs.d/elisp/skk")
(require 'skk-autoloads)
(global-set-key "\C-x\C-j" 'skk-mode)
(global-set-key "\C-xj" 'skk-auto-fill-mode)
(global-set-key "\C-xt" 'skk-tutorial)
(setq skk-preload t)


;paredit(括弧補完)設定
 (require 'paredit)
 (show-paren-mode 1)
;括弧内に色をつける
;;(setq show-paren-style 'expression)
 (defun turn-on-paredit () (paredit-mode 1))
 (add-hook 'clojure-mode-hook 'turn-on-paredit)

;clojureの設定
;auto-complete設定
(require 'clojure-mode)
(require 'auto-complete-config)
(ac-config-default)
;;(require 'ac-nrepl)
;;(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
;;(add-hook 'nrepl-mode-hook 'clojure-mode-font-lock-setup)
;;(add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
;;(require 'nrepl-ritz)

;; (eval-after-load "auto-complete" 
;;   '(add-to-list 'ac-modes 'nrepl-mode))

;nrepl
;; (add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)
;; (setq nrepl-popup-stacktraces nil)
;; (add-to-list 'same-window-buffer-names "*nrepl*")
;; (add-hook 'nrepl-interaction-mode 'paredit-mode)

;cider
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
;*nrepl-connection*,*nrepl-server*のbufferを表示しない
(setq cider-hide-special-buffers t)
;error bufferのポップアップを停止(有効にする場合はnil->t)
(setq cider-popup-stacktraces nil)

(setq nrepl-buffer-name-separator "-")

(setq nrepl-buffer-name-show-port t)

;;C-c,C-zでCIDER REPL bufferに切り替える
(setq cider-repl-display-in-current-window t)

;;CamelCaseの単語でforward-word,backward-wordを実行した場合大文字部にカーソルを移動する。
(add-hook 'cider-repl-mode-hook 'subword-mode)

(add-hook 'cider-repl-mode-hook 'paredit-mode)



;;ac-nrepl
(require 'ac-nrepl)
(add-hook 'cider-repl-mode-hook 'ac-nrepl-setup)
(add-hook 'cider-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'cider-repl-mode))
(defun set-auto-complete-as-completion-at-point-function()
  (setq completion-at-point-functions '(auto-complete)))
(add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)
(add-hook 'cider-repl-mode-hook 'set-auto-complete-as-completion-at-point-function)
(add-hook 'cider-mode-hook 'set-auto-complete-as-completion-at-point-function)

;;(define-key cider-mode-map (kbd "C-c C-d") 'ac-nrepl-popup-doc)


;;括弧の深さによって括弧の色を変える
(require 'rainbow-delimiters)
;すべてのプログラムモードで有効
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
;cider-repl-modeで有効(上記設定で有効にならない)
(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)

(require 'smartparens-config)
(add-hook 'cider-repl-mode-hook 'smartparens-strict-mode)
(add-hook 'prog-mode-hook 'smartparens-strict-mode)

;短形貼り付け方法の設定
(cua-mode t)
(setq cua-enable-cua-keys nil)


;初期画面の非表示
(setq inhibit-startup-message t)

;scratchバッファの初期メッセージを消す
(setq initial-scratch-message "")

;メニューバー、ツールバー非表示
(tool-bar-mode -1)
(menu-bar-mode -1)

;yesかnoではなくyかnで答えられるようにする
(defalias 'yes-or-no-p 'y-or-n-p)

;Backspaceボタンの割り当てを\C-hに設定する
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)

;バッファ左側に行番号を表示する
(global-linum-mode 1)
;(setq linum-format "%6d")

;カーソルがどの関数にあるかモードら員に表示
(which-function-mode 1)

;文字列をウィンドウの右端で折り返さない
;;通常のウインドウ用の設定
;; (setq-default truncate-lines t)
;;ウィンドウを左右に分割したとき用の設定
;;(setq-default truncate-partial-width-windows t)



;javascriptモードの設定
(add-to-list 'load-path "~/.emacs.d/elisp/js3-mode")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(js3-curly-indent-offset 2)
 '(js3-expr-indent-offset 2)
 '(js3-lazy-commas t)
 '(js3-lazy-dots t)
 '(js3-lazy-operators t)
 '(js3-paren-indent-offset 2)
 '(js3-square-indent-offset 2))
(autoload 'js3-mode "js3" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js3-mode))
(add-to-list 'ac-modes 'js3-modes)


;Sphinx用の設定

(add-to-list 'load-path "~/.emacs.d/elisp/rst")
(require 'rst)
(setq auto-mode-alist
      (append '(("\\.rst$" . rst-mode)
		("\\.rest$" . rst-mode)) auto-mode-alist))
(setq frame-background-mode 'dark)
(add-hook 'rst-mode-hook '(lambda() (setq indent-tabs-mode nil)))

;color-themeの設定
;; (add-to-list 'load-path "~/.emacs.d/elisp/color-theme")
;; (require 'color-theme)
;; (color-theme-initialize)
;; (color-theme-jonadabian-slate)
(load-theme 'wombat t)
(enable-theme 'wombat)


(defun eshell-cd-default-directory ()
  (interactive)
  (let ((dir default-directory))
    (eshell)
    (cd dir)
    (eshell-interactive-print (concat "cd " dir "\n"))
    (eshell-emit-prompt)))
(global-set-key (kbd "<C-M-return>") 'eshell-cd-default-directory)



(put 'downcase-region 'disabled nil)

(global-set-key (kbd "C-c <left>") 'windmove-left)
(global-set-key (kbd "C-c <down>") 'windmove-down)
(global-set-key (kbd "C-c <up>") 'windmove-up)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(rainbow-delimiters-depth-1-face ((t (:foreground "cornflower blue"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "dark orange"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "white"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "yellow"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "medium spring green"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "violet"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "khaki1")))))
