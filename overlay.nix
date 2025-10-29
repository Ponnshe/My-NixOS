self: super: {
  lorri = super.lorri.overrideAttrs (oldAttrs: rec {
    # Aquí puedes especificar una versión diferente del crate `time`
    # o aplicar un parche.
    patches = oldAttrs.patches or [] ++ [ ./time-fix.patch];
  });
}
