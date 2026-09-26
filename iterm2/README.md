# iTerm2 terminal configuration

This iTerm2 Python API package manages terminal appearance and startup presentation:

- Keep the tab bar visible when a window has one tab.
- Print a welcome message into the first available session at iTerm2 startup.

The tab bar setting is app-wide. These scripts do not create or modify profiles.

## Project structure

```text
iterm2/
├── plugin.py                 # Single iTerm2 AutoLaunch entry point
├── extensions/
│   ├── preferences.py        # User-facing preferences
│   └── terminal_ui.py        # Terminal appearance and startup behavior
└── loader.sh                 # Installs or updates the plugin and extensions
```

The workspace-level `utils.sh` provides the reusable `confirm_delete` helper
used by project loaders before replacing existing paths.

`plugin.py` is the only file that starts the iTerm2 API loop. Its
`Plugin.install(terminal)` applies preferences and selects a session, then calls
`Plugin.inject(session)`. Extensions implement `install(terminal)` or
`inject(session)` for the work they own.

## Install

1. In iTerm2, enable **Settings > General > Magic > Enable Python API**.
2. From this repository, run:

   ```sh
   make setup iterm2
   ```

3. Restart iTerm2. AutoLaunch contains only the runnable `workspace.py` entry
   point. Its `extensions/` package is installed outside the Scripts folder at
   `~/Library/Application Support/iTerm2/Workspace/extensions`. Look for
   “Welcome to iTerm2! Your terminal setup is ready.” in the first available
   terminal session.

After changing the settings or feature code, rerun `make setup iterm2` to update
the installed files, then restart iTerm2.

The workspace `setup.sh` installs iTerm2 with Homebrew when available, then
runs this project's `loader.sh` to install `workspace.py` and its `extensions/`
package. The workspace Makefile owns the workspace root and default install paths. You can
override `ITERM2_AUTOLAUNCH_DIR` when installing to a different AutoLaunch
directory.

To restore automatic hiding when there is one tab, set
`show_tab_bar_for_single_tab` to `False` in `Preferences` in
`extensions/preferences.py`. Change `startup_message` there to customize the message.

See the [iTerm2 Python API script guide](https://iterm2.com/python-api/tutorial/running.html)
and [preference API](https://iterm2.com/python-api/preferences.html).
