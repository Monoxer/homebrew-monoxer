# Adapted from the past official release: https://github.com/Homebrew/homebrew-core/blob/86727e94c99930cb99a643799a885c0e7b4e6525/Formula/k/ktlint.rb
class MonoxerKtlint < Formula
  desc "Anti-bikeshedding Kotlin linter with built-in formatter"
  homepage "https://ktlint.github.io/"
  url "https://github.com/pinterest/ktlint/releases/download/1.8.0/ktlint-1.8.0.zip"
  sha256 "3722801dd119b96a2fbeda0b9d66f173994f249998c87bcf2274b51977aa8f77"
  license "MIT"

  bottle do
    root_url "https://github.com/Monoxer/homebrew-monoxer/releases/download/monoxer-ktlint-1.8.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "dd8ff422e9c62653bab183daba553b8138d6735e1fa005f2b25b56f1d665f901"
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
