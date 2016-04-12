#!/bin/sh

syntax_errors=0
error_msg=$(mktemp /tmp/error_msg.XXXXXXXX)

if git rev-parse --quiet --verify HEAD > /dev/null
then
    against=HEAD
else
   against=4b825dc642cb6eb9a060e54bf8d69288fbee4904
fi

for indexfile in `git diff-index --diff-filter=AM --name-only --cached $against |egrep '\.(pp|erb)'`
do
   if [`git cat-file -s :0:$indexfile` -gt 0 ]
   then
   	case  $indexfile in 
           *.pp)
		git cat-file blob :0:$indexfile | puppet parser validate >$error_msg;;
	   *.erb)
		git cat-file blob :0:$indexfile | erb -x -T - |ruby -c 2> $error_msg > /dev/null ;;
	esac
	if ["$?" -ne 0]
	then 
	    echo -n "$indexfile:"
	    cat $error_msg
	    syntax_errors=`expr $syntax_errors +1`
	fi
    fi
done

rm -f $error_msg

if  ["$syntax_errors" -ne 0]
then
   echo "Error,aborting commit"
   exit 1
fi
