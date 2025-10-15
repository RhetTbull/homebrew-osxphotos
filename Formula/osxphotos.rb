class Osxphotos < Formula
  include Language::Python::Virtualenv

  desc "Export photos from Apple Photos app and query the Photos database"
  homepage "https://github.com/RhetTbull/osxphotos"
  version "0.73.4"
  url "https://files.pythonhosted.org/packages/source/o/osxphotos/osxphotos-#{version}.tar.gz"
  sha256 "80c3446320deb14cd3c281b22c5beb8f56fd89ccbd9b89668db6a1bbadf01c10"
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
