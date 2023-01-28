{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    profiles.default = {
      isDefault = true;

      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };

      userChrome = ''
        #TabsToolbar {
          visibility: collapse;
        }
        #sidebar-header {
          visibility: collapse !important;
        }
      '';
    };
  };
}
