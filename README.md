# pomodoro

> A simple terminal-based pomodoro timer

The point of pomodoro timers is to help you focus and save time. Unfortunately,
I found myself wasting time with other tools. To fix that, I spent a few minutes
making a simple timer for use in the terminal.

## Usage

Here are some common ways to use the timer:

**Start a 25 minute timer:**

```bash
pomodoro
```

**Start a short (5 minute) break:**

```bash
pomodoro -s
```

**Start a short (20 minute) break:**

```bash
pomodoro -l
```

**Start a 3 minute timer for tea:**

```bash
pomodoro -c 3
```

If you want to see more details, here's all options at the time of writing:

- `-c time, --custom time`: start a custom timer (time in minutes)
- `-h, --help`: show the help text
- `-l, --long`: starts the timer for 20 minutes
- `-s, --short`: starts the timer for 5 minutes

**Remember:** you can always run `pomodoro --help` to get the latest list of
options available.

## Install

You can install using [Homebrew](https://brew.sh/) or manually build from source:

### Install with Homebrew

Running this in your terminal adds [my tap](https://github.com/blakek/homebrew-blakek) and installs the package:

```bash
brew tap blakek/blakek && brew install blakek/blakek/pomodoro
```

### Build from Source

First, either [clone this
repo](https://help.github.com/articles/cloning-a-repository/) or [download a zip
file](https://github.com/blakek/pomodoro/archive/master.zip).

Then, in a terminal open to this project's directory, run make:

```
$ go build
```

## Updating

If you installed using Homebrew, you can use the normal `brew upgrade` process.

The easiest way to update from a source build is to re-run the install
directions. If you keep the repository, you can occasionally run
`git pull && make install` to build using the latest changes.

## License

MIT
