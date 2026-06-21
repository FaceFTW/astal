# Mpris

Library and CLI tool for interacting and monitoring media players exposing an
mpris interface through dbus.

An alternative for [playerctl](https://github.com/altdesktop/playerctl) that
better integrates with astal.

## Usage

You can browse the [Mpris reference](https://docs.astal.dev/mpris).

### CLI

```sh
astal-mpris --help
```

### Library

:::code-group

```js [<i class="devicon-javascript-plain"></i> JavaScript]
import Mpris from "gi://AstalMpris"

const spotify = Mpris.Player.new("spotify")

if (spotify.available) print(spotify.title)
```

```py [<i class="devicon-python-plain"></i> Python]
from gi.repository import AstalMpris as Mpris

spotify = Mpris.Player.new("spotify")

if spotify.get_available():
    print(spotify.get_title())
```

```lua [<i class="devicon-lua-plain"></i> Lua]
local Mpris = require("lgi").require("AstalMpris")

local spotify = Mpris.Player.new("spotify")

if spotify.available then
    print(spotify.title)
end
```

```vala [<i class="devicon-vala-plain"></i> Vala]
var spotify = AstalMpris.Player.new("spotify")

if (spotify.available) print(spotify.title);
```

:::

## Installation

1. install dependencies

    :::code-group

    ```sh [<i class="devicon-archlinux-plain"></i> Arch]
    sudo pacman -Syu meson vala valadoc json-glib gobject-introspection gdk-pixbuf2 libsoup3
    ```

    ```sh [<i class="devicon-fedora-plain"></i> Fedora]
    sudo dnf install meson vala valadoc json-glib-devel gobject-introspection-devel gdk-pixbuf2-devel libsoup3-devel
    ```

    ```sh [<i class="devicon-ubuntu-plain"></i> Ubuntu]
    sudo apt install meson valac valadoc libjson-glib-dev gobject-introspection libgdk-pixbuf-2.0-dev libsoup-3.0-dev
    ```

    :::

2. clone repo

    ```sh
    git clone https://github.com/aylur/astal.git
    cd astal/lib/mpris
    ```

3. install

    ```sh
    meson setup build
    meson install -C build
    ```
