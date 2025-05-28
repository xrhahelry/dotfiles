(setq doom-theme 'doom-one)
(setq display-line-numbers-type 'relative)
(setq doom-font (font-spec :family "IosevkaTerm Nerd Font" :size 20 :weight 'medium)
      doom-variable-pitch-font (font-spec :family "JetBrainsMono" :size 15 :weight 'light)
      doom-big-font (font-spec :family "Iosevka Nerd Font" :size 30))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(setq-default tab-width 4)
(setq-default evil-shift-width tab-width)
(defun prefer-horizontal-split ()
  (set-variable 'split-height-threshold nil t)
  (set-variable 'split-width-threshold 40 t)) ; make this as low as needed
(add-hook 'markdown-mode-hook 'prefer-horizontal-split)

(setq evil-escape-key-sequence "jk"
      evil-escape-delay 0.2)
(evil-escape-mode 1)

(define-key evil-normal-state-map (kbd "H") (kbd "^"))
(define-key evil-normal-state-map (kbd "L") (kbd "$"))
(define-key evil-visual-state-map (kbd "H") (kbd "^"))
(define-key evil-visual-state-map (kbd "L") (kbd "$"))

(map! :leader
      (:prefix ("e". "evaluate")
       :desc "Evaluate elisp in buffer"  "b" #'eval-buffer
       :desc "Evaluate defun"            "d" #'eval-defun
       :desc "Evaluate elisp expression" "e" #'eval-expression
       :desc "Evaluate last sexpression" "l" #'eval-last-sexp
       :desc "Evaluate elisp in region"  "r" #'eval-region))

(set-face-attribute 'mode-line nil :font "JetBrainsMono" :height 0.9)
(setq doom-modeline-height 35
      doom-modeline-bar-width 5
      doom-modeline-modal nil
      doom-modeline-buffer-file-name-style 'truncate-upto-project
      doom-modeline-project-detection 'project
      doom-modeline-persp-name t
      doom-modeline-persp-icon t
      doom-modeline-buffer-modification-icon t
      doom-modeline-modal-icon nil)

(after! org
  (setq inhibit-compacting-font-caches t)
  (custom-set-faces
    '(org-level-1 ((t (:inherit outline-1 :height 1.5 :family "JetBrainsMono"))))
    '(org-level-2 ((t (:inherit outline-2 :height 1.4 :family "JetBrainsMono"))))
    '(org-level-3 ((t (:inherit outline-3 :height 1.3 :family "JetBrainsMono"))))
    '(org-level-4 ((t (:inherit outline-4 :height 1.2 :family "JetBrainsMono"))))
    '(org-level-5 ((t (:inherit outline-5 :height 1.1 :family "JetBrainsMono"))))
    '(org-level-6 ((t (:inherit outline-6 :height 1.0 :family "JetBrainsMono"))))
    '(org-level-7 ((t (:inherit outline-7 :height 1.0 :family "JetBrainsMono"))))
    '(org-level-8 ((t (:inherit outline-8 :height 1.0 :family "JetBrainsMono")))))
  (setq org-directory "~/org/"
        org-default-notes-file (expand-file-name "notes.org" org-directory)
        org-ellipsis " ▼ "))
  (use-package! org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :config
  (setq org-bullets-bullet-list '("◉" "●" "◆" "○" "●" "◆" "○")))

(after! org
  (setq org-roam-directory "~/org/roam/"
        org-roam-graph-viewer "/usr/bin/firefox"))

(map! :leader
      (:prefix ("n r" . "org-roam")
       :desc "Completion at point" "c" #'completion-at-point
       :desc "Find node"           "f" #'org-roam-node-find
       :desc "Show graph"          "g" #'org-roam-graph
       :desc "Insert node"         "i" #'org-roam-node-insert
       :desc "Capture to node"     "n" #'org-roam-capture
       :desc "Toggle roam buffer"  "r" #'org-roam-buffer-toggle))

(after! org
  (setq org-agenda-files '("~/org/agenda.org")))

(map! :leader
      (:prefix ("d" . "dired")
       :desc "Open dired" "d" #'dired
       :desc "Dired jump to current" "j" #'dired-jump)
      (:after dired
       (:map dired-mode-map
        :desc "Peep-dired image previews" "d p" #'peep-dired
        :desc "Dired view file"           "d v" #'dired-view-file)))
(evil-define-key 'normal dired-mode-map
  (kbd "M-RET") 'dired-display-file
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-find-file ; use dired-find-file instead of dired-open.
  (kbd "m") 'dired-mark
  (kbd "t") 'dired-toggle-marks
  (kbd "u") 'dired-unmark
  (kbd "C") 'dired-do-copy
  (kbd "D") 'dired-do-delete
  (kbd "J") 'dired-goto-file
  (kbd "M") 'dired-do-chmod
  (kbd "O") 'dired-do-chown
  (kbd "P") 'dired-do-print
  (kbd "R") 'dired-do-rename
  (kbd "T") 'dired-do-touch
  (kbd "Y") 'dired-copy-filenamecopy-filename-as-kill ; copies filename to kill ring.
  (kbd "Z") 'dired-do-compress
  (kbd "+") 'dired-create-directory
  (kbd "-") 'dired-do-kill-lines
  (kbd "% l") 'dired-downcase
  (kbd "% m") 'dired-mark-files-regexp
  (kbd "% u") 'dired-upcase
  (kbd "* %") 'dired-mark-files-regexp
  (kbd "* .") 'dired-mark-extension
  (kbd "* /") 'dired-mark-directories
  (kbd "; d") 'epa-dired-do-decrypt
  (kbd "; e") 'epa-dired-do-encrypt)

;; Code runner configuration for Emacs using compile
(defvar code-runner-commands
  '((haskell-mode . "runghc %f")
    (julia-mode . "julia --project=%d %f")
    (python-mode . "python -u '%f'")
    (c++-mode . "cd %d && ./build.sh")
    (c-mode . "cd %d && ./build.sh"))
  "Alist of major modes to their respective run commands.
%f = full file path, %d = directory path, %n = file name without extension")

(defun code-runner-expand-command (command)
  "Expand placeholders in COMMAND with current buffer information."
  (let* ((file-path (buffer-file-name))
         (dir-path (file-name-directory file-path))
         (file-name (file-name-nondirectory file-path))
         (file-base (file-name-sans-extension file-name)))
    (replace-regexp-in-string
     "%f" file-path
     (replace-regexp-in-string
      "%d" (directory-file-name dir-path)
      (replace-regexp-in-string
       "%n" file-base
       command)))))

(defun code-runner-run-file ()
  "Run the current file based on its major mode."
  (interactive)
  (if-let ((command-template (alist-get major-mode code-runner-commands)))
      (let* ((expanded-command (code-runner-expand-command command-template))
             (default-directory (file-name-directory (buffer-file-name))))
        (save-buffer)
        (compile expanded-command))
    (message "No run command defined for %s" major-mode)))

(defun code-runner-add-command (mode command)
  "Add or update a run command for a specific MODE."
  (interactive
   (list (intern (completing-read "Major mode: "
                                  (mapcar #'car code-runner-commands)))
         (read-string "Command: ")))
  (setf (alist-get mode code-runner-commands) command)
  (message "Added command for %s: %s" mode command))

;; Doom Emacs key binding
(map! :leader
      (:prefix ("r" . "run")
       :desc "Run current file" "f" #'code-runner-run-file))

;; Set compilation window height (similar to VimuxHeight)
(setq compilation-window-height 10)

;; Focus compilation buffer after running
(defun code-runner-focus-compilation ()
  "Focus the compilation buffer after compilation starts."
  (when-let ((comp-window (get-buffer-window "*compilation*")))
    (select-window comp-window)))

(add-hook 'compilation-start-hook 'code-runner-focus-compilation)

;; Colorize compilation output
(require 'ansi-color)
(defun colorize-compilation-buffer ()
  "Colorize compilation buffer output."
  (ansi-color-apply-on-region compilation-filter-start (point)))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)
