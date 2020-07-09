# Ninja Kiwi Archive Rich Presence

[![pypresence](https://img.shields.io/badge/using-pypresence-00bb88.svg?style=for-the-badge&logo=discord&logoWidth=20)](https://github.com/qwertyquerty/pypresence)

## Installation

First, clone the repository.

```cmd
git clone https://www.github.com/yolodude25/ninja-kiwi-archive-rich-presence
```

Then, install the required modules.

```cmd
cd ninja-kiwi-archive-rich-presence
```

```cmd
pip install -r requirements.txt
```

## Config

The [config](config.ini.example) allows you to change what is displayed on your rich presence.

### Available Values

- `{game_hf}`: Name of game (e.g. "Bloons TD 5")
- `{version_hf}`: Image key of game. (e.g. "bloonstd5")
- `{icon}`: Image key of Ninja Kiwi Archive Icon.

## Usage

Make a copy of [`config.ini.example`](config.ini.example) and remove the `.example`, then [edit it](#config) if you want.

Run `presence.py`.
