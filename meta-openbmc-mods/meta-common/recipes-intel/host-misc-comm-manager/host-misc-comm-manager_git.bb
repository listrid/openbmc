SUMMARY = "Miscellaneous host interface communication manager"
DESCRIPTION = "Daemon exposes Miscellaneous host interface communications like \
               platform reset, mail box & scratch pad"

PV = "1.0+git${SRCPV}"

S = "${WORKDIR}/git"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e"

SRC_URI = "git://github.com/Intel-BMC/host-misc-comm-manager.git;protocol=ssh"

SRCREV = "0d8577404fd321841fc84de547fe3d1d2a36909f"

inherit cmake systemd
SYSTEMD_SERVICE_${PN} = "xyz.openbmc_project.Host.Misc.Manager.service"

DEPENDS = "boost sdbusplus phosphor-logging"
