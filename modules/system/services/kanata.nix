let
  serviceName = "internalKeyboard";
in
{
  config.services.kanata = {
    enable = true;
    keyboards = {
      ${serviceName} = {
        extraDefCfg = "process-unmapped-keys yes";
        config = # lisp
          ''
            (defsrc
             caps a s d f j k l ;
            )
            (defvar
             tap-time 150
             hold-time 200
            )
            (defalias
             caps (tap-hold 300 300 esc lctl)
             a (tap-hold $tap-time $hold-time a lalt)
             s (tap-hold $tap-time $hold-time s lmet)
             d (tap-hold $tap-time $hold-time d lctl)
             f (tap-hold $tap-time $hold-time f lsft)
             j (tap-hold $tap-time $hold-time j rsft)
             k (tap-hold $tap-time $hold-time k rctl)
             l (tap-hold $tap-time $hold-time l rmet)
             ; (tap-hold $tap-time $hold-time ; ralt)
            )

            (deflayer base
              @caps @a  @s  @d  @f  @j  @k  @l  @;
            )
          '';
      };
      #escCaps = {
      #  extraDefCfg = "process-unmapped-keys yes";
      #  config = /*lisp*/ ''
      #    (defsrc
      #      caps
      #    )
      #    (defalias
      #     caps (tap-hold 300 300 esc lctl)
      #    )
      #    (deflayer base
      #      @caps
      #    )
      #  '';
      #};
    };
  };
  # let wadsaek manage kanata
  config.security.polkit.extraConfig = # js
    ''
      polkit.addRule(function(action, subject) {
          if (action.id == "org.freedesktop.systemd1.manage-units" &&
              action.lookup("unit") == "kanata-${serviceName}.service" &&
              subject.user == "wadsaek") {
              return polkit.Result.YES;
          }
      });
    '';
}
