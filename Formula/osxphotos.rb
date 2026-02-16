class Osxphotos < Formula
  include Language::Python::Virtualenv

  desc "Export photos from Apple Photos app and query the Photos database"
  homepage "https://github.com/RhetTbull/osxphotos"
  version "0.75.4"
  url "https://files.pythonhosted.org/packages/source/o/osxphotos/osxphotos-#{version}.tar.gz"
  sha256 "51425cd85f45e32001a13e33aac52a1d62c02ce911913c5288297e2431dcb56a"
  license "MIT"

  depends_on "python@3.13"
  depends_on :macos

  def install
    virtualenv_create(libexec, "python3")
    system libexec/"bin/python", "-m", "pip", "install", "--upgrade", "pip", "setuptools", "wheel"
    # Set headerpad_max_install_names so Homebrew can rewrite dylib IDs in
    # Rust-built extensions (e.g. whenever's _whenever.so) without running
    # out of Mach-O header space.
    ENV.append "LDFLAGS", "-Wl,-headerpad_max_install_names"
    system libexec/"bin/python", "-m", "pip", "install", buildpath.to_s
    bin.install_symlink libexec/"bin/osxphotos"
  end
end
