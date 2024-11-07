{
  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        extraDefCfg = "process-unmapped-keys yes";
        config = /*lisp*/ ''
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
    };
  };
}
