PREFIX ?= /usr/local/bin
V ?= v

all: pomodoro

clean:
	$(RM) -r .*.dSYM
	$(RM) .vrepl*
	$(RM) .*.

# Moves the build binary to the installation prefix
install: pomodoro
	mv -i `pwd`/pomodoro ${PREFIX}/pomodoro

# Makes the pomodoro executable
pomodoro:
	${V} -prod -o pomodoro pomodoro.v
	@echo "Successfully built pomodoro"

# Alternate to install. Symlinks from this directory to the installation prefix
symlink: pomodoro
	ln -is `pwd`/pomodoro ${PREFIX}/pomodoro
