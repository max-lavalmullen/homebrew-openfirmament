# OpenFirmament 0.7.0 — first downloadable preview

Both the native Mac app and terminal sky map are available as self-contained
downloads for **Apple silicon, macOS 14 or later**. The astronomy catalogs are
included; neither application needs a compiler, account or network access to run.

- Mac app: searchable stars and deep-sky objects, constellation finder patterns,
  Sun/Moon/planets, observing planner, journal editing/export, lists, reviewed
  fieldbook imports and guided tours. Includes the guiding-star icon and fixes
  for quitting with sheets open.
- Terminal: black sky, colored stars, braille constellation arcs, search and
  inspector, mouse/keyboard pan and zoom, observer selection, UTC time travel,
  300× playback, red-light mode and plain-text snapshots.
- Installation: Homebrew casks for the CLI and app, direct
  ZIP/tar downloads and a checksum-verifying curl CLI installer.

```sh
brew tap max-lavalmullen/openfirmament
brew install --cask max-lavalmullen/openfirmament/openfirmament-cli
brew install --cask max-lavalmullen/openfirmament/openfirmament-app
```

**First-launch limitation:** these are ad-hoc-signed, unnotarized previews.
macOS may require explicit approval after the first attempted app launch via
System Settings → Privacy & Security. See [Apple's guidance](https://support.apple.com/102445).
No installer disables Gatekeeper or removes quarantine.

**Not included:** satellite/spacecraft tracking, all-88 constellation coverage,
Intel, Linux or Windows packages. Dates are limited to 1972–2049. The chart uses
the geometric horizon; see the bundled accuracy documentation.

Tested locally on an Apple-silicon Mac: 694 astronomy/core assertions,
88 app-model assertions, 44 terminal assertions, 41 terminal PTY checks, and
50 archive/installer checks, all passing. Relocated copies were tested;
corrupt/missing resources and tampered downloads are rejected.

Downloads carry SHA-256 hashes in `SHA256SUMS`. Each archive includes MIT software
notices, CC BY-SA catalog attribution and separate NAIF kernel terms.
The app source and development history remain in the private development repository;
this public repository contains distribution metadata and installers.
