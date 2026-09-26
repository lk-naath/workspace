#!/usr/bin/env python3

"""Single iTerm2 entry point and extension lifecycle coordinator."""

import iterm2
import os
import sys

# Keep supporting modules outside AutoLaunch, which treats entries there as
# scripts. This location is stable even when the workspace checkout moves.
support_dir = os.path.join(
	os.path.expanduser("~"),
	"Library",
	"Application Support",
	"iTerm2",
	"Workspace",
)
sys.path.insert(0, support_dir)

from extensions.preferences import Preferences
from extensions.terminal_ui import TerminalUI


class Plugin:
	"""Install extensions and inject the first available terminal session."""

	def __init__(self):
		self.preferences = Preferences()
		self.extensions = [TerminalUI(self.preferences)]

	async def install(self, terminal):
		"""Install extension preferences, then inject the first session."""
		await self.preferences.install(terminal)

		app = await iterm2.async_get_app(terminal)
		for window in await app.async_get_windows():
			for tab in await window.async_get_tabs():
				sessions = await tab.async_get_sessions()
				if sessions:
					await self.inject(sessions[0])
					return

	async def inject(self, session):
		"""Pass the active session to each extension that handles sessions."""
		for extension in self.extensions:
			await extension.inject(session)


plugin = Plugin()
iterm2.run_until_complete(plugin.install)

