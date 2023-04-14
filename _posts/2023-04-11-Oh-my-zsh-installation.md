---
categories: install_config_usage default
tags: [oh-my-zsh]
---

* install zsh
```bash
sudo apt-get install zsh
chsh -s $(which zsh)
```

* install oh-my-zsh
```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
* install syntax highlighting plugin
```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

* install auto-suggestions plugin
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

* config the plugin in ~/.zshrc
```bash
plugins={git vi-mode zsh-syntax-highlighting}
```
