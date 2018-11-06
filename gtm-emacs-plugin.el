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
;; This file provides `gtm-emacs-plugin-record', which records time with gtm. Essentially it calls `gtm record [options] <file_name>'.
;;
;; Usage:
;;     M-x gtm-emacs-plugin-record
;;
;;     To automatically record time after saving:
;;     (Choose depending on your favorite mode.)
;;
;; (eval-after-load 'js-mode
;; 	'(add-hook 'js-mode-hook (lambda () (add-hook 'after-save-hook 'gtm-emacs-plugin-record))))
;;
;; (eval-after-load 'js2-mode
;; 	'(add-hook 'js-mode-hook (lambda () (add-hook 'after-save-hook 'gtm-emacs-plugin-record))))
;;
;;     Or track all your files:
;;
;; (add-hook 'after-save-hook 'gtm-emacs-plugin-record)

;;; Code:
(defgroup gtm-emacs-plugin-record nil
  "Record to gtm with ‘gtm-emacs-plugin-record’."
  :link '(function-link gtm-emacs-plugin-record)
  :tag "Git Time Metric (gtm) Record"
  :group 'tools)

(defcustom gtm-emacs-plugin-executable "gtm"
  "Set gtm executable to use."
  :tag "Git Time Metric (gtm) Executable"
  :type 'string)

(defcustom gtm-emacs-plugin-executable-options nil
  "Additional options to pass to gtm (e.g. “-status=false”)."
  :tag "Git Time Metric (gtm) Options"
  :type '(repeat string))

;;;###autoload
(defun gtm-emacs-plugin-record()
  "Record to gtm (git time metric), ie call ‘gtm record <file_name>’."
  (interactive)
  (unless buffer-file-name
    (error "Git Time Metric requires a file-visiting buffer"))

  (let ((gtm (executable-find gtm-emacs-plugin-executable))
        (options (append (list "record")
                         gtm-emacs-plugin-executable-options
                         (list buffer-file-name))))
    (unless gtm
      (error "Executable ‘%s’ not found" gtm-emacs-plugin-executable))
    (apply 'call-process gtm nil "*gtm Errors*" nil options)))

(provide 'gtm-emacs-plugin)

;;; gtm-emacs-plugin.el ends here
