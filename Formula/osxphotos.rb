class Osxphotos < Formula
  include Language::Python::Virtualenv

  desc "Export photos from Apple Photos app and query the Photos database"
  homepage "https://github.com/RhetTbull/osxphotos"
  version "0.73.2"
  url "https://files.pythonhosted.org/packages/source/o/osxphotos/osxphotos-#{version}.tar.gz"
  sha256 "d42538e542c5e100c00298a0f37876a03a9832823f2c511e26b95e795bc5434e"
  license "MIT"

  depends_on "python@3.13"
  depends_on :macos

  def install
    virtualenv_create(libexec, "python3")
    system libexec/"bin/python", "-m", "pip", "install", "--upgrade", "pip", "setuptools", "wheel"
    system libexec/"bin/python", "-m", "pip", "install", buildpath.to_s
    bin.install_symlink libexec/"bin/osxphotos"
  end
end
