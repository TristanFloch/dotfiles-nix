(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-safe-themes
   '("99ea831ca79a916f1bd789de366b639d09811501e8c092c85b2cb7d697777f93" "6b80b5b0762a814c62ce858e9d72745a05dd5fc66f821a1c5023b4f2a76bc910" "4a8d4375d90a7051115db94ed40e9abb2c0766e80e228ecad60e06b3b397acab" "1623aa627fecd5877246f48199b8e2856647c99c6acdab506173f9bb8b0a41ac" "2cdc13ef8c76a22daa0f46370011f54e79bae00d5736340a5ddfe656a767fddf" "3c2f28c6ba2ad7373ea4c43f28fcf2eed14818ec9f0659b1c97d4e89c99e091e" "730a87ed3dc2bf318f3ea3626ce21fb054cd3a1471dcd59c81a4071df02cb601" "6084dce7da6b7447dcb9f93a981284dc823bab54f801ebf8a8e362a5332d2753" "7d708f0168f54b90fc91692811263c995bebb9f68b8b7525d0e2200da9bc903c" "d5a878172795c45441efcd84b20a14f553e7e96366a163f742b95d65a3f55d71" "188fed85e53a774ae62e09ec95d58bb8f54932b3fd77223101d036e3564f9206" "d74c5485d42ca4b7f3092e50db687600d0e16006d8fa335c69cf4f379dbd0eee" "711efe8b1233f2cf52f338fd7f15ce11c836d0b6240a18fffffc2cbd5bfe61b0" "e074be1c799b509f52870ee596a5977b519f6d269455b84ed998666cf6fc802a" "6c3b5f4391572c4176908bb30eddc1718344b8eaff50e162e36f271f6de015ca" "be9645aaa8c11f76a10bcf36aaf83f54f4587ced1b9b679b55639c87404e2499" "d6603a129c32b716b3d3541fc0b6bfe83d0e07f1954ee64517aa62c9405a3441" "5b809c3eae60da2af8a8cfba4e9e04b4d608cb49584cb5998f6e4a1c87c057c4" "c83c095dd01cde64b631fb0fe5980587deec3834dc55144a6e78ff91ebc80b19" "b5fff23b86b3fd2dd2cc86aa3b27ee91513adaefeaa75adc8af35a45ffb6c499" "cae81b048b8bccb7308cdcb4a91e085b3c959401e74a0f125e7c5b173b916bf9" "c086fe46209696a2d01752c0216ed72fd6faeabaaaa40db9fc1518abebaf700d" "3df5335c36b40e417fec0392532c1b82b79114a05d5ade62cfe3de63a59bc5c6" "54cf3f8314ce89c4d7e20ae52f7ff0739efb458f4326a2ca075bf34bc0b4f499" "aaa4c36ce00e572784d424554dcc9641c82d1155370770e231e10c649b59a074" "4f01c1df1d203787560a67c1b295423174fd49934deb5e6789abd1e61dba9552" "5036346b7b232c57f76e8fb72a9c0558174f87760113546d3a9838130f1cdb74" "74ba9ed7161a26bfe04580279b8cad163c00b802f54c574bfa5d924b99daa4b9" "990e24b406787568c592db2b853aa65ecc2dcd08146c0d22293259d400174e37" "bf387180109d222aee6bb089db48ed38403a1e330c9ec69fe1f52460a8936b66" "6c9cbcdfd0e373dc30197c5059f79c25c07035ff5d0cc42aa045614d3919dab4" "01cf34eca93938925143f402c2e6141f03abb341f27d1c2dba3d50af9357ce70" "e1ef2d5b8091f4953fe17b4ca3dd143d476c106e221d92ded38614266cea3c8b" "71e5acf6053215f553036482f3340a5445aee364fb2e292c70d9175fb0cc8af7" "a3b6a3708c6692674196266aad1cb19188a6da7b4f961e1369a68f06577afa16" "4bca89c1004e24981c840d3a32755bf859a6910c65b829d9441814000cf6c3d0" "79278310dd6cacf2d2f491063c4ab8b129fee2a498e4c25912ddaa6c3c5b621e" "9efb2d10bfb38fe7cd4586afb3e644d082cbcdb7435f3d1e8dd9413cbe5e61fc" "2f1518e906a8b60fac943d02ad415f1d8b3933a5a7f75e307e6e9a26ef5bf570" "e6ff132edb1bfa0645e2ba032c44ce94a3bd3c15e3929cdf6c049802cf059a2a" "76bfa9318742342233d8b0b42e824130b3a50dcc732866ff8e47366aed69de11" "c4bdbbd52c8e07112d1bfd00fee22bf0f25e727e95623ecb20c4fa098b74c1bd" default))
 '(doom-big-font-mode nil t)
 '(flycheck-clang-warnings '("all" "extra" "no-pragma-once-outside-header"))
 '(lsp-headerline-breadcrumb-segments '(project file symbols) t)
 '(org-agenda-files '("~/Documents/orgfiles/"))
 '(org-capture-templates
   '(("t" "Personal todo" entry
      (file+headline +org-capture-todo-file "Inbox")
      "* TODO %?
