class Pmx < Formula
  desc "Engineering metrics from git history, with a web dashboard"
  homepage "https://github.com/attrecto/project-metrics"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/attrecto/project-metrics/releases/download/v0.1.2/pmx-aarch64-apple-darwin.tar.xz"
      sha256 "5d486c23cf05d825e97941a45fc9b7fc5cb2d4ba5ac1aa9246219760a0c7a3f5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/attrecto/project-metrics/releases/download/v0.1.2/pmx-x86_64-apple-darwin.tar.xz"
      sha256 "8830c0a1c3231aa083244b96851da6505b1017830e41df7cf2b493323594f128"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/attrecto/project-metrics/releases/download/v0.1.2/pmx-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "263cc257697b64ebeb19d875b5e2ca691f9709bb8f65df3952b44d4a38e23e10"
    end
    if Hardware::CPU.intel?
      url "https://github.com/attrecto/project-metrics/releases/download/v0.1.2/pmx-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2f52152eb9cd382e4009197b6ac8b904a4fcfbf15e212f3938b0761a0bf7c20b"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "pmx"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "pmx"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "pmx"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "pmx"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
