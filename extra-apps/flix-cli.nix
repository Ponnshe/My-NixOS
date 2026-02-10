{ lib
, python313Packages
, src
}:

python313Packages.buildPythonApplication {
  pname = "flix-cli";
  version = "1.8.1.17";
  format = "pyproject";

  inherit src;

  # Hatchling es indispensable para este pyproject.toml
  nativeBuildInputs = with python313Packages; [
    hatchling
  ];

  # Mapeo directo de dependencias usando Python 3.13
  propagatedBuildInputs = with python313Packages; [
    beautifulsoup4
    catt
    httpx
    krfzf-py
    platformdirs
    regex
    typer
    yt-dlp
  ];

  # Evitamos tests que puedan requerir red o archivos inexistentes en el build sandbox
  doCheck = false;

  meta = with lib; {
    description = "A high efficient, powerful and fast movie scraper.";
    homepage = "https://codeberg.org/s-warn/flix-cli";
    license = licenses.gpl3Only;
    mainProgram = "flix-cli";
  };
}
