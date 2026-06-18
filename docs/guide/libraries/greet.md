# Greet

Library and CLI greeter for [greetd](https://sr.ht/~kennylevinsen/greetd/).

## Usage

You can browse the [Greet reference](https://docs.astal.dev/greet).

### CLI

The `astal-greet` CLI itself is a greeter.

```sh
astal-greet --help
```

You can configure greetd to enter a shell where you can test the CLI.

```toml
[default_session]
command = "bash"
```

### Library

The library exposes a [`login`](https://docs.astal.dev/greet/func.login.html)
(and [`login_with_env`](https://docs.astal.dev/greet/func.login_with_env.html))
function that creates a session, posts the password, and starts the session in
one go. It should work for most use cases, but as the greetd documentation
mentions, PAM might send multiple authentication requests, in which case this
function will fail.

:::code-group

```js [<i class="devicon-javascript-plain"></i> JavaScript]
import Greet from "gi://AstalGreet"

Greet.login("username", "password", "compositor", (_, res) => {
    try {
        Greet.login_finish(res)
    } catch (err) {
        printerr(err)
    }
})
```

```py [<i class="devicon-python-plain"></i> Python]
from gi.repository import AstalGreet as Greet

def callback(_, res):
    try
        Greet.login_finish(res)
    except Exception as e:
        print(e)

Greet.login("username", "password", "compositor", callback)
```

```lua [<i class="devicon-lua-plain"></i> Lua]
local Greet = require("lgi").require("AstalGreet")

Greet.login("username", "password", "compositor", function (_, res)
    local err = Greet.login_finish(res)
    if err ~= nil then
        print(err)
    end
end)
```

```vala [<i class="devicon-vala-plain"></i> Vala]
try {
    yield AstalGreet.login("username", "password", "compositor");
} catch (Error err) {
    printerr(err.message);
}
```

:::

In cases where you need to handle multiple PAM requests, AstalGreet provides a
[`Greeter`](https://docs.astal.dev/greet/class.Greeter) helper object.

:::code-group

```js [<i class="devicon-javascript-plain"></i> JavaScript]
import Greet from "gi://AstalGreet"

const greeter = new Greet.Greeter()
const username = "username" // prompt the user for a username

greeter.connect("visible-request", (_, message) => {
    const response = "" // prompt the user for input
    greeter.post_auth(response)
})

greeter.connect("secret-request", (_, message) => {
    const response = "" // prompt the user for a secret input
    greeter.post_auth(response)
})

greeter.connect("info-message", (_, message) => {
    // print the message
})

greeter.connect("error-message", (_, message) => {
    // print the message
})

greeter.connect("cancelled", (_, error) => {
    // restart the session
    greeter.create_session(username)
})

greeter.connect("authenticated", () => {
    const cmd = ["compositor", "--flags"]
    const env = ["KEY1=VALUE", "KEY2=VALUE"]

    greeter.start_session(cmd, env, (_, res) => {
        greeter.start_session_finish(res)
        // terminate the greeter process
    })
})

// start the login flow
greeter.create_session(username)
```

```py [<i class="devicon-python-plain"></i> Python]
from gi.repository import AstalGreet as Greet

greeter = Greet.Greeter()
username = "username" # prompt the user for a username

def on_visible_request(_, message):
    response = "" # prompt the user for input
    greeter.post_auth(response)

def on_secret_request(_, message):
    response = "" # prompt the user for a secret input
    greeter.post_auth(response)

def on_info_message(_, message):
    # print the message
    pass

def on_error_message(_, message):
    # print the message
    pass

def on_cancelled(_, error):
    # restart the session
    greeter.create_session(username)

def on_authenticated(_):
    cmd = ["compositor", "--flags"]
    env = ["KEY1=VALUE", "KEY2=VALUE"]

    def callback(_, res):
        greeter.start_session_finish(res)
        # terminate the greeter process

    greeter.start_session(cmd, env, callback)

greeter.connect("visible-request", on_visible_request)
greeter.connect("secret-request", on_secret_request)
greeter.connect("info-message", on_info_message)
greeter.connect("error-message", on_error_message)
greeter.connect("cancelled", on_cancelled)
greeter.connect("authenticated", on_authenticated)

# start the login flow
greeter.create_session(username)
```

```lua [<i class="devicon-lua-plain"></i> Lua]
local Greet = require("lgi").require("AstalGreet")

local greeter = Greet.Greeter()
local username = "username" -- prompt the user for a username

greeter.on_visible_request = function(_, message)
    local response = "" -- prompt the user for input
    greeter:post_auth(response)
end

greeter.on_secret_request = function(_, message)
    local response = "" -- prompt the user for a secret input
    greeter:post_auth(response)
end

greeter.on_info_message = function(_, message)
    -- print the message
end

greeter.on_error_message = function(_, message)
    -- print the message
end

greeter.on_cancelled = function(_, error)
    -- restart the session
    greeter:create_session(username)
end

greeter.on_authenticated = function()
    local cmd = { "compositor", "--flags" }
    local env = { "KEY1=VALUE", "KEY2=VALUE" }

    greeter:start_session(cmd, env, function(_, res)
        greeter:start_session_finish(res)
        -- terminate the greeter process
    end)
end

-- start the login flow
greeter:create_session(username)
```

```vala [<i class="devicon-vala-plain"></i> Vala]
var greeter = new AstalGreet.Greeter();
string username = "username"; // prompt the user for a username

greeter.visible_request.connect((message) => {
    string response = ""; // prompt the user for input
    greeter.post_auth(response);
});

greeter.secret_request.connect((message) => {
    string response = ""; // prompt the user for a secret input
    greeter.post_auth(response);
});

greeter.info_message.connect((message) => {
    // print the message
});

greeter.error_message.connect((message) => {
    // print the message
});

greeter.cancelled.connect((error) => {
    // restart the session
    greeter.create_session(username);
});

greeter.authenticated.connect(() => {
    string[] cmd = { "compositor", "--flags" };
    string[] env = { "KEY1=VALUE", "KEY2=VALUE" };

    greeter.start_session.begin(cmd, env, (_, res) => {
        greeter.start_session.end(res);
        // terminate the greeter process
    });
});

// start the login flow
greeter.create_session(username);
```

:::

## Installation

1. install dependencies

    :::code-group

    ```sh [<i class="devicon-archlinux-plain"></i> Arch]
    sudo pacman -Syu meson vala valadoc json-glib gobject-introspection
    ```

    ```sh [<i class="devicon-fedora-plain"></i> Fedora]
    sudo dnf install meson vala valadoc json-glib-devel gobject-introspection-devel
    ```

    ```sh [<i class="devicon-ubuntu-plain"></i> Ubuntu]
    sudo apt install meson valac valadoc libjson-glib-dev gobject-introspection
    ```

    :::

    ::: info

    Although `greetd` is not a direct build dependency, it should be
    self-explanatory that the daemon is required to be available at runtime.

    :::

2. clone repo

    ```sh
    git clone https://github.com/aylur/astal.git
    cd astal/lib/greet
    ```

3. install

    ```sh
    meson setup build
    meson install -C build
    ```
