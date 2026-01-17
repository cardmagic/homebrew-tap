class Messages < Formula
  desc "Fuzzy search and browse Apple Messages/iMessage from CLI"
  homepage "https://github.com/cardmagic/messages"
  url "https://registry.npmjs.org/@cardmagic/messages/-/messages-1.2.1.tgz"
  sha256 "309d53c91adf79a694e7267249d3e81264c184d6b0b32575765d021d8de24abb"
  license "MIT"

  depends_on "node"
  depends_on :macos

  uses_from_macos "python" => :build

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  def caveats
    <<~EOS
      This tool requires Full Disk Access to read Apple Messages.
      Grant access in: System Settings > Privacy & Security > Full Disk Access
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/messages --version")
  end
end
