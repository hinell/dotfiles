console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#---------------------------------------------------------------------------MAIN
[[ "$1" =~ '--help' ]] && {   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; }
export SERVER_PORT=${SERVER_PORT:-5000}
console.wrn "$0: testing if the server is running by using curl..."
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn "Already running, aborting.";   exit 0; else   console.ok "MDN Yari: Initiating new instance ..."; fi
CONTENT_PATH=/media/alex/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err 'content folder not found'; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err `node is not found`       ; exit 2; };
[[ -s "$LASTRUN_PID_PATH" ]] && {
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
dirs -c
pushd $CONTENT_PATH;
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
disown
sleep 3s && xdg-open http://localhost:$SERVER_PORT & disown;
# Report
#-------------------------------------
console.ok "MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e "\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
[[ "$1" =~ '--help' ]] && {   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; }
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn "Already running, aborting.";   exit 0; else   console.ok "MDN Yari: Initiating new instance ..."; fi
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
#!/usr/bin/bash -i
# Title			: MDN Offline Content Server
# Summary		: Starts up the MDN Offline Content Server
# Created-at	: Tuesday, July 27, 2021
# Last-Modified	: January 05, 2022
# Authors		: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description	:  This scrip is primarily intended to be used inside a systemd
# service unit; that's why paths are absolute and not relative.
# Usage			: TODO: write docs
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#---------------------------------------------------------------------------MAIN
[[ "$1" =~ '--help' ]] && {   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; }
export SERVER_PORT=${SERVER_PORT:-5000}
console.wrn "$0: testing if the server is running by using curl..."
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn "Already running, aborting.";   exit 0; else   console.ok "MDN Yari: Initiating new instance ..."; fi
CONTENT_PATH=/media/alex/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err 'content folder not found'; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err `node is not found`       ; exit 2; };
[[ -s "$LASTRUN_PID_PATH" ]] && {
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
dirs -c
pushd $CONTENT_PATH;
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
disown
sleep 3s && xdg-open http://localhost:$SERVER_PORT & disown;
# Report
#-------------------------------------
console.ok "MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e "\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
console.ok "MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e "\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#!/usr/bin/bash -i
# Title			: MDN Offline Content Server
# Summary		: Starts up the MDN Offline Content Server
# Created-at	: Tuesday, July 27, 2021
# Last-Modified	: January 05, 2022
# Authors		: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description	:  This scrip is primarily intended to be used inside a systemd
# service unit; that's why paths are absolute and not relative.
# Usage			: TODO: write docs
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#---------------------------------------------------------------------------MAIN
[[ "$1" =~ '--help' ]] && {   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; }
console.err() {   echo -e "\e[31m ERR\e[0m | $1"; } # console.err end
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
[[ "$1" =~ '--help' ]] && {   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; }
#!/usr/bin/bash -i
# Title			: MDN Offline Content Server
# Summary		: Starts up the MDN Offline Content Server
# Created-at	: Tuesday, July 27, 2021
# Last-Modified	: January 05, 2022
# Authors		: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description	:  This scrip is primarily intended to be used inside a systemd
# service unit; that's why paths are absolute and not relative.
# Usage			: TODO: write docs
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#---------------------------------------------------------------------------MAIN
[[ "$1" =~ '--help' ]] && {   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; }
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
console.err() {   echo -e "\e[31m ERR\e[0m | $1"; } # console.err end
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
[[ "$1" =~ '--help' ]] && {   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; }
#!/usr/bin/bash -i
# Title			: MDN Offline Content Server
# Summary		: Starts up the MDN Offline Content Server
# Created-at	: Tuesday, July 27, 2021
# Last-Modified	: January 05, 2022
# Authors		: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description	:  This scrip is primarily intended to be used inside a systemd
# service unit; that's why paths are absolute and not relative.
# Usage			: TODO: write docs
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#---------------------------------------------------------------------------MAIN
[[ "$1" =~ '--help' ]] && {   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; }
export SERVER_PORT=${SERVER_PORT:-5000}
console.wrn "$0: testing if the server is running by using curl..."
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn "Already running, aborting.";   exit 0; else   console.ok "MDN Yari: Initiating new instance ..."; fi
CONTENT_PATH=/media/alex/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err 'content folder not found'; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err `node is not found`       ; exit 2; };
[[ -s "$LASTRUN_PID_PATH" ]] && {
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
dirs -c
pushd $CONTENT_PATH;
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
disown
sleep 3s && xdg-open http://localhost:$SERVER_PORT & disown;
# Report
#-------------------------------------
console.ok "MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e "\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
 dirs
 help dirs
 dirs
 dirs -p
 dirs -p -v
 dirs -l -p
 dirs -l
 dirs -c
 dirs -l
 dirs -l -p
 dirs -l
 dirs -c
 dirs -l
#!/usr/bin/bash -i
# Title			: MDN Offline Content Server
# Summary		: Starts up the MDN Offline Content Server
# Created-at	: Tuesday, July 27, 2021
# Last-Modified	: January 05, 2022
# Authors		: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description	:  This scrip is primarily intended to be used inside a systemd
# service unit; that's why paths are absolute and not relative.
# Usage			: TODO: write docs
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
console.wrn "$0: testing if the server is running by using curl..."
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn "Already running, aborting.";   exit 0; else   console.ok "MDN Yari: Initiating new instance ..."; fi
CONTENT_PATH=/media/alex/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err 'content folder not found'; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err `node is not found`       ; exit 2; };
[[ -s "$LASTRUN_PID_PATH" ]] && {
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
# dirs -c
# pushd $CONTENT_PATH;
# CONTENT_ROOT=files \
# REACT_APP_DISABLE_AUTH=true \
# BUILD_OUT_ROOT=build \
# node ./node_modules/@mdn/yari/server \
# & echo $! > $LASTRUN_PID_PATH;
# disown
# sleep 3s && xdg-open http://localhost:$SERVER_PORT & disown;
# Report
#-------------------------------------
console.ok "MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e "\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn "Already running, aborting.";   exit 0; else   console.ok "MDN Yari: Initiating new instance ..."; fi
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
#!/usr/bin/bash -i
# Title			: MDN Offline Content Server
# Summary		: Starts up the MDN Offline Content Server
# Created-at	: Tuesday, July 27, 2021
# Last-Modified	: January 05, 2022
# Authors		: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description	:  This scrip is primarily intended to be used inside a systemd
# service unit; that's why paths are absolute and not relative.
# Usage			: TODO: write docs
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
console.wrn "$0: testing if the server is running by using curl..."
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn "Already running, aborting.";   exit 0; else   console.ok "MDN Yari: Initiating new instance ..."; fi
CONTENT_PATH=/media/alex/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err 'content folder not found'; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err `node is not found`       ; exit 2; };
[[ -s "$LASTRUN_PID_PATH" ]] && {
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
# dirs -c
# pushd $CONTENT_PATH;
# CONTENT_ROOT=files \
# REACT_APP_DISABLE_AUTH=true \
# BUILD_OUT_ROOT=build \
# node ./node_modules/@mdn/yari/server \
# & echo $! > $LASTRUN_PID_PATH;
# disown
# sleep 3s && xdg-open http://localhost:$SERVER_PORT & disown;
# Report
#-------------------------------------
console.ok "MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e "\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
console.wrn "$0: testing if the server is running by using curl..."
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn "Already running, aborting.";   exit 0; else   console.ok "MDN Yari: Initiating new instance ..."; fi
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
#!/usr/bin/bash -i
# Title			: MDN Offline Content Server
# Summary		: Starts up the MDN Offline Content Server
# Created-at	: Tuesday, July 27, 2021
# Last-Modified	: January 05, 2022
# Authors		: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description	:  This scrip is primarily intended to be used inside a systemd
# service unit; that's why paths are absolute and not relative.
# Usage			: TODO: write docs
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
SCRIPT_NAME=$(dirname `pwd`)
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
TEST_RUNNING_MSG="${SCRIPT_NAME}: testing if the server is running by using curl..."
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn $TEST_RUNNING_MSG;   exit 0; else   console.ok $TEST_RUNNING_MSG; fi
CONTENT_PATH=/media/alex/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err 'content folder not found'; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err `node is not found`       ; exit 2; };
[[ -s "$LASTRUN_PID_PATH" ]] && {
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
# dirs -c
# pushd $CONTENT_PATH;
# CONTENT_ROOT=files \
# REACT_APP_DISABLE_AUTH=true \
# BUILD_OUT_ROOT=build \
# node ./node_modules/@mdn/yari/server \
# & echo $! > $LASTRUN_PID_PATH;
# disown
# sleep 3s && xdg-open http://localhost:$SERVER_PORT & disown;
# Report
#-------------------------------------
console.ok "MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e "\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn $TEST_RUNNING_MSG;   exit 0; else   console.ok $TEST_RUNNING_MSG; fi
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
#!/usr/bin/bash -i
# Title			: MDN Offline Content Server
# Summary		: Starts up the MDN Offline Content Server
# Created-at	: Tuesday, July 27, 2021
# Last-Modified	: January 05, 2022
# Authors		: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description	:  This scrip is primarily intended to be used inside a systemd
# service unit; that's why paths are absolute and not relative.
# Usage			: TODO: write docs
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
SCRIPT_NAME=$(dirname `pwd`)
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
TEST_RUNNING_MSG="${SCRIPT_NAME}: testing if the server is running by using curl..."
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn $TEST_RUNNING_MSG;   exit 0; else   console.err $TEST_RUNNING_MSG; fi
CONTENT_PATH=/media/alex/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err 'content folder not found'; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err `node is not found`       ; exit 2; };
[[ -s "$LASTRUN_PID_PATH" ]] && {
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
# dirs -c
# pushd $CONTENT_PATH;
# CONTENT_ROOT=files \
# REACT_APP_DISABLE_AUTH=true \
# BUILD_OUT_ROOT=build \
# node ./node_modules/@mdn/yari/server \
# & echo $! > $LASTRUN_PID_PATH;
# disown
# sleep 3s && xdg-open http://localhost:$SERVER_PORT & disown;
# Report
#-------------------------------------
console.ok "MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e "\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
SCRIPT_NAME=$(dirname `pwd`)
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn $TEST_RUNNING_MSG;   exit 0; else   console.err $TEST_RUNNING_MSG; fi
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
#!/usr/bin/bash -i
# Title			: MDN Offline Content Server
# Summary		: Starts up the MDN Offline Content Server
# Created-at	: Tuesday, July 27, 2021
# Last-Modified	: January 05, 2022
# Authors		: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description	:  This scrip is primarily intended to be used inside a systemd
# service unit; that's why paths are absolute and not relative.
# Usage			: TODO: write docs
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
SCRIPT_NAME=$(dirname ${0})
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
TEST_RUNNING_MSG="${SCRIPT_NAME}: testing if the server is running by using curl..."
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn $TEST_RUNNING_MSG;   exit 0; else   console.err $TEST_RUNNING_MSG; fi
CONTENT_PATH=/media/alex/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err 'content folder not found'; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err `node is not found`       ; exit 2; };
[[ -s "$LASTRUN_PID_PATH" ]] && {
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
# dirs -c
# pushd $CONTENT_PATH;
# CONTENT_ROOT=files \
# REACT_APP_DISABLE_AUTH=true \
# BUILD_OUT_ROOT=build \
# node ./node_modules/@mdn/yari/server \
# & echo $! > $LASTRUN_PID_PATH;
# disown
# sleep 3s && xdg-open http://localhost:$SERVER_PORT & disown;
# Report
#-------------------------------------
console.ok "MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e "\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
console.ok "MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e "\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#!/usr/bin/bash -i
# Title			: MDN Offline Content Server
# Summary		: Starts up the MDN Offline Content Server
# Created-at	: Tuesday, July 27, 2021
# Last-Modified	: January 05, 2022
# Authors		: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description	:  This scrip is primarily intended to be used inside a systemd
# service unit; that's why paths are absolute and not relative.
# Usage			: TODO: write docs
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
SCRIPT_NAME=$(dirname ${0})
console.ok($0)
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
console.err() {   echo -e "\e[31m ERR\e[0m | $1"; } # console.err end
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
console.ok($0)
#!/usr/bin/bash -i
# Title			: MDN Offline Content Server
# Summary		: Starts up the MDN Offline Content Server
# Created-at	: Tuesday, July 27, 2021
# Last-Modified	: January 05, 2022
# Authors		: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description	:  This scrip is primarily intended to be used inside a systemd
# service unit; that's why paths are absolute and not relative.
# Usage			: TODO: write docs
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
SCRIPT_NAME=$(dirname ${0})
console.ok $0
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
TEST_RUNNING_MSG="${SCRIPT_NAME}: testing if the server is running by using curl..."
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn $TEST_RUNNING_MSG;   exit 0; else   console.err $TEST_RUNNING_MSG; fi
CONTENT_PATH=/media/alex/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err 'content folder not found'; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err `node is not found`       ; exit 2; };
[[ -s "$LASTRUN_PID_PATH" ]] && {
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
# dirs -c
# pushd $CONTENT_PATH;
# CONTENT_ROOT=files \
# REACT_APP_DISABLE_AUTH=true \
# BUILD_OUT_ROOT=build \
# node ./node_modules/@mdn/yari/server \
# & echo $! > $LASTRUN_PID_PATH;
# disown
# sleep 3s && xdg-open http://localhost:$SERVER_PORT & disown;
# Report
#-------------------------------------
console.ok "MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e "\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
console.ok $0
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn $TEST_RUNNING_MSG;   exit 0; else   console.err $TEST_RUNNING_MSG; fi
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
#!/usr/bin/bash -i
# Title			: MDN Offline Content Server
# Summary		: Starts up the MDN Offline Content Server
# Created-at	: Tuesday, July 27, 2021
# Last-Modified	: January 05, 2022
# Authors		: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description	:  This scrip is primarily intended to be used inside a systemd
# service unit; that's why paths are absolute and not relative.
# Usage			: TODO: write docs
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
SCRIPT_NAME=$(dirname ${0})
console.ok $(dirname $0)
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
TEST_RUNNING_MSG="${SCRIPT_NAME}: testing if the server is running by using curl..."
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn $TEST_RUNNING_MSG;   exit 0; else   console.err $TEST_RUNNING_MSG; fi
CONTENT_PATH=/media/alex/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err 'content folder not found'; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err `node is not found`       ; exit 2; };
[[ -s "$LASTRUN_PID_PATH" ]] && {
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
# dirs -c
# pushd $CONTENT_PATH;
# CONTENT_ROOT=files \
# REACT_APP_DISABLE_AUTH=true \
# BUILD_OUT_ROOT=build \
# node ./node_modules/@mdn/yari/server \
# & echo $! > $LASTRUN_PID_PATH;
# disown
# sleep 3s && xdg-open http://localhost:$SERVER_PORT & disown;
# Report
#-------------------------------------
console.ok "MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e "\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
console.ok $(dirname $0)
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn $TEST_RUNNING_MSG;   exit 0; else   console.err $TEST_RUNNING_MSG; fi
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
#!/usr/bin/bash -i
# Title			: MDN Offline Content Server
# Summary		: Starts up the MDN Offline Content Server
# Created-at	: Tuesday, July 27, 2021
# Last-Modified	: January 05, 2022
# Authors		: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description	:  This scrip is primarily intended to be used inside a systemd
# service unit; that's why paths are absolute and not relative.
# Usage			: TODO: write docs
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
SCRIPT_NAME=$(basename ${0})
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
TEST_RUNNING_MSG="${SCRIPT_NAME}: testing if the server is running by using curl..."
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn $TEST_RUNNING_MSG;   exit 0; else   console.err $TEST_RUNNING_MSG; fi
CONTENT_PATH=/media/alex/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err 'content folder not found'; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err `node is not found`       ; exit 2; };
[[ -s "$LASTRUN_PID_PATH" ]] && {
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
# dirs -c
# pushd $CONTENT_PATH;
# CONTENT_ROOT=files \
# REACT_APP_DISABLE_AUTH=true \
# BUILD_OUT_ROOT=build \
# node ./node_modules/@mdn/yari/server \
# & echo $! > $LASTRUN_PID_PATH;
# disown
# sleep 3s && xdg-open http://localhost:$SERVER_PORT & disown;
# Report
#-------------------------------------
console.ok "MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e "\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn $TEST_RUNNING_MSG;   exit 0; else   console.err $TEST_RUNNING_MSG; fi
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
#!/usr/bin/bash -i
# Title			: MDN Offline Content Server
# Summary		: Starts up the MDN Offline Content Server
# Created-at	: Tuesday, July 27, 2021
# Last-Modified	: January 05, 2022
# Authors		: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description	:  This scrip is primarily intended to be used inside a systemd
# service unit; that's why paths are absolute and not relative.
# Usage			: TODO: write docs
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
SCRIPT_NAME=$(basename ${0})
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
TEST_RUNNING_MSG="${SCRIPT_NAME}: testing if the server is running by using curl..."
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn $TEST_RUNNING_MSG;   exit 0; else   console.err $TEST_RUNNING_MSG; fi
CONTENT_PATH=/media/alex/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err 'content folder not found'; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err `node is not found`       ; exit 2; };
[[ -s "$LASTRUN_PID_PATH" ]] && {
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
# dirs -c
# pushd $CONTENT_PATH;
# CONTENT_ROOT=files \
# REACT_APP_DISABLE_AUTH=true \
# BUILD_OUT_ROOT=build \
# node ./node_modules/@mdn/yari/server \
# & echo $! > $LASTRUN_PID_PATH;
# disown
# sleep 3s && xdg-open http://localhost:$SERVER_PORT & disown;
# Report
#-------------------------------------
console.ok "MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e "\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
console.ok "MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e "\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#!/usr/bin/bash -i
# Title			: MDN Offline Content Server
# Summary		: Starts up the MDN Offline Content Server
# Created-at	: Tuesday, July 27, 2021
# Last-Modified	: January 05, 2022
# Authors		: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description	:  This scrip is primarily intended to be used inside a systemd
# service unit; that's why paths are absolute and not relative.
# Usage			: TODO: write docs
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {
} # console.ok end
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
} # console.ok end
#!/usr/bin/bash -i
# Title			: MDN Offline Content Server
# Summary		: Starts up the MDN Offline Content Server
# Created-at	: Tuesday, July 27, 2021
# Last-Modified	: January 05, 2022
# Authors		: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description	:  This scrip is primarily intended to be used inside a systemd
# service unit; that's why paths are absolute and not relative.
# Usage			: TODO: write docs
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {
  ;
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
  ;
#!/usr/bin/bash -i
# Title			: MDN Offline Content Server
# Summary		: Starts up the MDN Offline Content Server
# Created-at	: Tuesday, July 27, 2021
# Last-Modified	: January 05, 2022
# Authors		: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description	:  This scrip is primarily intended to be used inside a systemd
# service unit; that's why paths are absolute and not relative.
# Usage			: TODO: write docs
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {
  :; } # console.ok end
SCRIPT_NAME=$(basename ${0})
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
TEST_RUNNING_MSG="${SCRIPT_NAME}: testing if the server is running by using curl..."
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn $TEST_RUNNING_MSG;   exit 0; else   console.err $TEST_RUNNING_MSG; fi
CONTENT_PATH=/media/alex/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err 'content folder not found'; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err `node is not found`       ; exit 2; };
[[ -s "$LASTRUN_PID_PATH" ]] && {
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
# dirs -c
# pushd $CONTENT_PATH;
# CONTENT_ROOT=files \
# REACT_APP_DISABLE_AUTH=true \
# BUILD_OUT_ROOT=build \
# node ./node_modules/@mdn/yari/server \
# & echo $! > $LASTRUN_PID_PATH;
# disown
# sleep 3s && xdg-open http://localhost:$SERVER_PORT & disown;
# Report
#-------------------------------------
console.ok "MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e "\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
  :; } # console.ok end
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn $TEST_RUNNING_MSG;   exit 0; else   console.err $TEST_RUNNING_MSG; fi
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
#!/usr/bin/bash -i
# Title			: MDN Offline Content Server
# Summary		: Starts up the MDN Offline Content Server
# Created-at	: Tuesday, July 27, 2021
# Last-Modified	: January 05, 2022
# Authors		: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description	:  This scrip is primarily intended to be used inside a systemd
# service unit; that's why paths are absolute and not relative.
# Usage			: TODO: write docs
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
# console.ok() {
#   echo -e "\e[32m OK  \e[0m | $1";
# } # console.ok end
SCRIPT_NAME=$(basename ${0})
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
TEST_RUNNING_MSG="${SCRIPT_NAME}: testing if the server is running by using curl..."
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn $TEST_RUNNING_MSG;   exit 0; else   console.err $TEST_RUNNING_MSG; fi
CONTENT_PATH=/media/alex/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err 'content folder not found'; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err `node is not found`       ; exit 2; };
[[ -s "$LASTRUN_PID_PATH" ]] && {
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
# dirs -c
# pushd $CONTENT_PATH;
# CONTENT_ROOT=files \
# REACT_APP_DISABLE_AUTH=true \
# BUILD_OUT_ROOT=build \
# node ./node_modules/@mdn/yari/server \
# & echo $! > $LASTRUN_PID_PATH;
# disown
# sleep 3s && xdg-open http://localhost:$SERVER_PORT & disown;
# Report
#-------------------------------------
console.ok "MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e "\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn $TEST_RUNNING_MSG;   exit 0; else   console.err $TEST_RUNNING_MSG; fi
[[ -s "$LASTRUN_PID_PATH" ]] && {
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
#!/usr/bin/bash -i
# Title			: MDN Offline Content Server
# Summary		: Starts up the MDN Offline Content Server
# Created-at	: Tuesday, July 27, 2021
# Last-Modified	: January 05, 2022
# Authors		: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description	:  This scrip is primarily intended to be used inside a systemd
# service unit; that's why paths are absolute and not relative.
# Usage			: TODO: write docs
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
SCRIPT_NAME=$(basename ${0})
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
TEST_RUNNING_MSG="${SCRIPT_NAME}: testing if the server is running by using curl..."
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn $TEST_RUNNING_MSG;   exit 0; else   console.err $TEST_RUNNING_MSG; fi
CONTENT_PATH=/media/alex/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err 'content folder not found'; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err `node is not found`       ; exit 2; };
# [[ -s "$LASTRUN_PID_PATH" ]] && {
#
#   # If PID of the last run of the Yari server is found
#   # If it's running process
#   # if it's in the PID range of 30k+
#   # Then kill the process
#   #-------------------------------------
#   LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";
#   mdn.docs.kill &> /dev/null;
# } # [[ ... ]]
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
# dirs -c
# pushd $CONTENT_PATH;
# CONTENT_ROOT=files \
# REACT_APP_DISABLE_AUTH=true \
# BUILD_OUT_ROOT=build \
# node ./node_modules/@mdn/yari/server \
# & echo $! > $LASTRUN_PID_PATH;
# disown
# sleep 3s && xdg-open http://localhost:$SERVER_PORT & disown;
# Report
#-------------------------------------
console.ok "MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e "\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err 'content folder not found'; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err `node is not found`       ; exit 2; };
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
# Report
#-------------------------------------
console.ok "MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e "\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#!/usr/bin/bash -i
# Title			: MDN Offline Content Server
# Summary		: Starts up the MDN Offline Content Server
# Created-at	: Tuesday, July 27, 2021
# Last-Modified	: January 05, 2022
# Authors		: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description	:  This scrip is primarily intended to be used inside a systemd
# service unit; that's why paths are absolute and not relative.
# Usage			: TODO: write docs
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
SCRIPT_NAME=$(basename ${0})
# #---------------------------------------------------------------------------MAIN
# # https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
# if [[ "$1" =~ '--help' ]]
#   echo -e "A helper script to run yari server.";
#   echo -e "Configuration:";
#   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";
#   echo -e "\tSERVER_PORT=5042         to setup up custom port";
#   exit 0
# TEST_RUNNING_MSG="${SCRIPT_NAME}: testing if the server is running by using curl..."
# export SERVER_PORT=${SERVER_PORT:-5000}
# if curl -If http://localhost:$SERVER_PORT &> /dev/null
# then
#   console.wrn $TEST_RUNNING_MSG
#   exit 0;
# else
#   console.err $TEST_RUNNING_MSG
# fi
# CONTENT_PATH=/media/alex/ProgramsAndGames/pr/Devdocs/MDN/content
# NVM_VERSION="$(nvm version)";
# NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
# LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
# declare LAST_RUN_PID;
# # Check for content path, node and last pid path
# [[ -d "$CONTENT_PATH"     ]] || { console.err 'content folder not found'; exit 1; };
# [[ -s "$NODE_PATH_BIN"    ]] || { console.err `node is not found`       ; exit 2; };
# [[ -s "$LASTRUN_PID_PATH" ]] && {
#   # If PID of the last run of the Yari server is found
#   # If it's running process
#   # if it's in the PID range of 30k+
#   # Then kill the process
#   #-------------------------------------
#   LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";
#   mdn.docs.kill &> /dev/null;
# } # [[ ... ]]
# # Clear stack & Push directory to the stack
# # -------------------------------------
# # See  Bash Manual on Directory Stack Builtins
# dirs -c
# pushd $CONTENT_PATH;
# CONTENT_ROOT=files \
# REACT_APP_DISABLE_AUTH=true \
# BUILD_OUT_ROOT=build \
# node ./node_modules/@mdn/yari/server \
# & echo $! > $LASTRUN_PID_PATH;
# disown
# sleep 3s && xdg-open http://localhost:$SERVER_PORT & disown;
#
# # Report
# #-------------------------------------
# console.ok "MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
# console.ok "MDN Yari: running at http://localhost:$SERVER_PORT"
# echo -e "\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
# #-------------------------------------
# console.ok "MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
# console.ok "MDN Yari: running at http://localhost:$SERVER_PORT"
# echo -e "\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#!/usr/bin/bash -i
# Title			: MDN Offline Content Server
# Summary		: Starts up the MDN Offline Content Server
# Created-at	: Tuesday, July 27, 2021
# Last-Modified	: January 05, 2022
# Authors		: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description	:  This scrip is primarily intended to be used inside a systemd
# service unit; that's why paths are absolute and not relative.
# Usage			: TODO: write docs
#--------------------------------------------------------------------------Utils
# mdn.docs.kill(){
#   [[ $LAST_RUN_PID -gt 30000 ]]\
#   && ps -p $LAST_RUN_PID \
#   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ;
# }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
SCRIPT_NAME=$(basename ${0})
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
TEST_RUNNING_MSG="${SCRIPT_NAME}: testing if the server is running by using curl..."
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn $TEST_RUNNING_MSG;   exit 0; else   console.err $TEST_RUNNING_MSG; fi
CONTENT_PATH=/media/alex/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err 'content folder not found'; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err `node is not found`       ; exit 2; };
[[ -s "$LASTRUN_PID_PATH" ]] && {
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
dirs -c
pushd $CONTENT_PATH;
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
disown
sleep 3s && xdg-open http://localhost:$SERVER_PORT & disown;
# Report
#-------------------------------------
console.ok "MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e "\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
pushd $CONTENT_PATH;
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
disown
sleep 3s && xdg-open http://localhost:$SERVER_PORT & disown;
#!/usr/bin/bash -i
# Title			: MDN Offline Content Server
# Summary		: Starts up the MDN Offline Content Server
# Created-at	: Tuesday, July 27, 2021
# Last-Modified	: January 05, 2022
# Authors		: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description	:  This scrip is primarily intended to be used inside a systemd
# service unit; that's why paths are absolute and not relative.
# Usage			: TODO: write docs
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
SCRIPT_NAME=$(basename ${0})
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
TEST_RUNNING_MSG="${SCRIPT_NAME}: testing if the server is running by using curl..."
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn $TEST_RUNNING_MSG;   exit 0; else   console.err $TEST_RUNNING_MSG; fi
CONTENT_PATH=/media/alex/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err 'content folder not found'; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err `node is not found`       ; exit 2; };
[[ -s "$LASTRUN_PID_PATH" ]] && {
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
# dirs -c
# pushd $CONTENT_PATH;
# CONTENT_ROOT=files \
# REACT_APP_DISABLE_AUTH=true \
# BUILD_OUT_ROOT=build \
# node ./node_modules/@mdn/yari/server \
# & echo $! > $LASTRUN_PID_PATH;
# disown
# sleep 3s && xdg-open http://localhost:$SERVER_PORT & disown;
# Report
#-------------------------------------
console.ok "MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e "\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
# node ./node_modules/@mdn/yari/server \
# & echo $! > $LASTRUN_PID_PATH;
# disown
# sleep 3s && xdg-open http://localhost:$SERVER_PORT & disown;
#!/usr/bin/bash -i
# Title			: MDN Offline Content Server
# Summary		: Starts up the MDN Offline Content Server
# Created-at	: Tuesday, July 27, 2021
# Last-Modified	: January 05, 2022
# Authors		: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description	:  This scrip is primarily intended to be used inside a systemd
# service unit; that's why paths are absolute and not relative.
# Usage			: TODO: write docs
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
SCRIPT_NAME=$(basename ${0})
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
TEST_RUNNING_MSG="${SCRIPT_NAME}: testing if the server is running by using curl..."
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn $TEST_RUNNING_MSG;   exit 0; else   console.err $TEST_RUNNING_MSG; fi
CONTENT_PATH=/media/alex/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err 'content folder not found'; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err `node is not found`       ; exit 2; };
[[ -s "$LASTRUN_PID_PATH" ]] && {
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
dirs -c
pushd $CONTENT_PATH;
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
disown
sleep 3s && xdg-open http://localhost:$SERVER_PORT & disown;
# Report
#-------------------------------------
console.ok "MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e "\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn $TEST_RUNNING_MSG;   exit 0; else   console.err $TEST_RUNNING_MSG; fi
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
#!/usr/bin/bash -i
# Title			: MDN Offline Content Server
# Summary		: Starts up the MDN Offline Content Server
# Created-at	: Tuesday, July 27, 2021
# Last-Modified	: January 05, 2022
# Authors		: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description	:  This scrip is primarily intended to be used inside a systemd
# service unit; that's why paths are absolute and not relative.
# Usage			: TODO: write docs
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
SCRIPT_NAME=$(basename ${0})
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
TEST_RUNNING_MSG="${SCRIPT_NAME}: testing if the server is running by using curl..."
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn $TEST_RUNNING_MSG;   exit 0; else   console.err $TEST_RUNNING_MSG; fi
CONTENT_PATH=/media/alex/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err 'content folder not found'; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err `node is not found`       ; exit 2; };
[[ -s "$LASTRUN_PID_PATH" ]] && {
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
dirs -c
pushd $CONTENT_PATH;
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
disown
sleep 3s && xdg-open http://localhost:$SERVER_PORT & disown;
# Report
#-------------------------------------
console.ok "MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e "\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
console.ok "MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e "\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: January 05, 2022
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
#  $ git di -p -U0 @~ > ../../git.mdn.content.patch.diff
# Usage: TODO: add description
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
SCRIPT_NAME=$(basename ${0})
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
TEST_RUNNING_MSG="${SCRIPT_NAME}: testing if the server is running by using curl..."
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn ${TEST_RUNNING_MSG};   exit 0; else   console.err ${TEST_RUNNING_MSG}; fi
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn ${TEST_RUNNING_MSG};   exit 0; else   console.err ${TEST_RUNNING_MSG}; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: January 05, 2022
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
#  $ git di -p -U0 @~ > ../../git.mdn.content.patch.diff
# Usage: TODO: add description
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
SCRIPT_NAME=$(basename ${0})
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
TEST_RUNNING_MSG="${SCRIPT_NAME}: testing if the server is running by using curl..."
echo "$TEST_RUNNING_MSG"
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn ${TEST_RUNNING_MSG};   exit 0; else   console.err ${TEST_RUNNING_MSG}; fi
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
echo "$TEST_RUNNING_MSG"
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn ${TEST_RUNNING_MSG};   exit 0; else   console.err ${TEST_RUNNING_MSG}; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: January 05, 2022
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
#  $ git di -p -U0 @~ > ../../git.mdn.content.patch.diff
# Usage: TODO: add description
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
SCRIPT_NAME=$(basename ${0})
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
TEST_RUNNING_MSG="${SCRIPT_NAME}: testing if the server is running by using curl..."
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn "${TEST_RUNNING_MSG} - already running!";   exit 0; else   console.err "${TEST_RUNNING_MSG} - launching"; fi
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn "${TEST_RUNNING_MSG} - already running!";   exit 0; else   console.err "${TEST_RUNNING_MSG} - launching"; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: January 05, 2022
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
#  $ git di -p -U0 @~ > ../../git.mdn.content.patch.diff
# Usage: TODO: add description
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
SCRIPT_NAME=$(basename ${0})
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
TEST_RUNNING_MSG="${SCRIPT_NAME}: testing if the server is running by using curl..."
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn "${TEST_RUNNING_MSG}";   exit 0; else   console.err "${TEST_RUNNING_MSG} - launching"; fi
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn "${TEST_RUNNING_MSG}";   exit 0; else   console.err "${TEST_RUNNING_MSG} - launching"; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: January 05, 2022
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
#  $ git di -p -U0 @~ > ../../git.mdn.content.patch.diff
# Usage: TODO: add description
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
SCRIPT_NAME=$(basename ${0})
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
TEST_RUNNING_MSG="${SCRIPT_NAME}: testing if the server is running by using curl..."
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn "${TEST_RUNNING_MSG} - already running!";   exit 0; else   console.err "${TEST_RUNNING_MSG} - launching"; fi
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.wrn "${TEST_RUNNING_MSG} - already running!";   exit 0; else   console.err "${TEST_RUNNING_MSG} - launching"; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: January 05, 2022
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
#  $ git di -p -U0 @~ > ../../git.mdn.content.patch.diff
# Usage: TODO: add description
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
SCRIPT_NAME=$(basename ${0})
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
TEST_RUNNING_MSG="${SCRIPT_NAME}: testing if the server is running by using curl..."
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${TEST_RUNNING_MSG} - running!";   exit 0; else   console.wrn "${TEST_RUNNING_MSG} - launching"; fi
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
TEST_RUNNING_MSG="${SCRIPT_NAME}: testing if the server is running by using curl..."
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${TEST_RUNNING_MSG} - running!";   exit 0; else   console.wrn "${TEST_RUNNING_MSG} - launching"; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: January 05, 2022
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
#  $ git di -p -U0 @~ > ../../git.mdn.content.patch.diff
# Usage: TODO: add description
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
SCRIPT_NAME=$(basename ${0})
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo ${KILL_MESSAGE};   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo ${KILL_MESSAGE};   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: January 05, 2022
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
#  $ git di -p -U0 @~ > ../../git.mdn.content.patch.diff
# Usage: TODO: add description
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
SCRIPT_NAME=$(basename ${0})
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: January 05, 2022
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
#  $ git di -p -U0 @~ > ../../git.mdn.content.patch.diff
# Usage: TODO: add description
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
SCRIPT_NAME=$(basename ${0})
CONTENT_PATH=/media/alex/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: January 05, 2022
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
#  $ git di -p -U0 @~ > ../../git.mdn.content.patch.diff
# Usage: TODO: add description
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
SCRIPT_NAME=$(basename ${0})
CONTENT_PATH=/media/alex/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
if [[ "$1" =~ '--help' ]]; then   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: January 05, 2022
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
#  $ git di -p -U0 @~ > ../../git.mdn.content.patch.diff
# Usage: TODO: add description
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
SCRIPT_NAME=$(basename ${0})
CONTENT_PATH=/media/alex/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--help' ]]; then   echo -e "There are no commands!";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
if [[ "$1" =~ '--help' ]]; then   echo -e "There are no commands!";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: January 05, 2022
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
#  $ git di -p -U0 @~ > ../../git.mdn.content.patch.diff
# Usage: TODO: add description
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
SCRIPT_NAME=$(basename ${0})
CONTENT_PATH=/media/alex/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--help' ]]; then   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
if [[ "$1" =~ '--help' ]]; then   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: January 05, 2022
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
#  $ git di -p -U0 @~ > ../../git.mdn.content.patch.diff
# Usage: TODO: add description
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
SCRIPT_NAME=$(basename ${0})
SCRIPT_VERSION="1.1.0"
CONTENT_PATH=/media/alex/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}" fi
if [[ "$1" =~ '--help' ]]; then   echo -"MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}" fi
if [[ "$1" =~ '--help' ]]; then   echo -"MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: January 05, 2022
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
#  $ git di -p -U0 @~ > ../../git.mdn.content.patch.diff
# Usage: TODO: add description
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
SCRIPT_NAME=$(basename ${0})
SCRIPT_VERSION="1.1.0"
CONTENT_PATH=/media/alex/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}" fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}" fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: January 05, 2022
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
#  $ git di -p -U0 @~ > ../../git.mdn.content.patch.diff
# Usage: TODO: add description
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
SCRIPT_NAME=$(basename ${0})
SCRIPT_VERSION="1.1.0"
CONTENT_PATH=/media/alex/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}" fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}" fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: January 05, 2022
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
#  $ git di -p -U0 @~ > ../../git.mdn.content.patch.diff
# Usage: TODO: add description
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
SCRIPT_NAME=$(basename ${0})
SCRIPT_VERSION="1.1.0"
CONTENT_PATH=/media/alex/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}" fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}" fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: January 05, 2022
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
#  $ git di -p -U0 @~ > ../../git.mdn.content.patch.diff
# Usage: TODO: add description
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
SCRIPT_NAME=$(basename ${0})
SCRIPT_VERSION="1.1.0"
CONTENT_PATH=/media/alex/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}" fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}" fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: January 05, 2022
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
#  $ git di -p -U0 @~ > ../../git.mdn.content.patch.diff
# Usage: TODO: add description
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
SCRIPT_NAME=$(basename ${0})
SCRIPT_VERSION="1.1.0"
CONTENT_PATH=/media/alex/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}" fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}" fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: January 05, 2022
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
#  $ git di -p -U0 @~ > ../../git.mdn.content.patch.diff
# Usage: TODO: add description
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
SCRIPT_NAME=$(basename ${0})
SCRIPT_VERSION="1.1.0"
CONTENT_PATH=/media/alex/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}" fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
ll
blkid -f
blkid -l
blkid --list-
blid -f
blkid
blkid -l
blkid -f
man blkid
man blkid -f
man blkid -fs
lsblk -fs
lsblk -f
cd home
cd /home
ll
sudo mv alex alex_old
sudo mv alex_new/ alex
1234
ll
ll alex
 ll
 echo $SHELL
 which zsh
  man shell
 zsh
 man -k shell
 man zshall
 man zsh
 man -k shell
 update-shells
 sudo update-shells
 setusershell
 which setusershell
 man setusershell
 man shells
 shells
 chsh
 suod  chsh -l
 sudo chsh -l
 chsh -l
 chsh
 add-shell 
 add-shell $(which zsh)
 sudo add-shell $(which zsh)
 chsh
 sudo apt reinstall zsh
 chsh
 which zsh
 chsh
 man chsh
 echo $SHELL
