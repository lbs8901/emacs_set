(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

(add-hook 'before-save-hook 'whitespace-cleanup)

(set-default-font "Bitstream Vera Sans Mono 15")

;;disable backup
(setq backup-inhibited t)
(setq make-backup-files nil)
;;disable auto save
(setq auto-save-default nil)

;; (eval-after-load 'php-mode
;;   '(require 'php-ext))


;; (require 'web-mode)
;; (add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

;; (add-hook 'php-mode-hook (lambda ()
;;     (defun ywb-php-lineup-arglist-intro (langelem)
;;       (save-excursion
;;         (goto-char (cdr langelem))
;;         (vector (+ (current-column) c-basic-offset))))
;;     (defun ywb-php-lineup-arglist-close (langelem)
;;       (save-excursion
;;         (goto-char (cdr langelem))
;;         (vector (current-column))))
;;     (c-set-offset 'arglist-intro 'ywb-php-lineup-arglist-intro)
;;     (c-set-offset 'arglist-close 'ywb-php-lineup-arglist-close)))

(defun unindent-closure ()
  "Fix php-mode indent for closures"
  (let ((syntax (mapcar 'car c-syntactic-context)))
    (if (and (member 'arglist-cont-nonempty syntax)
             (or
              (member 'statement-block-intro syntax)
              (member 'brace-list-intro syntax)
              (member 'brace-list-close syntax)
              (member 'block-close syntax)))
       (save-excursion
          (beginning-of-line)
          (delete-char (* (count 'arglist-cont-nonempty syntax)
                          c-basic-offset))) )))

(add-hook 'php-mode-hook
          (lambda ()
            (add-hook 'c-special-indent-hook 'unindent-closure)))

;; tab unindent set
(global-set-key (kbd "<backtab>") 'un-indent-by-removing-4-spaces)
(defun un-indent-by-removing-4-spaces ()
  "remove 4 spaces from beginning of of line"
  (interactive)
  (save-excursion
    (save-match-data
      (beginning-of-line)
      ;; get rid of tabs at beginning of line
      (when (looking-at "^\\s-+")
        (untabify (match-beginning 0) (match-end 0)))
      (when (looking-at "^    ")
        (replace-match "")))))

;; (require 'mmm-auto)
;; (setq mmm-global-mode 'maybe)
;; (mmm-add-mode-ext-class 'html-mode "\\.php\\'" 'html-php)
;; (mmm-add-mode-ext-class 'html-mode nil 'html-js)

(setq-default truncate-lines t)

(defun custom_newline()
  (interactive)
  (newline)
  (indent-relative)
  )

(global-set-key (kbd "C-m") 'custom_newline)

(defun shift-region (distance)
  (let ((mark (mark)))
    (save-excursion
      (indent-rigidly (region-beginning) (region-end) distance)
      (push-mark mark t t)
      ;; Tell the command loop not to deactivate the mark
      ;; for transient mark mode
      (setq deactivate-mark nil))))

(defun shift-right ()
  (interactive)
  (shift-region 1))

(defun shift-left ()
  (interactive)
  (shift-region -1))

;; Bind (shift-right) and (shift-left) function to your favorite keys. I use
;; the following so that Ctrl-Shift-Right Arrow moves selected text one
;; column to the right, Ctrl-Shift-Left Arrow moves selected text one
;; column to the left:

(global-set-key [C-S-right] 'shift-right)
(global-set-key [C-S-left] 'shift-left)

;; (setq redisplay-dont-pause t)
