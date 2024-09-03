{lib, ...}: {
  options = {
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
