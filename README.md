# RVLoader-LMV

> A fork of [RVLoader](https://github.com/Aurelio92/RVLoader) adding animated splash screens and multi-theme UI support — each theme brings its own look, music, and sound effects inspired by iconic Nintendo interfaces.

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Based on RVLoader](https://img.shields.io/badge/Based%20on-RVLoader-orange.svg)](https://github.com/Aurelio92/RVLoader)
[![Platform: Wii](https://img.shields.io/badge/Platform-Wii-lightgrey.svg)]()

---

##  What's new in LMV

| Feature | Description |
|---|---|
| 🎬 Animated splash screen | Per-theme intro animation plays on boot |
| 🎨 Theme system | Switch between Wii, Wii U, DSi and 3DS styles |
| 🎵 Background music | Each theme has its own looping background track |
| 🔊 Sound effects | Navigation, launch and cancel sounds per theme |
| 🔧 Same core | All original RVLoader features are preserved |

---

## 🎨 Available themes

###  Wii
Classic Wii System Menu look — channel grid, bubbly icons, soft blue tones.

###  Wii U
GamePad-inspired layout with flat design, dark background and smooth transitions.

###  DSi
Faithful recreation of the Nintendo DSi Menu — bouncy bubble icons, pastel sky gradient and DSi-style sound effects.

###  3DS
Home Menu style with a dark starfield, hexagonal grid and 3DS UI sounds.

---

## 📁 Theme structure

Themes live in `/rvloader/themes/<theme_name>/` on your SD/USB card.

```
/rvloader/
  themes/
    dsi/
      theme.xml
      scripts/
        background.lua
        gamesview.lua
        bgmusic.lua
        ...
      assets/
        background.png
        icon_frame.png
        ...
    wii/
    wiiu/
    3ds/
  music/
    dsi/  bgmusic.mp3
    wii/  bgmusic.mp3
    wiiu/ bgmusic.mp3
    3ds/  bgmusic.mp3
  sounds/
    dsi/  select.mp3  launch.mp3  back.mp3
    wii/  ...
    wiiu/ ...
    3ds/  ...
```

> **Note:** Music and sound files are **not included** in this repository for copyright reasons.  
> You must supply your own MP3 files and place them in the paths above.

---

## 🚀 Installation

1. Build RVLoader-Nexus (see [Build](#build)) or grab a prebuilt release.
2. Copy `driveRoot/` contents to the root of your SD/USB.
3. Add your music/sound files (see structure above).
4. Launch via the Homebrew Channel.

---

## 🔨 Build

### Prerequisites

Install [devkitPro](https://devkitpro.org/wiki/Getting_Started) with the following packages:

```bash
(dkp-)pacman -S wii-dev libfat-ogc ppc-mxml ppc-libpng ppc-freetype ppc-zlib ppc-bzip2
```

### Compile

```bash
git clone https://github.com/Lamondille/RVLoader-LMV
cd RVLoader-LMV
make
```

Clean build artifacts:

```bash
make clean
```

Output: `driveRoot/apps/RVLoader/boot.dol`

---

## 🤝 Credits

- **[Aurelio92](https://github.com/Aurelio92)** and all RVLoader contributors — original loader, all core functionality
- Theme Lua scripts and splash screen system — RVLoader-Nexus contributors

---

## 📄 License

This project is licensed under the **GNU General Public License v3.0** — see [LICENSE](LICENSE) for details.

This is a fork of [RVLoader](https://github.com/Aurelio92/RVLoader) by Aurelio92, also distributed under GPL-3.0.
