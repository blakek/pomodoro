package main

import (
	"fmt"
	"time"

	"github.com/jessevdk/go-flags"
	"github.com/teddywing/go-notifier"
)

var arguments struct {
	CustomMinutes float64 `long:"custom" short:"c" description:"start a custom timer for given number of minutes" default:"25"`
	RunShortTimer bool    `long:"short" short:"s" description:"starts a timer for 5 minutes"`
	RunLongTimer  bool    `long:"long" short:"l" description:"starts a timer for 20 minutes"`
}

func printTime(time int) {
	minutes := time / 60
	seconds := time % 60

	fmt.Printf("\033[2K\r%v:%02v remaining", minutes, seconds)
}

func main() {
	var minutes float64

	flags.Parse(&arguments)

	if arguments.RunLongTimer {
		minutes = 20.0
	} else if arguments.RunShortTimer {
		minutes = 5.0
	} else {
		minutes = arguments.CustomMinutes
	}

	seconds := int(minutes * 60)

	for i := seconds; i > 0; i-- {
		printTime(i)
		time.Sleep(1 * time.Second)
	}

	// Print final newline
	fmt.Println()

	notification := notifier.Notification{
		Title:   "This is the title",
		Message: "This is the message",
	}

	systemNotifier, _ := notifier.NewNotifier()

	systemNotifier.DeliverNotification(notification)
}
