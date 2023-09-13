{ config, pkgs, ... }: {
  services.restic.backups.mars = {
    backupCleanupCommand = ''
      rm -fr /var/backups/mars
      nextcloud-occ maintenance:mode --off
    '';
    backupPrepareCommand = ''
      nextcloud-occ maintenance:mode --on
      mkdir -p /var/backups/mars
      ${pkgs.rsync}/bin/rsync -Aavx /var/lib/nextcloud/ /var/backups/mars/nextcloud/
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
}
