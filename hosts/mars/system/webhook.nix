{ pkgs, ... }:
let
  hugo-build = pkgs.writeShellApplication {
    name = "hugo-build";
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
          "id": "hugo-webhook",
          "execute-command": "${hugo-build}/bin/hugo-build",
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
