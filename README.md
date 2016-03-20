# helm-flycheck.el [![melpa badge][melpa-badge]][melpa-link] [![melpa stable badge][melpa-stable-badge]][melpa-stable-link]

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
[travis-badge]: https://travis-ci.org/yasuyk/helm-flycheck.svg
[travis-link]: https://travis-ci.org/yasuyk/helm-flycheck
[melpa-link]: http://melpa.org/#/helm-flycheck
[melpa-stable-link]: http://stable.melpa.org/#/helm-flycheck
[melpa-badge]: http://melpa.org/packages/helm-flycheck-badge.svg
[melpa-stable-badge]: http://stable.melpa.org/packages/helm-flycheck-badge.svg
