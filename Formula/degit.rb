require "language/node"

class Degit < Formula
  desc "Straightforward project scaffolding"
  homepage "https://github.com/Rich-Harris/degit"
  url "https://registry.npmjs.org/degit/-/degit-2.8.4.tgz"
  sha256 "2fa329afe68038c4c4d1542908503a4a09211d97f326b30a1c7422a8238203de"
  license "MIT"

  bottle do
    root_url "https://github.com/Monoxer/homebrew-monoxer/releases/download/degit-2.8.4"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "94c3fb38ceb7b40b2e60495fc4bd0ae2ac7f31f0daefb720d61da2bc78320c09"
    sha256 cellar: :any_skip_relocation, big_sur:        "09e05e2aa425a265a3864d5d89df6c11d66d9e13d58fb3139fb6b4edd7b9ed10"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "43d388200d5dac6c7e7a0921bc595d6acbef57490da60dd1088bdaa677b12189"
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    system "true"
  end
end
