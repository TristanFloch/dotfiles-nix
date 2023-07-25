((nil . ((projectile-project-install-cmd . "home-manager --flake .#tristan@nixos-zenbook switch")
         (projectile-project-compilation-cmd . "home-manager --flake .#tristan@nixos-zenbook build")
         (projectile-project-test-cmd . "home-manager --flake .#tristan@nixos-zenbook test")
         (eval . (map! :leader
                       :prefix "p"
                       :desc "Apply home-manager config" "I" 'projectile-install-project)))))
