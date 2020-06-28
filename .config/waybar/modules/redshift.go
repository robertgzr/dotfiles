// usage:
// go build -o waybar-redshift redshift.go
package main

import (
	"encoding/json"
	"fmt"
	"os"
	"os/exec"
	"os/signal"
	"strings"

	. "syscall"
)

const (
	ICON = ""
)

func main() {
	var (
		update = make(chan os.Signal, 1)
		cancel = make(chan os.Signal, 1)
	)
	signal.Notify(update, SIGUSR1, SIGUSR2, SIGHUP)
	signal.Notify(cancel, SIGTERM, SIGINT)

	// could use golang.org/x/sys/unix.Prctl here
	// but I want to avoid the dependency
	if _, _, e := Syscall6(SYS_PRCTL,
		uintptr(PR_SET_PDEATHSIG),
		uintptr(SIGTERM),
		0, 0, 0, 0); e != 0 {
		os.Exit(1)
	}
	// if err := Prctl(PR_SET_PDEATHSIG,
	// 		SIGTERM,
	// 		0, 0, 0); err != nil {
	// 	fmt.Fprintln(os.Stderr, err)
	// 	os.Exit(1)
	// }

	lookup()
	for {
		select {
		case sig := <-update:
			switch sig {
			case SIGUSR1:
				// redshift off
				printJson("day", "day", ICON)
			case SIGUSR2:
				// redshift on
				printJson("night", "night", ICON)
			case SIGHUP:
				lookup()
			}
		case <-cancel:
			fmt.Fprintln(os.Stderr, "bye")
			os.Exit(0)
		}
	}
}

func printJson(class, tooltip, text string) {
	_ = json.NewEncoder(os.Stdout).Encode(map[string]string{
		"class":   class,
		"tooltip": "redshift: " + tooltip,
		"text":    text,
	})
}

func lookup() {
	b, err := exec.Command("redshift", "-p").Output()
	if err != nil {
		return
	}
	fds := strings.Fields(string(b))
	for idx, f := range fds {
		if f == "Period:" {
			fds = fds[idx+1:]
			break
		}
	}
	switch fds[0] {
	case "Night":
		printJson("night", "night", ICON)
	case "Transition":
		printJson("night", "transition", ICON)
	case "Day":
		printJson("day", "day", ICON)
	}
}
