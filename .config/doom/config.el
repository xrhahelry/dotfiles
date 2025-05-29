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

(map! :leader
      (:prefix ("w" . "window")
       :desc "Vertical split" "v" #'split-window-right
       :desc "Horizontal split" "s" #'split-window-below))

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
        org-roam-graph-viewer "/usr/bin/brave-browser"))

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

(defvar code-runner-commands
  '((haskell-mode . "runghc %f")
    (julia-mode . "julia --project=%d %f")
    (python-mode . "python -u '%f'")
    (c++-mode . "cd %d && ./build.sh")
    (c-mode . "cd %d && ./build.sh")))

(defvar code-runner-replace-buffer t)

;; Remove the focus-compilation hook since we're replacing the buffer
;; (defun code-runner-focus-compilation ()
;;   (when-let ((comp-window (get-buffer-window "*compilation*")))
;;     (select-window comp-window)))
;; (add-hook 'compilation-start-hook 'code-runner-focus-compilation)

(defun code-runner-expand-command (command)
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
  (interactive)
  (if-let ((command-template (alist-get major-mode code-runner-commands)))
      (let* ((expanded-command (code-runner-expand-command command-template))
             (default-directory (file-name-directory (buffer-file-name)))
             (current-window (selected-window)))
        (save-buffer)
        (if code-runner-replace-buffer
            (progn
              ;; Set display-buffer-alist to reuse current window
              (let ((display-buffer-alist
                     '(("\\*compilation\\*"
                        (display-buffer-reuse-window display-buffer-same-window)))))
                (compile expanded-command)))
          (compile expanded-command)))
    (message "No run command defined for %s" major-mode)))

(defun code-runner-add-command (mode command)
  (interactive
   (list (intern (completing-read "Major mode: "
                                  (mapcar #'car code-runner-commands)))
         (read-string "Command: ")))
  (setf (alist-get mode code-runner-commands) command)
  (message "Added command for %s: %s" mode command))

(map! :leader
      (:prefix ("r" . "run")
       :desc "Run current file" "f" #'code-runner-run-file))

(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (ansi-color-apply-on-region compilation-filter-start (point)))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

(map! :leader
      (:prefix ("a" . "Anaconda")
       :desc "Activate conda environment" "a" #'conda-env-activate
       :desc "Deactivate conda environment" "d" #'conda-env-deactivate))

(after! ein
        (setq ein:output-area-inlined-images t)
        (setq ein:output-area-mime-type-preferences
                '("image/png" "text/html" "text/plain"))
        (setq ein:cell-max-width 80)

  ;; (defun my/center-ein-notebook ()
  ;;   (setq-local visual-fill-column-width 100
  ;;               visual-fill-column-center-text t)
  ;;   (visual-fill-column-mode 1))

  (defun my/ein-notebook-pretty ()
    (display-line-numbers-mode 1))          ;; show line numbers in cells
  ;;   (my/center-ein-notebook))               ;; center content

  (add-hook 'ein:notebook-mode-hook #'my/ein-notebook-pretty)
  )

(map! :leader
      (:prefix ("j" . "Jupyter")
       :desc "Start jupyter server" "a" #'ein:jupyter-server-start
       :desc "Stop jupyter server" "d" #'ein:jupyter-server-stop
       :desc "Next Cell" "n" #'ein:worksheet-goto-next-input
       :desc "Previous Cell" "p" #'ein:worksheet-goto-prev-input
       :desc "Run all" "r" #'ein:worksheet-execute-all-cells
       :desc "Clear output" "c" #'ein:worksheet-clear-output
       :desc "Add cell above" "k" #'ein:worksheet-insert-cell-above
       :desc "Add cell below" "j" #'ein:worksheet-insert-cell-below))

(map! :map ein:notebook-mode-map
      "C-<return>" #'ein:worksheet-execute-cell-and-goto-next)
