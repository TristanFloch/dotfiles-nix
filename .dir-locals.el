((nil . ((projectile-project-install-cmd . "darwin-rebuild --flake .# switch")
         (projectile-project-compilation-cmd . "darwin-rebuild --flake .# build")
         (eval . (map! :leader
                       :prefix "p"
                       :desc "Apply home-manager config" "I" 'projectile-install-project)))))
