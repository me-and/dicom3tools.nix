{
  lib,
  fetchurl,
  stdenv,
  imake,
  libX11,
  libXext,
  makedepend,
  # If you have your own UIDs allocated, this is the place to define them, e.g.
  # by adding `"-DDefaultUIDRoot=1.2.840.99999"`.
  imakeConfigurationArgs ? [ ],
}:
stdenv.mkDerivation rec {
  pname = "dicom3tools";
  version = "1.00.snapshot.20240914122739";
  src = fetchurl {
    url = "https://www.dclunie.com/dicom3tools/workinprogress/dicom3tools_${version}.tar.bz2";
    hash = "sha256-NYGLckMVyNmmxo4vexdVqfVaSL1izoS7n8m+1ZZodiw=";
  };
  nativeBuildInputs = [
    imake
    libX11
    libXext
    makedepend
  ];
  preBuild = ''
    makeFlagsArray+=(
        INSTALLBINDIR="''${!outputBin}/bin"
        INSTALLINCDIR="''${!outputDev}/include"
        INSTALLLIBDIR="''${!outputBin}/lib"
        INSTALLMANDIR="''${!outputMan}/share/man"
    )
  '';
  configurePhase = ''
    runHook preConfigure
    ./Configure
    imake -I./config ${lib.escapeShellArgs imakeConfigurationArgs}
    runHook postConfigure
  '';
  buildFlags = [ "World" ];
  installFlags = [
    "install"
    "install.man"
  ];

  meta = {
    description = "Command line utilities for creating, modifying, dumping and validating files of DICOM attributes, and conversion of proprietary image formats to DICOM.";
    homepage = "https://www.dclunie.com/dicom3tools.html";
    # Non-standard BSD-3 based license.  TODO Is there a better way to define
    # this?  What do other packages with sui generis licenses do?
    license = {
      shortName = "dicom3tools";
      fullName = "dicom3tools license";
      redistributable = true;
      deprecated = false;
      url = "https://www.dclunie.com/dicom3tools/COPYRIGHT";
    };
    maintainers = [ lib.maintainers.me-and ];
    sourceProvenance = [ lib.sourceTypes.fromSource ];
  };
}
