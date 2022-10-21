{pkgs, ...}: 
{
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
    extensions = with pkgs.vscode-extensions; 
    [ ms-vscode.cpptools
      #ms-vscode.cmake-tools
      eamodio.gitlens
      vscodevim.vim
    ];
  };
}
