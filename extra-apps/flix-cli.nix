{ lib
, python313Packages
, src
, catt
, makeWrapper
}:

let
  catt-module = python313Packages.toPythonModule catt;
in
python313Packages.buildPythonApplication {
  pname = "flix-cli";
  version = "1.8.1.17";
  format = "pyproject";

  inherit src;

  # Parcheamos el archivo de proyecto antes de que empiece la construcción
  postPatch = ''
    # Cambiamos las restricciones estrictas (==) por flexibles (>=)
    # Esto soluciona el error de "not satisfied by version X.X.X"
    sed -i 's/==/>=/g' pyproject.toml
  '';

  nativeBuildInputs = with python313Packages; [
    hatchling
    makeWrapper
  ];

  propagatedBuildInputs = with python313Packages; [
    beautifulsoup4
    catt-module
    httpx
    krfzf-py
    platformdirs
    regex
    typer
    yt-dlp
  ];

  postInstall = ''
    wrapProgram $out/bin/flix-cli \
      --prefix PATH : ${lib.makeBinPath [ catt ]}
  '';

  doCheck = false;

  meta = with lib; {
    description = "A high efficient, powerful and fast movie scraper.";
    homepage = "https://codeberg.org/s-warn/flix-cli";
    license = licenses.gpl3Only;
    mainProgram = "flix-cli";
  };
}
