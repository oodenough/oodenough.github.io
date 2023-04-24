---
categories: [w install]
tags: [archlinux, oh-my-zsh, install]
---

```bash
git clone https:aur.archlinux.org/yay.git #==> install yay(Yet Another Yoghurt the aur helper)
cd yay
makepkg -si 
yay -S(yayn) ttf-dejavu ttf-meslo-nerd-font-powerlevel10k #==> install font
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
#==> install the theme 
```
then edit `.zshrc` add `powerlevel10k/powerlevel10k` to `THEME`
execute `source .zshrc` to configure p10k theme

```bash
p10k configure #==> reset powerlevel10k
git -C ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k pull #==> update the theme
```

