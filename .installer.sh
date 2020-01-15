#!/usr/bin/bash

sudo xargs apt install < ./.programs.system
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
