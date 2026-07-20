#!/usr/bin/env python3

import os
import re
import subprocess
import sys
import tarfile
import tempfile
import urllib.request
import xml.etree.ElementTree as ET

INSTALL_DIR = os.path.expanduser("~/.local/share/android-studio")
DESKTOP_FILE = os.path.expanduser("~/.local/share/applications/android-studio.desktop")
RELEASES_URL = "https://jb.gg/android-studio-releases-list.xml"


def is_installed():
    return os.path.isfile(os.path.join(INSTALL_DIR, "bin", "studio"))


def get_latest_stable_url():
    print("Fetching Android Studio releases list...")
    with urllib.request.urlopen(RELEASES_URL) as resp:
        xml_data = resp.read()

    root = ET.fromstring(xml_data)
    for item in root.iter("item"):
        channel = item.findtext("channel", "")
        if channel != "Release":
            continue
        for dl in item.iter("download"):
            url = dl.findtext("link", "")
            if "linux" in url and "arm" not in url and url.endswith(".tar.gz"):
                return url

    raise RuntimeError("Could not find stable Linux download URL")


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
        # strip top-level directory (android-studio/)
        prefix = members[0].name.split("/")[0] + "/"
        for member in members:
            member.path = member.path.removeprefix(prefix)
            tar.extract(member, INSTALL_DIR)


def write_desktop_file():
    content = f"""[Desktop Entry]
Version=1.0
Type=Application
Name=Android Studio
Exec={INSTALL_DIR}/bin/studio
Icon={INSTALL_DIR}/bin/studio.png
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-studio
"""
    os.makedirs(os.path.dirname(DESKTOP_FILE), exist_ok=True)
    with open(DESKTOP_FILE, "w") as f:
        f.write(content)


def install_scrcpy():
    print("Installing scrcpy...")
    subprocess.run(["sudo", "apt", "install", "-y", "scrcpy"], check=True)


def main():
    if is_installed():
        print("android-studio: already installed, skipping")
        return

    url = get_latest_stable_url()
    print(f"Latest stable: {url}")

    archive = download(url)
    try:
        extract(archive)
    finally:
        os.unlink(archive)

    write_desktop_file()
    print(f"Android Studio installed to {INSTALL_DIR}")

    install_scrcpy()


if __name__ == "__main__":
    main()