sudo chsh
 sudo chsh -s $(which zsh)
 chsh -s $(which zsh)
zsh
  read -sq
   read -q
   read -s
  read -sq
   read -q
   read -s
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: January 05, 2022
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
#  $ git di -p -U0 @~ > ../../git.mdn.content.patch.diff
# Usage: TODO: add description
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
SCRIPT_NAME=$(basename ${0})
SCRIPT_VERSION="1.1.0"
CONTENT_PATH=/media/alex/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
# Check for content path, node and last pid path
#-------------------------------------
[[ -d "$CONTENT_PATH"     ]] || { console.err 'content folder not found'; exit 1; };
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: January 05, 2022
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
#  $ git di -p -U0 @~ > ../../git.mdn.content.patch.diff
# Usage: TODO: add description
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
SCRIPT_NAME=$(basename ${0})
SCRIPT_VERSION="1.1.0"
CONTENT_PATH=/media/alex/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
# Check for content path, node and last pid path
#-------------------------------------
[[ -d "$CONTENT_PATH"     ]] || { console.err 'content folder not found'; exit 1; };
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: January 05, 2022
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
#  $ git di -p -U0 @~ > ../../git.mdn.content.patch.diff
# Usage: TODO: add description
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
SCRIPT_NAME=$(basename ${0})
SCRIPT_VERSION="1.1.0"
CONTENT_PATH=/media/alex/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
# Check for content path, node and last pid path
#-------------------------------------
[[ -d "$CONTENT_PATH"     ]] || { console.err 'content folder not found'; exit 1; };
CONTENT_PATH=/media/alex/ProgramsAndGames/pr/Devdocs/MDN/content
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: January 05, 2022
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
#  $ git di -p -U0 @~ > ../../git.mdn.content.patch.diff
# Usage: TODO: add description
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
SCRIPT_NAME=$(basename ${0})
SCRIPT_VERSION="1.1.1"
CONTENT_PATH=/media/all/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err 'content folder not found'; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err `node is not found`       ; exit 2; };
[[ -s "$LASTRUN_PID_PATH" ]] && {
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
dirs -c
pushd $CONTENT_PATH;
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
disown
sleep 3s && xdg-open http://localhost:$SERVER_PORT & disown;
# Report
#-------------------------------------
console.ok "MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e ${KILL_MESSAGE}
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
sleep 3s && xdg-open http://localhost:$SERVER_PORT & disown;
console.ok "MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "MDN Yari: running at http://localhost:$SERVER_PORT"
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 05, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: TODO: add description
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
SCRIPT_NAME=$(basename ${0})
SCRIPT_VERSION="1.1.1"
CONTENT_PATH=/media/all/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err "$0: content folder not found"; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err "$0: node is not found"       ; exit 2; };
[[ -s "$LASTRUN_PID_PATH" ]] && {
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
dirs -c
pushd $CONTENT_PATH;
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
disown
sleep 3s && xdg-open http://localhost:$SERVER_PORT &
# Report
#-------------------------------------
console.ok "$0: MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "$0: MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e ${KILL_MESSAGE}
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 05, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: TODO: add description
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
SCRIPT_NAME=$(basename ${0})
SCRIPT_VERSION="1.1.1"
CONTENT_PATH=/media/all/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err "$0: content folder not found"; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err "$0: node is not found"       ; exit 2; };
[[ -s "$LASTRUN_PID_PATH" ]] && {
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
dirs -c
pushd $CONTENT_PATH;
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
disown
sleep 3s && xdg-open http://localhost:$SERVER_PORT &
# Report
#-------------------------------------
console.ok "$0: MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "$0: MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e ${KILL_MESSAGE}
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 05, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: TODO: add description
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
SCRIPT_NAME=$(basename ${0})
SCRIPT_VERSION="1.1.1"
CONTENT_PATH=/media/all/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err "$0: content folder not found"; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err "$0: node is not found"       ; exit 2; };
[[ -s "$LASTRUN_PID_PATH" ]] && {
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
dirs -c
pushd $CONTENT_PATH;
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
disown
sleep 3s && xdg-open http://localhost:$SERVER_PORT &
# Report
#-------------------------------------
console.ok "$0: MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "$0: MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e ${KILL_MESSAGE}
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 05, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: TODO: add description
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
SCRIPT_NAME=$(basename ${0})
SCRIPT_VERSION="1.1.1"
CONTENT_PATH=/media/all/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err "$0: content folder not found"; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err "$0: node is not found"       ; exit 2; };
[[ -s "$LASTRUN_PID_PATH" ]] && {
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
dirs -c
pushd $CONTENT_PATH;
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
disown
sleep 3s && xdg-open http://localhost:$SERVER_PORT &
# Report
#-------------------------------------
console.ok "$0: MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "$0: MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e ${KILL_MESSAGE}
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 05, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: TODO: add description
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
SCRIPT_NAME=$(basename ${0})
SCRIPT_VERSION="1.1.1"
CONTENT_PATH=/media/all/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err "$0: content folder not found"; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err "$0: node is not found"       ; exit 2; };
[[ -s "$LASTRUN_PID_PATH" ]] && {
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
dirs -c
pushd $CONTENT_PATH;
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
disown
sleep 3s && xdg-open http://localhost:$SERVER_PORT &
# Report
#-------------------------------------
console.ok "$0: MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "$0: MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e ${KILL_MESSAGE}
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 05, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: TODO: add description
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
SCRIPT_NAME=$(basename ${0})
SCRIPT_VERSION="1.1.1"
CONTENT_PATH=/media/all/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err "$0: content folder not found"; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err "$0: node is not found"       ; exit 2; };
[[ -s "$LASTRUN_PID_PATH" ]] && {
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
dirs -c
pushd $CONTENT_PATH;
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
disown
sleep 3s && xdg-open http://localhost:$SERVER_PORT &
# Report
#-------------------------------------
console.ok "$0: MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "$0: MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e ${KILL_MESSAGE}
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 05, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: TODO: add description
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
SCRIPT_NAME=$(basename ${0})
SCRIPT_VERSION="1.1.1"
CONTENT_PATH=/media/all/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err "$0: content folder not found"; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err "$0: node is not found"       ; exit 2; };
[[ -s "$LASTRUN_PID_PATH" ]] && {
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
dirs -c
pushd $CONTENT_PATH;
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
disown
sleep 3s && xdg-open http://localhost:$SERVER_PORT &
# Report
#-------------------------------------
console.ok "$0: MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "$0: MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e ${KILL_MESSAGE}
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 05, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: TODO: add description
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
SCRIPT_NAME=$(basename ${0})
SCRIPT_VERSION="1.1.1"
CONTENT_PATH=/media/all/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err "$0: content folder not found"; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err "$0: node is not found"       ; exit 2; };
[[ -s "$LASTRUN_PID_PATH" ]] && {
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
dirs -c
pushd $CONTENT_PATH;
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
disown
sleep 3s && xdg-open http://localhost:$SERVER_PORT &
# Report
#-------------------------------------
console.ok "$0: MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "$0: MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e ${KILL_MESSAGE}
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 05, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: TODO: add description
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
SCRIPT_NAME=$(basename ${0})
SCRIPT_VERSION="1.1.1"
CONTENT_PATH=/media/all/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn_docs_server_pid.txt
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err "$0: content folder not found"; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err "$0: node is not found"       ; exit 2; };
[[ -s "$LASTRUN_PID_PATH" ]] && {
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
dirs -c
pushd $CONTENT_PATH;
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
disown
sleep 3s && xdg-open http://localhost:$SERVER_PORT &
# Report
#-------------------------------------
console.ok "$0: MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "$0: MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e ${KILL_MESSAGE}
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 05, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: TODO: add description
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
SCRIPT_NAME=$(basename ${0})
SCRIPT_VERSION="1.1.1"
CONTENT_PATH=/media/all/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn-docs-server.pid
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err "$0: content folder not found"; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err "$0: node is not found"       ; exit 2; };
[[ -s "$LASTRUN_PID_PATH" ]] && {
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
dirs -c
pushd $CONTENT_PATH;
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
disown
sleep 3s && xdg-open http://localhost:$SERVER_PORT &
# Report
#-------------------------------------
console.ok "$0: MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "$0: MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e ${KILL_MESSAGE}
console.ok "$0: MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "$0: MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e ${KILL_MESSAGE}
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 05, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: TODO: add description
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
SCRIPT_NAME=$(basename ${0})
SCRIPT_VERSION="1.1.1"
CONTENT_PATH=/media/all/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn-docs-server.pid
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 05, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: TODO: add description
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
SCRIPT_NAME=$(basename ${0})
SCRIPT_VERSION="1.1.1"
CONTENT_PATH=/media/all/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn-docs-server.pid
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 05, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: TODO: add description
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
SCRIPT_NAME=$(basename ${0})
SCRIPT_VERSION="1.1.1"
CONTENT_PATH=/media/all/ProgramsAndGames/pr/Devdocs/MDN/content
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn-docs-server.pid
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
CONTENT_PATH=/media/all/ProgramsAndGames/pr/Devdocs/MDN/content
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Configuration:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 25, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: $ start.sh
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
SCRIPT_NAME=$(basename ${0})
SCRIPT_VERSION="1.1.1"
CONTENT_PATH=${CONTENT_PATH:-/media/all/ProgramsAndGames/pr/Devdocs/MDN/content}
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn-docs-server.pid
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
# Export current configuration for import into another script .e.g ~/.zshrc
if [[ "$1" =~ '--config' ]]; then echo -e "SCRIPT_NAME=$SCRIPT_NAME"; echo -e "SCRIPT_VERSION=$SCRIPT_VERSION"; echo -e "CONTENT_PATH=$CONTENT_PATH"; echo -e "LASTRUN_PID=$LASTRUN_PID";  fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if [[ "$1" =~ '--config' ]]; then echo -e "SCRIPT_NAME=$SCRIPT_NAME"; echo -e "SCRIPT_VERSION=$SCRIPT_VERSION"; echo -e "CONTENT_PATH=$CONTENT_PATH"; echo -e "LASTRUN_PID=$LASTRUN_PID";  fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 25, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: $ start.sh
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
SCRIPT_NAME=$(basename ${0})
SCRIPT_VERSION="1.1.1"
CONTENT_PATH=${CONTENT_PATH:-/media/all/ProgramsAndGames/pr/Devdocs/MDN/content}
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn-docs-server.pid
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
# Export current configuration for import into another script .e.g ~/.zshrc
if [[ "$1" =~ '--config' ]]; then echo -e "SCRIPT_NAME=$SCRIPT_NAME"; echo -e "SCRIPT_VERSION=$SCRIPT_VERSION"; echo -e "CONTENT_PATH=$CONTENT_PATH"; echo -e "LASTRUN_PID=$LASTRUN_PID";  fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
if [[ "$1" =~ '--config' ]]; then echo -e "SCRIPT_NAME=$SCRIPT_NAME"; echo -e "SCRIPT_VERSION=$SCRIPT_VERSION"; echo -e "CONTENT_PATH=$CONTENT_PATH"; echo -e "LASTRUN_PID=$LASTRUN_PID";  fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 25, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: $ start.sh
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
SCRIPT_NAME=$(basename ${0})
SCRIPT_VERSION="1.1.1"
CONTENT_PATH=${CONTENT_PATH:-/media/all/ProgramsAndGames/pr/Devdocs/MDN/content}
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn-docs-server.pid
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
# Export current configuration for import into another script .e.g ~/.zshrc
if [[ "$1" =~ '--config' ]]; then   echo -e "SCRIPT_NAME=$SCRIPT_NAME";   echo -e "SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "CONTENT_PATH=$CONTENT_PATH";   echo -e "LASTRUN_PID=$LASTRUN_PID";   exit 0; fi
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if [[ "$1" =~ '--config' ]]; then   echo -e "SCRIPT_NAME=$SCRIPT_NAME";   echo -e "SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "CONTENT_PATH=$CONTENT_PATH";   echo -e "LASTRUN_PID=$LASTRUN_PID";   exit 0; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 25, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: $ start.sh
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
SCRIPT_NAME=$(basename ${0})
SCRIPT_VERSION="1.1.1"
CONTENT_PATH=${CONTENT_PATH:-/media/all/ProgramsAndGames/pr/Devdocs/MDN/content}
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn-docs-server.pid
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
# Export current configuration for import into another script .e.g ~/.zshrc
if [[ "$1" =~ '--config' ]]; then   echo -e "SCRIPT_NAME=$SCRIPT_NAME";   echo -e "SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "CONTENT_PATH=$CONTENT_PATH";   echo -e "LASTRUN_PID=$LASTRUN_PID";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if [[ "$1" =~ '--config' ]]; then   echo -e "SCRIPT_NAME=$SCRIPT_NAME";   echo -e "SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "CONTENT_PATH=$CONTENT_PATH";   echo -e "LASTRUN_PID=$LASTRUN_PID";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 25, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: $ start.sh
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
SCRIPT_NAME=$(basename ${0})
SCRIPT_VERSION="1.1.1"
CONTENT_PATH=${CONTENT_PATH:-/media/all/ProgramsAndGames/pr/Devdocs/MDN/content}
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn-docs-server.pid
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
# Export current configuration for import into another script .e.g ~/.zshrc
if [[ "$1" =~ '--config' ]]; then   echo -e "SCRIPT_NAME=$SCRIPT_NAME";   echo -e "SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "CONTENT_PATH=$CONTENT_PATH";   echo -e "LASTRUN_PID=$LASTRUN_PID";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if [[ "$1" =~ '--config' ]]; then   echo -e "SCRIPT_NAME=$SCRIPT_NAME";   echo -e "SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "CONTENT_PATH=$CONTENT_PATH";   echo -e "LASTRUN_PID=$LASTRUN_PID";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 25, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: $ start.sh
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
# SCRIPT_NAME=$(basename ${0})
# SCRIPT_VERSION="1.1.1"
# CONTENT_PATH=${CONTENT_PATH:-/media/all/ProgramsAndGames/pr/Devdocs/MDN/content}
# NVM_VERSION="$(nvm version)";
# NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
# LASTRUN_PID_PATH=/tmp/mdn-docs-server.pid
# declare LAST_RUN_PID;
# KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
# Export current configuration for import into another script .e.g ~/.zshrc
if [[ "$1" =~ '--config' ]]; then   echo -e "SCRIPT_NAME=$SCRIPT_NAME";   echo -e "SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "CONTENT_PATH=$CONTENT_PATH";   echo -e "LASTRUN_PID=$LASTRUN_PID";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if [[ "$1" =~ '--config' ]]; then   echo -e "SCRIPT_NAME=$SCRIPT_NAME";   echo -e "SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "CONTENT_PATH=$CONTENT_PATH";   echo -e "LASTRUN_PID=$LASTRUN_PID";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 25, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: $ start.sh
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
SCRIPT_NAME=$(basename ${0})
SCRIPT_VERSION="1.1.1"
CONTENT_PATH=${CONTENT_PATH:-/media/all/ProgramsAndGames/pr/Devdocs/MDN/content}
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn-docs-server.pid
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
# Export current configuration for import into another script .e.g ~/.zshrc
if [[ "$1" =~ '--config' ]]; then   echo -e "SCRIPT_NAME=$SCRIPT_NAME";   echo -e "SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "CONTENT_PATH=$CONTENT_PATH";   echo -e "LASTRUN_PID=$LASTRUN_PID";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if [[ "$1" =~ '--config' ]]; then   echo -e "SCRIPT_NAME=$SCRIPT_NAME";   echo -e "SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "CONTENT_PATH=$CONTENT_PATH";   echo -e "LASTRUN_PID=$LASTRUN_PID";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 25, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: $ start.sh
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
SCRIPT_NAME=$(basename ${0})
SCRIPT_VERSION="1.1.1"
CONTENT_PATH=${CONTENT_PATH:-/media/all/ProgramsAndGames/pr/Devdocs/MDN/content}
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn-docs-server.pid
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
# Export current configuration for import into another script .e.g ~/.zshrc
if [[ "$1" =~ '--config' ]]; then   echo -e "SCRIPT_NAME=$SCRIPT_NAME";   echo -e "SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "CONTENT_PATH=$CONTENT_PATH";   echo -e "LASTRUN_PID=$LASTRUN_PID";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if [[ "$1" =~ '--config' ]]; then   echo -e "SCRIPT_NAME=$SCRIPT_NAME";   echo -e "SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "CONTENT_PATH=$CONTENT_PATH";   echo -e "LASTRUN_PID=$LASTRUN_PID";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 25, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: $ start.sh
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
SCRIPT_NAME=$(basename ${0})
SCRIPT_VERSION="1.1.1"
CONTENT_PATH=${CONTENT_PATH:-/media/all/ProgramsAndGames/pr/Devdocs/MDN/content}
NVM_VERSION="$(nvm version)";
NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
LASTRUN_PID_PATH=/tmp/mdn-docs-server.pid
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
# Export current configuration for import into another script .e.g ~/.zshrc
if [[ "$1" =~ '--config' ]]; then   echo -e "SCRIPT_NAME=$SCRIPT_NAME";   echo -e "SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "CONTENT_PATH=$CONTENT_PATH";   echo -e "LASTRUN_PID=$LASTRUN_PID";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if [[ "$1" =~ '--config' ]]; then   echo -e "SCRIPT_NAME=$SCRIPT_NAME";   echo -e "SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "CONTENT_PATH=$CONTENT_PATH";   echo -e "LASTRUN_PID=$LASTRUN_PID";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 25, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: $ start.sh
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
# type nvm &> /dev/null || {
#   console.err "$0: \x1B[31mError: \x1B[0m nvm is required, install from: https://github.com/nvm-sh/nvm"
#   echo -e "Aborting."
#   exit -1
# } # nvm check end
SCRIPT_NAME=$(basename ${0})
SCRIPT_VERSION="1.1.2"
CONTENT_PATH=${CONTENT_PATH:-/media/all/ProgramsAndGames/pr/Devdocs/MDN/content}
# NVM_VERSION="$(nvm version)";
# NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
NODE_PATH_BIN="$(which node)"
LASTRUN_PID_PATH=/tmp/mdn-docs-server.pid
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
# Export current configuration for import into another script .e.g ~/.zshrc
if [[ "$1" =~ '--config' ]]; then   echo -e "SCRIPT_NAME=$SCRIPT_NAME";   echo -e "SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "CONTENT_PATH=$CONTENT_PATH";   echo -e "LASTRUN_PID=$LASTRUN_PID";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
if [[ "$1" =~ '--config' ]]; then   echo -e "SCRIPT_NAME=$SCRIPT_NAME";   echo -e "SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "CONTENT_PATH=$CONTENT_PATH";   echo -e "LASTRUN_PID=$LASTRUN_PID";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 25, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: $ start.sh
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
# type nvm &> /dev/null || {
#   console.err "$0: \x1B[31mError: \x1B[0m nvm is required, install from: https://github.com/nvm-sh/nvm"
#   echo -e "Aborting."
#   exit -1
# } # nvm check end
SCRIPT_NAME=$(basename ${0})
SCRIPT_VERSION="1.1.2"
CONTENT_PATH=${CONTENT_PATH:-/media/all/ProgramsAndGames/pr/Devdocs/MDN/content}
# NVM_VERSION="$(nvm version)";
# NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
NODE_PATH_BIN="$(which node)"
LASTRUN_PID_PATH=/tmp/mdn-docs-server.pid
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
# Export current configuration for import into another script .e.g ~/.zshrc
if [[ "$1" =~ '--config' ]]; then   echo -e "SCRIPT_NAME=$SCRIPT_NAME";   echo -e "SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "CONTENT_PATH=$CONTENT_PATH";   echo -e "LASTRUN_PID=$LASTRUN_PID";   exit 0; fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
# Export current configuration for import into another script .e.g ~/.zshrc
if [[ "$1" =~ '--config' ]]; then   echo -e "SCRIPT_NAME=$SCRIPT_NAME";   echo -e "SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "CONTENT_PATH=$CONTENT_PATH";   echo -e "LASTRUN_PID=$LASTRUN_PID";   exit 0; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 25, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: $ start.sh
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
# type nvm &> /dev/null || {
#   console.err "$0: \x1B[31mError: \x1B[0m nvm is required, install from: https://github.com/nvm-sh/nvm"
#   echo -e "Aborting."
#   exit -1
# } # nvm check end
SCRIPT_NAME=$(basename ${0})
SCRIPT_PATH=$(realpath $SRIPT_NAME)
echo $SCRIPT_PATH
exit 0
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
SCRIPT_PATH=$(realpath $SRIPT_NAME)
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 25, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: $ start.sh
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
# type nvm &> /dev/null || {
#   console.err "$0: \x1B[31mError: \x1B[0m nvm is required, install from: https://github.com/nvm-sh/nvm"
#   echo -e "Aborting."
#   exit -1
# } # nvm check end
SCRIPT_NAME=$(basename ${0})
SCRIPT_PATH=$(realpath $SCRIPT_NAME)
echo $SCRIPT_PATH
exit 0
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 25, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: $ start.sh
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
# type nvm &> /dev/null || {
#   console.err "$0: \x1B[31mError: \x1B[0m nvm is required, install from: https://github.com/nvm-sh/nvm"
#   echo -e "Aborting."
#   exit -1
# } # nvm check end
SCRIPT_NAME=$(basename ${0})
SCRIPT_PATH=$(realpath $SCRIPT_NAME)
echo $SCRIPT_PATH
exit 0
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 25, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: $ start.sh
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
# type nvm &> /dev/null || {
#   console.err "$0: \x1B[31mError: \x1B[0m nvm is required, install from: https://github.com/nvm-sh/nvm"
#   echo -e "Aborting."
#   exit -1
# } # nvm check end
SCRIPT_NAME=$(basename ${0})
SCRIPT_PATH=$(realpath $SCRIPT_NAME)
echo $SCRIPT_PATH
exit 0
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 25, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: $ start.sh
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
# type nvm &> /dev/null || {
#   console.err "$0: \x1B[31mError: \x1B[0m nvm is required, install from: https://github.com/nvm-sh/nvm"
#   echo -e "Aborting."
#   exit -1
# } # nvm check end
SCRIPT_NAME=$(basename ${0})
SCRIPT_PATH=$(realpath $SCRIPT_NAME)
echo $SCRIPT_PATH
exit 0
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
exit 0
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 25, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: $ start.sh
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
# type nvm &> /dev/null || {
#   console.err "$0: \x1B[31mError: \x1B[0m nvm is required, install from: https://github.com/nvm-sh/nvm"
#   echo -e "Aborting."
#   exit -1
# } # nvm check end
SCRIPT_NAME=$(basename ${0})
SCRIPT_PATH=$(realpath $SCRIPT_NAME)
echo $SCRIPT_PATH
SCRIPT_VERSION="1.1.2"
CONTENT_PATH=${CONTENT_PATH:-/media/all/ProgramsAndGames/pr/Devdocs/MDN/content}
# NVM_VERSION="$(nvm version)";
# NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
NODE_PATH_BIN="$(which node)"
LASTRUN_PID_PATH=/tmp/mdn-docs-server.pid
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
# Export current configuration for import into another script .e.g ~/.zshrc
if [[ "$1" =~ '--config' ]]; then   echo -e "MDN_SCRIPT_NAME=$SCRIPT_NAME";   echo -e "MDN_SCRIPT_PATH=$SCRIPT_PATH";   echo -e "MDN_SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "MDN_CONTENT_PATH=$CONTENT_PATH";   echo -e "MDN_LASTRUN_PID_PATH=$LASTRUN_PID_PATH";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
if [[ "$1" =~ '--config' ]]; then   echo -e "MDN_SCRIPT_NAME=$SCRIPT_NAME";   echo -e "MDN_SCRIPT_PATH=$SCRIPT_PATH";   echo -e "MDN_SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "MDN_CONTENT_PATH=$CONTENT_PATH";   echo -e "MDN_LASTRUN_PID_PATH=$LASTRUN_PID_PATH";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 25, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: $ start.sh
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
# type nvm &> /dev/null || {
#   console.err "$0: \x1B[31mError: \x1B[0m nvm is required, install from: https://github.com/nvm-sh/nvm"
#   echo -e "Aborting."
#   exit -1
# } # nvm check end
CONTENT_PATH=${CONTENT_PATH:-/media/all/ProgramsAndGames/pr/Devdocs/MDN/content}
SCRIPT_NAME=$(basename ${0})
echo $0
SCRIPT_PATH=$(realpath ${0}}
SCRIPT_VERSION="1.1.2"
# NVM_VERSION="$(nvm version)";
# NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
NODE_PATH_BIN="$(which node)"
LASTRUN_PID_PATH=/tmp/mdn-docs-server.pid
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"

#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]];
then
  echo -e "${SCRIPT_VERSION}"

fi
if [[ "$1" =~ '--help' ]]
then
  echo -e "MDN Docs Start script v${SCRIPT_VERSION}"
  echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";
  echo -e "A helper script to run yari server.";
  echo -e "Accepted ENV variables:";
  echo -e "\tCONTENT_PATH=./content   to setup up path to content root";
  echo -e "\tSERVER_PORT=5042         to setup up custom port";
  exit 0
fi

# Export current configuration for import into another script .e.g ~/.zshrc
if [[ "$1" =~ '--config' ]];
then
  echo -e "MDN_SCRIPT_NAME=$SCRIPT_NAME"
  echo -e "MDN_SCRIPT_PATH=$SCRIPT_PATH"
  echo -e "MDN_SCRIPT_VERSION=$SCRIPT_VERSION"
  echo -e "MDN_CONTENT_PATH=$CONTENT_PATH"
  echo -e "MDN_LASTRUN_PID_PATH=$LASTRUN_PID_PATH"
  exit 0
fi

export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null
then
  console.ok "${SCRIPT_NAME}: server is already running!"
  echo -e "${KILL_MESSAGE}"
  exit 0;
else
  console.wrn "${SCRIPT_NAME} starting up server..."
fi



# Check for content path, node and last pid path
#-------------------------------------
[[ -d "$CONTENT_PATH"     ]] || { console.err "$0: content folder not found"; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err "$0: node is not found"       ; exit 2; };
[[ -s "$LASTRUN_PID_PATH" ]] && {

  # If PID of the last run of the Yari server is found
  # If it's running process
  # if it's in the PID range of 30k+
  # Then kill the process
  #-------------------------------------
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";
  mdn.docs.kill &> /dev/null;
} # [[ ... ]]


# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
dirs -c
pushd $CONTENT_PATH;
CONTENT_ROOT=files \
REACT_APP_DISABLE_AUTH=true \
BUILD_OUT_ROOT=build \
node ./node_modules/@mdn/yari/server \
& echo $! > $LASTRUN_PID_PATH;
disown
sleep 3s && xdg-open http://localhost:$SERVER_PORT &

# Report
#-------------------------------------
console.ok "$0: MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "$0: MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e ${KILL_MESSAGE}

console.ok "$0: MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "$0: MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e ${KILL_MESSAGE}
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 25, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: $ start.sh
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
# type nvm &> /dev/null || {
#   console.err "$0: \x1B[31mError: \x1B[0m nvm is required, install from: https://github.com/nvm-sh/nvm"
#   echo -e "Aborting."
#   exit -1
# } # nvm check end
CONTENT_PATH=${CONTENT_PATH:-/media/all/ProgramsAndGames/pr/Devdocs/MDN/content}
SCRIPT_NAME=$(basename ${0})
echo $0
SCRIPT_PATH=$(realpath ${0})
SCRIPT_VERSION="1.1.2"
# NVM_VERSION="$(nvm version)";
# NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
NODE_PATH_BIN="$(which node)"
LASTRUN_PID_PATH=/tmp/mdn-docs-server.pid
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
# Export current configuration for import into another script .e.g ~/.zshrc
if [[ "$1" =~ '--config' ]]; then   echo -e "MDN_SCRIPT_NAME=$SCRIPT_NAME";   echo -e "MDN_SCRIPT_PATH=$SCRIPT_PATH";   echo -e "MDN_SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "MDN_CONTENT_PATH=$CONTENT_PATH";   echo -e "MDN_LASTRUN_PID_PATH=$LASTRUN_PID_PATH";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if [[ "$1" =~ '--config' ]]; then   echo -e "MDN_SCRIPT_NAME=$SCRIPT_NAME";   echo -e "MDN_SCRIPT_PATH=$SCRIPT_PATH";   echo -e "MDN_SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "MDN_CONTENT_PATH=$CONTENT_PATH";   echo -e "MDN_LASTRUN_PID_PATH=$LASTRUN_PID_PATH";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 25, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: $ start.sh
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
# type nvm &> /dev/null || {
#   console.err "$0: \x1B[31mError: \x1B[0m nvm is required, install from: https://github.com/nvm-sh/nvm"
#   echo -e "Aborting."
#   exit -1
# } # nvm check end
CONTENT_PATH=${CONTENT_PATH:-/media/all/ProgramsAndGames/pr/Devdocs/MDN/content}
SCRIPT_NAME=$(basename ${0})
echo $0
SCRIPT_PATH=$(realpath ${0})
SCRIPT_VERSION="1.1.2"
# NVM_VERSION="$(nvm version)";
# NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
NODE_PATH_BIN="$(which node)"
LASTRUN_PID_PATH=/tmp/mdn-docs-server.pid
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
# Export current configuration for import into another script .e.g ~/.zshrc
if [[ "$1" =~ '--config' ]]; then   echo -e "MDN_SCRIPT_NAME=$SCRIPT_NAME";   echo -e "MDN_SCRIPT_PATH=$SCRIPT_PATH";   echo -e "MDN_SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "MDN_CONTENT_PATH=$CONTENT_PATH";   echo -e "MDN_LASTRUN_PID_PATH=$LASTRUN_PID_PATH";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if [[ "$1" =~ '--config' ]]; then   echo -e "MDN_SCRIPT_NAME=$SCRIPT_NAME";   echo -e "MDN_SCRIPT_PATH=$SCRIPT_PATH";   echo -e "MDN_SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "MDN_CONTENT_PATH=$CONTENT_PATH";   echo -e "MDN_LASTRUN_PID_PATH=$LASTRUN_PID_PATH";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 25, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: $ start.sh
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
# type nvm &> /dev/null || {
#   console.err "$0: \x1B[31mError: \x1B[0m nvm is required, install from: https://github.com/nvm-sh/nvm"
#   echo -e "Aborting."
#   exit -1
# } # nvm check end
CONTENT_PATH=${CONTENT_PATH:-/media/all/ProgramsAndGames/pr/Devdocs/MDN/content}
SCRIPT_NAME=$(basename ${0})
SCRIPT_PATH=$(realpath ${0})
SCRIPT_VERSION="1.1.2"
# NVM_VERSION="$(nvm version)";
# NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
NODE_PATH_BIN="$(which node)"
LASTRUN_PID_PATH=/tmp/mdn-docs-server.pid
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
# Export current configuration for import into another script .e.g ~/.zshrc
if [[ "$1" =~ '--config' ]]; then   echo -e "MDN_SCRIPT_NAME=$SCRIPT_NAME";   echo -e "MDN_SCRIPT_PATH=$SCRIPT_PATH";   echo -e "MDN_SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "MDN_CONTENT_PATH=$CONTENT_PATH";   echo -e "MDN_LASTRUN_PID_PATH=$LASTRUN_PID_PATH";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if [[ "$1" =~ '--config' ]]; then   echo -e "MDN_SCRIPT_NAME=$SCRIPT_NAME";   echo -e "MDN_SCRIPT_PATH=$SCRIPT_PATH";   echo -e "MDN_SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "MDN_CONTENT_PATH=$CONTENT_PATH";   echo -e "MDN_LASTRUN_PID_PATH=$LASTRUN_PID_PATH";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 25, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: $ start.sh
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
# type nvm &> /dev/null || {
#   console.err "$0: \x1B[31mError: \x1B[0m nvm is required, install from: https://github.com/nvm-sh/nvm"
#   echo -e "Aborting."
#   exit -1
# } # nvm check end
CONTENT_PATH=${CONTENT_PATH:-/media/all/ProgramsAndGames/pr/Devdocs/MDN/content}
SCRIPT_NAME=$(basename ${0})
SCRIPT_PATH=$(realpath ${0})
SCRIPT_VERSION="1.1.2"
# NVM_VERSION="$(nvm version)";
# NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
NODE_PATH_BIN="$(which node)"
LASTRUN_PID_PATH=/tmp/mdn-docs-server.pid
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
# Export current configuration for import into another script .e.g ~/.zshrc
if [[ "$1" =~ '--config' ]]; then   echo -e "MDN_SCRIPT_NAME=$SCRIPT_NAME";   echo -e "MDN_SCRIPT_PATH=$SCRIPT_PATH";   echo -e "MDN_SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "MDN_CONTENT_PATH=$CONTENT_PATH";   echo -e "MDN_LASTRUN_PID_PATH=$LASTRUN_PID_PATH";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if [[ "$1" =~ '--config' ]]; then   echo -e "MDN_SCRIPT_NAME=$SCRIPT_NAME";   echo -e "MDN_SCRIPT_PATH=$SCRIPT_PATH";   echo -e "MDN_SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "MDN_CONTENT_PATH=$CONTENT_PATH";   echo -e "MDN_LASTRUN_PID_PATH=$LASTRUN_PID_PATH";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 25, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: $ start.sh
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
# type nvm &> /dev/null || {
#   console.err "$0: \x1B[31mError: \x1B[0m nvm is required, install from: https://github.com/nvm-sh/nvm"
#   echo -e "Aborting."
#   exit -1
# } # nvm check end
CONTENT_PATH=${CONTENT_PATH:-/media/all/ProgramsAndGames/pr/Devdocs/MDN/content}
SCRIPT_NAME=$(basename ${0})
SCRIPT_PATH=$(realpath ${0})
SCRIPT_VERSION="1.1.2"
# NVM_VERSION="$(nvm version)";
# NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
NODE_PATH_BIN="$(which node)"
LASTRUN_PID_PATH=/tmp/mdn-docs-server.pid
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
# Export current configuration for import into another script .e.g ~/.zshrc
if [[ "$1" =~ '--config' ]]; then   echo -e "MDN_SCRIPT_NAME=$SCRIPT_NAME";   echo -e "MDN_SCRIPT_PATH=$SCRIPT_PATH";   echo -e "MDN_SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "MDN_CONTENT_PATH=$CONTENT_PATH";   echo -e "MDN_LASTRUN_PID_PATH=$LASTRUN_PID_PATH";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if [[ "$1" =~ '--config' ]]; then   echo -e "MDN_SCRIPT_NAME=$SCRIPT_NAME";   echo -e "MDN_SCRIPT_PATH=$SCRIPT_PATH";   echo -e "MDN_SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "MDN_CONTENT_PATH=$CONTENT_PATH";   echo -e "MDN_LASTRUN_PID_PATH=$LASTRUN_PID_PATH";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 25, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: $ start.sh
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
# type nvm &> /dev/null || {
#   console.err "$0: \x1B[31mError: \x1B[0m nvm is required, install from: https://github.com/nvm-sh/nvm"
#   echo -e "Aborting."
#   exit -1
# } # nvm check end
CONTENT_PATH=${CONTENT_PATH:-/media/all/ProgramsAndGames/pr/Devdocs/MDN/content}
SCRIPT_NAME=$(basename ${0})
SCRIPT_PATH=$(realpath ${0})
SCRIPT_VERSION="1.1.2"
# NVM_VERSION="$(nvm version)";
# NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
NODE_PATH_BIN="$(which node)"
LASTRUN_PID_PATH=/tmp/mdn-docs-server.pid
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
# Export current configuration for import into another script .e.g ~/.zshrc
if [[ "$1" =~ '--config' ]]; then   echo -e "MDN_SCRIPT_NAME=$SCRIPT_NAME";   echo -e "MDN_SCRIPT_PATH=$SCRIPT_PATH";   echo -e "MDN_SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "MDN_CONTENT_PATH=$CONTENT_PATH";   echo -e "MDN_LASTRUN_PID_PATH=$LASTRUN_PID_PATH";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if [[ "$1" =~ '--config' ]]; then   echo -e "MDN_SCRIPT_NAME=$SCRIPT_NAME";   echo -e "MDN_SCRIPT_PATH=$SCRIPT_PATH";   echo -e "MDN_SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "MDN_CONTENT_PATH=$CONTENT_PATH";   echo -e "MDN_LASTRUN_PID_PATH=$LASTRUN_PID_PATH";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 25, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: $ start.sh
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
# type nvm &> /dev/null || {
#   console.err "$0: \x1B[31mError: \x1B[0m nvm is required, install from: https://github.com/nvm-sh/nvm"
#   echo -e "Aborting."
#   exit -1
# } # nvm check end
CONTENT_PATH=${CONTENT_PATH:-/media/all/ProgramsAndGames/pr/Devdocs/MDN/content}
SCRIPT_NAME=$(basename ${0})
SCRIPT_PATH=$(realpath ${0})
SCRIPT_VERSION="1.1.2"
# NVM_VERSION="$(nvm version)";
# NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
NODE_PATH_BIN="$(which node)"
LASTRUN_PID_PATH=/tmp/mdn-docs-server.pid
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
# Export current configuration for import into another script .e.g ~/.zshrc
if [[ "$1" =~ '--config' ]]; then   echo -e "MDN_SCRIPT_NAME=$SCRIPT_NAME";   echo -e "MDN_SCRIPT_PATH=$SCRIPT_PATH";   echo -e "MDN_SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "MDN_CONTENT_PATH=$CONTENT_PATH";   echo -e "MDN_LASTRUN_PID_PATH=$LASTRUN_PID_PATH";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
if [[ "$1" =~ '--config' ]]; then   echo -e "MDN_SCRIPT_NAME=$SCRIPT_NAME";   echo -e "MDN_SCRIPT_PATH=$SCRIPT_PATH";   echo -e "MDN_SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "MDN_CONTENT_PATH=$CONTENT_PATH";   echo -e "MDN_LASTRUN_PID_PATH=$LASTRUN_PID_PATH";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 25, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: $ start.sh
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
# type nvm &> /dev/null || {
#   console.err "$0: \x1B[31mError: \x1B[0m nvm is required, install from: https://github.com/nvm-sh/nvm"
#   echo -e "Aborting."
#   exit -1
# } # nvm check end
CONTENT_PATH=${CONTENT_PATH:-/media/all/ProgramsAndGames/pr/Devdocs/MDN/content}
SCRIPT_NAME=$(basename ${0})
SCRIPT_PATH=$(realpath ${0})
SCRIPT_VERSION="1.1.2"
# NVM_VERSION="$(nvm version)";
# NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
NODE_PATH_BIN="$(which node)"
LASTRUN_PID_PATH=/tmp/mdn-docs-server.pid
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
# Export current configuration for import into another script .e.g ~/.zshrc
# e.g. use it like so $ source <(bash scrpts/start.sh)
if [[ "$1" =~ '--config' ]]; then   echo -e "MDN_SCRIPT_NAME=$SCRIPT_NAME";   echo -e "MDN_SCRIPT_PATH=$SCRIPT_PATH";   echo -e "MDN_SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "MDN_CONTENT_PATH=$CONTENT_PATH";   echo -e "MDN_LASTRUN_PID_PATH=$LASTRUN_PID_PATH";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err "$0: content folder not found"; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err "$0: node is not found"       ; exit 2; };
[[ -s "$LASTRUN_PID_PATH" ]] && {
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
dirs -c
pushd $CONTENT_PATH;
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
disown
sleep 3s && xdg-open http://localhost:$SERVER_PORT &
# Report
#-------------------------------------
console.ok "$0: MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "$0: MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e ${KILL_MESSAGE}
if [[ "$1" =~ '--config' ]]; then   echo -e "MDN_SCRIPT_NAME=$SCRIPT_NAME";   echo -e "MDN_SCRIPT_PATH=$SCRIPT_PATH";   echo -e "MDN_SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "MDN_CONTENT_PATH=$CONTENT_PATH";   echo -e "MDN_LASTRUN_PID_PATH=$LASTRUN_PID_PATH";   exit 0; fi
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 25, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: $ start.sh
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
# type nvm &> /dev/null || {
#   console.err "$0: \x1B[31mError: \x1B[0m nvm is required, install from: https://github.com/nvm-sh/nvm"
#   echo -e "Aborting."
#   exit -1
# } # nvm check end
CONTENT_PATH=${CONTENT_PATH:-/media/all/ProgramsAndGames/pr/Devdocs/MDN/content}
SCRIPT_NAME=$(basename ${0})
SCRIPT_PATH=$(realpath ${0})
SCRIPT_VERSION="1.1.2"
# NVM_VERSION="$(nvm version)";
# NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
NODE_PATH_BIN="$(which node)"
LASTRUN_PID_PATH=/tmp/mdn-docs-server.pid
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
# Export current configuration for import into another script .e.g ~/.zshrc
# e.g. use it like so $ source <(bash scrpts/start.sh)
if [[ "$1" =~ '--config' ]]; then   echo -e "MDN_SCRIPT_NAME=$SCRIPT_NAME";   echo -e "MDN_SCRIPT_PATH=$SCRIPT_PATH";   echo -e "MDN_SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "MDN_CONTENT_PATH=$CONTENT_PATH";   echo -e "MDN_LASTRUN_PID_PATH=$LASTRUN_PID_PATH";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err "$0: content folder not found"; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err "$0: node is not found"       ; exit 2; };
[[ -s "$LASTRUN_PID_PATH" ]] && {
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
dirs -c
pushd $CONTENT_PATH;
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
disown
sleep 3s && xdg-open http://localhost:$SERVER_PORT &
# Report
#-------------------------------------
console.ok "$0: MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "$0: MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e ${KILL_MESSAGE}
#!/usr/bin/bash -i
#!/usr/bin/env -S bash
echo $path
echo "$0: all engines running!"
#!/usr/bin/env -S bash -i
echo $PATh
echo "$0 all engines running!"
# ex:ft=zsh
#!/usr/bin/env -S bash -i
echo $PATH
echo "$0 all engines running!"
# ex:ft=zsh
#!/usr/bin/env -S bash -i
echo $path
echo "$0 all engines running!"
# ex:ft=zsh
#!/usr/bin/env -S bash -i
echo $PATH
echo "$0 all engines running!"
# ex:ft=zsh
#!/usr/bin/env -S bash -i
echo $PATH
echo "$0 all engines running!"
# ex:ft=zsh
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 25, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: $ start.sh
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
# type nvm &> /dev/null || {
#   console.err "$0: \x1B[31mError: \x1B[0m nvm is required, install from: https://github.com/nvm-sh/nvm"
#   echo -e "Aborting."
#   exit -1
# } # nvm check end
CONTENT_PATH=${CONTENT_PATH:-/media/all/ProgramsAndGames/pr/Devdocs/MDN/content}
SCRIPT_NAME=$(basename ${0})
SCRIPT_PATH=$(realpath ${0})
SCRIPT_VERSION="1.1.2"
# NVM_VERSION="$(nvm version)";
# NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
NODE_PATH_BIN="$(which node)"
LASTRUN_PID_PATH=/tmp/mdn-docs-server.pid
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
# Export current configuration for import into another script .e.g ~/.zshrc
# e.g. use it like so $ source <(bash scrpts/start.sh)
if [[ "$1" =~ '--config' ]]; then   echo -e "MDN_SCRIPT_NAME=$SCRIPT_NAME";   echo -e "MDN_SCRIPT_PATH=$SCRIPT_PATH";   echo -e "MDN_SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "MDN_CONTENT_PATH=$CONTENT_PATH";   echo -e "MDN_LASTRUN_PID_PATH=$LASTRUN_PID_PATH";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err "$0: content folder not found"; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err "$0: node is not found"       ; exit 2; };
[[ -s "$LASTRUN_PID_PATH" ]] && {
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
dirs -c
pushd $CONTENT_PATH;
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
disown
sleep 3s && xdg-open http://localhost:$SERVER_PORT &
# Report
#-------------------------------------
console.ok "$0: MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "$0: MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e ${KILL_MESSAGE}
 which nvim-x
  { IFS= read -rd '' value <"content" } 2>/dev/null;     printf '%s' "$value"
  { IFS= read -rd '' value <<<"content" } 2>/dev/null;     printf '%s' "$value"
  { IFS= read -rd '' value <<<"content"; } 2>/dev/null;     printf '%s' "$value"
 which nvim-x
  { IFS= read -rd '' value <"content" } 2>/dev/null;     printf '%s' "$value"
  { IFS= read -rd '' value <<<"content" } 2>/dev/null;     printf '%s' "$value"
  { IFS= read -rd '' value <<<"content"; } 2>/dev/null;     printf '%s' "$value"
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 25, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: $ start.sh
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
# type nvm &> /dev/null || {
#   console.err "$0: \x1B[31mError: \x1B[0m nvm is required, install from: https://github.com/nvm-sh/nvm"
#   echo -e "Aborting."
#   exit -1
# } # nvm check end
CONTENT_PATH=${CONTENT_PATH:-/media/all/ProgramsAndGames/pr/Devdocs/MDN/content}
SCRIPT_NAME=$(basename ${0})
SCRIPT_PATH=$(realpath ${0})
SCRIPT_VERSION="1.1.2"
# NVM_VERSION="$(nvm version)";
# NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
NODE_PATH_BIN="$(which node)"
LASTRUN_PID_PATH=/tmp/mdn-docs-server.pid
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
# Export current configuration for import into another script .e.g ~/.zshrc
# e.g. use it like so $ source <(bash scrpts/start.sh)
if [[ "$1" =~ '--config' ]]; then   echo -e "MDN_SCRIPT_NAME=$SCRIPT_NAME";   echo -e "MDN_SCRIPT_PATH=$SCRIPT_PATH";   echo -e "MDN_SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "MDN_CONTENT_PATH=$CONTENT_PATH";   echo -e "MDN_LASTRUN_PID_PATH=$LASTRUN_PID_PATH";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err "$0: content folder not found"; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err "$0: node is not found"       ; exit 2; };
[[ -s "$LASTRUN_PID_PATH" ]] && {
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
dirs -c
pushd $CONTENT_PATH;
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
disown
sleep 3s && xdg-open http://localhost:$SERVER_PORT &
# Report
#-------------------------------------
console.ok "$0: MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "$0: MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e ${KILL_MESSAGE}
 FONT_FLAGS=' -fs 10 -fa "JetBrainsMono Nerd Font Mono"'
 xterm ${FONT_FLAGS} -e nvim
 xterm "${FONT_FLAGS}" -e nvim
 eval "xterm ${FONT_FLAGS} -e nvim"
 v="xterm ${FONT_FLAGS} -e nvim"
 echo $v
 $v
  nvim-x
 v='xterm -e nvim -fs 10 -fa "JetBrainsMono Nerd Font"'; $v
 echo $v
 xterm -e nvim -fs 10 -fa "JetBrainsMono Nerd Font"
 xterm -fs 10 -fa "JetBrainsMono Nerd Font" -e nvim
  v='xterm -fs 10 -fa "JetBrainsMono Nerd Font" -e nvim'; $v
 v='xterm -fs 10 -fa "JetBrainsMono Nerd Font" -e nvim'; $v
 v='xterm -fs 10 -fa "JetBrainsMonoNerdFont" -e nvim'; $v
 v='xterm -fs 10 -fa JetBrainsMono Nerd Font -e nvim'; $v
 v='xterm -fs 10 -fa JetBrainsMono\ Nerd Font -e nvim'; $v
 fc-list -q "JetBrainsMono Nerd Font Mono" || { 	echo "$0: JetBrainsMono Nerd Font Mono is not found!"; 	echo "\x1B[22m \x1B[1;36m?\x1B[0m Install JetBrainsMono Nerd Font Mono (~100mb)(Y/n)"; 	if read -sr -N 1; [[ ${REPLY} =~ [yY$'\n'] ]]; 	then 		local TEMPDIR=$(mktemp -d); 		git clone --depth 1 --filter=blob:none --sparse git@github.com:ryanoasis/nerd-fonts.git "$TEMPDIR"; 		pusdh "$TEMPDIR"; 		git sparse-checkout add patched-fonts/JetBrainsMono; 		fc-list -q %s
		./install.sh -s -S JetBrainsMono;  		popd; 	fi;  }
 bindkey
 keybind
 bind 
 bind -L
 bind -l
 bind -l -k
 bind -p
 bind -S
 bind -v
 bind -V
 bind -X
 bind -x
 bind 
 bind -P
 bind
 bindkey
 bind
 bind -a
 bind -P
 bind -S
 bind -P | less
 bind \C-h:backward-kill
 bind \C-H:backward-kill
 bind ^H:backward-kill
 bind -l
 bind -l | less
 bind \C-h:backward-kill
 bind -P | less
 bind -x \C-H:backward-kill
 bind -x \C-h:backward-kill
 bind -x \C-h:backward-kill-word 
 bind -x '\C-h:backward-kill-word '
 bind -x '\C-h:backward-kill-word'
 bind -x "\C-h:backward-kill-word"
 bind  \C-H:backward-kill-word
 bind  \C-H:backward-kill-word; bind -P | fgrep kill-word
 bind -u backward-kill-word
 bind -P | less
 bind  \C-H:backward-kill-word; bind -P | fgrep kill-word
 nvim-x ~/.bashrc
 bg 
 man lesspipe
 /bin/sh lesspipe
 which lesspipe
 sh lesspipe
 sh -c lesspipe
 var=""
 var+="asdf"
 echo $var
 bash
fasdfasfasdfasdf
aaa-------b-ccc
# 
 ll
# 
 ll
 
 EDITOR=nvim-x 
 EDITOR=nvim-x
 EDITOR=nvim-x
 
echo "${0}: this is an interactive script!"
  bind -P | fgrep kill-word
  bind -P | fgrep edit-
 vi
  man vi
 ll
 vi LICENSE README.MD 
 nvim-x
 vi LICENSE README.MD examples.bash 
 vi -h
 vim
 man vi
 vi
 ll
 echo $EDITOR
 EDITOR=nvim
 EDITOR=nvim
 
echo "from temporary script"
 ll /tmp/
 man mktemp
 mktemp wtf
 mktemp wtf.xxxx
 mktemp wtf.xxxxxxx
 mktemp 'wtf.xxxxxxxxx'
 mktemp wtf.XXXXX
 mktemp wtf.XXXXXXXXXXx
type  edit-and-execute-command
 dpkg -L bash
 less /usr/share/doc/bash/README.commands.gz
 dpkg -L bash-completion
 dpkg -L bash-completion | less
 dpkg -L zsh-completion | less
 dpkg -L zsh-common | less
 ll /usr/share/zsh/functions/Completion/Unix/_vim
 nvim-x -r /usr/share/zsh/functions/Completion/Unix/_vim
 man nvim
 nvim-x -R /usr/share/zsh/functions/Completion/Unix/_vim
 nvim-x /usr/share/zsh/functions/Completion/Unix/_vim
 v="str"; echo ${v@Q}
 v="str"; echo ${v@E}
 v="xyz=str"; echo ${vA}
 echo $xyz
 v="xyz=str"; eval ${vA}; echo $xyz
 v="xyz=str"; eval ${v@A}; echo $xyz
 v="xyz=str"; echo ${v@A}; echo $xyz
 v="xyz=str"; echo ${v@A}; echo $v
 v="xyz=str"; ${v@A}; echo $v
 v="xyz=str"; echo $v
 echo ${v@a}
 v="wow" echo ${v@u}
 v="wow" echo ${v@U}
 v=(one two three); echo ${v[@]/^/fuck}
 v=(one two three); echo ${v[@]/^./fuck}
 v=(one two three); echo ${v[@]//^./fuck}
 _=[ "one" "" ]del _
 command -v python2.7_ && echo true || echo false
sh
 [ command -v python2.3_ ];
 v=[ command -v python2.3_ ]; 
 v=[ command -v python2.3_ ]; echo $v
 v=[ command -v python2.3_ ]; echo $?
 v=[ command -v python2.7 ]; echo $?
  umask -p
 
 v=[ command -v python2.3_ ]; echo $?
 v=[ command -v python2.7 ]; echo $?
  umask -p
 
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 25, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: $ start.sh
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
# type nvm &> /dev/null || {
#   console.err "$0: \x1B[31mError: \x1B[0m nvm is required, install from: https://github.com/nvm-sh/nvm"
#   echo -e "Aborting."
#   exit -1
# } # nvm check end
CONTENT_PATH=${CONTENT_PATH:-/media/all/ProgramsAndGames/pr/Devdocs/MDN/content}
SCRIPT_NAME=$(basename ${0})
SCRIPT_PATH=$(realpath ${0})
SCRIPT_VERSION="1.1.2"
# NVM_VERSION="$(nvm version)";
# NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
NODE_PATH_BIN="$(which node)"
LASTRUN_PID_PATH=/tmp/mdn-docs-server.pid
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
# Export current configuration for import into another script .e.g ~/.zshrc
# e.g. use it like so $ source <(bash scrpts/start.sh)
if [[ "$1" =~ '--config' ]]; then   echo -e "MDN_SCRIPT_NAME=$SCRIPT_NAME";   echo -e "MDN_SCRIPT_PATH=$SCRIPT_PATH";   echo -e "MDN_SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "MDN_CONTENT_PATH=$CONTENT_PATH";   echo -e "MDN_LASTRUN_PID_PATH=$LASTRUN_PID_PATH";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err "$0: content folder not found"; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err "$0: node is not found"       ; exit 2; };
[[ -s "$LASTRUN_PID_PATH" ]] && {
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
dirs -c
pushd $CONTENT_PATH;
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
disown
sleep 3s && xdg-open http://localhost:$SERVER_PORT &
# Report
#-------------------------------------
console.ok "$0: MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "$0: MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e ${KILL_MESSAGE}
 where
 which
 which which
 man which
 man whence
 which
 which which
 man which
 man whence
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 25, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: $ start.sh
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
# type nvm &> /dev/null || {
#   console.err "$0: \x1B[31mError: \x1B[0m nvm is required, install from: https://github.com/nvm-sh/nvm"
#   echo -e "Aborting."
#   exit -1
# } # nvm check end
CONTENT_PATH=${CONTENT_PATH:-/media/all/ProgramsAndGames/pr/Devdocs/MDN/content}
SCRIPT_NAME=$(basename ${0})
SCRIPT_PATH=$(realpath ${0})
SCRIPT_VERSION="1.1.2"
# NVM_VERSION="$(nvm version)";
# NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
NODE_PATH_BIN="$(which node)"
LASTRUN_PID_PATH=/tmp/mdn-docs-server.pid
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
# Export current configuration for import into another script .e.g ~/.zshrc
# e.g. use it like so $ source <(bash scrpts/start.sh)
if [[ "$1" =~ '--config' ]]; then   echo -e "MDN_SCRIPT_NAME=$SCRIPT_NAME";   echo -e "MDN_SCRIPT_PATH=$SCRIPT_PATH";   echo -e "MDN_SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "MDN_CONTENT_PATH=$CONTENT_PATH";   echo -e "MDN_LASTRUN_PID_PATH=$LASTRUN_PID_PATH";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err "$0: content folder not found"; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err "$0: node is not found"       ; exit 2; };
[[ -s "$LASTRUN_PID_PATH" ]] && {
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
dirs -c
pushd $CONTENT_PATH;
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
disown
sleep 3s && xdg-open http://localhost:$SERVER_PORT &
# Report
#-------------------------------------
console.ok "$0: MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "$0: MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e ${KILL_MESSAGE}
 cfg.test(){ echo "wtf" ;}
 v="FOO" ;echo "${v@Lu}"
 v="FOO" ;echo "${v@L}"
 v="FOO" ;echo "${v@u}"
 v="FOO" ;echo "${v@U}"
 v="FOO" ;echo "${v@L}"
 v="FOO" ;echo "${v@A}"
 rm ~/.zsh_history 
 rm ~/.zsh_history ; ll $_
 stow zsh
 ls ~/.zsh_history 
 ll ~/.zsh_history 
 du -h ~/.zsh_history 
 ll zsh/.zsh_his
 ll zsh/.zsh_history
 ll -L ~/.zsh_history
 ll
  cd zsh
 ll
les .zsh_history_backup
less .zsh_history_backup
sed "s/^[[:digit:]]*  " <(head .zsh_history_backup)
sed "s/^[[:digit:]]*  //" <(head .zsh_history_backup)
sed "s/^[[:digit:]]+  //" <(head .zsh_history_backup)
sed -e "s/^[[:digit:]]+  //" <(head .zsh_history_backup)
sed -e "s/[[:digit:]]+  //" <(head .zsh_history_backup)
sed -e "s/[[:digit:]]*/____/" <(head .zsh_history_backup)
sed -e "s/[[:digit:]]* //" <(head .zsh_history_backup)
sed -e "s/[[:digit:]]* //" .zsh_history_backup > .zsh_history
 cd sh
 cd zsh
 ll
 sed -e "s/[[:digit:]]* //" .zsh_history_backup
 sed -e "s/[[:digit:]]* //" .zsh_history_backup > .zsh_history
 head .zsh_history
tail .zsh_history
 cp -f zsh/.zsh_history ~/.zsh_history
 ll
 cd /media/alex/rhea-home/alex/
ll
 ll
 clear; ll /media/alex/rhea-home/alex/.zsh_history 
 clear; less /media/alex/rhea-home/alex/.zsh_history 
 clear; cp -f /media/alex/rhea-home/alex/.zsh_history ~/.zsh_history
 clear; cp -f /media/alex/rhea-home/alex/.zsh_history ~/dotfiles/
 zsh
 rm .zsh_history; cp .zsh_history_backup3 -f ~/.zsh_history; cmp $_ .zsh_history_backup3
ll
 cmp .zsh_history_backup .zsh_history_backup3
 echo $_
 diff .zsh_history_backup .zsh_history_backup3
 rm zsh_history_backup3
 ll
 rm .zsh_history_backup3
 ll
 man kfmclient
 ll ~/.local/share/Trash/
ll
  ll
 foo(){ return 0 } ; ;
 foo(){ return 0; }
 foo(){ return 0 }
 foo(){ return 0; }
 foo(){ return 0 }
 caller
 declare -p BASH_SOURCE
 for val in {7..255}; do        (( $val % 2 )) || echo -n "$(tput setaf ${val})XXX$(tput op)" ;     done
 time for val in {7..255}; do        (( $val % 2 )) || echo -n "$(tput setaf ${val})XXX$(tput op)" ;     done
 time for val in {7..255}; do echo -n "$(tput setaf ${val})XXX$(tput op)" ;     done
 time for val in {7..255}; do echo -n "$(tput setaf ${val})XXX$(tput op)"  (( $val % 16 )) && echo "" ;     done
 time for val in {7..255}; do \echo -n "$(tput setaf ${val})XXX$(tput op)"  (( $val % 16 )) && echo "" ;     done
 time for val in {7..255}; do \ echo -n "$(tput setaf ${val})XXX$(tput op)"  (( $val % 16 )) && echo "" ;     done
 time for val in {7..255}; do echo -n "$(tput setaf ${val})XXX$(tput op)"  (( $val % 16 )) && echo "" ;     done
 time for val in {7..255}; do echo -n "$(tput setaf ${val})XXX$(tput op)" ; (( $val % 16 )) && echo "" ;     done
 time for val in {7..255}; do echo -n "$(tput setaf ${val})XXX$(tput op)" ; (( $val % 2 )) && echo "" ;     done
 time for val in {7..255}; do echo -n "$(tput setaf ${val})XXX$(tput op)" ; (( $val % 8 )) || echo "" ;     done
 time for val in {7..255}; do echo -n "$(tput setaf ${val})XXX$(tput op)" ; (( $val % 7 )) || echo "" ;     done
 time for val in {7..255}; do echo -n "$(tput setaf ${val})XXX$(tput op)" ; (( $val % 10 )) || echo "" ;     done
 time for val in {7..255}; do echo -n "$(tput setaf ${val})XXX$(tput op)" ;     done
  local -A arr=([body]="")
 arr=([body]="")
 arr[body]="fuck"
 declare -p arr
 arr[body]+=" you!" 
 declare -p arr
 v=body
 arr[${v}]="wtf is this?"
 declare -p arr
v="Free and Open Source Software [International] License (FOSSIL) v1.0.2" 
 echo ${v[0..5]}
 echo ${v[0,5]}
 echo ${v[1,5]}
 echo ${v[5]}
 echo ${#v}
 echo ${v[]}
 echo ${v[1]}
 echo "${v[1]}"
 echo "${v[2]}"
 echo "${v[3]}"
 echo "wtf" 
 echo "$_"
 whereis 
 whereis  bash
 whereis bash
 whereis -h bash
 whereis -l bash
 whereis -b bash
 whereis -h bash
 where bash
 which bash
 declare -g WTF
 source ./config 
 echo TITLEPREFIX
 which bash
 declare -g WTF
 source ./config 
 echo TITLEPREFIX
#!/usr/bin/bash -i
# Title..............: MDN Offline Content Server
# Summary............: Starts up the MDN Offline Content Server
# Created-at.........: Tuesday, July 27, 2021
# Last-Modified......: June 25, 2023
# Authors............: Alex A. Davronov <al.neodim@gmail.com> (2021-)
# Description........: This scrip is primarily intended to be used inside
# a systemd service unit; that's why paths are absolute and not relative.
# Development-note...:
#  To save diff patch, use:
# git di -p -U0 @~ -- scripts > ../../git.mdn.content.patch.diff
# Usage: $ start.sh
#--------------------------------------------------------------------------Utils
mdn.docs.kill(){   [[ $LAST_RUN_PID -gt 30000 ]]  && ps -p $LAST_RUN_PID   && kill -s SIGINT -$LAST_RUN_PID || echo "PID Failed" ; }
# -------------------------------------------------------------------console.wrn
console.wrn() {   echo -e "\e[;38;2;255;200;0m WRN \e[0m | $1"; } # console.warn end
# -------------------------------------------------------------------console.err
# @summary Console print error
console.err() {   echo -e "\e[31m ERR\e[0m  | $1"; } # console.err end
#---------------------------------------------------------------------console.ok
# @summary Console print good
# @param $arg0 - String to print
console.ok() {   echo -e "\e[32m OK  \e[0m | $1"; } # console.ok end
#--------------------------------------------------------------------global-vars
# type nvm &> /dev/null || {
#   console.err "$0: \x1B[31mError: \x1B[0m nvm is required, install from: https://github.com/nvm-sh/nvm"
#   echo -e "Aborting."
#   exit -1
# } # nvm check end
CONTENT_PATH=${CONTENT_PATH:-/media/all/ProgramsAndGames/pr/Devdocs/MDN/content}
SCRIPT_NAME=$(basename ${0})
SCRIPT_PATH=$(realpath ${0})
SCRIPT_VERSION="1.1.2"
# NVM_VERSION="$(nvm version)";
# NODE_PATH_BIN="$(ls /home/alex/.nvm/versions/node/$NVM_VERSION/bin/node)";
NODE_PATH_BIN="$(which node)"
LASTRUN_PID_PATH=/tmp/mdn-docs-server.pid
declare LAST_RUN_PID;
KILL_MESSAGE="\tTo kill the last running instance, run:\n\t\t\$ kill \$(cat $LASTRUN_PID_PATH)"
#---------------------------------------------------------------------------MAIN
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
if [[ "$1" =~ '--version' ]]; then   echo -e "${SCRIPT_VERSION}";  fi
if [[ "$1" =~ '--help' ]]; then   echo -e "MDN Docs Start script v${SCRIPT_VERSION}";   echo -e "\x1B[;38;2;255;200;0mThere are no commands! \x1B[0m";   echo -e "A helper script to run yari server.";   echo -e "Accepted ENV variables:";   echo -e "\tCONTENT_PATH=./content   to setup up path to content root";   echo -e "\tSERVER_PORT=5042         to setup up custom port";   exit 0; fi
# Export current configuration for import into another script .e.g ~/.zshrc
# e.g. use it like so $ source <(bash scrpts/start.sh)
if [[ "$1" =~ '--config' ]]; then   echo -e "MDN_SCRIPT_NAME=$SCRIPT_NAME";   echo -e "MDN_SCRIPT_PATH=$SCRIPT_PATH";   echo -e "MDN_SCRIPT_VERSION=$SCRIPT_VERSION";   echo -e "MDN_CONTENT_PATH=$CONTENT_PATH";   echo -e "MDN_LASTRUN_PID_PATH=$LASTRUN_PID_PATH";   exit 0; fi
export SERVER_PORT=${SERVER_PORT:-5000}
if curl -If http://localhost:$SERVER_PORT &> /dev/null; then   console.ok "${SCRIPT_NAME}: server is already running!";   echo -e "${KILL_MESSAGE}";   exit 0; else   console.wrn "${SCRIPT_NAME} starting up server..."; fi
# Check for content path, node and last pid path
[[ -d "$CONTENT_PATH"     ]] || { console.err "$0: content folder not found"; exit 1; };
[[ -s "$NODE_PATH_BIN"    ]] || { console.err "$0: node is not found"       ; exit 2; };
[[ -s "$LASTRUN_PID_PATH" ]] && {
  LAST_RUN_PID="$(cat $LASTRUN_PID_PATH)";   mdn.docs.kill &> /dev/null; } # [[ ... ]]
# Clear stack & Push directory to the stack
# -------------------------------------
# See  Bash Manual on Directory Stack Builtins
dirs -c
pushd $CONTENT_PATH;
CONTENT_ROOT=files REACT_APP_DISABLE_AUTH=true BUILD_OUT_ROOT=build node ./node_modules/@mdn/yari/server & echo $! > $LASTRUN_PID_PATH;
disown
sleep 3s && xdg-open http://localhost:$SERVER_PORT &
# Report
#-------------------------------------
console.ok "$0: MDN Yari: ...complete. PID: ${LAST_RUN_PID:-none}"
console.ok "$0: MDN Yari: running at http://localhost:$SERVER_PORT"
echo -e ${KILL_MESSAGE}
 bash -_asdf
 bash -c 'git branch'
 bash --help
   a=(./*.diff) 
   declare -p a
IFS=',' ; echo "${var}"
 var=(foo bar baz) ; IFS=',' ; echo "${var}"
v="some value"
v=(some value)
 echo ${${v}[2]}
 v=~
 echo %v
 echo $v
 echo ~
 echo ~+/
 local
 declare
 declare | wc -l
 declare | less
 declare | wc -l
 type enable 
 arr=(one)
 echo ${arr[1]}
 echo ${arr[0]}
 type catf
 type expr
 man expr
 expr -h
 expr substr "My huge string goes here" 0 8
 man expr
 expr substr "My huge string goes here" 0 8
 expr substr "My huge string goes here" "1" "8"
 expr substr "My huge string goes here" "1" "19"
 expr
  expr --help
 expr "" "|" "null"
 expr "nope" "|" "wtf"
 expr "0" "|" ""
 expr "0" "|" "124"
 ll
 ll 
 bindkey | less
 bindkey 
  bind | less
  bind 
  bind -l 
  bind -P
  bind -P | less
  bind -l | less
  bind -P | less
  bind -P | less

printf "edit and execute!"
 bind -P | bind
 bind -P | less
 bind -P | less
 
echo "wtf" 
 ll
 for v in one two three ; do echo $v; done
 if true; then; echo T; else; echo F; fi
 if true; then echo T; else; echo F; fi
 if true; then echo T; else echo F; fi
 dirs=($(ls -d */ ))
 /media/all/ProgramsAndGames/pr/2023/scaffold/templates/lua-format/pre-commit.lua-format.in
 ${BASH_SOURCE[0]}
 echo ${BASH_SOURCE[0]}
 set 0="w124124"
 echo $0
 0="wef"
 declare 0="wef"
 declare "0"="wef"
 set "wef" ; echo $1
 set "wef" ; echo $0
 ARR=( '"OPT1"' '"OPT2"' '"OPT3"' )
 echo ${ARR}
 echo ${ARR[@]}
 declare -p ARR
 fgrep '-a' <<<$(declare -p ARR)
 grep -F '-a' <<<$(declare -p ARR)
 fgrep '\-a' <<<$(declare -p ARR)
 fgrep '\-a' <<<$(declare -p ARR)  && echo T
 fgrep '\-a' <<<$(declare -p ARR)  && echo T | echo F
 declare -p ARR | fgrep '\-a' && echo T | echo F
 declare -p ARR | fgrep '\-a' && echo T || echo F
 declare -p ARR | fgrep '-a' && echo T || echo F
 declare -p ARR | fgrep 'a' && echo T || echo F
 declare -p ARR | fgrep '--a' && echo T || echo F
 declare -p ARR | fgrep '\-a' && echo T || echo F
 declare -p ARR | fgrep $'-a' && echo T || echo F
 declare -p ARR | fgrep $'-'a && echo T || echo F
 declare -p ARR | grep -F "\-a" && echo T || echo F
 declare -p ARR | grep -F "\\-a" && echo T || echo F
 declare -p ARR | grep -F "\\--a" && echo T || echo F
 declare -p ARR | grep -F -- "-a" && echo T || echo F
 declare -p ARR | grep -F -- " -a " && echo T || echo F
 ARR="str";  declare -p ARR | grep -F -- " -a " && echo T || echo F
 declare -i ARR="str";  declare -p ARR | grep -F -- " -a " && echo T || echo F
 declare -a ARR="str";  declare -p ARR | grep -F -- " -a " && echo T || echo F
 declare -a ARR=(one two three);  declare -p ARR | grep -F -- " -a " && echo T || echo F
 declare -a ARR=(one two three)  declare -p ARR | grep -F -- " -a " && echo T || echo F
declare -a ARR=(one two three) ; declare -p ARR | grep -F -- " -a " && echo T || echo F
 declare -p ARR
 history | awk '{print $2}' | sort | uniq -c | sort -rn | head -5
exit
 fn(){ echo $@ }
 fn(){ echo $@; };
 fn one two three
 nvim-x /etc/fstab 
 cd /home/alex
 clear
 cd /
 cd /home/alex
 cd /media/all/ProgramsAndGames/Downloads/Software.x86.x64/CADs
 cd '/media/all/ProgramsAndGames/Programs/BazisSoft/Bazis CAD/Manual/ru'
 cd /media/all/ProgramsAndGames/Downloads/Software.x86.x64/CADs
 cd '/media/all/ProgramsAndGames/Programs/BazisSoft/Bazis CAD/'
 cd /media/all/ProgramsAndGames/Programs/SOLIDWORKS/SOLIDWORKS/lang/english/
 cd '/media/all/ProgramsAndGames/pr/2024/solidworks/Настенный сушитель для вещей'
 cd /media/all/ProgramsAndGames/Backup/Books/Fasteners/
 cd '/media/all/ProgramsAndGames/pr/2024/solidworks/Настенный сушитель для вещей'
 cd /home/alex
 clear
 cd /
 cd /home/alex
 cd /
 cd /home/alex
 clear
 cd /
 cd /home/alex
 cd /media/all/ProgramsAndGames/Downloads/Software.x86.x64/CADs
 cd '/media/all/ProgramsAndGames/Programs/BazisSoft/Bazis CAD/Manual/ru'
 cd /media/all/ProgramsAndGames/Downloads/Software.x86.x64/CADs
 cd '/media/all/ProgramsAndGames/Programs/BazisSoft/Bazis CAD/'
 cd /media/all/ProgramsAndGames/Programs/SOLIDWORKS/SOLIDWORKS/lang/english/
 cd '/media/all/ProgramsAndGames/pr/2024/solidworks/Настенный сушитель для вещей'
 cd /media/all/ProgramsAndGames/Backup/Books/Fasteners/
 cd '/media/all/ProgramsAndGames/pr/2024/solidworks/Настенный сушитель для вещей'
 cd /home/alex
 clear
 cd /
 cd /home/alex
 cd /media/all/ProgramsAndGames/Backup/Books/Fasteners/
 cd '/media/all/ProgramsAndGames/pr/2024/solidworks/Настенный сушитель для вещей'
 which zsh
defaults 
 man defaults 
 cd /media/alex/ProgramsAndGames1
 cd /media/all/ProgramsAndGames/Backup/Books/Fasteners/
 lsblk
 lsblk -a
 lsblk -A
 cd /media/alex/ProgramsAndGames1
 cd /media/alex
 cd /media/alex/ProgramsAndGames
 cd /media/alex/
 cd /media/alex/ProgramsAndGames1
 cd /media/alex/ProgramsAndGames1/Backup
 cd /media/alex/ProgramsAndGames1/Backup/Docs
 cd /media/alex/ProgramsAndGames1/Backup/Docs/Alex
 cd /media/alex/ProgramsAndGames1/Backup
 cd /media/alex/ProgramsAndGames1/Backup/Users
 cd /media/alex/ProgramsAndGames1/Backup/Users/Root.Linux
 cd /media/alex/ProgramsAndGames1/Backup/Users/Root.Linux/etc
 cd /media/alex/ProgramsAndGames1/Backup/Users/Root.Linux/
 cd /media/alex/ProgramsAndGames1/Backup/Users/Root.Linux/lib
 cd /media/alex/ProgramsAndGames1/Backup/Users/Root.Linux/
 cd /media/alex/ProgramsAndGames1/Backup/Users/Root.Linux/etc
 cd /media/alex/ProgramsAndGames1/Backup/Users/Root.Linux/
 cd /media/alex/ProgramsAndGames1/Backup/Users/
 cd /media/alex/ProgramsAndGames1/Backup/Users/Alex.Linux
 cd /media/alex/ProgramsAndGames1/Backup/Users/Alex.Linux/user
 cd /media/alex/ProgramsAndGames1/Backup/Users/Alex.Linux/
 cd /media/alex/ProgramsAndGames1/Backup/Users/
 cd /media/alex/ProgramsAndGames1/Backup/Users/Root.Linux
 cd /media/alex/ProgramsAndGames1/Backup/Users/Root.Linux/etc
 cd /media/alex/ProgramsAndGames1/Backup/Users/Root.Linux/
 cd /media/alex/ProgramsAndGames1/Backup/Users/
blkid
blkid | less
blkid | less -SRC
mount
mount --uuid
mount | less -SRC
 man fstab
google-chrome
 cat /etc/hostname
 nvim-x /etc/hostname
kate /etc/hostname
cat /etc/hostname
google-chrome
mount
mount -a
 sudo mount -a
 cd /media/all/ProgramsAndGames
 cd /media/all/cdrom
 cd /media/all/ProgramsAndGames
 cd /media/all
 cd /media/all/ProgramsAndGames
 systemctl daemon-reload
 cd /home/alex
 clear
 cd /
 cd /home/alex
 clear
 cd /
 cd /home/alex
 clear
 cd /
 cd /home/alex
 clear
 cd /
 cd /home/alex
 clear
 cd /
 cd /home/alex
 cat /etc/shells 
 man defaults
 man shell
cd et
cd ec
 cd /etc/
 printf Numlock=on > /etc/sddm.conf
 ll /etc/sddm.conf
 echo Numlock=on > /etc/sddm.conf
 echo Numlock=on > /etc/sddm.conf_
 ll 
 touch sddm.conf
mount | grep -e "Programs"
 cmake --version
ll %
exit
ll 
exit
 zsh
 set glob
 set noglob
 echo ./*
 noglob
 noglob echo
 noglob echo ./*
 dir="xyz/"
 	echo -n "${0}: checking ./${dir%/}/**/*.lua"
 files=(lua/*/**/*.lua)
 files=(lua/*/**/*.lua); declare -p files
 files=(./lua/*/**/*.lua); declare -p files
 files=$(./lua/*/**/*.lua); declare -p files
 files=$(ls ./lua/*/**/*.lua); declare -p files
 files=$(ls ./lua/*/**.lua); declare -p files
 files=(./lua/*/**.lua); declare -p files
 files=(./lua/**/*.lua); declare -p files
local 1
 declare 1
 A=()
A+=(A)
A+=(B)
A+=(C)
A+=(D)
declare -p A
 echo ${#A}
 echo ${##A}
 echo ${#A[@]}
 man xterm
 man Xresources
 man .Xresources
 man .xresources
 man -k xresources
 man -k Xresources
 man -k Xresourse
 man -k Xresou
 man -k X
 man -k .X
 man -k X | less
 man X
xrdb -merge $HOME/.Xresources
 nvim-x index.txt 
 cat index.txt 
cd ..
  rm -rdI ca8e6a89271bc3e761ac0edb279775e0bfca11f5
 nvim-x index.txt 
ll 
  ll
 ll 090a96aac5387ace_1
 head 090a96aac5387ace_1
 nvim-x README.md 
ll
trap 
trap '' *
trap '' '*'
 trap --list
 trap -lp
 trap -l
 trap -lp
 bind
 type bind
 bind 
 bind '\n'
 bind '<CR>'
 bind
 bind -l
 bind -l | less
 bind -x
 bind -X | less
 bind -X 
 bind -X '^M'
 bind -X '\C-M'
 bind -X \C-M:
 bind -X '*'
 bind -X ':'
 bind -X ''
 bind -X 
 bind 
 bind
 bindkey
 bind -X
 bind -X | less
 laujit
 luajit
 jobs
 luajit
  ./snp
 bind -r '^M'
 bind -r '\n'
 bind -r '\C-M'
 bind '\C-M' accept-line
 bind '\C-M':accept-line
 trap --list
 trap -lp
 sh
uname -a
uname -u
uname -h
uname --help
uname -sn
uname -s
uname -o
cat /etc/hostname
cat /etc/os-release 
plasma --version
plasmashell --version
plasmashell -v
 zsh
 ll
 ls
 echo $SHELL
 zsh
zsh
 man -k greeter
 man sddm-greeter
 locate sddm.conf
locate greeter
 locate greeter.conf
 locate sddm-greeter
ll /var/lib/sddm/
 sudo ls /var/lib/sddm/
 sudo ls /var/lib/sddm/.config
 sudo ls /var/lib/sddm/.config/
 sudo ls /var/lib/sddm/.config/sddm
 sudo ls /var/lib/sddm/.config/sddm*
 sudo touch /var/lib/sddm/.config/sddm-greeter-qt6rc
sudo  ls /var/lib/sddm/.config/sddm-greeter-qt6rc
 sudo  ls /var/lib/sddm/.config/sddm-greeter-qt6rc
 sudo  ls -hua /var/lib/sddm/.config/sddm-greeter-qt6rc
 sudo  ls -huca /var/lib/sddm/.config/sddm-greeter-qt6rc
 sudo  ls -ahuca /var/lib/sddm/.config/sddm-greeter-qt6rc
 man ls
 zsh
 . .zshenv
 echo $XDG_BIN_HOME
GIT_REMOTE_URL=git@github.com:hinell/dotfiles.git;
[[  =~ 'hinell' ]] && echo FUCKING;
  man awk
man man
 man man
man man
 man man
 xman
 man man
 man sddm.conf
 man man
 xterm -e bash --noprofile
 man less
 LESS=--use-color man less
 GROFF_NO_SGR=1 LESS=--use-color man less
 GROFF_NO_SGR=1 LESS="--use-color -DE" man less
 GROFF_NO_SGR=1 LESS="--use-color -R" man less
 GROFF_NO_SGR=1 LESS="--use-color -R" man sddm.conf
  GROFF_NO_SGR=1 LESS_TERMCAP_mb=$'\e[1;31m' LESS='--use-color -R' LESS_TERMCAP_us=$'\e[01;37m' man man
 cat <({
echo "one"
echo "two"
echo "thr"
 cat <({
echo "one"
echo "two"
echo "thr"
})
