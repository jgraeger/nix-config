{
  config,
  pkgs,
  ...
}: {

  networking.firewall = {
    allowedTCPPorts = [ 53 ];
    allowedUDPPorts = [ 53 ];
  };
  
  services.blocky = {
    enable = true;
    settings = {
      ports.dns = 53;

      upstreams.groups.default = [
        "tcp-tls:1.1.1.1:853"
        "2606:4700:4700::1111"    
      ];

      customDNS = {
        customTTL = "5m";
        mapping = {
          "rubus.net.graeger.dev" = "100.64.10.1,fd00:314::2";
        };
      };
      
      blocking = {
        denylists = {          
          ads = [
            "https://adaway.org/hosts.txt"
            "https://v.firebog.net/hosts/AdguardDNS.txt"
          ];
          
          tracking = [
            "https://v.firebog.net/hosts/Easyprivacy.txt"
            "https://v.firebog.net/hosts/Prigent-Ads.txt"  
          ];

          malware = [
            "https://v.firebog.net/hosts/Prigent-Crypto.txt"
          ];

        };
      
        clientGroupsBlock = {
          default = [ "ads" "tracking" "malware" ];
        };

      };

      caching = {
        minTime = "1m";
        maxTime = "5m";
        prefetching = true;
      };

    };
  };

}
