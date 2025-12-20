# drist – a simple hosts deployment tool
# See the LICENSE file for copyright and license details.
.POSIX:

BIN    = drist
PREFIX ?= /usr/local/bin
MANDIR ?= /usr/local/share/man/man1

all:

install: 
	@echo installing executable to "${PREFIX}"
	@install -d -o root -g wheel -m 0755 "${BIN}" "${PREFIX}/"
	@echo installing manual page to ${MANDIR}/man1
	@install -d -o root -g wheel -m 0644 "${BIN}.1" "${MANDIR}/"

uninstall:
	@echo removing executable file from "${PREFIX}"
	@rm -f "${PREFIX}/${BIN}"
	@echo removing manual page from ${MANDIR}
	@rm -f ${MANDIR}/${BIN}.1

.PHONY: all install uninstall
