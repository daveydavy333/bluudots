cd /hdxp/pkgs/base-openrc
for f in svc-dbus svc-iwd svc-getty-tty1; do sed -i '/^export PATH=/d' $f; done
sed -i '/^respawn_delay=/a respawn_period=60' svc-net svc-getty-tty1
cat > svc-hdx-boot <<'EOF'
#!/usr/local/sbin/openrc-run
description="Run the HDXI boot scripts in /etc/rc.d/boot (firmware, fsck, mount, udev, alsa, dbus...)"

start() {
	mkdir -p /var/log
	if [ -s /etc/hostname ]; then hostname "$(cat /etc/hostname)"; else hostname hdxi; fi
	ip link set lo up 2>/dev/null || ifconfig lo up 2>/dev/null
	for f in /etc/rc.d/boot/*.sh; do
		[ -f "$f" ] || continue
		ebegin "boot script ${f##*/}"
		sh "$f" >>/var/log/hdx-boot.log 2>&1
		eend $?
	done
	return 0
}
EOF
for s in hdx-boot dbus iwd net getty-tty1; do install -m755 svc-$s /etc/init.d/$s; done
grep -n 'PATH\|respawn' svc-*      # sanity check: no "export PATH" left, respawn_period=60 in net and getty
sync
