{ stdenvNoCC, unzip }:

stdenvNoCC.mkDerivation {
  pname = "avenir-next-condensed";
  version = "1.0";
  
  # Point to the ZIP file, not the TTC file inside
  src = ./01_FONT_AvenirNextCondensed.zip;
  
  nativeBuildInputs = [ unzip ];
  
  # Let Nix automatically unpack the zip
  sourceRoot = ".";
  
  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    # Find and copy all font files (ttf and ttc)
    find . -type f \( -name '*.ttf' -o -name '*.ttc' \) -exec cp {} $out/share/fonts/truetype/ \;
  '';
  
  meta = {
    description = "Avenir Next Condensed font family";
  };
}