%i" :prepend t)
     ("a" "Appointment" entry
      (file "gcal.org")
      "* %?
%^T

:PROPERTIES:
:END:
")
     ("l" "Link" entry
      (file+headline "links.org" "Links")
      "* %x %^g
" :prepend t :immediate-finish t)
     ("b" "Book" entry
      (file+headline "books.org" "Books")
      "* %^{Author} - %^{Title} %^g

" :prepend t :immediate-finish t)
     ("n" "Personal notes" entry
      (file+headline +org-capture-notes-file "Inbox")
      "* %u %?
%i
%a" :prepend t)
     ("j" "Journal" entry
      (file+olp+datetree +org-capture-journal-file)
      "* %U %?
%i
%a" :prepend t)
     ("p" "Templates for projects")
     ("pt" "Project-local todo" entry
      (file+headline +org-capture-project-todo-file "Inbox")
      "* TODO %?
%i
%a" :prepend t)
     ("pn" "Project-local notes" entry
      (file+headline +org-capture-project-notes-file "Inbox")
      "* %U %?
%i
%a" :prepend t)
     ("pc" "Project-local changelog" entry
      (file+headline +org-capture-project-changelog-file "Unreleased")
      "* %U %?
%i
%a" :prepend t)
     ("o" "Centralized templates for projects")
     ("ot" "Project todo" entry #'+org-capture-central-project-todo-file "* TODO %?
 %i
 %a" :heading "Tasks" :prepend nil)
     ("on" "Project notes" entry #'+org-capture-central-project-notes-file "* %U %?
 %i
 %a" :prepend t :heading "Notes")
     ("oc" "Project changelog" entry #'+org-capture-central-project-changelog-file "* %U %?
 %i
 %a" :prepend t :heading "Changelog")))
 '(org-format-latex-options
   '(:foreground default :background default :scale 1.7 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
     ("begin" "$1" "$" "$$" "\\(" "\\[")))
 '(org-startup-folded 'content)
 ;; '(org-time-stamp-custom-formats '("<%m/%d/%y %a>" . "<%m/%d/%y %a %H:%M>"))
 ;; '(org-todo-keyword-faces
 ;;   '(("[-]" . +org-todo-active)
 ;;     ("PROGRESS" . +org-todo-active)
 ;;     ("[?]" . +org-todo-onhold)
 ;;     ("WAIT" . +org-todo-onhold)
 ;;     ("HOLD" . +org-todo-onhold)
 ;;     ("PROJ" . +org-todo-project)))
 ;; '(org-todo-keywords
 ;;   '((type "TODO(t)" "PROGRESS(i)" "PROJ(p)" "WAIT(w)" "HOLD(h)" "|" "DONE(d)" "CANCELLED(k)")
 ;;     (sequence "[ ](T)" "[-](I)" "[?](W)" "|" "[X](D)")))
 '(package-selected-packages '(bison-mode flycheck-pkg-config))
 '(smtpmail-smtp-server "smtp.office365.com")
 '(smtpmail-smtp-service 587)
 '(yas-snippet-dirs
   '(+snippets-dir doom-snippets-dir +file-templates-dir "/home/tristan/.doom.d/snippets/")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
