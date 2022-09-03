"""
Usage: 
	pip install fabric3
	fab -H xxx test
	fab test
"""
from fabric.api import env, run
from fabric.decorators import task
# from fabric.contrib.project import rsync_project

env.hosts = ["xxx"]  # name of ssh hostname
env.use_ssh_config = True
env.ssh_config_path = "/home/mike/.ssh/config"

@task
def test():
    run("touch fab.txt")
