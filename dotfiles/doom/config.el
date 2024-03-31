(setq user-full-name "Kanishak Vaidya"
      user-mail-address "kanishak@gmail")

(set-face-attribute 'default nil
  :font "JetBrains Mono Nerd Font"
  :height 150
  :weight 'medium)
(set-face-attribute 'variable-pitch nil
  :font "JetBrains Mono Nerd Font"
  :height 150
  :weight 'medium)
(set-face-attribute 'fixed-pitch nil
  :font "JetBrains Mono Nerd Font"
  :height 150
  :weight 'medium)
;; Makes commented text and keywords italics.
;; This is working in emacsclient but not emacs.
;; Your font must have an italic face available.
(set-face-attribute 'font-lock-comment-face nil
  :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
  :slant 'italic)

;; This sets the default font on all graphical frames created after restarting Emacs.
;; Does the same thing as 'set-face-attribute default' above, but emacsclient fonts
;; are not right unless I also add this method of setting the default font.
;; (add-to-list 'default-frame-alist '(font . "JetBrains Mono Nerd Font-14"))

;; Uncomment the following line if line spacing needs adjusting.
(setq-default line-spacing 0.14)

;; (setq doom-font (font-spec :family "JetBrains Mono Nerd Font" :size 20 :weight 'Regular)
;;       doom-variable-pitch-font (font-spec :family "Sans" :size 13))

(custom-set-faces
 '(markdown-header-face ((t (:inherit font-lock-function-name-face :weight bold :family "Source Code Pro"))))
 '(markdown-header-face-1 ((t (:inherit org-level-1 :height 1.5 :overline t))))
 '(markdown-header-face-2 ((t (:inherit org-level-2 :height 1.4 :overline t))))
 '(markdown-header-face-3 ((t (:inherit org-level-3 :height 1.3 :overline t))))
 '(markdown-header-face-4 ((t (:inherit org-level-4 :height 1.2))))
 '(markdown-header-face-5 ((t (:inherit org-level-5 :height 1.1))))
 '(markdown-header-face-6 ((t (:inherit org-level-6 :height 1.1)))))

(add-to-list 'custom-theme-load-path "~/.config/doom/themes/")
(setq doom-theme 'doom-tomorrow-night)
;; (setq doom-theme 'everforest-hard-dark)
(setq display-line-numbers-type t)
(setq fancy-splash-image "~/.config/doom/images/levitating-gnu.png")
;; (setq fancy-splash-image "~/.config/doom/images/legendaryPokes.png")
(setq +doom-dashboard-banner-padding '(2 . 2))
(setq +doom-dashboard-functions
  '(doom-dashboard-widget-banner
    doom-dashboard-widget-shortmenu
    ;; doom-dashboard-widget-loaded
    ;; doom-dashboard-widget-footer
    ))
(vertico-reverse-mode)
(setq vertico-resize t
      vertico-cycle t)

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(setq org-startup-folded t)

;; Using RETURN to follow links in Org/Evil
;; Unmap keys in 'evil-maps if not done, (setq org-return-follows-link t) will not work
(setq org-src-window-setup 'other-frame)
(with-eval-after-load 'evil-maps
  (define-key evil-motion-state-map (kbd "SPC") nil)
  (define-key evil-motion-state-map (kbd "RET") nil)
  (define-key evil-motion-state-map (kbd "TAB") nil))
;; Setting RETURN key in org-mode to follow links
  (setq org-return-follows-link  t)

(setq org-html-validation-link nil
      org-export-with-broken-links t
      org-html-head-include-scripts nil
      org-html-head-include-default-style nil)

(setq org-publish-project-alist
      '(("kvos-site"
         :base-directory "~/doc/repos/arch-kvos/org-site"
         :base-extension "org"
         :publishing-directory "~/doc/repos/arch-kvos/docs"
         :publishing-function org-html-publish-to-html
         :recursive t
         :with-author nil           ;; Don't include author name
         :with-creator t            ;; Include Emacs and Org versions in footer
         :with-toc nil              ;; Include a table of contents
         :section-numbers nil       ;; Don't include section numbers
         :time-stamp-file nil)
        ("kvos-static"
         :base-directory "~/doc/repos/arch-kvos/org-site"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|sh\\|md"
         :publishing-directory "~/doc/repos/arch-kvos/docs"
         :recursive t
         :publishing-function org-publish-attachment)
        ("kvos" :components ("kvos-site" "kvos-static"))
        ("phd-progress"
         :base-directory "~/doc/repos/profile"
         :base-extension "org"
         :publishing-directory "~/doc/repos/profile/docs"
         :recursive t
         :with-author nil           ;; Don't include author name
         :with-creator nil          ;; Include Emacs and Org versions in footer
         :with-toc nil              ;; Include a table of contents
         :section-numbers nil       ;; Don't include section numbers
         :publishing-function org-html-publish-to-html)))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((octave . t)
   (C . t)))

(setq org-directory "~/doc/notes/org/"
      org-roam-directory "~/doc/notes/org/roam")

(after! spell-fu
  (setq ispell-dictionary "en_US"))

(after! company-mode
  (setq company-minimum-prefix-length 2
        company-reftex-annotate-citations t))

(setq tex-fontify-script nil)
(setq font-latex-fontify-script nil)
(setq +latex-viewers '(zathura))
(setq-default TeX-master nil)

(setq-hook! 'LaTeX-mode-hook +lsp-company-backends '(:separate company-capf company-yasnippet
 company-reftex-labels company-reftex-citations company-files company-dabbrev company-dabbrev-code))

(evil-define-key 'normal dired-mode-map
  (kbd "M-RET") 'dired-display-file
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-find-file) ; use dired-find-file instead of dired-open.

(setq rmh-elfeed-org-files '("~/.config/doom/elfeed.org"))

(after! elfeed
  (setq elfeed-search-filter "@1-week-ago"))

;; (add-hook! 'elfeed-search-mode-hook #'elfeed-update)
