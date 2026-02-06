#!/bin/sh
VERSION_FILE="$HOME/waterfox/waterfox-version.cwl"
RELEASES_URL="https://cdn.waterfox.com/waterfox/releases"
INSTALL_DIR="$HOME/waterfox"
WATERFOX_BIN="$INSTALL_DIR/waterfox/waterfox"
LOCAL_BIN="$HOME/.local/bin"
DESKTOP_FILE="$HOME/.local/share/applications/waterfox.desktop"

echo "Checking latest Waterfox version..."

# --- FETCH NEWEST VERSION ---

NEWEST_VERSION=$(curl -s "$RELEASES_URL/" \
    | sed -n 's#.*/waterfox/releases/\([^/]*\)/.*#\1#p' \
    | grep -E '^[0-9.]+$' \
    | sort -V \
    | tail -n 1)

if [ -z "$NEWEST_VERSION" ]; then
    echo "Error: could not determine newest Waterfox version"
    exit 1
fi

echo "Newest available Waterfox version: $NEWEST_VERSION"

# --- FETCH INSTALLED VERSION ---

if [ -f "$VERSION_FILE" ]; then
    INSTALLED_VERSION=$(cat "$VERSION_FILE")
else
    INSTALLED_VERSION=0
fi

echo "Installed Waterfox version: $INSTALLED_VERSION"


# --- COMPARE ---

if [ "$INSTALLED_VERSION" = "$NEWEST_VERSION" ]; then
    echo "Waterfox is already up to date."
    exit 0
fi

# --- DOWNLOAD ---

echo "Installing Waterfox $NEWEST_VERSION..."
mkdir -p "$INSTALL_DIR"

TARBALL="waterfox-$NEWEST_VERSION.tar.bz2"
DOWNLOAD_URL="$RELEASES_URL/$NEWEST_VERSION/Linux_x86_64/$TARBALL"

wget -O "$INSTALL_DIR/$TARBALL" "$DOWNLOAD_URL" || exit 1

# --- EXTRACT ---

echo "$NEWEST_VERSION" > "$HOME/waterfox/waterfox-version.cwl"

echo "Extracting..."
tar -xjf "$INSTALL_DIR/$TARBALL" -C "$INSTALL_DIR" || exit 1

# --- SYMLINK ---
rm -f "$HOME"/waterfox/"waterfox-$NEWEST_VERSION.tar.bz2"
mkdir -p "$LOCAL_BIN"
ln -sf "$WATERFOX_BIN" "$LOCAL_BIN/waterfox"

# --- PATH FIX ---

echo "Checking PATH..."

if ! echo "$PATH" | tr ':' '\n' | grep -qx "$LOCAL_BIN"; then
    echo "~/.local/bin not in PATH"

    if [ -f "$HOME/.bashrc" ] && ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.bashrc"; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
        echo "Added ~/.local/bin to ~/.bashrc"
    fi

    export PATH="$LOCAL_BIN:$PATH"
    echo "PATH updated for current session"
else
    echo "~/.local/bin already in PATH"
fi

# --- DESKTOP ENTRY ---

mkdir -p "$(dirname "$DESKTOP_FILE")"

cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Name=Waterfox
Comment=Web Browser
Exec=$WATERFOX_BIN
Icon=$INSTALL_DIR/waterfox/browser/chrome/icons/default/default128.png
Terminal=false
Type=Application
Categories=Network;WebBrowser;
EOF

echo
echo "you should be able to open it now via command 'waterfox' "
echo "Waterfox $NEWEST_VERSION installed successfully."
echo "IMPORTANT: open a NEW terminal or run:"
echo "  source ~/.bashrc"
echo "Then you can use: waterfox"
