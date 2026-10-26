#!/bin/sh
# OpenFirmament CLI installer. No sudo, shell-profile edits or security overrides.
set -eu
version='0.7.0'
sha256='8f5b416df269c043e1d1e8417b586ac276138674eaf2e0c8910b590db0f7f091'
url="https://github.com/max-lavalmullen/homebrew-openfirmament/releases/download/v$version/openfirmament-cli-macos-arm64.tar.gz"
prefix="$HOME/.local"
archive=''
while [ "$#" -gt 0 ]; do
    case "$1" in
        --prefix|--archive)
            option=$1; shift
            [ "$#" -gt 0 ] || { printf 'Missing value for %s\n' "$option" >&2; exit 2; }
            case "$option" in --prefix) prefix=$1 ;; --archive) archive=$1 ;; esac
            ;;
        --help)
            printf 'Usage: sh install.sh [--prefix DIR] [--archive FILE]\n'; exit 0 ;;
        *) printf 'Unknown option: %s\n' "$1" >&2; exit 2 ;;
    esac
    shift
done
[ "$(uname -s)" = Darwin ] && [ "$(uname -m)" = arm64 ] || {
    printf 'This release requires an Apple-silicon Mac.\n' >&2; exit 1;
}
major=$(sw_vers -productVersion | cut -d . -f 1)
[ "$major" -ge 14 ] || { printf 'macOS 14 or newer is required.\n' >&2; exit 1; }
case "$prefix" in /*) ;; *) printf 'Prefix must be an absolute path.\n' >&2; exit 2 ;; esac
case "$prefix" in *'
'*) printf 'Prefix cannot contain a newline.\n' >&2; exit 2 ;; esac

destination="$prefix/bin/openfirmament"
if [ -e "$destination" ] || [ -L "$destination" ]; then
    if [ -L "$destination" ] || ! grep -q '^# openfirmament-managed-launcher$' "$destination"; then
        printf 'Refusing to replace existing command: %s\nUse --prefix with another directory.\n' "$destination" >&2
        exit 1
    fi
fi
scratch=$(mktemp -d "${TMPDIR:-/tmp}/openfirmament-install.XXXXXX")
staging=''
cleanup() {
    rm -rf "$scratch"
    if [ -n "$staging" ]; then rm -rf "$staging"; fi
}
trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM
trap 'exit 129' HUP
if [ -n "$archive" ]; then
    cp "$archive" "$scratch/cli.tar.gz"
else
    printf 'Downloading OpenFirmament %s…\n' "$version"
    curl --fail --location --proto '=https' --proto-redir '=https' --tlsv1.2 \
        --connect-timeout 15 --max-time 300 "$url" -o "$scratch/cli.tar.gz"
fi
actual=$(shasum -a 256 "$scratch/cli.tar.gz" | awk '{print $1}')
[ "$actual" = "$sha256" ] || { printf 'Checksum mismatch. Nothing was installed.\n' >&2; exit 1; }
mkdir -p "$prefix/lib/openfirmament" "$prefix/bin"
staging=$(mktemp -d "$prefix/lib/openfirmament/.install.XXXXXX")
tar -xzf "$scratch/cli.tar.gz" -C "$staging"
codesign --verify --strict "$staging/OpenFirmamentTerminal"
"$staging/OpenFirmamentTerminal" --version
root="$prefix/lib/openfirmament"
if [ -e "$root/current" ] && [ ! -L "$root/current" ]; then
    printf 'Refusing to replace non-symlink: %s/current\n' "$root" >&2; exit 1
fi
if [ -L "$root/$version" ]; then
    printf 'Refusing unexpected version symlink: %s/%s\n' "$root" "$version" >&2; exit 1
fi
if [ -e "$root/$version" ]; then
    # Idempotent installs must match the verified archive byte-for-byte.
    diff -qr "$staging" "$root/$version" >/dev/null || {
        printf 'Existing version differs from the release: %s\n' "$root/$version" >&2; exit 1;
    }
else
    mv "$staging" "$root/$version"
    staging=''
fi
cat > "$scratch/openfirmament" <<'LAUNCHER'
#!/bin/sh
# openfirmament-managed-launcher
root=$(CDPATH= cd -- "$(dirname -- "$0")/../lib/openfirmament" && pwd)
exec "$root/current/OpenFirmamentTerminal" "$@"
LAUNCHER
chmod 755 "$scratch/openfirmament"
ln -sfn "$version" "$root/current"
cp "$scratch/openfirmament" "$destination"
chmod 755 "$destination"
printf '\nInstalled: %s\nRun: %s\n' "$destination" "$destination"
printf 'No shell startup files were changed. Older versions remain in %s.\n' "$root"
