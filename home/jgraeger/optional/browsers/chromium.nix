{
  programs.chromium = {
    enable = true;
    commandLineArgs = [
      "--no-default-browser-check"
      "--restore-last-session"
  ];

    extensions = [
      "ddkjiahejlhfcafbddmgiahcphecmpfh" # ublock lite
      "aeblfdkhhhdcdjpifhhbdiojplfjncoa" # 1Password
    ];
  };
}
