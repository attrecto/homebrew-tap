class Pmx < Formula
  desc "Engineering metrics from git history, with a web dashboard"
  homepage "https://github.com/attrecto/project-metrics"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/attrecto/project-metrics/releases/download/v0.1.1/pmx-aarch64-apple-darwin.tar.xz"
      sha256 "7be75e5bc983d2747a895003d73dc2bc2770b15701e7a2c7e78351bf51ae77e5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/attrecto/project-metrics/releases/download/v0.1.1/pmx-x86_64-apple-darwin.tar.xz"
      sha256 "a420edec8b4f066dc3ca2dde95e373f9444aba546131e38bbb44105f444d9a9a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/attrecto/project-metrics/releases/download/v0.1.1/pmx-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1ce86b9a3c897b23c33b3b5a364cb3b8b7f0516856d63fe7461493cc5a0615fc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/attrecto/project-metrics/releases/download/v0.1.1/pmx-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "201ef0f9a1f7a0a505021c320af4585cc7a037b551270e04e9e6a1ea9bcad877"
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
