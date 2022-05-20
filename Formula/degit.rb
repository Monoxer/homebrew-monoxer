require "language/node"

class Degit < Formula
  desc "Straightforward project scaffolding"
  homepage "https://github.com/Rich-Harris/degit"
  url "https://github.com/Rich-Harris/degit/archive/refs/tags/v2.8.4.tar.gz"
  sha256 "3a24a0727e057b0565cab588e93bdf578df43ceaf3495b57dc1aae1ecbf07555"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install"
    system "npm", "run", "build"
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    system "true"
  end
end
