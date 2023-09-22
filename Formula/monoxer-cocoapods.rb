class MonoxerCocoapods < Formula
  desc "Dependency manager for Cocoa projects"
  homepage "https://cocoapods.org/"
  url "https://github.com/CocoaPods/CocoaPods/archive/1.11.0.tar.gz"
  sha256 "4f494e7651cdf1a7afae6117fb1ed33c919471d7bc3b7575a68d5c316faf567c"
  license "MIT"
  revision 1
  head "https://github.com/CocoaPods/CocoaPods.git", branch: "master"

  bottle do
    root_url "https://github.com/Monoxer/homebrew-monoxer/releases/download/monoxer-cocoapods-1.11.0_1"
    rebuild 1
    sha256                               ventura:      "a8ec4a58b9f2bb9fd11f762db1db743d436a07bf931e966cb6a7d6091a96073d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "56ad66cc726f9031c60cc2ad3c0c403c997b2519fddf5319cdcdca031e3d8365"
  end

  keg_only "this is a homemade formula"

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
    if build.head?
      system "gem", "install", "cocoapods-1.12.1.gem"
    else
      system "gem", "install", "cocoapods-#{version}.gem"
    end
    # Other executables don't work currently.
    bin.install libexec/"bin/pod", libexec/"bin/xcodeproj"
    bin.env_script_all_files(libexec/"bin", GEM_HOME: ENV["GEM_HOME"])
  end

  test do
    system "#{bin}/pod", "list"
  end
end
