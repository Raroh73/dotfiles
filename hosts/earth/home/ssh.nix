_: {
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        identityFile = "/home/raroh73/.ssh/github";
      };
      "mars" = {
        hostname = "192.168.0.11";
        user = "raroh73";
        identityFile = "/home/raroh73/.ssh/mars";
      };
      "earth" = {
        hostname = "192.168.0.12";
        user = "raroh73";
        identityFile = "/home/raroh73/.ssh/earth";
      };
    };
  };
}
