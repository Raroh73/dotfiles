{ config, pkgs, ... }: {
  services.restic.backups = {
    backup-mars = {
      backupCleanupCommand = ''
        rm -fr /var/backups/mars
      '';
      backupPrepareCommand = ''
        mkdir -p /var/backups/mars
      '';
      environmentFile = config.age.secrets.backup-mars-environment.path;
      initialize = true;
      passwordFile = config.age.secrets.backup-mars-password.path;
      paths = [ "/var/backups/mars" ];
      pruneOpts = [
        "--keep-daily 31"
        "--keep-monthly 12"
        "--keep-yearly 1"
      ];
      repositoryFile = config.age.secrets.backup-mars-repository.path;
    };
  };
}
