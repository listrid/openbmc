inherit useradd

# TODO: This should be removed, once up-stream bump up
# issue is resolved
SRC_URI += "git://github.com/openbmc/phosphor-net-ipmid"
SRCREV = "d4a4bed525f79c39705fa526b20ab663bb2c2069"

USERADD_PACKAGES = "${PN}"
# add a group called ipmi
GROUPADD_PARAM_${PN} = "ipmi "

# Default rmcpp iface is eth0; channel 1
# Add channel 2 instance (eth1)
RMCPP_EXTRA = "eth1"
SYSTEMD_SERVICE_${PN} += " \
        ${PN}@${RMCPP_EXTRA}.service \
        ${PN}@${RMCPP_EXTRA}.socket \
        "

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " file://10-nice-rules.conf \
             file://0006-Modify-dbus-namespace-of-chassis-control-for-guid.patch \
             file://0011-Remove-Get-SOL-Config-Command-from-Netipmid.patch \
           "

do_install_append() {
    mkdir -p ${D}${sysconfdir}/systemd/system/phosphor-ipmi-net@.service.d/
    install -m 0644 ${WORKDIR}/10-nice-rules.conf ${D}${sysconfdir}/systemd/system/phosphor-ipmi-net@.service.d/
}
