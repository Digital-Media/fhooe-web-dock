#!/bin/bash
[ -z $1 ] && echo "Usage: bs <script-name>" && exit 1
test -d $HOME/src || mkdir $HOME/src
test -f $HOME/src/$1 && echo "Datei existiert bereits!" && exit 2
echo "#!/bin/bash" > $HOME/src/$1
echo "#$HOME/bin/$1" >> $HOME/src/$1
echo "#" >> $HOME/src/$1
echo "Author:"
read author
echo "# Author: $author" >> $HOME/src/$1
echo "# Date: $(date) " >> $HOME/src/$1
echo "# Changes:" >> $HOME/src/$1

