{lib}: let
  inherit
    (lib)
    mapAttrs
    ;
in {
  toAbsolutePath = path: (toString path);

  npins2plugins = sources:
    mapAttrs (
      plugin: metadata:
        if builtins.isAttrs metadata
        then
          metadata
          // {
            __functor = _self: _args: {
              name = plugin;
              src = metadata.outPath;
            };
          }
        else metadata
    )
    sources;
}
