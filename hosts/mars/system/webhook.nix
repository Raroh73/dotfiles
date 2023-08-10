{ pkgs, ... }:
let
  raroh73_xyz-build = pkgs.writeShellApplication {
    name = "raroh73_xyz-build";
    text = ''
      if [ ! -d /srv/web/raroh73.xyz ]
      then
        ${pkgs.git}/bin/git clone https://github.com/Raroh73/raroh73.xyz.git /srv/web/raroh73.xyz
        cd /srv/web/raroh73.xyz
      else
        cd /srv/web/raroh73.xyz
        ${pkgs.git}/bin/git pull https://github.com/Raroh73/raroh73.xyz.git
      fi
      ${pkgs.hugo}/bin/hugo
    '';
  };
in
{
  services.webhook = {
    enable = true;
    hooksTemplated = {
      hugo-webhook = ''
        {
          "id": "raroh73_xyz-webhook",
          "execute-command": "${raroh73_xyz-build}/bin/raroh73_xyz-build",
          "trigger-rule": {
            "and": [
              {
                "match": {
                  "type": "payload-hmac-sha1",
                  "secret": "",
                  "parameter": {
                    "source": "header",
                    "name": "X-Hub-Signature"
                  }
                }
              },
              {
                "match": {
                  "type": "value",
                  "value": "refs/heads/main",
                  "parameter": {
                    "source": "payload",
                    "name": "ref"
                  }
                }
              }
            ]
          }
        }
      '';
    };
  };
}
