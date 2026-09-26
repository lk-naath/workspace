"""Terminal appearance and startup presentation."""

from .preferences import Preferences


class TerminalUI:
    """iTerm2 extension for app preferences and session startup text."""

    def __init__(self, preferences: Preferences):
        self.preferences = preferences

    async def inject(self, session):
        """Inject startup presentation into the session provided by the plugin."""
        message = "[iTerm2 inject test] Python API is connected to this tab."
        await session.async_send_text(f"\r\n  {message}\r\n\r\n")
