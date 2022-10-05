class MonoxerRome < Formula
  desc "Carthage cache for S3, Minio, Ceph, Google Storage, Artifactory and many others"
  homepage "https://github.com/tmspzz/Rome/#readme"
  url "https://github.com/Monoxer/Rome/archive/refs/tags/v0.24.1.66.tar.gz"
  sha256 "9ba615d1001ce6ce93cacf5e3b193d30f6aa25fa33014438105747785b71dc36"
  license "MIT"

  bottle do
    root_url "https://github.com/Monoxer/homebrew-monoxer/releases/download/monoxer-rome-0.24.1.66"
    sha256 cellar: :any_skip_relocation, big_sur:      "a946535817c7de87ade679660eea4bc3343c9532376f6ba2f0ed14a018777bf7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2f147c1ba8fd5d0944a1bc51c15a5982796892cfb71a84ba2683f3eccf58ded3"
  end

  depends_on "cabal-install" => :build
  depends_on "ghc@8.10" => :build

  uses_from_macos "zlib"

  def install
    system "cabal", "v2-update"
    system "cabal", "v2-install", *std_cabal_v2_args
  end

  test do
    (testpath/"Romefile").write <<~EOS
      cache:
        local: ~/Library/Caches/Rome
    EOS
    system "git", "init"
    system "git", "config", "user.name", "BrewTestBot"
    system "git", "config", "user.email", "BrewTestBot@test.com"
    system "git", "add", "Romefile"
    system "git", "commit", "-m", "test"
    (testpath/"Cartfile.resolved").write <<~EOS
      github "realm/realm-swift" "v10.20.2"
    EOS
    assert_match "realm-swift v10.20.2", shell_output("rome list")
  end
end
