import notifier_mac
import os
import time

struct Arguments {
	minutes f32
	show_help bool
}

fn print_time(time i64) {
	minutes := int(time / 60)
	seconds := time % 60

	print('\e[2K\r${minutes}:${seconds:02d} remaining')

	// Don't optimize output timing; print immediately.
	C.fflush(stdout)
}

fn show_help() {
	println('Usage: pomodoro [options]')
	println('')
	println('Examples:')
	println('  Start a standard pomodoro timer for 25 minutes:')
	println('	 pomodoro')
	println('  Start a short (5 minute) break:')
	println('	 pomodoro -s')
	println('  Start a 3 minute timer for tea:')
	println('	 pomodoro -c 3')
	println('')
	println('Options:')
	println('  -c time, --custom time  start a custom timer (time in minutes)')
	println('  -h, --help              show this help text')
	println('  -l, --long              starts the timer for 20 minutes')
	println('  -s, --short             starts the timer for 5 minutes')
}

fn parse_arguments(args []string, defaultValues Arguments) Arguments {
	if args.len == 0 {
		return defaultValues
	}

	arg := args[0]

	if arg in ['-c', '--custom'] {
		return parse_arguments(
			args.slice(2, args.len),
			{ defaultValues | minutes: args[1].f32()  }
		)
	}

	if arg in ['-h', '--help'] {
		return parse_arguments(
			args.slice(1, args.len),
			{ defaultValues | show_help: true }
		)
	}

	if arg in ['-l', '--long'] {
		return parse_arguments(
			args.slice(1, args.len),
			{ defaultValues | minutes: 20 }
		)
	}

	if arg in ['-s', '--short'] {
		return parse_arguments(
			args.slice(1, args.len),
			{ defaultValues | minutes: 5 }
		)
	}

	println('Unknown argument ${arg}')
	exit(1)
}

fn main() {
	// Get arguments
	arguments := parse_arguments(
		os.args.slice(1, os.args.len),
		Arguments {
			minutes: 25
			show_help: false
		}
	)

	// If help specified, show help and exit
	if arguments.show_help {
		show_help()
		exit(0)
	}

	// Take in minutes for easier typing, but use seconds so we know how much
	// time is left
	seconds := int(arguments.minutes * 60)

	for i := seconds; i > 0; i-- {
		print_time(i)
		time.sleep(1)
	}

	notification_minutes := seconds / 60
	notification_seconds := seconds % 60

	notification_options := notifier_mac.Options {
		sound_name: 'default',
		text: 'Finished ${notification_minutes}min ${notification_seconds:d}s timer'
		title: 'Pomodoro'
	}

	notifier_mac.show_notification(notification_options)

	// Print extra newline so next command is on a new line
	println('')
}
