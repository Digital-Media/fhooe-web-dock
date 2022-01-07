#!/bin/bash
[ -z $1 ] && echo "Usage: bs <script-name>" && exit 1
test -d $HOME/bin || mkdir $HOME/bin
test -f $HOME/bin/$1 && echo "Datei existiert bereits!" && exit 2
echo "#!/bin/bash" > $HOME/bin/$1
echo "#$HOME/bin/$1" >> $HOME/bin/$1
echo "#" >> $HOME/bin/$1
echo "Author:"
read author
echo "# Author: $author" >> $HOME/bin/$1
echo "# Date: $(date) " >> $HOME/bin/$1
echo "# Changes:" >> $HOME/bin/$1

