cat > /tmp/ins <<'EOF'
# this wlroots has no x11 backend: drop the header and the x11 output checks
sed -i '/#include <wlr\/backend\/x11.h>/d' src/backend/output.c
sed -i 's/wlr_output_is_x11(wlr_output_ptr)/0/g' src/backend/output.c
! grep -q 'x11' src/backend/output.c.orig 2>/dev/null || true
grep -q 'wlr_output_is_x11\|backend/x11.h' src/backend/output.c && { echo "util-wlmaker: x11 patch did not apply" >&2; exit 1; }
EOF
P=/hdxp/pkgs/util-wlmaker
awk -v f=/tmp/ins '/^grep -q .IMPORTED_TARGET/ && !d {while((getline l < f)>0) print l; d=1} {print}' $P/make.sh > /tmp/make.new
