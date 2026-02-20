# drist – a simple hosts deployment tool
# See the LICENSE file for copyright and license details.
.POSIX:

BIN    = drist
PREFIX ?= /usr/local/bin
MANDIR ?= /usr/local/share/man/man1

all:

install: 
	@echo installing executable to "${PREFIX}"
	@cp "${BIN}" "${PREFIX}/${BIN}"
	@echo installing manual page to ${MANDIR}/man1
	@cp "${BIN}.1" "${MANDIR}/${BIN}.1"

uninstall:
	@echo removing executable file from "${PREFIX}"
	@rm -f "${PREFIX}/${BIN}"
	@echo removing manual page from ${MANDIR}
	@rm -f ${MANDIR}/${BIN}.1

.PHONY: all install uninstall
