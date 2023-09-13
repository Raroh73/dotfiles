{ pkgs, ... }:
let
  raroh73_xyz-build = pkgs.writeShellApplication {
    name = "raroh73_xyz-build";
    runtimeInputs = with pkgs; [ git hugo ];
    text = ''
      rm -fr /srv/web/raroh73.xyz/public
      if [ ! -d /srv/web/raroh73.xyz ]
      then
        git clone https://github.com/Raroh73/raroh73.xyz.git /srv/web/raroh73.xyz
        cd /srv/web/raroh73.xyz
      else
        cd /srv/web/raroh73.xyz
        git pull https://github.com/Raroh73/raroh73.xyz.git
      fi
      hugo --minify
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
