(setq evil-escape-key-sequence "jk"
      evil-escape-delay 0.2)
(evil-escape-mode 1)
(setq doom-theme 'doom-one)
(setq display-line-numbers-type 'relative)
(setq org-directory "~/org/")
(setq-default tab-width 4)
(setq-default evil-shift-width tab-width)
(setq doom-font (font-spec :family "IosevkaTerm Nerd Font" :size 20 :weight 'medium)
      doom-variable-pitch-font (font-spec :family "JetBrains Mono" :size 15 :weight 'light)
      doom-big-font (font-spec :family "Iosevka" :size 30))
(defun prefer-horizontal-split ()
  (set-variable 'split-height-threshold nil t)
  (set-variable 'split-width-threshold 40 t)) ; make this as low as needed
(add-hook 'markdown-mode-hook 'prefer-horizontal-split)
(define-key evil-normal-state-map (kbd "H") (kbd "^"))
(define-key evil-normal-state-map (kbd "L") (kbd "$"))
(define-key evil-visual-state-map (kbd "H") (kbd "^"))
(define-key evil-visual-state-map (kbd "L") (kbd "$"))
(setq doom-modeline-height 35
      doom-modeline-bar-width 1
      doom-modeline-modal nil
      doom-modeline-buffer-file-name-style 'truncate-upto-project
      doom-modeline-project-detection 'project
      doom-modeline-buffer-modification-icon t
      doom-modeline-modal-icon nil)
;; (after! doom-modeline
;;   (line-number-mode -1)
;;   (setq doom-modeline-buffer-encoding t))
