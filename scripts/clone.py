import argparse
import subprocess
from pathlib import Path

import pip


def import_or_install(package):
    try:
        __import__(package)
    except ImportError:
        pip.main(["install", package])


def main(repo_url: str, workspace_dir: str):
    from giturlparse import parse as gh_parse

    p = gh_parse(repo_url)
    if not p.valid:
        raise Exception(f"url was invalid! repo_url = {repo_url}")

    owner_dir_path = Path.home() / Path(workspace_dir) / Path(p.owner)
    owner_dir_path.mkdir(parents=True, exist_ok=True)

    try:
        res = subprocess.call(["git", "clone", repo_url], cwd=str(owner_dir_path))
        if res == 0:
            print("Clone done!")
    except Exception as e:
        print(f"clone failed. err={e}")


if __name__ == "__main__":
    import_or_install("giturlparse")

    parser = argparse.ArgumentParser(
        description="clone repos under workspace directory with owner name."
    )
    parser.add_argument("repo_url")

    args = parser.parse_args()
    repo_url = args.repo_url

    workspace_dir = "workspace"
    main(repo_url, workspace_dir)
