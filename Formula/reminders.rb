class Reminders < Formula
  desc "Fuzzy search and browse Apple Reminders from CLI"
  homepage "https://github.com/cardmagic/reminders"
  url "https://registry.npmjs.org/@cardmagic/reminders/-/reminders-1.0.0.tgz"
  sha256 "3bc76cbcd305a99011cbb8f0e1b41c1f783e4ee2b54cb5959765675ad9e24b55"
  license "MIT"

  depends_on "node"
  depends_on :macos

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  def caveats
    <<~EOS
      This tool requires Full Disk Access to read Apple Reminders.
      Grant access in: System Settings > Privacy & Security > Full Disk Access
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/reminders --version")
  end
end
