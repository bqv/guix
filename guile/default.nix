{ lib, newScope, guile, gnutls, overrides ? (self: super: {}) }:

let
  packages = self: let
    callPackage = newScope self;

    guile-gnutls = (gnutls.override {
      inherit guile;
      guileBindings = true;
    }).overrideAttrs (attrs: {
      configureFlags = [
        "--with-guile-site-dir=\${out}/share/guile/site"
        "--with-guile-site-ccache-dir=\${out}/share/guile/ccache"
        "--with-guile-extension-dir=\${out}/lib/guile/extensions"
      ];
    });
  in {
    inherit guile-gnutls;

    guile-gcrypt = callPackage ./guile-gcrypt { };

    bytestructures = callPackage ./bytestructures { };

    guile-git = callPackage ./guile-git { };

    guile-json = callPackage ./guile-json { };

    guile-sqlite3 = callPackage ./guile-sqlite3 { };

    guile-ssh = callPackage ./guile-ssh { };
  };
in
  lib.fix' (lib.extends overrides packages)
