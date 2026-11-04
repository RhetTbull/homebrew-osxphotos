class Osxphotos < Formula
  include Language::Python::Virtualenv

  desc "Export photos from Apple Photos app and query the Photos database"
  homepage "https://github.com/RhetTbull/osxphotos"
  url "https://files.pythonhosted.org/packages/93/62/52ffeb1b5ae2f46dcd48f1cc97d51d779b10c41c580718be90611b106d36/osxphotos-0.78.0.tar.gz"
  sha256 "a70f56381bed7adbdedfd6bc93729e8a48d2c38cfe441c9b1d99cbb8a71d19cc"
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
