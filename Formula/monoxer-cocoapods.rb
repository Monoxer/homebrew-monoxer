class MonoxerCocoapods < Formula
  desc "Dependency manager for Cocoa projects"
  homepage "https://cocoapods.org/"
  url "https://github.com/CocoaPods/CocoaPods/archive/1.11.0.tar.gz"
  sha256 "4f494e7651cdf1a7afae6117fb1ed33c919471d7bc3b7575a68d5c316faf567c"
  license "MIT"
  revision 1

  bottle do
    root_url "https://github.com/Monoxer/homebrew-monoxer/releases/download/monoxer-cocoapods-1.11.0"
    sha256 cellar: :any,                 arm64_monterey: "dc1686550da5838227cc47f4d25c78c214a818c8f8f9e1d8eaca77ec676b6635"
    sha256                               big_sur:        "45be56e366c91030d3e4e0bc30d77cb987c15b1bfe0eb2e861017a73c050c13b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "70cfd9d41b1eebab1bea0d951a4bb46c544c25631962adbcd6d9b75a299fc602"
  end

  depends_on "pkg-config" => :build
  depends_on "ruby" if Hardware::CPU.arm?

  uses_from_macos "libffi", since: :catalina
  uses_from_macos "ruby", since: :catalina

  def install
    if MacOS.version >= :mojave && MacOS::CLT.installed?
      ENV["SDKROOT"] = ENV["HOMEBREW_SDKROOT"] = MacOS::CLT.sdk_path(MacOS.version)
    end

    ENV["GEM_HOME"] = libexec
    system "gem", "build", "cocoapods.gemspec"
    system "gem", "install", "cocoapods-#{version}.gem"
    # Other executables don't work currently.
    bin.install libexec/"bin/pod", libexec/"bin/xcodeproj"
    bin.env_script_all_files(libexec/"bin", GEM_HOME: ENV["GEM_HOME"])
  end

  test do
    system "#{bin}/pod", "list"
  end
end
