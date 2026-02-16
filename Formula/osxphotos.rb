class Osxphotos < Formula
  include Language::Python::Virtualenv

  desc "Export photos from Apple Photos app and query the Photos database"
  homepage "https://github.com/RhetTbull/osxphotos"
  version "0.75.5"
  url "https://files.pythonhosted.org/packages/source/o/osxphotos/osxphotos-#{version}.tar.gz"
  sha256 "0f44e5ecb1e175217c8b719b58e55aa4bb9d3caeeb69f075c086cf5fa8efeb1b"
  license "MIT"

  depends_on "python@3.13"
  depends_on :macos

  def install
    virtualenv_create(libexec, "python3")
    system libexec/"bin/python", "-m", "pip", "install", "--upgrade", "pip", "setuptools", "wheel"
    system libexec/"bin/python", "-m", "pip", "install", buildpath.to_s

    # Remove whenever's Rust extension to avoid Homebrew dylib relinking
    # failure (Mach-O header too small for rewritten install name).
    # The whenever package falls back to its pure-Python implementation.
    rm Dir[libexec/"lib/python*/site-packages/whenever/_whenever*.so"]

    bin.install_symlink libexec/"bin/osxphotos"
  end
end
