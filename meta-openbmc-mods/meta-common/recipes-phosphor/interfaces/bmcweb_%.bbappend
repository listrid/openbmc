SRC_URI = "git://github.com/openbmc/bmcweb.git"
SRCREV = "dab0604af234bdd5010407031a01343d6c242edf"

DEPENDS += "boost-url"
RDEPENDS_${PN} += "phosphor-nslcd-authority-cert-config"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# add a user called bmcweb for the server to assume
# bmcweb is part of group shadow for non-root pam authentication
USERADD_PARAM_${PN} = "-r -s /usr/sbin/nologin -d /home/bmcweb -m -G shadow bmcweb"

GROUPADD_PARAM_${PN} = "web; redfish "

SRC_URI += "file://0001-Firmware-update-configuration-changes.patch \
            file://0002-Use-chip-id-based-UUID-for-Service-Root.patch \
            file://0004-bmcweb-handle-device-or-resource-busy-exception.patch \
            file://0006-Define-Redfish-interface-Registries-Bios.patch \
            file://0007-BIOS-config-Add-support-for-PATCH-operation.patch \
            file://0008-Add-support-to-ResetBios-action.patch \
            file://0009-Add-support-to-ChangePassword-action.patch \
            file://0010-managers-add-attributes-for-Manager.CommandShell.patch \
            file://0034-recommended-fixes-by-crypto-review-team.patch \
            file://0011-bmcweb-Add-PhysicalContext-to-Thermal-resources.patch \
            file://0012-Log-RedFish-event-for-Invalid-login-attempt.patch \
            file://0013-Add-UART-routing-logic-into-host-console-connection-.patch \
"

# Temporary downstream mirror of upstream patch to enable feature in Intel builds.
SRC_URI += "file://0037-Add-state-sensor-messages-to-the-registry.patch \
"

# EventService: Temporary pulled to downstream. See eventservice\README for details
SRC_URI += "file://eventservice/0001-EventService-Fix-retry-handling-for-http-client.patch \
            file://eventservice/0002-EventService-https-client-support.patch \
            file://eventservice/0004-Add-Server-Sent-Events-support.patch \
            file://eventservice/0005-Add-SSE-style-subscription-support-to-eventservice.patch \
            file://eventservice/0006-Add-EventService-SSE-filter-support.patch \
"

# Temporary downstream mirror of upstream patches, see telemetry\README for details
SRC_URI += "file://telemetry/0003-Add-support-for-MetricDefinition-scheme.patch \
            file://telemetry/0004-Sync-Telmetry-service-with-EventService.patch \
"

SRC_URI += "file://0001-Add-ConnectedVia-property-to-virtual-media-item-temp.patch \
            file://0002-Invalid-status-code-from-InsertMedia-REST-methods.patch \
            file://0003-Set-Inserted-redfish-property-for-not-inserted-resou.patch \
            file://0004-Bmcweb-handle-permission-denied-exception.patch \
            file://0005-Fix-unmounting-image-in-proxy-mode.patch \
"

SRC_URI += "file://0038-Revert-Disable-nbd-proxy-from-the-build.patch \
            file://0039-Fix-comparison-for-proxy-legacy-mode.patch \
"

# Fix to avoid bmcweb crash on VM mount
SRC_URI += "file://0039-Fix-bmcweb-crashes-if-socket-directory-not-present.patch \
"

# Temporary fix: Move it to service file
do_install_append() {
        install -d ${D}/var/lib/bmcweb
        install -d ${D}/etc/ssl/certs/authority
}

# Enable PFR support
EXTRA_OEMESON += "${@bb.utils.contains('IMAGE_FSTYPES', 'intel-pfr', '-Dredfish-provisioning-feature=enabled', '', d)}"

# Enable NBD proxy embedded in bmcweb
EXTRA_OEMESON += " -Dvm-nbdproxy=enabled"

# Disable dependency on external nbd-proxy application
EXTRA_OEMESON += " -Dvm-websocket=disabled"
RDEPENDS_${PN}_remove += "jsnbd"

# Enable Validation unsecure based on IMAGE_FEATURES
EXTRA_OEMESON += "${@bb.utils.contains('EXTRA_IMAGE_FEATURES', 'validation-unsecure', '-Dvalidate-unsecure-feature=enabled', '', d)}"

