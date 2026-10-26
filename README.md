# OpenFirmament

An offline sky atlas for your Mac and your terminal. Explore stars, constellation
patterns, the Moon and planets; search deep-sky objects; travel through time.
The Mac app includes an observing journal, lists and guided tours. The terminal
companion adds a black sky, colored stars, braille constellation lines and mouse
or keyboard navigation.

**Preview 0.7.0 · Apple silicon (M1 or later) · macOS 14 Sonoma or later.**
No account, subscription, telemetry, paid API or runtime network connection.

## Install with Homebrew

```sh
brew tap max-lavalmullen/openfirmament

# Terminal CLI/TUI:
brew install --cask max-lavalmullen/openfirmament/openfirmament-cli
openfirmament

# Mac application:
brew install --cask max-lavalmullen/openfirmament/openfirmament-app
```

Open **OpenFirmament** from Applications. Future versions can be installed with
`brew upgrade --cask openfirmament-cli` and `brew upgrade --cask openfirmament-app`.
This is a custom tap, not Homebrew's official core/cask catalog. The CLI cask uses
Homebrew 7's command-wrapper support and installs a prebuilt executable. Run
`brew update` first on older Homebrew installations. The optional `openfirmament`
formula is also available, but Homebrew's formula installation checks require
current Xcode Command Line Tools even though the archive is prebuilt. Prefer the
CLI cask or curl installer if those tools are unavailable.

## Download directly

- [Download the Mac app ZIP](https://github.com/max-lavalmullen/homebrew-openfirmament/releases/latest/download/OpenFirmament-macos-arm64.zip)
- [Download the terminal CLI/TUI archive](https://github.com/max-lavalmullen/homebrew-openfirmament/releases/latest/download/openfirmament-cli-macos-arm64.tar.gz)
- [Release notes and SHA-256 checksums](https://github.com/max-lavalmullen/homebrew-openfirmament/releases/latest)

Unzip the app and move **OpenFirmament.app** to Applications. The catalogs are
already included; no compiler or separate astronomy download is required.

**First launch:** this preview is ad-hoc signed, not Apple Developer ID signed or
notarized. macOS may block the downloaded app. After trying to open it, follow
[Apple's instructions for opening an app you trust](https://support.apple.com/102445)
in System Settings → Privacy & Security. We do not remove quarantine or disable
Gatekeeper. A clean, warning-free first launch needs a future notarized release.

## Install the CLI with curl

This installs the terminal version into `~/.local`, without sudo or Homebrew.
The installer verifies a pinned SHA-256 checksum before extracting the archive,
and keeps older installed versions when upgrading.

```sh
curl -fsSL https://raw.githubusercontent.com/max-lavalmullen/homebrew-openfirmament/main/install.sh -o /tmp/openfirmament-install.sh
sh /tmp/openfirmament-install.sh
~/.local/bin/openfirmament
```

You can inspect the script before running it. Use `--prefix /your/path` to install
elsewhere, or `--archive /path/to/openfirmament-cli-macos-arm64.tar.gz` to install
an already-downloaded archive (the same checksum is still required).
The installer does not modify shell startup files. Add `~/.local/bin` to your PATH
if desired. It refuses to overwrite an unrelated existing `openfirmament` command.

For manual CLI use, unpack the archive and run `./OpenFirmamentTerminal` from the
unpacked directory. Keep `OpenFirmament_SkyCore.bundle` next to the executable.

## Terminal controls

Arrows pan; `+` / `-` zoom; `/` searches; Tab selects; `0` shows the whole sky.
`o` sets latitude/longitude, `t` sets UTC time, `[` / `]` step an hour, and Space
plays time at 300× speed. `n` returns to now. `c` toggles constellations, `d` adds
deep-sky objects, `r` enables red light, `?` shows help, and `q` quits.
Mouse drag and wheel zoom work in supporting terminals.

```sh
openfirmament --lat 40.7128 --lon -74.0060
openfirmament --snapshot --no-color --time 2026-01-15T03:00:00Z > sky.txt
openfirmament --help
```

A wide terminal (120 × 38 or larger) shows an inspector. The saved Mac-app observer
is reused read-only; otherwise Greenwich is explicitly labeled as an example.
Your location is never inferred. Changes made in the TUI apply only to that session.

## Scope and licenses

The bundled catalog contains 8,920 stars, 12,161 deep-sky objects, ten constellation
finder patterns and Sun/Moon/seven-planet ephemerides. Dates span 1972–2049. This is
an observing prototype; satellite/spacecraft tracking, all-88 constellation coverage,
Intel, Linux and Windows packages are not included in this release.

Original software is MIT-licensed. Adapted HYG/OpenNGC data and constellation
patterns are CC BY-SA 4.0. The unmodified JPL DE442s kernel has separate NAIF terms.
Every archive includes license notices, data provenance and accuracy documentation.
No endorsement by NASA/JPL, Homebrew, or any third-party app is implied.

This repository contains public distribution files and installers. The development
repository and its history remain private; this repository is not the app source
tree. Support and packaging issues can be filed here.
