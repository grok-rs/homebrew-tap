class Snp < Formula
  desc "You Shell Not Pass: a drop-in replacement for pre-commit 4.6.2 with lefthook-inspired extensions"
  homepage "https://github.com/grok-rs/snp"
  version "2.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/grok-rs/snp/releases/download/v2.0.0/snp-aarch64-apple-darwin.tar.xz"
      sha256 "32fda187d4bce8e7bab93c8cf8cce66920c2f82c1416cf5d3a489f7aa3fda9b0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/grok-rs/snp/releases/download/v2.0.0/snp-x86_64-apple-darwin.tar.xz"
      sha256 "de39fa752d771e0cf04a518071a7e0c62f62a2f2736a58c93f391805bae125a9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/grok-rs/snp/releases/download/v2.0.0/snp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6cb9b280a8d5ba9b6d4075a351b2ce553d50d37f0ee8565c4cfeeff481658d8b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/grok-rs/snp/releases/download/v2.0.0/snp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5662d70b08bb52a57165dffee3eb9915dbf06785258b067a51c4f64ce0712795"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-pc-windows-gnu": {},
    "aarch64-unknown-linux-gnu": {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static": {}
  }

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
      bin.install "snp"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "snp"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "snp"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "snp"
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
