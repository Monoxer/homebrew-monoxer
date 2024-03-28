# Adapted from the past official release: https://github.com/Homebrew/homebrew-core/blob/86727e94c99930cb99a643799a885c0e7b4e6525/Formula/k/ktlint.rb
class MonoxerKtlint < Formula
  desc "Anti-bikeshedding Kotlin linter with built-in formatter"
  homepage "https://ktlint.github.io/"
  url "https://github.com/pinterest/ktlint/releases/download/1.0.1/ktlint-1.0.1.zip"
  sha256 "02af5dbeeaa8a6f14bf612c391976c6932c329502b3d3ada1c45d019dcac5ade"
  license "MIT"

  bottle do
    root_url "https://github.com/Monoxer/homebrew-monoxer/releases/download/monoxer-ktlint-1.0.1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "c9eee66bddf97d4a0aaf930f9c01e0f75158712b36c8db57d3ad225971c53ab7"
    sha256 cellar: :any_skip_relocation, ventura:      "87b4825eeab2e8b45ae5370e1b018e1d34fcb70354a7dfa67e4f3c8ab0fe4aeb"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b2ccc5e9bff28389d679528b2770d4c6f2639d1db193b1a44d088ae6f1495665"
  end

  depends_on "openjdk"

  def install
    libexec.install "bin/ktlint"
    (libexec/"ktlint").chmod 0755
    (bin/"ktlint").write_env_script libexec/"ktlint", Language::Java.java_home_env
  end

  test do
    (testpath/"Main.kt").write <<~EOS
      fun main( )
    EOS
    (testpath/"Out.kt").write <<~EOS
      fun main()
    EOS
    system bin/"ktlint", "-F", "Main.kt"
    assert_equal shell_output("cat Main.kt"), shell_output("cat Out.kt")
  end
end
