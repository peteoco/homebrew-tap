cask "shade" do
  version "2.2"
  sha256 "2da2089587b484b3800821fc41db110d3dc764d653bdd2d62e289e09e78b97ce"

  url "https://github.com/peteoco/shade/releases/download/v#{version}/Shade.zip"
  name "Shade"
  desc "Menu bar app that turns displays off and on without unplugging them"
  homepage "https://github.com/peteoco/shade"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :ventura"

  app "Shade.app"

  # Shade is ad-hoc signed, not notarized. Remove the quarantine flag so it opens.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Shade.app"]
  end

  uninstall quit: "com.peteoconnell.shade"

  zap trash: [
    "~/Library/Application Support/Shade",
    "~/Library/Preferences/com.peteoconnell.shade.plist",
  ]

  caveats <<~EOS
    Shade is free and open source but not notarized by Apple.
    If you ever lose a screen, press Ctrl-Option-Cmd-B or run:
      #{appdir}/Shade.app/Contents/MacOS/Shade --rescue
  EOS
end
