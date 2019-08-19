module notifier_mac

import os

struct Options {
	sound_name string
	text string
	title string
}

pub fn show_notification(options Options) {
	command := 'osascript -e \'display notification "${options.text}" with title "${options.title}" sound name "${options.sound_name}"\''

	os.system(command)
}
