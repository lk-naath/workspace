#!/usr/bin/env python3

import os
import sys
from enum import Enum, auto

import iterm2

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


class TabEvent(Enum):
	STARTUP = auto()
	NEW_TAB = auto()
	EXISTING_TAB = auto()
	UNKNOWN = auto()


class Tracker:
	def __init__(self, app):
		self.__app = app
		self.__existing_tab_ids = set()
		self.__startup_tab_id = None
		self.__startup_claimed = False
		self.startup_tab = None
		self.startup_event = TabEvent.UNKNOWN

	async def __aenter__(self):
		self.__existing_tab_ids = {
			tab.tab_id
			for window in self.__app.terminal_windows
			for tab in window.tabs
		}
		window = self.__app.current_window
		tab = window.current_tab if window else None
		if tab is not None and tab.current_session is not None:
			self.startup_tab = tab
			self.__startup_tab_id = tab.tab_id
			self.startup_event = self.classify(tab)
		return self

	async def __aexit__(self, exc_type, exc_value, traceback):
		self.__existing_tab_ids.clear()
		self.startup_tab = None
		return False

	def classify(self, tab):
		if tab is None or not tab.tab_id:
			return TabEvent.UNKNOWN
		if self.is_startup(tab):
			return TabEvent.STARTUP
		if self.is_new_tab(tab):
			return TabEvent.NEW_TAB
		return TabEvent.EXISTING_TAB

	def is_startup(self, tab):
		if tab is None or self.__startup_claimed or tab.tab_id != self.__startup_tab_id:
			return False
		self.__startup_claimed = True
		return True

	def is_new_tab(self, tab):
		if tab is None or not tab.tab_id:
			return False
		if tab.tab_id in self.__existing_tab_ids:
			return False
		self.__existing_tab_ids.add(tab.tab_id)
		return True


class Plugin:
	def __init__(self):
		self.preferences = Preferences()
		self.extensions = [TerminalUI(self.preferences)]

	async def install(self, terminal):
		await self.preferences.install(terminal)
		app = await iterm2.async_get_app(terminal)
		async with Tracker(app) as tracker:
			if tracker.startup_event is TabEvent.STARTUP:
				session = tracker.startup_tab.current_session
				for extension in self.extensions:
					await extension.on_startup(session, tracker.startup_tab)

			async with iterm2.NewSessionMonitor(terminal) as monitor:
				while True:
					session_id = await monitor.async_get()
					session = app.get_session_by_id(session_id)
					if session is None:
						continue
					tab = session.tab
					event = tracker.classify(tab)
					if event is TabEvent.NEW_TAB:
						for extension in self.extensions:
							await extension.on_new_tab(session, tab)

plugin = Plugin()
iterm2.run_until_complete(plugin.install)
