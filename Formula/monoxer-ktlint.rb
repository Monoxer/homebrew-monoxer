# Adapted from the past official release: https://github.com/Homebrew/homebrew-core/blob/86727e94c99930cb99a643799a885c0e7b4e6525/Formula/k/ktlint.rb
class MonoxerKtlint < Formula
  desc "Anti-bikeshedding Kotlin linter with built-in formatter"
  homepage "https://ktlint.github.io/"
  url "https://github.com/pinterest/ktlint/releases/download/1.0.1/ktlint-1.0.1.zip"
  sha256 "02af5dbeeaa8a6f14bf612c391976c6932c329502b3d3ada1c45d019dcac5ade"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "89f032b664c5b7b3b4b2bf0d523b2a36a286e5f637cfaca8e149e285fb8b8580"
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
