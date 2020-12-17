package main

import (
	"fmt"
	"os"
	"time"

	"github.com/blakek/go-notifier"
	"github.com/jessevdk/go-flags"
)

var arguments struct {
	CustomTimer   string `long:"custom" short:"c" description:"start a custom timer for given number of minutes" default:"25m"`
	RunShortTimer bool   `long:"short" short:"s" description:"starts a timer for 5 minutes"`
	RunLongTimer  bool   `long:"long" short:"l" description:"starts a timer for 20 minutes"`
}

func clearCurrentLine() {
	fmt.Print("\033[2K\r")
}

func printTime(timeRemaining time.Duration) {
	clearCurrentLine()

	if timeRemaining <= 0 {
		fmt.Printf("Timer finished at %s\n", time.Now().Format(time.Kitchen))
	} else {
		fmt.Printf("%s remaining", timeRemaining.String())
	}
}

func main() {
	var duration time.Duration
	flags.Parse(&arguments)

	if arguments.RunLongTimer {
		duration = 20 * time.Minute
	} else if arguments.RunShortTimer {
		duration = 5 * time.Minute
	} else {
		var parseError error
		duration, parseError = time.ParseDuration(arguments.CustomTimer)

		if parseError != nil {
			fmt.Fprintln(os.Stderr, parseError)
			os.Exit(2)
		}

	}

	ticker := time.NewTicker(time.Second)
	timeRemaining := duration

	for range ticker.C {
		timeRemaining = (timeRemaining - time.Second).Round(time.Second)
		printTime(timeRemaining)

		if timeRemaining <= 0 {
			break
		}
	}

	notification := notifier.Notification{
		Title:   "Timer Finished",
		Message: fmt.Sprintf("Finished %s timer", duration.String()),
		Timeout: 15,
	}

	systemNotifier, _ := notifier.NewNotifier()
	systemNotifier.DeliverNotification(notification)

	// HACK: tries to deliver notification before exiting
	time.Sleep(time.Second)
}
