;;; M-x g goto-line
(global-set-key "\M-g" 'goto-line)

(global-set-key "\C-h" 'backward-delete-char)

;;; trr
;(add-to-list 'load-path "~/.emacs.d/emacs-trr/")
;(setq TRR:record-dir "~/.emacs.d/emacs-trr/")
;(require 'trr)

;;; Evil
;; Emacs directory
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

;; Package management
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(defun package-install-with-refresh (package)
  (unless (assq package package-alist)
    (package-refresh-contents))
  (unless (package-installed-p package)
    (package-install package)))

;; Install evil
(package-install-with-refresh 'evil)

;; Enable evil
(require 'evil)
(evil-mode 1)

;;; Import settings from .emacs
(global-unset-key "\C-o" )
(setq rosdistro (getenv "ROS_DISTRO"))
(add-to-list 'load-path (format "/opt/ros/%s/share/emacs/site-lisp" (or rosdistro "indigo")))
(require 'rosemacs)
(invoke-rosemacs)
(global-set-key "\C-x\C-r" ros-keymap)
