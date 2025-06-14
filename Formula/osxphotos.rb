class Osxphotos < Formula
  include Language::Python::Virtualenv

  desc "Export photos from Apple Photos app and query the Photos database"
  homepage "https://github.com/RhetTbull/osxphotos"
  url "https://files.pythonhosted.org/packages/source/o/osxphotos/osxphotos-0.72.0.tar.gz"
  sha256 "6adc48ed4c4e0e055e9a754a3e5fe80c0b5c1b60b8a088b5cba6a725f51a2f65"
  license "MIT"

  depends_on "python@3.12"
  depends_on :macos

  def install
    virtualenv_install_with_resources

    # Generate shell completions
    generate_completions_from_executable(bin/"osxphotos", shells: [:bash, :zsh, :fish],
                                          shell_parameter_format: :click)
  end

  test do
    # Test basic functionality
    assert_match "OSXPhotos", shell_output("#{bin}/osxphotos --version")
    assert_match "Usage", shell_output("#{bin}/osxphotos --help")
    
    # Test that we can import the module
    system libexec/"bin/python", "-c", "import osxphotos; print('Import successful')"
  end
end
