require "language/node"

class Degit < Formula
  desc "Straightforward project scaffolding"
  homepage "https://github.com/Rich-Harris/degit"
  url "https://registry.npmjs.org/degit/-/degit-2.8.4.tgz"
  sha256 "2fa329afe68038c4c4d1542908503a4a09211d97f326b30a1c7422a8238203de"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    system "true"
  end
end
