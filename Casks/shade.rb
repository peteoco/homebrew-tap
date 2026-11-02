cask "shade" do
  version "1.3"
  sha256 "8e3f9149d137e19bb020b3eb9d70ee2a09751b39fc1f490d6c68473c156922cf"

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
