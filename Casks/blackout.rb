cask "blackout" do
  version "1.2"
  sha256 "c71dd9c2c4160b32585ace902b268fa9d8eaea84aa72406ee769bd2fd446a2a5"

  url "https://github.com/peteoco/blackout/releases/download/v#{version}/Blackout.zip"
  name "Blackout"
  desc "Menu bar app that turns displays off and on without unplugging them"
  homepage "https://github.com/peteoco/blackout"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :ventura"

  app "Blackout.app"

  # Blackout is ad-hoc signed, not notarized. Remove the quarantine flag so it opens.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Blackout.app"]
  end

  uninstall quit: "com.peteoconnell.blackout"

  zap trash: [
    "~/Library/Application Support/Blackout",
    "~/Library/Preferences/com.peteoconnell.blackout.plist",
  ]

  caveats <<~EOS
    Blackout is free and open source but not notarized by Apple.
    If you ever lose a screen, press Ctrl-Option-Cmd-B or run:
      #{appdir}/Blackout.app/Contents/MacOS/Blackout --rescue
  EOS
end
