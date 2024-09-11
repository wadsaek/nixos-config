{lib, ...}: {
  options = {
    hostName = lib.mkOption{
      type = lib.types.strMatching
        "^$|^[[:alnum:]]([[:alnum:]_-]{0,61}[[:alnum:]])?$";
    };
    resolution = 
    let 
      uintp /*uint positive*/ = lib.types.ints.positive;
    in {
      horizontal = lib.mkOption {
        type = uintp;
      };
      vertical = lib.mkOption {
        type = uintp;
      };
    };
  };
}
