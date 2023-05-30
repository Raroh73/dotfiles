_: {
  services.syncthing = {
    enable = true;
    devices = {
      mars = {
        id = "A2ZWOM3-X3MS66V-LSPAWJE-TDTK5RO-YGVRR2Q-REVDHCJ-H5X6K4L-DD3YFQK";
      };
      mercury = {
        id = "SBCAKJL-CE7JTO6-Y32RE3V-Y5IS4NO-VOSEAZ7-S33I7CD-JV7OAEY-RGF4WQF";
      };
    };
    folders = {
      filebox = {
        devices = [ "mars" "mercury" ];
        path = "~/filebox";
      };
    };
    openDefaultPorts = true;
  };
}
