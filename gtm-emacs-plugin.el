;;; gtm-emacs-plugin.el --- Provide function to record time with gtm ( git time metric )

;; Copyright (C) 2018 Anton Sivolapov
;; This package uses the MIT License.
;; See the LICENSE file.

;; Author: Anton Sivolapov <anton.sivolapov@gmail.com>
;; Version: 1.0
;; Package-Requires: ()
;; Keywords: tools, gtm, productivity, time
;; URL: https://github.com/c301/gtm-emacs-plugin

;;; Commentary:
;;
;; This file provides `gtm-git-time-metric-record', which records time with gtm. Essentially it calls `gtm record [options] <file_name>'.
;;
;; Usage:
;;     M-x gtm-git-time-metric-record
;;
;;     To automatically record time after saving:
;;     (Choose depending on your favorite mode.)
;;
;; (eval-after-load 'js-mode
;; 	'(add-hook 'js-mode-hook (lambda () (add-hook 'after-save-hook 'gtm-git-time-metric-record))))
;;
;; (eval-after-load 'js2-mode
;; 	'(add-hook 'js-mode-hook (lambda () (add-hook 'after-save-hook 'gtm-git-time-metric-record))))
;;
;;     Or track all your files:
;;
;; (add-hook 'after-save-hook 'gtm-git-time-metric-record)

;;; Code:
(defgroup gtm-git-time-metric-record nil
  "Record to gtm with ‘gtm-git-time-metric-record’."
  :link '(function-link gtm-git-time-metric-record)
  :tag "Git Time Metric (gtm) Record"
  :group 'tools)

(defcustom gtm-git-time-metric-record-executable "gtm"
  "Set gtm executable to use."
  :tag "Git Time Metric (gtm) Executable"
  :type 'string)

(defcustom gtm-git-time-metric-record-options nil
  "Additional options to pass to gtm (e.g. “-status=false”)."
  :tag "Git Time Metric (gtm) Options"
  :type '(repeat string))

;;;###autoload
(defun gtm-git-time-metric-record()
  "Record to gtm (git time metric), ie call ‘gtm record <file_name>’."
  (interactive)
  (unless buffer-file-name
    (error "Git Time Metric requires a file-visiting buffer"))

  (let ((gtm (executable-find gtm-git-time-metric-record-executable))
        (options (append (list "record")
                         gtm-git-time-metric-record-options
                         (list buffer-file-name))))
    (unless gtm
      (error "Executable ‘%s’ not found" gtm-git-time-metric-record-executable))
    (apply 'call-process gtm nil "*gtm Errors*" nil options)))

(provide 'gtm-git-time-metric-record)

;;; gtm-emacs-plugin.el ends here
