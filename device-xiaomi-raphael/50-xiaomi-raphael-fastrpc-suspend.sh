#!/bin/sh
# Keep the FastRPC sensor session out of system suspend.
#
# Leaving a FastRPC session open across a suspend makes SLPI's
# sensor_process die with EX:sensor_process:0x1:frpc_dsp:0x6e on resume,
# and the crash takes the whole sensor stack with it: iio-sensor-proxy
# cannot reopen the sensor afterwards, dereferences the unset GError in
# the libssc drivers and dies too.
#
# The service units cannot cover this.  hexagonrpcd-adsp-rootpd and
# hexagonrpcd-adsp-sensorspd carry Conflicts=suspend.target upstream and
# google-sargo still needs a hook on top, because the stop that Conflicts
# schedules lands after the suspend has already begun, and because the
# GNOME power key writes /sys/power/state without going through
# suspend.target at all.  Doing it from the sleep hook runs at the one
# point every suspend path passes through.
#
# A/B checked on hardware: suspending with no FastRPC client keeps the
# SLPI crash counter flat, suspending with an open session increments it
# every time, and stopping the server here keeps it flat across repeated
# rounds while the sensors come back working.
#
# systemd 262 only scans /usr/lib/systemd/system-sleep, so the script has
# to live in the lib directory; the same pre/post protocol is what Debian,
# Ubuntu and Arch use, so this is not specific to one distribution.
case "$1" in
pre)
	systemctl stop hexagonrpcd-sdsp.service
	;;
post)
	systemctl start hexagonrpcd-sdsp.service
	;;
esac
exit 0
