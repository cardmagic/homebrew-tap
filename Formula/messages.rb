class Messages < Formula
  desc "Fuzzy search and browse Apple Messages/iMessage from CLI"
  homepage "https://github.com/cardmagic/messages"
  url "https://registry.npmjs.org/@cardmagic/messages/-/messages-1.5.0.tgz"
  sha256 "dcbece0c10936005676196242dbcf5fc7bfe5d721574a6351e63f24aa70832f6"
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
