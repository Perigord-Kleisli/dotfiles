self: super: 
{
  zplug-overlay = super.callPackage ./Zplug.nix {};
  raleway-overlay = super.callPackage ./Raleway.nix {};
  fennel-ls = super.callPackage ./Fennel-ls.nix {};
}
