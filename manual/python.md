# Insatll pyenv and pipenv on Arch

```
$ sudo pacman -S --noconfirm python-pipenv
$ yay -S --noconfirm pyenv
```

# Install python through pyenv

```
$ pyenv install 3.6.0 # tensorflow doesn't work on version 3.7
$ pyenv versions
  system
    * 3.6.0 (set by /home/mike/apps/deep_learning/.python-version)
```

# If u wanna use specific python version in local

```
$ pyenv local 3.6.0
$ python --version
Python 3.6.0
```

# Specify python version of virtualenv which is used by pipenv

```
$ pipenv install --python 3.6
Virtualenv already exists!
Removing existing virtualenv…
Creating a virtualenv for this project…
Pipfile: /home/mike/apps/models/tutorials/image/imagenet/Pipfile
Using /home/mike/.pyenv/versions/3.6.0/bin/python3.6 (3.6.0) to create virtualenv…
⠙ Creating virtual environment...Using base prefix '/home/mike/.pyenv/versions/3.6.0'
New python executable in /home/mike/.local/share/virtualenvs/imagenet-qPLN_QUI/bin/python3.6
Also creating executable in /home/mike/.local/share/virtualenvs/imagenet-qPLN_QUI/bin/python
Installing setuptools, pip, wheel...done.
Running virtualenv with interpreter /home/mike/.pyenv/versions/3.6.0/bin/python3.6

✔ Successfully created virtual environment!
Virtualenv location: /home/mike/.local/share/virtualenvs/imagenet-qPLN_QUI
Creating a Pipfile for this project…
Pipfile.lock not found, creating…
Locking [dev-packages] dependencies…
Locking [packages] dependencies…
Updated Pipfile.lock (ca72e7)!
Installing dependencies from Pipfile.lock 
```

# Confirm python version

```
$ python --version
Python 3.7.3
$ pipenv run python --version
Python 3.6.0
$ pipenv shell # launch new shell
$ python --version
Python 3.6.0
```

# Install packages

```
$ pipenv install 
```

# Install Python linters 

```
$ pip install -U flake8 autopep8 black isort
```
