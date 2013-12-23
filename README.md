# helm-flycheck.el

Show [flycheck] errors with [helm].

## Requirements

- [helm]
- [flycheck]
- [dash]

## Installation

If you're an Emacs 24 user or you have a recent version of package.el
you can install `helm-flycheck.el` from the [MELPA](http://melpa.milkbox.net/) repository.

## Configuration

Add the following to your emacs init file.

    (require 'helm-flycheck) ;; Not necessary if using ELPA package
    (eval-after-load 'flycheck
      '(define-key flycheck-mode-map (kbd "C-c ! h") 'helm-flycheck))

## Basic usage

#### <kbd>M-x</kbd> `helm-flycheck`

Show [flycheck] errors with [helm].


[helm]:https://github.com/emacs-helm/helm
[flycheck]:http://flycheck.github.io/
[dash]:https://github.com/magnars/dash.el
