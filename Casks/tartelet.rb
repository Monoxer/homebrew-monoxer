cask "tartelet" do
  version "0.9.0"
  sha256 "4330eab65cefe6c50ecf8b386caf5a08b763f4b5cfd7de9ea4d0165f8a5cade8"

  url "https://github.com/shapehq/tartelet/releases/download/#{version}/Tartelet.zip"
  name "Tartelet"
  desc "Manage multiple GitHub Actions runners in ephemeral virtual machines"
  homepage "https://github.com/shapehq/tartelet"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :big_sur"

  app "Tartelet.app"

  zap trash: [
    "~/Library/Application Support/dk.shape.Tartelet",
    "~/Library/Caches/dk.shape.Tartelet",
    "~/Library/HTTPStorages/dk.shape.Tartelet",
    "~/Library/Preferences/dk.shape.Tartelet.plist",
    "~/Library/Saved Application State/dk.shape.Tartelet.savedState",
  ]

  caveats <<~EOS
    Make sure that you have Tart installed before installing Tartelet. You can install Tart using
    Homebrew by running the following command.

      brew install cirruslabs/cli/tart
  EOS
end
