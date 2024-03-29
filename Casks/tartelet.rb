cask "tartelet" do
  version "0.8.2"
  sha256 "707daa1ea5c7bac2e92ac8dc5ad66c4439b50f233d3a616e824d1c174d9c85a9"

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
    "~/Library/Preferences/dk.shape.Tartelet.plist",
    "~/Library/Saved Application State/dk.shape.Tartelet.savedState",
  ]

  caveats <<~EOS
    Make sure that you have Tart installed before installing Tartelet. You can install Tart using
    Homebrew by running the following command.

      brew install cirruslabs/cli/tart
  EOS
end
