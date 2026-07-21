{ inputs, ... }: {
  imports = [ inputs.sops-nix.darwinModules.sops ];

  sops = {
    defaultSopsFile = ../../../secrets.yaml;
    # Decrypt with the machine's SSH host key (converted to age at activation)
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  };
}
