class MonoxerCocoapods < Formula
  desc "Dependency manager for Cocoa projects"
  homepage "https://cocoapods.org/"
  url "https://github.com/CocoaPods/CocoaPods/archive/1.11.0.tar.gz"
  sha256 "4f494e7651cdf1a7afae6117fb1ed33c919471d7bc3b7575a68d5c316faf567c"
  license "MIT"
  revision 1

  bottle do
    root_url "https://github.com/Monoxer/homebrew-monoxer/releases/download/monoxer-cocoapods-1.11.0_1"
    sha256                               monterey:     "13bb1729f17cabdab636011b26c0784294d342ef824fc7125bde9708baa46f66"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f51c30de88286d37acdcc95bed4134591c8fe49d30806ea31b8825e11db2af9f"
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
