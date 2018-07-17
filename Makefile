# notes – a console notes manager using git
# See the LICENSE file for copyright and license details.
.POSIX:

VERSION = 0.1

BIN    = drist
PREFIX = /usr
BINDIR = ${PREFIX}/bin
MANDIR = ${PREFIX}/share/man

all:

install: 
	@echo installing executable to "${DESTDIR}${PREFIX}/bin"
	@mkdir -p "${DESTDIR}${BINDIR}"
	@cp -f "${BIN}" "${DESTDIR}${BINDIR}/${BIN}"
	@chmod 755 "${DESTDIR}${BINDIR}/${BIN}"
	@echo installing manual page to ${DESTDIR}${MANDIR}/man1
	@mkdir -p ${DESTDIR}${MANDIR}/man1
	@sed "s/VERSION/${VERSION}/g" < ${BIN}.1 > ${DESTDIR}${MANDIR}/man1/${BIN}.1
	@chmod 644 ${DESTDIR}${MANDIR}/man1/${BIN}.1

uninstall:
	@echo removing executable file from "${DESTDIR}${PREFIX}/bin"
	@rm -f "${DESTDIR}${BINDIR}/${BIN}"
	@echo removing manual page from ${DESTDIR}${MANDIR}/man1
	@rm -f ${DESTDIR}${MANDIR}/man1/${BIN}.1

.PHONY: all install uninstall clean
