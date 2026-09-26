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


class Tracker:
	"""Classify startup sessions and sessions created in new tabs."""

	def __init__(self, app):
		self.__known_tab_ids = {
			tab.tab_id
			for window in app.terminal_windows
			for tab in window.tabs
		}
		self.__startup_pending = True

	def is_startup(self, tab):
		"""Return True once for the active startup tab, when available."""
		if not self.__startup_pending or tab.tab_id not in self.__known_tab_ids:
			return False
		self.__startup_pending = False
		return True

	def is_new_tab(self, tab):
		"""Return True once for each tab created after tracking begins."""
		if tab.tab_id in self.__known_tab_ids:
			return False
		self.__known_tab_ids.add(tab.tab_id)
		return True


class Plugin:
	"""Install extensions and route startup and new-tab events."""

	def __init__(self):
		self.preferences = Preferences()
		self.extensions = [TerminalUI(self.preferences)]

	async def install(self, terminal):
		"""Install preferences, welcome the active tab, then watch new tabs."""
		await self.preferences.install(terminal)
		app = await iterm2.async_get_app(terminal)
		tracker = Tracker(app)

		startup_tab = next(
			(
				tab
				for window in app.terminal_windows
				for tab in window.tabs
				if tab.current_session is not None
			),
			None,
		)
		if startup_tab is not None and tracker.is_startup(startup_tab):
			for extension in self.extensions:
				await extension.on_startup(startup_tab.current_session, startup_tab)

		async with iterm2.NewSessionMonitor(terminal) as monitor:
			while True:
				session_id = await monitor.async_get()
				session = app.get_session_by_id(session_id)
				if session is None or session.tab is None:
					continue
				tab = session.tab
				if tracker.is_startup(tab):
					for extension in self.extensions:
						await extension.on_startup(session, tab)
				elif tracker.is_new_tab(tab):
					for extension in self.extensions:
						await extension.on_new_tab(session, tab)

plugin = Plugin()
iterm2.run_until_complete(plugin.install)
