class MonoxerNode < Formula
  desc "Platform built on V8 to build network applications"
  homepage "https://nodejs.org/"
  url "https://nodejs.org/dist/v14.16.0/node-v14.16.0.tar.xz"
  sha256 "4e7648a617f79b459d583f7dbdd31fbbac5b846d41598f3b54331a5b6115dfa6"
  license "MIT"

  livecheck do
    url "https://nodejs.org/dist/"
    regex(%r{href=["']?v?(14(?:\.\d+)+)/?["' >]}i)
  end

  bottle do
    root_url "https://github.com/Monoxer/homebrew-monoxer/releases/download/monoxer-node-14.19.3"
    sha256 cellar: :any,                 arm64_monterey: "fff3c6112ee1e6e9d3a58e79ddb934f9b758ffbdf2fc5e2786268850915ae206"
    sha256 cellar: :any,                 big_sur:        "12f9c7447f837a0891304f961bb6b73edb294cbbdee26370d5a1fd115916c431"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "eb868ef3317a8a686818b87910adf822ee0cb46776970cc2b39cdf3530ecc798"
  end

  keg_only :versioned_formula

  depends_on "pkg-config" => :build
  depends_on "python@3.9" => :build
  depends_on "icu4c"

  uses_from_macos "zlib"

  on_macos do
    depends_on "macos-term-size"
  end

  def install
    # make sure subprocesses spawned by make are using our Python 3
    ENV["PYTHON"] = Formula["python@3.9"].opt_bin/"python3"

    system "python3", "configure.py", "--prefix=#{prefix}", "--with-intl=system-icu"
    system "make", "install"
  end

  def post_install
    (lib/"node_modules/npm/npmrc").atomic_write("prefix = #{HOMEBREW_PREFIX}\n")
  end

  def caveats
    <<~EOS
      以下のコードを#{shell_profile}に追記してください！
      Add the following to #{shell_profile} or your desired shell configuration file:
        export PATH="#{opt_prefix}/bin:$PATH"
    EOS
  end

  test do
    path = testpath/"test.js"
    path.write "console.log('hello');"

    output = shell_output("#{bin}/node #{path}").strip
    assert_equal "hello", output
    output = shell_output("#{bin}/node -e 'console.log(new Intl.NumberFormat(\"en-EN\").format(1234.56))'").strip
    assert_equal "1,234.56", output

    output = shell_output("#{bin}/node -e 'console.log(new Intl.NumberFormat(\"de-DE\").format(1234.56))'").strip
    assert_equal "1.234,56", output

    # make sure npm can find node
    ENV.prepend_path "PATH", opt_bin
    ENV.delete "NVM_NODEJS_ORG_MIRROR"
    assert_equal which("node"), opt_bin/"node"
    assert_predicate bin/"npm", :exist?, "npm must exist"
    assert_predicate bin/"npm", :executable?, "npm must be executable"
    npm_args = ["-ddd", "--cache=#{HOMEBREW_CACHE}/npm_cache", "--build-from-source"]
    system "#{bin}/npm", *npm_args, "install", "npm@latest"
    system "#{bin}/npm", *npm_args, "install", "bufferutil"
    assert_predicate bin/"npx", :exist?, "npx must exist"
    assert_predicate bin/"npx", :executable?, "npx must be executable"
    assert_match "< hello >", shell_output("#{bin}/npx cowsay hello")
  end
end
