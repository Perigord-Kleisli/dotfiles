{pkgs, ...}: 
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; 
    [ ms-vscode.cpptools
      asvetliakov.vscode-neovim
    ];
  };
}
