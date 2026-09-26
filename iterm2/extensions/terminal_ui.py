"""Terminal appearance and startup presentation."""

from .preferences import Preferences


class TerminalUI:
    """iTerm2 extension for app preferences and once-per-tab welcome text."""

    def __init__(self, preferences: Preferences):
        self.preferences = preferences
        self._welcomed_tabs = set()

    async def on_startup(self, session, tab):
        """Welcome the active tab when iTerm2 starts."""
        await self._welcome(session, tab)

    async def on_new_tab(self, session, tab):
        """Welcome a newly created tab once."""
        await self._welcome(session, tab)

    async def _welcome(self, session, tab):
        if tab.tab_id in self._welcomed_tabs:
            return
        self._welcomed_tabs.add(tab.tab_id)
        message = self.preferences.startup_message
        await session.async_inject(f"\r\n  {message}\r\n\r\n".encode())
