self: super: 
{
  raleway-overlay = super.callPackage ./Raleway.nix {};
  marksman = super.callPackage ./marksman {};
  fennel-language-server = super.callPackage ./fennel-language-server.nix {};
}
