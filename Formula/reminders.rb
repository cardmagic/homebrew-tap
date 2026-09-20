class Reminders < Formula
  desc "Fuzzy search and browse Apple Reminders from CLI"
  homepage "https://github.com/cardmagic/reminders"
  url "https://registry.npmjs.org/@cardmagic/reminders/-/reminders-1.3.0.tgz"
  sha256 "2c2b15778ad0d9d153c720e0fb52acb0dc25fcfd442af4d53dc7684a3ed90e34"
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
