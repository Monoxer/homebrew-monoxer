class MonoxerCocoapods < Formula
  desc "Dependency manager for Cocoa projects"
  homepage "https://cocoapods.org/"
  url "https://github.com/CocoaPods/CocoaPods/archive/1.12.1.tar.gz"
  sha256 "da018fc61694753ecb7ac33b21215fd6fb2ba660bd7d6c56245891de1a5f061c"
  license "MIT"

  bottle do
    root_url "https://github.com/Monoxer/homebrew-monoxer/releases/download/monoxer-cocoapods-1.11.0_1"
    sha256 cellar: :any,                 arm64_ventura: "0ba52c2908f9e9b21c46f605e20757bd29e6b562e2a2d79235055184dbc93fc8"
    sha256                               monterey:      "13bb1729f17cabdab636011b26c0784294d342ef824fc7125bde9708baa46f66"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f51c30de88286d37acdcc95bed4134591c8fe49d30806ea31b8825e11db2af9f"
  end

  depends_on "pkg-config" => :build
  depends_on "ruby"
  uses_from_macos "libffi", since: :catalina

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
