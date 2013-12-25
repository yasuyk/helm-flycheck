;;; helm-flycheck.el --- Show flycheck errors with helm

;; Copyright (C) 2013 Yasuyuki Oka <yasuyk@gmail.com>

;; Author: Yasuyuki Oka <yasuyk@gmail.com>
;; Version: 0.1
;; URL: https://github.com/yasuyk/helm-flycheck
;; Package-Requires: ((dash "2.4.0") (flycheck "0.15") (helm "1.5.7"))
;; Keywords: helm, flycheck

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Installation:

;; Add the following to your Emacs init file:
;;
;;  (require 'helm-flycheck) ;; Not necessary if using ELPA package
;;  (eval-after-load 'flycheck
;;    '(define-key flycheck-mode-map (kbd "C-c ! h") 'helm-flycheck))

;; That's all.

;;; Code:

(require 'dash)
(require 'flycheck)
(require 'helm)

(defvar helm-source-flycheck
  '((name . "Flycheck")
    (init . helm-flycheck-init)
    (candidates . helm-flycheck-candidates)
    (action . (("Go to" . helm-flycheck-action-goto-error)))))

(defvar helm-flycheck-candidates nil)

(defun helm-flycheck-init ()
  "Initialize `helm-source-flycheck'."
  (let ((status (cadr (split-string
                       flycheck-mode-line
                       flycheck-mode-line-lighter))))
    (if (equal ":" (ignore-errors (substring status 0 1)))
        (setq helm-flycheck-candidates
              (mapcar 'helm-flycheck-make-candidate
                      (flycheck-sort-errors flycheck-current-errors)))
      (helm-flycheck-show-status-message status)
      (helm-exit-minibuffer))))

(defun helm-flycheck-show-status-message (status)
  "Show message about `flycheck' STATUS."
  (message
   (cond ((equal status "")
          "There are no errors in the current buffer.")
         ((equal status "*")
          "A syntax check is being performed currently.")
         ((equal status "-")
          "Automatic syntax checker selection did not find a suitable syntax checker.")
         ((equal status "!")
          "The syntax check failed. Inspect the *Messages* buffer for details.")
         ((equal status "?")
          "The syntax check had a dubious result."))))

(defun helm-flycheck-make-candidate (error)
  "Return a string of candidate for the given ERROR."
  (let ((face (-> error
                flycheck-error-level
                flycheck-error-level-error-list-face))
        (replace-nl-to-sp (lambda (m)
                            (ignore-errors
                              (replace-regexp-in-string
                               "\n *" " " m)))))
    (format "%5s %3s%8s  %s"
            (flycheck-error-list-make-number-cell
             (flycheck-error-line error) 'flycheck-error-list-line-number)
            (flycheck-error-list-make-number-cell
             (flycheck-error-column error)
             'flycheck-error-list-column-number)
            (propertize (symbol-name (flycheck-error-level error))
                        'font-lock-face face)
            (or (funcall replace-nl-to-sp
                         (flycheck-error-message error)) ""))))

(defun helm-flycheck-action-goto-error (candidate)
  "Visit error of CANDIDATE."
  (let* ((strings (split-string candidate))
         (lineno (string-to-number (car strings)))
         error-pos)
    (goto-char (point-min))
    (forward-line (1- lineno))
    (setq error-pos
          (car
           (->> (flycheck-overlays-in
                 (point)
                 (save-excursion (forward-line 1) (point)))
             (-map #'overlay-start)
             -uniq
             (-sort #'<=))))
    (goto-char error-pos)))

;;;###autoload
(defun helm-flycheck ()
  "Show flycheck errors with `helm'."
  (interactive)
  (unless flycheck-mode
    (user-error "Flycheck mode not enabled"))
  (helm :sources 'helm-source-flycheck
        :buffer "*helm flycheck*"))

(provide 'helm-flycheck)

;; Local Variables:
;; coding: utf-8
;; End:

;;; helm-flycheck.el ends here
