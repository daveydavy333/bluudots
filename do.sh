FTS_H=$(find /usr /opt -name fts.h 2>/dev/null | head -1)
[ -n "$FTS_H" ] || { echo "wlmaker: fts.h not found, hdx i devel-musl-fts first" >&2; exit 1; }
FTS_INC=$(dirname "$FTS_H")
export CPATH="$FTS_INC${CPATH:+:$CPATH}"
export LIBRARY_PATH="$(dirname "$FTS_INC")/lib${LIBRARY_PATH:+:$LIBRARY_PATH}"
