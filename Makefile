# drist – a simple hosts deployment tool
# See the LICENSE file for copyright and license details.
.POSIX:

BIN    = drist
PREFIX ?= /usr/local
BINDIR ?= ${PREFIX}/bin
MANDIR ?= ${PREFIX}/man

all:

install: 
	@echo installing executable to "${DESTDIR}${PREFIX}/bin"
	@mkdir -p "${DESTDIR}${BINDIR}"
	@install "${BIN}" "${DESTDIR}${BINDIR}/${BIN}"
	@echo installing manual page to ${DESTDIR}${MANDIR}/man1
	@mkdir -p "${DESTDIR}${MANDIR}/man1"
	@install "${BIN}.1" "${DESTDIR}${MANDIR}/man1/${BIN}.1"

uninstall:
	@echo removing executable file from "${DESTDIR}${PREFIX}/bin"
	@rm -f "${DESTDIR}${BINDIR}/${BIN}"
	@echo removing manual page from ${DESTDIR}${MANDIR}/man1
	@rm -f ${DESTDIR}${MANDIR}/man1/${BIN}.1

.PHONY: all install uninstall clean
