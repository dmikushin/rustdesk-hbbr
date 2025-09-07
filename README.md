# RustDesk HBBR (Static Build)

This is a stripped-down version of RustDesk HBBR configured for static compilation.

## About

HBBR (RustDesk Relay Server) is responsible for:
- Relaying encrypted data between RustDesk clients
- Handling NAT traversal when direct peer-to-peer connection is not possible
- Runs on port 21117 by default

## Building

### Linux (using musl for static linking)
```bash
# Install musl target
rustup target add x86_64-unknown-linux-musl

# Build static binary
cargo build --release --target x86_64-unknown-linux-musl
```

### Windows
```bash
# For MinGW
cargo build --release --target x86_64-pc-windows-gnu

# For MSVC
cargo build --release --target x86_64-pc-windows-msvc
```

### macOS
```bash
cargo build --release
```

The compiled binary will be in `target/<target>/release/hbbr`

## Usage

```bash
./hbbr -h
```

Common options:
- `-p, --port <PORT>`: Listen on port (default: 21117)
- `-k, --key <KEY>`: Key for encryption (must match the key used by clients and hbbs)

## Systemd Service

A systemd service file is included in `systemd/rustdesk-hbbr.service`. To install:

```bash
sudo cp systemd/rustdesk-hbbr.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable rustdesk-hbbr
sudo systemctl start rustdesk-hbbr
```

## Configuration

The relay server works in conjunction with HBBS (ID/Rendezvous server). Make sure:
- Both HBBS and HBBR use the same encryption key (`-k` parameter)
- Port 21117 is open in your firewall for TCP/UDP traffic
- The server has sufficient bandwidth for relaying client traffic

## License

Licensed under the same terms as the original RustDesk project.


