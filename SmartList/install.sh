#! /bin/sh
: &&O='cd .' || exec /bin/sh "$0" $argv:q # we're in a csh, feed myself to sh
$O || exec /bin/sh "$0" "$@"		  # we're in a buggy zsh
#$Id: install.sh,v 1.46 1994/06/01 17:21:34 berg Exp $

if test -z "$IFS"
then IFS=" \
	\

"
  export IFS
fi

SHELL=/bin/sh				# make sure we get a decent shell
export SHELL
umask 022				# making sure that umask has sane value

test $# != 1 -a $# != 2 && echo "Usage: install.sh target-directory [.bin]" &&
 exit 64

target="$1"
bindir="$2"

setid=../src/setid

case "$target" in		# Make sure $target is absolute
  /*) ;;
  *) target=`cd "$target";pwd` ;;
esac

test -z "$bindir" && bindir=.bin

test ! -d "$target" && echo "Please create the target directory first" &&
 echo "Make sure it has the right owner" && exit 2

if test ! -f ../config.h
then
  echo "You must merge the source trees of procmail and SmartList"
  echo "together.  Simply unpack them on top of each other."
  exit 2
fi

if binmail=`procmail /dev/null DEFAULT=/dev/null 'LOG=$SENDMAIL' \
  </dev/null 2>&1`
then
  case "$binmail" in
     ""|*procmail:*)
	 echo "Failed in extracting the value of SENDMAIL from procmail"
	 echo \
	"Please make sure that the new version of procmail has been installed"
	 echo \
       'If you already have, make sure that "console" is undefined in config.h'
	 exit 64 ;;
  esac
else
  echo "Please make sure that procmail is on our PATH"
  exit 64
fi

if expr "X$bindir" : X.bin >/dev/null
then
:
else
  echo "I prefer a bin directory that starts with .bin"
  echo "If you want to enforce a different name, patch install.sh first :-)."
  exit 64
fi

cd "`dirname $0`"
PATH=.:$PATH

export target bindir binmail PATH

TMPF=/tmp/list.id.$$

trap "/bin/rm -f $TMPF; exit 1" 1 2 3 15

/bin/rm -f $TMPF

echo Id test >$TMPF

AM_ROOT=no

if ls -l $TMPF | grep '^[^ ]*  *[0-9][0-9]*  *root ' >/dev/null
then
  /bin/rm -f $TMPF
  AM_ROOT=yes
  installerid=`ls -l ../Makefile |
   sed -e 's/^[^ ]* *[0-9][0-9]*[^0-9] *\([^ ]*\) .*$/\1/'`
  listid=`ls -ld $target/. |
   sed -e 's/^[^ ]* *[0-9][0-9]*[^0-9] *\([^ ]*\) .*$/\1/'`
  if test root = $listid
  then
     echo "Please give $target the right owner & group first"
     exit 2
  fi
else
  /bin/rm -f $TMPF
  if ( exec 2>/dev/null; echo Id test >targetdir.tmp )
  then
  :
  else	# You can run install.sh WITHOUT root permissions as well!
     echo "Please run install.sh with root permissions instead"
     exit 77
  fi
  listid=`ls -l install.sh |
   sed -e 's/^[^ ]* *[0-9][0-9]*[^0-9] *\([^ ]*\) .*$/\1/'`
fi

trap "" 1 2 3 15

export listid

if test $AM_ROOT = yes
then
  if test ! -f $setid
  then
     echo "Please execute the following commands first:"
     echo ""
     echo "	cd ..; make setid; cd SmartList"
     echo ""
     echo "Then run this script again."
     exit 64
  fi
  case $installerid in
     [0-9]*) exec 4>&0
	 . ./install.sh2
	 exec 4>&- ;;
     *) $setid $installerid 4>&0 <install.sh2 || exit 1;;
  esac
  $setid $listid $target <install.sh3 || exit 64
  echo "Making $target/$bindir/flist suid root..."
  if chown root "$target/$bindir/flist" && chmod 04755 "$target/$bindir/flist"
  then
  :
  else
     echo "You either have to symlink the $target/$bindir"
     echo "directory to a partition where root has root permissions;"
     echo "or make sure that root can use its rights on the existing"
     echo "partition (that contains $target/$bindir)."
     echo "Then run this script again."
     exit 64
  fi
else
  exec 4>&0
  . ./install.sh2
  exec 4>&-
  . ./install.sh3
fi

echo '**********************************************************************'
echo "Finished installing, now you should:"
echo ""
if test -f $target/.etc/rc.init.new
then
  echo "	edit $target/.etc/rc.init.new"
  echo ""
  echo "AND then (preserving hardlinks!):"
  echo ""
  echo "	cat $target/.etc/rc.init.new >$target/.etc/rc.init"
else
  echo "	edit $target/.etc/rc.init"
fi
echo ""
echo "so that \`PATH', \`domain' and \`listmaster' reflect your installation."
if test -f $target/.etc/rc.init.new
then
  echo "Finally, to reenable the lists execute:"
  echo ""
  echo "		/bin/rm -f $target/.etc/rc.lock"
  echo ""
  touch "$target/.etc/rc.lock"
fi
echo '**********************************************************************'
