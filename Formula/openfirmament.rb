class Openfirmament < Formula
  desc "Interactive offline terminal sky atlas"
  homepage "https://github.com/max-lavalmullen/homebrew-openfirmament"
  url "https://github.com/max-lavalmullen/homebrew-openfirmament/releases/download/v0.7.0/openfirmament-cli-macos-arm64.tar.gz"
  version "0.7.0"
  sha256 "8f5b416df269c043e1d1e8417b586ac276138674eaf2e0c8910b590db0f7f091"
  # MIT software, CC BY-SA data and separate NAIF ephemeris terms; see docs.
  license :cannot_represent

  depends_on arch: :arm64
  depends_on macos: :sonoma

  def install
    libexec.install "OpenFirmamentTerminal", "OpenFirmament_SkyCore.bundle"
    bin.write_exec_script libexec/"OpenFirmamentTerminal"
    mv bin/"OpenFirmamentTerminal", bin/"openfirmament"
    doc.install "README.md", "docs"
    prefix.install "LICENSE"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/openfirmament --version")
    assert_match "0 failures", shell_output("#{bin}/openfirmament --self-check")
    assert_match "OPENFIRMAMENT", shell_output("#{bin}/openfirmament --snapshot --no-color --lat 0 --lon 0 --time 2026-01-15T03:00:00Z")
  end
end
