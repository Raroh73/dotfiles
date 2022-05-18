{ ... }: {
  programs.bash = {
    enable = true;
    historyControl = [ "erasedups" ];
    historyFile = "$HOME/.bash_history";
  };
}
