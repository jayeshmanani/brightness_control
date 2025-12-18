# 🌙 Screen Brightness Control Script (No sudo required)

A lightweight POSIX-compatible shell script for adjusting screen brightness using **xrandr**.  
Supports **up/down steps**, **exact percentages**, **automatic display detection**, and **state saving** — all **without sudo**.

---

## ✨ Features

- 🔍 **Auto-detects your active display**
- 🌗 **Increase or decrease brightness** in fixed steps  
  (`up` = +10%, `down` = –10%)
- 🎯 **Set exact brightness** (only accepts integers between **5–100**)
- 🔒 **Never sets brightness below 5%** (prevents black screen)
- 💾 **Stores last used brightness** in `~/.screen_brightness`
- 🧩 **100% POSIX-compatible** — works with `sh` or `bash`
- 🚫 **No sudo needed**

---

## 📦 Installation

1. Place the script wherever you like, for example:

    ```sh
    ~/brightness.sh
    ```

2. Make it executable:

    ```sh
    chmod +x ~/brightness.sh
    ```

3. (Optional) Add it to your PATH:

    ```sh
    sudo ln -s ~/brightness.sh /usr/local/bin/brightness
    ```

    Now you can simply type:

    ```sh
    brightness up
    ```

---

## 🚀 Usage

### 🔼 Increase brightness by 10%
```sh
./brightness.sh u
```
or
```
./brightness.sh u
```

### 🔽 Decrease brightness by 10%
```
./brightness.sh d
```
or
```
./brightness.sh down
```

### 🎯 Set brightness to an exact value (5–100)
```
./brightness.sh 30
```

### ❌ Invalid input examples (will be rejected)
```
./brightness.sh 0
./brightness.sh 200
./brightness.sh abc
```

The script validates your input and shows helpful error messages.
---
## 💡 How It Works

### 🔍 Auto-detection

The script finds your active display using:
```
xrandr | grep " connected"
```
You don’t need to hard-code HDMI-1, eDP-1, etc.

### 💾 State Saving
The last applied brightness is saved in:

```
~/.screen_brightness
```
This preserves correct “up”/“down” adjustments across reboots.

### 🔢 Brightness Mapping
Internal conversion:
```
30% → 0.30  
75% → 0.75  
100% → 1.00
```
This is passed directly to xrandr.

### 🔒 Safety Features
- Minimum brightness: 5%

- Maximum brightness: 100%

- Rejects:
    - Non-numeric input
    - Values < 5 or > 100
    - Negative numbers
    - Empty input

This prevents accidental black screens.

## 🧪 Examples
Dim the display:
```
brightness d
brightness d
```
or 
```
brightness down
```

Set comfortable brightness:

```
brightness 60
```

Brighten up:
```
brightness u
```
or 
```
brightness up
```

## 🛠 Requirements
-   ```xrandr```
-   ```bc```
-   A POSIX shell (```sh```, ```dash```, ```bash```, etc.)

All common Linux distributions include these tools.

## 📄 License
Free to use, modify, and share.