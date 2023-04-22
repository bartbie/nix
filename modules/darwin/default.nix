{ pkgs, ... }: {
  programs.zsh.enable = true;
  environment = {
    shells = with pkgs; [ bash zsh fish ];
    loginShell = pkgs.fish;
    systemPackages = with pkgs; [
      # coreutils
      vim
      git
      curl
      wget
      kitty
    ];
    systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];
  };
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };
  # NOTE: removes any manually-added fonts.
  fonts.fontDir.enable = true;
  fonts.fonts = [ pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; } ];
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  system.defaults = {
    finder.AppleShowAllExtensions = true;
    finder._FXShowPosixPathInTitle = true;
    dock.autohide = true;
    NSGlobalDomain.AppleShowAllExtensions = true;
    NSGlobalDomain.InitialKeyRepeat = 14;
    NSGlobalDomain.KeyRepeat = 1;
  };
  # backwards compat; don't change
  system.stateVersion = 4;

  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    masApps = { };
    casks = [
      "raycast"
      "telegram"
      "discord"
      # ""
    ];
    # taps = [ "fujiapple852/trippy" ];
    # brews = [ "trippy" ];
  };
}
