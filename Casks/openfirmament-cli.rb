cask "openfirmament-cli" do
  version "0.7.0"
  sha256 "8f5b416df269c043e1d1e8417b586ac276138674eaf2e0c8910b590db0f7f091"

  url "https://github.com/max-lavalmullen/homebrew-openfirmament/releases/download/v#{version}/openfirmament-cli-macos-arm64.tar.gz"
  name "OpenFirmament Terminal"
  desc "Interactive offline terminal sky atlas"
  homepage "https://github.com/max-lavalmullen/homebrew-openfirmament"

  depends_on arch: :arm64
  depends_on macos: ">= :sonoma"

  # An absolute executable path preserves its adjacent astronomy resource bundle.
  command_wrapper "openfirmament",
                  executable: "#{staged_path}/OpenFirmamentTerminal"
end
