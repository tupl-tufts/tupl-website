#!/bin/bash
# This script starts a webserver in the current working
# directory (run with './test.sh'), starts up either chrome
# or firefox pointing at the webserver, and then kills the
# webserver when the user types CTRL-C.

python3 -m http.server 8080 &
PY=$!
sleep 1
if hash google-chrome-stable; then
  google-chrome-stable http://localhost:8080 &
  BROWSER=$?
elif hash google-chrome; then
  google-chrome http://localhost:8080 &
  BROWSER=$?
elif hash firefox; then
  firefox http://localhost:8080 &
  BROWSER=$?
fi

ctrl_c() {
  echo "Killing webserver, PID=$PY"
  kill -9 $PY
  exit
}
trap ctrl_c INT

echo $PY
wait

