;; emacs ���� iTerm ���J��
; (defun execute-on-iterm (command)
;   (interactive "MCommand: ")
;   (do-applescript
;    (format "tell application 'iTerm'
;               activate
;               tell current session of current terminal
;                 write text '%s'
;               end tell
;             end tell"
; 	   command)))

; (defun cd-on-iterm ()
;   (interactive)
;   (execute-on-iterm
;    (format "cd %s" default-directory)))
   
;; python�̃R�[�f�B���O�K��`�F�b�N
;(when (load "python-pep8")
;  (define-key global-map "\C-c\ p" 'python-pep8))

;; Emacs��Git�N���C�A���g
;(require 'magit)

;; �R���p�C��������I���������ɃE�B���h�E�������ŕ���
;(bury-successful-compilation 1)

;; linum-mode �s�ԍ��̕\���Ȃ�
;; M-g g �œ���̍s�ɃW�����v
(global-linum-mode)

;; �r�[�v��������
(setq ring-bell-function 'ignore)

;; for NO-GUI environment
(cond (window-system
       (set-scroll-bar-mode 'right)))

;; Do not show Emacs startup screen
(setq inhibit-startup-screen t)

;; 1�s���X�N���[��
(setq scroll-conservatively 35
      scroll-margin 0
      scroll-step 1)

;; menu bar, tool bar, scroll bar
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode -1)

;; C-h��backspace�Ƃ��Ďg�p����
(keyboard-translate ?\C-h ?\C-?)

;; C-m��newline-and-indent�����蓖�Ă�B�����l��newline
(define-key global-map (kbd "C-m") 'newline-and-indent)

;; "C-t"�ŃE�B���h�E��؂�ւ���B�����l��transpose-chars
(define-key global-map (kbd "C-t") 'other-window)

;; ���������{���(�Œ���̕����R�[�h�̐ݒ肪�����)
(set-language-environment "Japanese")

(set-terminal-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(setq default-file-name-coding-system 'utf-8)
(setq file-name-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Emacs����̎����y/n�ŉ񓚂���
(fset 'yes-or-no-p 'y-or-n-p)

;; Emacs 23���O�̃o�[�W�����𗘗p���Ă���ꍇ�A
;; user-emacs-directory�ϐ�������`�̂��ߎ��̐ݒ��ǉ�
(when (< emacs-major-version 23)
  (defvar user-emacs-directory "~/.emacs.d/"))

;; load-path ��ǉ�����֐����`
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
              (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

;; ��艺�ɋL�q�������̂�PATH�̐擪�ɒǉ������
(dolist (dir (list
	      "/sbin"
	      "/usr/sbin"
	      "/bin"
	      "/usr/bin"
	      "/opt/local/bin"
	      "/sw/bin"
	      "/usr/local/bin"
	      "/usr/osxws/bin"
	      "/usr/texbin"
	      (expand-file-name "~/bin")
	      (expand-file-name "~/.emacs.d/bin")
	      ))
;; PATH��exec-path�ɓ������̂�ǉ�����
(when (and (file-exists-p dir)(not (member dir exec-path)))
  (setenv "PATH" (concat dir ":" (getenv "PATH")))
  (setq exec-path (append (list dir) exec-path))))

;; �����̃f�B���N�g���Ƃ��̃T�u�f�B���N�g����load-path�ɒǉ�
(add-to-load-path "elisp" "conf" "public_repos")

(add-to-list 'load-path "~/.emacs.d/elisp/color-theme")
;; Color Theme
;; for trying: M-x load-library RET color-theme RET 
;;   M-x color-theme-select RET
(require 'color-theme)
(color-theme-initialize)
(color-theme-classic)
;; �E�B���h�E�𔼓�����
(set-frame-parameter nil 'alpha 95)

;; �J�����ԍ����\��
(column-number-mode t)

;; �t�@�C���T�C�Y��\��
(size-indication-mode t)

;; Show full path of the file
(setq frame-title-format "%f")

;; package.el�̐ݒ�
;; �p�b�P�[�W���C���X�g�[������ɂ́A
;; M-x list-packages ����I�����邩�A
;; M-x package-refresh-contents �̌�� M-x package-initialize �p�b�P�[�W��
;; (M-x package-install �p�b�P�[�W�� �̊ԈႢ�H)
(package-initialize)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

;; clojure-mode
(use-package clojure-mode)

;; CIDER
(use-package cider)

;; web-mode �̐ݒ�
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[gj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))
(setq web-mode-engines-alist
'(("php"    . "\\.phtml\\'")
  ("blade"  . "\\.blade\\.")))

;; auto-install�̐ݒ�
(when (require 'auto-install nil t) 
  ;; �C���X�g�[���f�B���N�g����ݒ肷�� �����l�� ~/.emacs.d/auto-install/
  (setq auto-install-directory "~/.emacs.d/elisp/")
  ;; EmacsWiki�ɓo�^����Ă���elisp �̖��O���擾����
  ;(auto-install-update-emacswiki-package-name t)
  ;; �K�v�ł���΃v���L�V�̐ݒ���s��
  ;; (setq url-proxy-services '(("http" . "localhost:8339")))
  ;; install-elisp �̊֐��𗘗p�\�ɂ���
  (auto-install-compatibility-setup))

;; (auto-install-batch "anything")
(when (require 'anything nil t)
  (setq
   ;; ����\������܂ł̎��ԁB�f�t�H���g��0.5
   anything-idle-delay 0.3
   ;; �^�C�v���čĕ`�ʂ���܂ł̎��ԁB�f�t�H���g��0.1
   anything-input-idle-delay 0.2
   ;; ���̍ő�\�����B�f�t�H���g��50
   anything-candidate-number-limit 100
   ;; ��₪�����Ƃ��ɑ̊����x�𑁂�����
   anything-quick-update t
   ;; ���I���V���[�g�J�b�g���A���t�@�x�b�g��
   anything-enable-shortcuts 'alphabet)

  (when (require 'anything-config nil t)
    ;; root�����ŃA�N�V���������s����Ƃ��̃R�}���h
    ;; �f�t�H���g��"su"
    (setq anything-su-or-sudo "sudo"))

  (require 'anything-match-plugin nil t)

  (when (and (executable-find "cmigemo")
             (require 'migemo nil t))
    (require 'anything-migemo nil t))

  (when (require 'anything-complete nil t)
    ;; lisp�V���{���̕⊮���̍Č�������
    (anything-lisp-complete-symbol-set-timer 150))

  (require 'anything-show-completion nil t)

  (when (require 'auto-install nil t)
    (require 'anything-auto-install nil t))

  (when (require 'descbinds-anything nil t)
    ;; describe-bindings��Anything�ɒu��������
    (descbinds-anything-install)))

;; Auto Complete Mode
(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories 
    "~/.emacs.d/elisp/ac-dict")
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (ac-config-default))
(global-auto-complete-mode 1)

;; color-moccur�̐ݒ�
(when (require 'color-moccur nil t)
  ;; M-o��occur-by-moccur�����蓖��
  (define-key global-map (kbd "M-o") 'occur-by-moccur)
  ;; �X�y�[�X��؂��AND����
  (setq moccur-split-word t)
  ;; �f�B���N�g�������̂Ƃ����O����t�@�C��
  (add-to-list 'dmoccur-exclusion-mask "\\.DS_Store")
  (add-to-list 'dmoccur-exclusion-mask "^#.+#$")
  ;; Migemo�𗘗p�ł�����ł����Migemo���g��
  (when (and (executable-find "cmigemo")
             (require 'migemo nil t))
    (setq moccur-use-migemo t)))

;; undohist�̐ݒ�
(when (require 'undohist nil t)
  (undohist-initialize))


;; �Ή����銇�ʂ��n�C���C�g����B
(show-paren-mode 1)

;; undo-tree�̐ݒ�
(when (require 'undo-tree nil t)
  (global-undo-tree-mode))

;; point-undo�̐ݒ�
(when (require 'point-undo nil t)
  ;; (define-key global-map [f5] 'point-undo)
  ;; (define-key global-map [f6] 'point-redo)
  (define-key global-map (kbd "M-[") 'point-undo)
  (define-key global-map (kbd "M-]") 'point-redo)
  )

;;; P97-99 �t�H���g�̐ݒ�
(when (eq window-system 'ns)
  ;; ascii�t�H���g��Menlo��
  (set-face-attribute 'default nil
                      :family "Menlo"
                      :height 120)
  ;; ���{��t�H���g���q���M�m���� Pro��
  (set-fontset-font
   nil 'japanese-jisx0208
   ;; �p�ꖼ�̏ꍇ
   ;; (font-spec :family "Hiragino Mincho Pro"))
;   (font-spec :family "�q���M�m���� Pro"))
   (font-spec :family "Hiragino Kaku Gothic ProN"))
  ;; �Ђ炪�ȂƃJ�^�J�i�����g���V�[�_��
  ;; U+3000-303F	CJK�̋L������ы�Ǔ_
  ;; U+3040-309F	�Ђ炪��
  ;; U+30A0-30FF	�J�^�J�i
  (set-fontset-font
   nil '(#x3040 . #x30ff)
   (font-spec :family "NfMotoyaCedar"))
  ;; �t�H���g�̉����𒲐߂���
  (setq face-font-rescale-alist
        '((".*Menlo.*" . 1.0)
          (".*Hiragino_Mincho_Pro.*" . 1.2)
          (".*nfmotoyacedar-bold.*" . 1.2)
          (".*nfmotoyacedar-medium.*" . 1.2)
          ("-cdac$" . 1.3))))

(when (eq system-type 'windows-nt)
  ;; ascii�t�H���g��Consolas��
  (set-face-attribute 'default nil
                      :family "Consolas"
                      :height 120)
  ;; ���{��t�H���g�����C���I��
  (set-fontset-font
   nil
   'japanese-jisx0208
   (font-spec :family "���C���I"))
  ;; �t�H���g�̉����𒲐߂���
  (setq face-font-rescale-alist
        '((".*Consolas.*" . 1.0)
          (".*���C���I.*" . 1.15)
          ("-cdac$" . 1.3))))

;; yatex
(setq auto-mode-alist
      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq load-path (cons (expand-file-name "~/src/emacs/yatex") load-path))
(add-to-list 'load-path "~/.emacs.d/elisp/yatex")
;(setq tex-command "platex")
(setq tex-command "~/Library/Texshop/bin/platex2pdf-utf8")
;(setq dvi2-command "xdvi")
(setq dvi2-command "open -a Preview")
;(setq bibtex-command "pbibtex")
(setq dviprint-command-format "dvipdf %s")

;(set-frame-paremeter nil 'alpha 90)

;; Gather backup files and auto-save files
;; to ~/.emacs.d/backups/
(add-to-list 'backup-directory-alist
	     (cons "." "~/.emacs.d/backups/"))
;(setq auto-save-file-name-transforms
;      '((".*" ,(expand-file-name "~/.emacs.d/backups/") t)))


;; dired-mode
(ffap-bindings)
(require 'dired-aux)

