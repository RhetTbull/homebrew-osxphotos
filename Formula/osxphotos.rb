class Osxphotos < Formula
  include Language::Python::Virtualenv

  desc "Export photos from Apple Photos app and query the Photos database"
  homepage "https://github.com/RhetTbull/osxphotos"
  url "https://files.pythonhosted.org/packages/20/57/44770b159a8a3b719083d06a52709fa5851c98dc0a7c4cf8c7c1e36f6d88/osxphotos-0.77.2.tar.gz"
  sha256 "9bb737d785b2467026d591417572b2c5888010a41664ab608dc134cca314ec66"
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
