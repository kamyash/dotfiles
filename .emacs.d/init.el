;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; load paths
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
	      (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))
(add-to-load-path ".cask")

(require 'cask)
(cask-initialize)

(global-linum-mode) ; M-g g -> jump to specific line

;; view
(setq inhibit-startup-screen t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode -1)
(set-frame-parameter nil 'alpha 95)
(column-number-mode t)
(size-indication-mode t)
(setq frame-title-format "%f") ; Show full path of the file
(show-paren-mode 1)
(load-theme 'sanityinc-solarized-dark t)

;; UX
(setq ring-bell-function 'ignore)
(fset 'yes-or-no-p 'y-or-n-p)
(setq scroll-conservatively 35
      scroll-margin 0
      scroll-step 1) ; scroll by 1 line
(require 'auto-complete-config)
(ac-config-default)

;; key-binds
(keyboard-translate ?\C-h ?\C-?)
(define-key global-map (kbd "C-m") 'newline-and-indent) ; default: newline
(define-key global-map (kbd "C-t") 'other-window) ; default: transpose-chars

;; language environment
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(setq default-file-name-coding-system 'utf-8)
(setq file-name-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; fonts
(when (eq window-system 'ns)
  (set-face-attribute 'default nil
                      :family "Menlo"
                      :height 120)
  (set-fontset-font
   nil 'japanese-jisx0208
   (font-spec :family "Hiragino Kaku Gothic ProN"))
  (set-fontset-font
   nil '(#x3040 . #x30ff)
   (font-spec :family "NfMotoyaCedar"))
  (setq face-font-rescale-alist
        '((".*Menlo.*" . 1.0)
          (".*Hiragino_Mincho_Pro.*" . 1.2)
          (".*nfmotoyacedar-bold.*" . 1.2)
          (".*nfmotoyacedar-medium.*" . 1.2)
          ("-cdac$" . 1.3))))
(when (eq system-type 'windows-nt)
  (set-face-attribute 'default nil
                      :family "Consolas"
                      :height 120)
  (set-fontset-font
   nil
   'japanese-jisx0208
   (font-spec :family "メイリオ"))
  (setq face-font-rescale-alist
        '((".*Consolas.*" . 1.0)
          (".*メイリオ.*" . 1.15)
          ("-cdac$" . 1.3))))

(add-to-list 'backup-directory-alist
	     (cons "." "~/.emacs.d/backups/")) ; gather buckup files and auto-save files

