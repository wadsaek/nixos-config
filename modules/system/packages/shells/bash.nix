{
  programs.bash = {
    enable = true;
    completion.enable = true;
    shellInit = ''
      set -o vi
      shopt -s dirspell autocd cdspell
      shopt -s nullglob globstar
      shopt -s lithist
      shopt -s nocaseglob
    '';
  };
}
