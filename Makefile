jCC      = gcc
CFLAGS   = -std=c99 -Wall -Wextra
LIBS_TIMER = `pkg-config --cflags --libs gtk+-3.0 libnotify libcanberra`
LIBS_STOPW = `pkg-config --cflags --libs gtk+-3.0`
 
PREFIX   ?= /usr/local
BINPREFIX = $(PREFIX)/bin

all: CFLAGS += -Os
all: gstopwatch gtimer

debug: CFLAGS += -O0 -g -pedantic -DDEBUG
debug: all

gstopwatch: gstopwatch.c
	$(CC) gstopwatch.c -o gstopwatch $(CFLAGS) $(LIBS_STOPW)

gtimer: gtimer.c
	$(CC) gtimer.c -o gtimer $(CFLAGS) $(LIBS_TIMER)

install:
	mkdir -p $(DESTDIR)/$(BINPREFIX)
	mkdir -p $(DESTDIR)/usr/share/applications/

	install -m 0755 gstopwatch $(DESTDIR)/$(BINPREFIX)/
	install -m 0755 gtimer $(DESTDIR)/$(BINPREFIX)/
	install -m 0644 data/gstopwatch.desktop $(DESTDIR)/usr/share/applications/
	install -m 0644 data/gtimer.desktop $(DESTDIR)/usr/share/applications/

uninstall:
	rm -f $(BINPREFIX)/gstopwatch
	rm -f $(BINPREFIX)/gtimer
	rm -f /usr/share/applications/gstopwatch.desktop
	rm -r /usr/share/applications/gtimer.desktop

clean:
	rm -f gstopwatch
	rm -f gtimer
