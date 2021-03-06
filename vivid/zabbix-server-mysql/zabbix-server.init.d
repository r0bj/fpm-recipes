#! /bin/sh
### BEGIN INIT INFO
# Provides:          zabbix-server
# Required-Start:    $remote_fs $network
# Required-Stop:     $remote_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Should-Start:      mysql
# Should-Stop:       mysql
# Short-Description: Start zabbix-server daemon
# Description: Start zabbix-server daemon (MySQL)
### END INIT INFO

NAME=zabbix_server
DAEMON=/usr/sbin/$NAME
# Exit if executable is not installed
[ -x $DAEMON ] || exit 0

DIR=/var/run/zabbix
PID=$DIR/$NAME.pid
RETRY=TERM/30/KILL/5
START=no

# Read configuration variable file if it is present
DEFAULTS_FILE=/etc/default/zabbix-server
[ -r "$DEFAULTS_FILE" ] && . $DEFAULTS_FILE

# Load the VERBOSE setting and other rcS variables
[ -f /etc/default/rcS ] && . /etc/default/rcS

# define LSB log_* functions.
. /lib/lsb/init-functions

_ev_ () {
  [ "$VERBOSE" = "no" ] || eval $@
}

[ -d "$DIR" ] || mkdir "$DIR"
chown -R zabbix:zabbix "$DIR"
export PATH="${PATH:+$PATH:}/usr/sbin:/sbin"

case "$1" in
  start)
    if [ $START != "yes" ]; then
        log_action_msg "$NAME is disabled in $DEFAULTS_FILE."
        exit 0
    fi
    start-stop-daemon --start --pidfile $PID --exec $DAEMON --test --quiet > /dev/null
    [ $? -ne 0 ] && log_action_msg "$NAME is already running" && exit 0
    _ev_ log_action_begin_msg \"$NAME starting\"
    R=$(start-stop-daemon --start --pidfile $PID --exec $DAEMON --oknodo 2>&1) \
    && _ev_ log_action_end_msg 0 \"$R\" \
    || _ev_ log_action_end_msg 1 \"$R\"
  ;;
  stop)
    _ev_ log_action_begin_msg "$NAME stopping"
    R=$(start-stop-daemon --stop --pidfile $PID --exec $DAEMON --oknodo --retry=$RETRY 2>&1) \
    && _ev_ log_action_end_msg 0 \"$R\" \
    || _ev_ log_action_end_msg 1 \"$R\"
  ;;
  status)
    ## return status 0 if process is running.
    status_of_proc -p $PID "$DAEMON" "$NAME"
  ;;
  restart|force-reload)
    $0 stop
    $0 start
  ;;
  *)
    echo "Usage: /etc/init.d/$NAME {start|stop|restart|force-reload|status}" >&2
    exit 1
  ;;
esac
