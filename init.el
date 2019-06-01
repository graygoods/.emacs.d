;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://https://melpa.org/packages/") t)
(package-initialize)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (wombat)))
 '(ecb-options-version "2.50")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--mouse-2))
 '(ecb-source-path (quote (("~/" "~/"))))
 '(org-support-shift-select (quote always))
 '(package-selected-packages (quote (magit "ecb" company undo-tree)))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((((class color) (min-colors 89)) (:background "#242424" :foreground "#f6f3e8" :family "Courier 10 Pitch" :foundry "bitstream" :slant normal :weight normal :height 151 :width normal))))
 '(cursor ((((class color) (min-colors 89)) (:background "#656565"))))
 '(highlight ((((class color) (min-colors 89)) (:background "Black" :foreground nil :underline nil))))
 '(org-level-1 ((t (:bold t :foreground "dodger blue" :height 1.5))))
 '(org-level-2 ((t (:bold t :foreground "#edd400" :height 1.2))))
 '(org-level-3 ((t (:bold t :foreground "#6ac214" :height 1.0))))
 '(org-level-4 ((t (:bold nil :foreground "tomato" :height 1.0)))))

(let ((class '((class color) (min-colors 89))))
  (custom-set-faces
   `(default ((,class (:background "#242424" :foreground "#f6f3e8"))))
   `(cursor ((,class (:background "#656565"))))
   ;; Highlighting faces
   `(highlight ((,class (:background "Black" :foreground nil
                                     :underline nil))))))
(global-linum-mode t) ;;line num

(tool-bar-mode 0)


(setq-default indent-tabs-mode nil) 
(setq c-basic-offset 4)
(setq default-tab-width 4) ;;tab width

(electric-pair-mode t)
(electric-layout-mode  t)
(electric-indent-mode t) ;;electric pair

(show-paren-mode t)
(setq show-paren-style 'parenthesis) ;;show paren

(global-hl-line-mode t) ;;high light line

;(setq c-plus-plus-eleven 0)
;(setq y "org")
(defun mycompile()
  (interactive)
  (save-buffer)
  (cond
   ((string-equal ".org" (substring (buffer-file-name) (search ".org" buffer-file-name)))
    (org-export-dispatch)
    )
   
   ((string-equal ".cpp" (substring (buffer-file-name) (search ".cpp" buffer-file-name)))
    (compile (format "g++ %s -o %s -Wall -g3" (buffer-file-name) (substring buffer-file-name 0 -4)))
    )

   ((string-equal ".c" (substring (buffer-file-name) (search ".c" buffer-file-name)))
    (compile (format "gcc %s -o %s -Wall -g3" (buffer-file-name) (substring buffer-file-name 0 -2)))
    )
   )
  )

(defun run()
  (interactive)
  (save-buffer)
  (cond 
   ((string-equal system-type "gnu/linux")
    (shell-command (format "gnome-terminal -- bash -c \"time %s; read n -1\"" (substring buffer-file-name 0 -4))))
   
   ((string-equal system-type "windows-nt")
    (shell-command (format "echo @echo off ^& %s.exe >> tmp.bat" (substring buffer-file-name 0 -4)))
    (shell-command "echo echo -------------------------------- ^& echo Process exited with return value ^%errorlevel^% ^& pause ^& exit >> tmp.bat")
    (shell-command "start tmp.bat")
    (shell-command "del tmp.bat")
    )
   )
  )

(global-set-key [f7] 'mycompile) ;;use f7 for compile
(global-set-key [f8] 'run)
;(global-set-key [f9] 'mygdb)
(global-set-key [f10] 'shell)
(global-set-key (kbd "C-x g") 'magit-status)

(defun split()
  (interactive)
  (delete-other-windows)
  (split-window-right)
  (enlarge-window-horizontally 22)
  (other-window 1)
  (split-window-below)
  (other-window 1)
  (other-window 1)
  (shell)
  (compile (format "g++ %s" (buffer-file-name))))
(global-set-key [f6] 'split)

;;set transparent effect
(global-set-key [(f4)] 'loop-alpha)
(setq alpha-list '((100 100) (95 65) (85 55) (75 45) (65 35)))
(defun loop-alpha ()
  (interactive)
  (let ((h (car alpha-list)))                ;; head value will set to
    ((lambda (a ab)
       (set-frame-parameter (selected-frame) 'alpha (list a ab))
       (add-to-list 'default-frame-alist (cons 'alpha (list a ab)))
       ) (car h) (car (cdr h)))
    (setq alpha-list (cdr (append alpha-list (list h))))
    )
  )

(require 'package)
(package-initialize)
(add-to-list'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

(add-to-list 'load-path "~/.emacs.d/popup")
(add-to-list 'load-path "~/.emacs.d/auto-complete")
(require 'auto-complete)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/dict")
(ac-config-default)

(add-to-list 'load-path "~/.emacs.d/yasnippet")
(require 'yasnippet)
(setq yas-snippet-dirs '("~/.emacs.d/snippets"))
(yas-global-mode 1)


(add-to-list 'load-path "~/.emacs.d/color-theme")
(require 'color-theme)
;(color-theme-initialize)
;(color-theme-gray30)
;(color-theme-calm-forest)

                                        ;
;(add-to-list 'load-path "~/.emacs.d/cedet")
;(load-file "~/.emacs.d/cedet/common/cedet.el")
;(global-ede-mode 1)
;(semantic-load-enable-gaudy-code-helpers)
;(global-srecode-minor-mode 1)

(add-to-list 'load-path "~/.emacs.d/ecb")
(require 'ecb)
;(ecb-activate)
(setq ecb-tip-of-the-day nil)
(setq stack-trace-on-error nil)
(setq ecb-auto-activate t)
(ecb-activate)

(load-file "~/.emacs.d/tabbar.el")
(require 'tabbar)
(tabbar-mode t)
(set-face-attribute 'tabbar-default nil
                    :family "Consolas"
                    :background "#5E5E5E"
                    :foreground "#CECECE"
                    :height 1.0
                    )
;; 设置左边按钮外观：外框框边大小和颜色
(set-face-attribute 'tabbar-button nil
                    :inherit 'tabbar-default
                    :box '(:line-width 1 :color "#5E5E5E")
                    )
;; 设置当前tab外观：颜色，字体，外框大小和颜色
(set-face-attribute 'tabbar-selected nil
                    :inherit 'tabbar-default
                    :foreground "White"
                    :background "#2E2E2E"
                    :box '(:line-width 2 :color "#2E2E2E")
                    ;; :overline "black"
                    ;; :underline "black"
                    :weight 'bold
                    )
;; 设置非当前tab外观：外框大小和颜色
(set-face-attribute 'tabbar-unselected nil
                    :inherit 'tabbar-default
                    ;:foreground "White"
                    :background "#5E5E5E"
                    :box '(:line-width 2 :color "#5E5E5E")
                    )

(defun refresh-file ()
  (interactive)
  (revert-buffer t (not (buffer-modified-p)) t))
 
(global-set-key [(f5)] 'refresh-file)

(global-set-key [apps] "    ")

;(add-to-list 'custom-theme-load-path "~/.emacs.d/color-theme-tangotango")
;(load-theme 'tangotango t)

;helm-emms
;(add-to-list 'load-path "G:/data/.emacs.d/helm-emms")
;(load-file "G:/data/.emacs.d/helm-emms/helm-emms.el")
;(require 'helm-emms)
;(autoload 'helm-emms "helm-emms" nil t)

;w3m
;(add-to-list 'load-path "G:/data/.emacs.d/w3m-el")
;(require 'w3m-load) 
;(add-to-list 'exec-path "G:/data/.emacs.d/w3m")
;(require 'w3m)

(add-to-list 'load-path "~/.emacs.d/smex")
(require 'smex)
(smex-initialize)
(global-set-key(kbd "M-x") 'smex)
(global-set-key(kbd "M-X") 'smex-major-mode-commands)
;;This is your old M-x.
(global-set-key(kbd "C-c C-c M-x") 'execute-extended-command)

;(add-to-list 'load-path "D:/data/.emacs.d/flycheck")
                                        ;(require 'flycheck)

(defun display-buffer-at-bottom--display-buffer-at-bottom-around (orig-fun &rest args)
  "Bugfix for ECB: cannot use `display-buffer-at-bottom', call
`display-buffer-use-some-window' instead in ECB frame."
  (if (and ecb-minor-mode (equal (selected-frame) ecb-frame))
      (apply 'display-buffer-use-some-window args)
    (apply orig-fun args)))
(advice-add 'display-buffer-at-bottom :around #'display-buffer-at-bottom--display-buffer-at-bottom-around)

;(autoload 'w3m "w3m" "interface for w3m on emacs" t) 
;(setq w3m-command-arguments '("-cookie" "-F")) 
;(setq w3m-use-cookies t) 
;(setq w3m-home-page "http://www.baidu.com") 
;(require 'mime-w3m) 
;(setq w3m-default-display-inline-image t) 
;(setq w3m-default-toggle-inline-images t)

;(add-hook 'c-mode-hook 'company-clang)
;(add-hook 'after-init-hook 'global-company-mode)
;(add-hook 'c++-mode-hook 'global-company-mode)
