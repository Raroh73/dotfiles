_: {
  services.syncthing = {
    enable = true;
    devices = {
      earth = {
        id = "YJS3IOF-CVOFPIE-C5J6WVQ-RXU7JEU-MU33EFG-AJDL5R7-2ANSWJZ-MVG5YAM";
      };
      mercury = {
        id = "SBCAKJL-CE7JTO6-Y32RE3V-Y5IS4NO-VOSEAZ7-S33I7CD-JV7OAEY-RGF4WQF";
      };
    };
    folders = {
      filebox = {
        devices = [ "earth" "mercury" ];
        path = "~/filebox";
      };
    };
    openDefaultPorts = true;
  };
}
