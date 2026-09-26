class Osxphotos < Formula
  include Language::Python::Virtualenv

  desc "Export photos from Apple Photos app and query the Photos database"
  homepage "https://github.com/RhetTbull/osxphotos"
  url "https://files.pythonhosted.org/packages/70/3b/bfd19eba72f76ab60005adc70c5b4b770e47927a66640a4ce9fbffd67ac8/osxphotos-0.77.0.tar.gz"
  sha256 "fe6b89e100761cef2f5ae2a0d202735f1c0b07218db3265b7dba228cc2619a40"
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
