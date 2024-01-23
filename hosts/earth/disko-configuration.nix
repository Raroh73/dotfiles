#{
#  disko.devices.disk = {
#    one = {
#      content = {
#        partitions = {
#          ESP = {
#            content = {
#              format = "vfat";
#              mountpoint = "/boot";
#              type = "filesystem";
#            };
#            size = "512M";
#            type = "EF00";
#          };
#          root = {
#            content = {
#              format = "ext4";
#              mountpoint = "/";
#              type = "filesystem";
#            };
#            size = "100%";
#          };
#        };
#        type = "gpt";
#      };
#      device = "/dev/nvme0n1";
#      type = "disk";
#    };
#  };
#}
