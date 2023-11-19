self: super: 
{
  raleway-overlay = super.callPackage ./Raleway.nix {};
  fennel-ls = super.callPackage ./fennel-ls.nix {};
  feather = super.callPackage ./Feather.nix {};
  filewatcher = super.callPackage ./filewatcher.nix {};
  glsl_analyzer = super.callPackage ./glsl_analyzer.nix {};
}
