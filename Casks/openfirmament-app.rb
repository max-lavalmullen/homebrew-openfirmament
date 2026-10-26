cask "openfirmament-app" do
  version "0.7.0"
  sha256 "d7f7bebd5e9d0a4c2ab079e83ab71201479df354be63569d4674c19305d5ac55"

  url "https://github.com/max-lavalmullen/homebrew-openfirmament/releases/download/v#{version}/OpenFirmament-macos-arm64.zip"
  name "OpenFirmament"
  desc "Offline sky atlas with stars, planets and an observing journal"
  homepage "https://github.com/max-lavalmullen/homebrew-openfirmament"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "OpenFirmament.app"

  caveats <<~EOS
    This preview is ad-hoc signed, not Apple-notarized. macOS may require
    your explicit first-launch approval in System Settings > Privacy & Security.
    https://support.apple.com/102445
    Uninstall keeps your observing journal and saved preferences.
  EOS
end
