class Osxphotos < Formula
  include Language::Python::Virtualenv

  desc "Export photos from Apple Photos app and query the Photos database"
  homepage "https://github.com/RhetTbull/osxphotos"
  url "https://files.pythonhosted.org/packages/37/24/f1df22cee33127de0e5b51cafb8a9cdaba0deeeb8d99c905341740201d0a/osxphotos-0.78.1.tar.gz"
  sha256 "726164b29cafc971aa72b7076d82c6155032cdfc44f4451130d22b334e90733f"
  license "MIT"

  depends_on :macos
  depends_on "python@3.13"

  # Rust extensions from PyPI wheels (e.g. whenever, tibs) are dylibs with
  # @rpath install names and too little Mach-O header padding for Homebrew
  # to rewrite them to absolute paths. Python loads extensions by path, so
  # the install name doesn't matter; keep it as-is. Requires Homebrew >= 4.6.18.
  preserve_rpath

  def install
    virtualenv_create(libexec, "python3")
    system libexec/"bin/python", "-m", "pip", "install", "--upgrade", "pip", "setuptools", "wheel"
    system libexec/"bin/python", "-m", "pip", "install", buildpath.to_s

    bin.install_symlink libexec/"bin/osxphotos"
  end
end
