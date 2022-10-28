class Tart < Formula
  desc "macOS and Linux VMs on Apple Silicon to use in CI and other automations"
  homepage "https://github.com/cirruslabs/tart#readme"
  url "https://github.com/cirruslabs/tart/archive/refs/tags/0.32.1.tar.gz"
  sha256 "cb9c2adcd26aca53380816a667dd6d722ebd3e553c9fb530b5b0ebff4f810c86"
  license "AGPL-3.0-or-later"

  depends_on "rust" => :build
  depends_on xcode: ["14.1", :build]
  depends_on arch: :arm64
  depends_on macos: :monterey
  depends_on :macos

  uses_from_macos "swift"

  resource "softnet" do
    url "https://github.com/cirruslabs/softnet/archive/refs/tags/0.3.0.tar.gz"
    sha256 "b77fb9424cf6a5c61e2a2513a531f0a9321047890979ca7282a5c036ebf48938"
  end

  def install
    resource("softnet").stage do
      system "cargo", "install", *std_cargo_args
    end
    system "swift", "build", "--disable-sandbox", "-c", "release", "--product", "tart"
    system "/usr/bin/codesign", "-f", "-s", "-", "--entitlement", "Resources/tart.entitlements", ".build/release/tart"
    bin.install ".build/release/tart"
  end

  test do
    ENV["TART_HOME"] = testpath/".tart"
    system "tart", "create", "test", "--linux"
    assert_match "test", shell_output("tart list")
  end
end
