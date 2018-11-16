# git-time-metric
Plugin for the Emacs editor to be used with the [Git Time Metric](https://github.com/git-time-metric/gtm) platform.

## Usage
`M-x git-time-metric-record`

To automatically record time after saving:

(Choose depending on your favorite mode.)

```
(eval-after-load 'js-mode
	   '(add-hook 'js-mode-hook (lambda () (add-hook 'after-save-hook 'git-time-metric-record))))

(eval-after-load 'js2-mode
	   '(add-hook 'js-mode-hook (lambda () (add-hook 'after-save-hook 'git-time-metric-record))))
```

or track all your files

```
(add-hook 'after-save-hook 'git-time-metric-record)
```

