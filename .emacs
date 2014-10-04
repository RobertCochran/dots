;;;; Emacs startup
; Alex Jordan
; 17 July 2013

(add-to-list 'load-path  "~/.emacs.d/")

;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; COMPATIBILITY NOTES
;
;;;;;;;;;;;;;;;;;;;;;;;;;;

; Emacs 24

; Compatible out-of-the-box.

; Emacs 23

; Requires manual installation of package.el in the appropriate load-path directory.
; May cause problems with deftheme in the future. Works currently.
; On Debian, emacs-23 throws error "package emacs-24 is not available". Needs further debugging.

; magit-filenotify may cause problems, due to needing Emacs 24.4's filenotify. Needs testing.

;;;;;;;;;;;;;;;
;
; PACKAGES
;
;;;;;;;;;;;;;;;

(require 'package)

; Main ELPA repository for Emacs versions where this isn't included by default
(when (< emacs-major-version 24)
	(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

; MEPLA
(add-to-list 'package-archives
	'("melpa" . "http://melpa.milkbox.net/packages/") t)

; Bug fix from the MELPA home page
(defadvice package-compute-transaction
	(before package-compute-transaction-reverse (package-list requirements) activate compile)
		"reverse the requirements"

		(setq requirements (reverse requirements))
		(print requirements))

(package-initialize)

; Ensure that the proper packages are installed
(defun ensure-packages (package-list)
  "Ensures packages in list are installed locally"
  (unless (file-exists-p package-user-dir)
    (package-refresh-contents))
  (dolist (package package-list)
    (unless (package-installed-p package)
      (package-install package))))

(ensure-packages '(solarized-theme sudo-ext markdown-mode markdown-mode+ stupid-indent-mode pkgbuild-mode nyan-mode 2048-game apache-mode apt-utils display-theme less-css-mode know-your-http-well lua-mode lorem-ipsum list-processes+ melpa-upstream-visit mediawiki grunt hardcore-mode hackernews ham-mode list-packages-ext eide powershell powershell-mode annoying-arrows-mode json-mode jade-mode editorconfig magit magit-filenotify magit-gh-pulls magit-tramp org-magit gist git-commit-mode git-link git-messenger gitattributes-mode gitconfig gitconfig-mode github-browse-file github-clone gitignore-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; EMACS BUILT-IN CUSTOMIZATIONS
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Save all tempfiles in $TMPDIR/emacs$UID/
(defconst emacs-tmp-dir (format "%s/%s%s/" temporary-file-directory "emacs" (user-uid)))
(setq backup-directory-alist
	`((".*" . ,emacs-tmp-dir)))
(setq auto-save-file-name-transforms
	`((".*" ,emacs-tmp-dir t)))
(setq auto-save-list-file-prefix
	emacs-tmp-dir)

;;;;;;;;;;;;;;;;;;
;
; MAJOR MODES
;
;;;;;;;;;;;;;;;;;;

; PKGBUILD mode
(autoload 'pkgbuild-mode "pkgbuild-mode.el" "PKGBUILD mode." t)
(setq auto-mode-alist (append '(("/PKGBUILD$" . pkgbuild-mode)) auto-mode-alist))

; TODO:
; apache-mode
; less-css-mode
; markdown-mode
; mediawiki
; lua-mode
; powershell-mode
; json-mode

;;;;;;;;;;;;;;;;;;
;
; MINOR MODES
;
;;;;;;;;;;;;;;;;;;

; package-list-packages improvements
; (add-hook 'package-menu-mode-hook (lambda () (list-packages-ext-mode 1))

; TODO:
; display-theme-mode
; nyan-mode
; markdown-mode+
; stupid-indent-mode
; hardcore-mode
; ham-mode
; list-processes+
; list-packages-ext
; rainbow-delimiters-mode
; annoying-arrows-mode

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; UTILITIES & LIBRARIES
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; TODO:
; sudo-ext
(autoload '2048-game "2048-game" "play 2048 in Emacs" t)
; apt-utils
; know-your-http-well
; lorem-ipsum
; melpa-upstream-visit
; mediawiki
; grunt
; hackernews
; eide
; powershell
; editorconfig
; magit-*

;;;;;;;;;;;;;
;
; THEMES
;
;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (solarized-dark)))
 '(custom-safe-themes (quote ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
