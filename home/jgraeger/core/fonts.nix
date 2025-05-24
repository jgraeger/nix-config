{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    corefonts
    ubuntu_font_family
  
    font-awesome
    source-code-pro
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji    
    jetbrains-mono

    fira-sans
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.inconsolata

    meslo-lgs-nf
  ];
}
