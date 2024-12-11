{
  pkgs,
  lib,
  ...
}:
pkgs.python312Packages.buildPythonPackage {
  pname = "textual-autocomplete";
  version = "3.0.0a13";
  pyproject = true;
  src = pkgs.fetchFromGitHub {
    owner = "darrenburns";
    repo = "textual-autocomplete";
    rev = "2cb572bf5b1ea0554b396d0833dfb398cb45dc9b";
    hash = "sha256-jfGYC3xDspwEr+KGApGB05VFuzluDe5S9a/Sjg5HtdI=";
  };
  build-system = [pkgs.python312Packages.hatchling];
  dependencies = with pkgs.python312Packages; [
    python
    (textual.overridePythonAttrs (old: rec {
      version = "0.86.2";
      src = pkgs.fetchFromGitHub {
        owner = "Textualize";
        repo = "textual";
        rev = "refs/tags/v${version}";
        hash = "sha256-cQYBa1vba/fuv/j0D/MNUboQNTc913UG4dp8a1EPql4=";
      };

      postPatch = ''
        sed -i "/^requires-python =.*/a version = '${version}'" pyproject.toml
      '';
    }))
    typing-extensions
  ];
  meta = {
    description = "Easily add autocomplete dropdowns to your Textual apps";
    homepage = "https://github.com/darrenburns/textual-autocomplete";
    license = lib.licenses.mit;
  };
}
