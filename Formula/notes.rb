class Notes < Formula
  desc "Fuzzy search and browse Apple Notes from CLI"
  homepage "https://github.com/cardmagic/notes"
  url "https://registry.npmjs.org/@cardmagic/notes/-/notes-1.3.0.tgz"
  sha256 "24b4769a7fd633377591f5da8bd54538ce6c29deb1fc3f7b7c73424e12d9927b"
  license "MIT"

  depends_on "node"
  depends_on :macos

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  def caveats
    <<~EOS
      This tool requires Full Disk Access to read Apple Notes.
      Grant access in: System Settings > Privacy & Security > Full Disk Access

      For PDF text extraction, install poppler:
        brew install poppler
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/notes --version")
  end
end
