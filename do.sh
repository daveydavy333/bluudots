for f in /etc/hdxi/hevel-config.h /hdxp/src/util-hevel-src/config.h; do
  sed -i 's/term_flag = "-w"/term_flag = "-a"/' "$f"
  sed -i 's/terminal_app_ids\[\] = {"foot", /terminal_app_ids[] = {"foot", "foot-256color", /' "$f"
  sed -i 's|term = "/usr/local/bin/hterm";|term = "foot";|' "$f"
  grep -n 'term_flag\|char \*const term \|terminal_app_ids' "$f"
done
