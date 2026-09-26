"""User preferences for the iTerm2 experience."""

from dataclasses import dataclass

import iterm2


@dataclass(frozen=True)
class Preferences:
    """Appearance and startup preferences managed by this project."""

    show_tab_bar_for_single_tab: bool = True
    startup_message: str = "Welcome to iTerm2! Your terminal setup is ready."

    async def install(self, terminal):
        """Apply app-wide iTerm2 preferences through the terminal connection."""
        await iterm2.async_set_preference(
            terminal,
            "HideTab",
            not self.show_tab_bar_for_single_tab,
        )
