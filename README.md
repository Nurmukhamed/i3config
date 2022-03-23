# English - Small description 

It's been a year since I switched to linux on my computer and laptop. The operating system is [Ubuntu 20.04](https://releases.ubuntu.com/20.04/), the window manager is [i3](https://i3wm.org/).

## Rust
A number of [rust programs](https://www.linux.org.ru/forum/talks/15282317) are also used

* [Alacritty](https://github.com/jwilm/alacritty)
* [bat](https://github.com/sharkdp/bat)
* [broot](https://dystroy.org/broot/)
* [dust](https://github.com/bootandy/dust)
* [exa](https://the.exa.website/)
* [rg](https://github.com/BurntSushi/ripgrep)
* [starship](https://starship.rs/)
* [i3status-rust](https://github.com/greshake/i3status-rust)
* [zellij](https://github.com/zellij-org/zellij)

For convenience, I created a Docker image. Packages are assembled inside the image and laid out in ./packages

```
cd ./docker
mkdir ./packages
bash ./run.sh
ls -al ./packages
```

## Fonts 
Fonts used
[nerd fonts](https://www.nerdfonts.com/)
[JetBrains Mono](https://www.jetbrains.com/ru-ru/lp/mono/)

## Ansible

**TODO**
To facilitate reuse, I wrote ansible playbook.

### Prepare

``` 
sudo apt update -y
sudo apt install python3-pip python3-venv

mkdir ~/python3

python3 -m venv ~/python3/ansible
activate ~/python3/ansible/bin/activate
python3 -m pip install pip --upgrade
python3 -m pip install ansible ansible-lint

```

### Run playbook
```
cd ~/git/i3config
ansible-playbook ./ansible-playbook/main.yaml

```
# Russian - Короткое описание

Уже год как перешел на linux на своем компьютере и ноутбуке. Операционная система [Ubuntu 20.04](https://releases.ubuntu.com/20.04/), оконный менеджер - [i3](https://i3wm.org/).

## Rust
Также используются ряд [программ на rust](https://www.linux.org.ru/forum/talks/15282317)

* [Alacritty](https://github.com/jwilm/alacritty)
* [bat](https://github.com/sharkdp/bat)
* [broot](https://dystroy.org/broot/)
* [dust](https://github.com/bootandy/dust)
* [exa](https://the.exa.website/)
* [rg](https://github.com/BurntSushi/ripgrep)
* [starship](https://starship.rs/)
* [i3status-rust](https://github.com/greshake/i3status-rust)
* [zellij](https://github.com/zellij-org/zellij)

Для удобства создал Docker-образ. Внутри образа происходит сборка пакетов и выкладывается в ./packages

```
cd ./docker
mkdir ./packages
bash ./run.sh
ls -al ./packages
```

## Фонты
[nerd fonts](https://www.nerdfonts.com/)
[JetBrains Mono](https://www.jetbrains.com/ru-ru/lp/mono/)

## Ansible

**TODO**

Для облегчения повторного использования написал ansible плейбук.

### Подготовка окружения

``` 
sudo apt update -y
sudo apt install python3-pip python3-venv

mkdir ~/python3

python3 -m venv ~/python3/ansible
activate ~/python3/ansible/bin/activate
python3 -m pip install pip --upgrade
python3 -m pip install ansible ansible-lint

```

### Запуск плейбука
```
cd ~/git/i3config
ansible-playbook ./ansible-playbook/main.yaml
```

![](https://i.imgur.com/khiyp9L.png)
