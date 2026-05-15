#!/usr/bin/env python3

import json
import os
import tarfile
import tempfile
import urllib.request

INSTALL_DIR = os.path.expanduser("~/.local/share/JetBrains/Toolbox/bin")
DESKTOP_FILE = os.path.expanduser("~/.local/share/applications/jetbrains-toolbox.desktop")
RELEASES_URL = "https://data.services.jetbrains.com/products/releases?code=TBA&latest=true&type=release"


def is_installed():
    return os.path.isfile(os.path.join(INSTALL_DIR, "jetbrains-toolbox"))


def get_latest_url():
    print("Fetching JetBrains Toolbox releases info...")
    with urllib.request.urlopen(RELEASES_URL) as resp:
        data = json.loads(resp.read())

    for release in data.get("TBA", []):
        downloads = release.get("downloads", {})
        link = downloads.get("linux", {}).get("link", "")
        if link.endswith(".tar.gz"):
            return link

    raise RuntimeError("Could not find Linux x86_64 download URL")


def download(url):
    tmp = tempfile.NamedTemporaryFile(suffix=".tar.gz", delete=False)
    print(f"Downloading {url} ...")

    def progress(count, block_size, total_size):
        if total_size > 0:
            pct = count * block_size * 100 // total_size
            print(f"\r  {pct}%", end="", flush=True)

    urllib.request.urlretrieve(url, tmp.name, reporthook=progress)
    print()
    return tmp.name


def extract(archive_path):
    os.makedirs(INSTALL_DIR, exist_ok=True)
    print(f"Extracting to {INSTALL_DIR} ...")
    with tarfile.open(archive_path) as tar:
        members = tar.getmembers()
        prefix = members[0].name.split("/")[0] + "/"
        for member in members:
            member.path = member.path.removeprefix(prefix)
            tar.extract(member, INSTALL_DIR)


def write_desktop_file():
    content = f"""[Desktop Entry]
Version=1.0
Type=Application
Name=JetBrains Toolbox
Exec={INSTALL_DIR}/jetbrains-toolbox
Icon={INSTALL_DIR}/jetbrains-toolbox.png
Categories=Development;
Terminal=false
StartupWMClass=jetbrains-toolbox
"""
    os.makedirs(os.path.dirname(DESKTOP_FILE), exist_ok=True)
    with open(DESKTOP_FILE, "w") as f:
        f.write(content)


def main():
    if is_installed():
        print("jetbrains-toolbox: already installed, skipping")
        return

    url = get_latest_url()
    print(f"Latest stable: {url}")

    archive = download(url)
    try:
        extract(archive)
    finally:
        os.unlink(archive)

    write_desktop_file()
    print(f"JetBrains Toolbox installed to {INSTALL_DIR}")


if __name__ == "__main__":
    main()
