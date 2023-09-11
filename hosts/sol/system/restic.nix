{ config, pkgs, ... }: {
  services.restic.backups.sol = {
    backupCleanupCommand = ''
      rm -fr /var/backups/sol
      nextcloud-occ maintenance:mode --off
    '';
    backupPrepareCommand = ''
      nextcloud-occ maintenance:mode --on
      mkdir -p /var/backups/sol
      ${pkgs.sqlite}/bin/sqlite3 /var/lib/nextcloud/data/nextcloud.db .dump > /var/backups/sol/nextcloud.sql
    '';
    environmentFile = config.age.secrets.restic-sol-environment.path;
    initialize = true;
    passwordFile = config.age.secrets.restic-sol-password.path;
    paths = [ "/var/backups/sol" ];
    pruneOpts = [
      "--keep-daily 31"
      "--keep-monthly 12"
      "--keep-yearly 1"
    ];
    repositoryFile = config.age.secrets.restic-sol-repository.path;
  };
}
