FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

#SYSTEMD_SUBSTITUTIONS_remove = "KCS_DEVICE:${KCS_DEVICE}:${DBUS_SERVICE_${PN}}"

# Default kcs device is ipmi-kcs3; this is SMS.
# Add SMM kcs device instance

# Replace the '-' to '_', since Dbus object/interface names do not allow '-'.
KCS_DEVICE = "ipmi_kcs3"
SMM_DEVICE = "ipmi_kcs4"
SYSTEMD_SERVICE_${PN}_append = " ${PN}@${SMM_DEVICE}.service "

SRC_URI = "git://github.com/openbmc/kcsbridge.git"
SRCREV = "3b170152ddc967f270939f4c351be987c451f0ca"

SRC_URI += "file://99-ipmi-kcs.rules"

do_install_append() {
    install -d ${D}${base_libdir}/udev/rules.d
    install -m 0644 ${WORKDIR}/99-ipmi-kcs.rules ${D}${base_libdir}/udev/rules.d/
}
