export HOME_OVERRRIDE=$HOME
export HOME=${HOME_OVERRRIDE:-/home/integral}

export HEADAS=/opt/heasoft/x86_64-pc-linux-gnu-libc2.17/

[ -s $HEADAS/headas-init.sh ] && 
    . $HEADAS/headas-init.sh


source /etc/pyenvrc
