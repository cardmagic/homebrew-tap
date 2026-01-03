class Notes < Formula
  desc "Fuzzy search and browse Apple Notes from CLI"
  homepage "https://github.com/cardmagic/notes"
  url "https://registry.npmjs.org/@cardmagic/notes/-/notes-1.0.1.tgz"
  sha256 "5b2d6e1e905f11e0a6a0681e0390b3c0792d2a908541bd2727b56a190a9f5aa8"
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
