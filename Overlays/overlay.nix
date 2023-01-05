self: super: 
{
  zplug-overlay = super.callPackage ./Zplug.nix {};
  raleway-overlay = super.callPackage ./Raleway.nix {};
  marksman = super.callPackage ./marksman.nix {};
  fennel-ls = super.callPackage ./fennel-ls.nix {};
  fennel-language-server = super.callPackage ./fennel-language-server.nix {};
}
