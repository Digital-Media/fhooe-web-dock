#!/bin/bash
#
# Author: Martin Harrer
# Date: Wed Oct 22 11:14:25 CEST 2008 
# Use: 
# Changes: added sudo bash -c for rm -rf   20.10.20 Martin Harrer
#
# uncomment for debugging, displays content of variables
# set -x
#
# Directory rechte löschen, falls es schon vorhanden ist
sudo bash -c "rm -rf $HOME/rechte"
# Directory rechte neu anlegen
mkdir $HOME/rechte
# ins Directory rechte wechseln
cd $HOME/rechte
# Directories mit allen Kombination von Rechten fuer User erstellen
mkdir rdir
mkdir wdir
mkdir xdir
mkdir rwdir
mkdir rxdir
mkdir wxdir
mkdir rwxdir
# Dateien mit allen Kombinationen von Rechten fuer User erstellen
echo "echo test">rdatei
echo "echo test">wdatei
echo "echo test">xdatei
echo "echo test">rwdatei
echo "echo test">rxdatei
echo "echo test">wxdatei
echo "echo test">rwxdatei
# Auflisten der Dateien und Directories nach Neuanlage
ls -l
# Die Berechtigungen setzen, so dass Dateiname 
# und Rechte bei User zusammenstimmen
chmod 400 rdir
chmod 200 wdir
chmod 100 xdir
chmod 600 rwdir
chmod 500 rxdir
chmod 300 wxdir
chmod 700 rwxdir
chmod 400 rdatei
chmod 200 wdatei
chmod 100 xdatei
chmod 600 rwdatei
chmod 500 rxdatei
chmod 300 wxdatei
chmod 700 rwxdatei
# Alle Dateien und Directories auflisten, damit man die Rechte sieht
ls -l
# Lese-, Schreib- und Ausfuehungsrecht testen fuer Dateien
# Leserecht
echo
echo "Leserecht fuer Dateien"
echo
echo "# cat rdatei"
cat rdatei
echo "# cat wdatei"
cat wdatei
echo "# cat xdatei"
cat xdatei
echo "# cat rwdatei"
cat rwdatei
echo "# cat rxdatei"
cat rxdatei
echo "# cat wxdatei"
cat wxdatei
echo "# cat rwxdatei"
cat rwxdatei
# Schreibrecht
echo
echo "Schreibrecht fuer Dateien"
echo
echo "# echo #test >> rdatei"
echo "#test">> rdatei
echo "# echo #test >> wdatei"
echo "#test">> wdatei
echo "# echo #test >> xdatei"
echo "#test">> xdatei
echo "# echo #test >> rwdatei"
echo "#test">> rwdatei
echo "# echo #test >> rxdatei"
echo "#test">> rxdatei
echo "# echo #test >> wxdatei"
echo "#test">> wxdatei
echo "# echo #test >> rwxdatei"
echo "#test">> rwxdatei
# Ausfuehrungsrecht
echo
echo "Ausfuehrungsrecht fuer Dateien"
echo
echo "# ./rdatei" # die naechste zeile liefert output test
./rdatei
echo "# ./wdatei" # die naechste zeile liefert output test
./wdatei
echo "# ./xdatei" # die naechste zeile liefert output test
./xdatei
echo "# ./rwdatei" # die naechste zeile liefert output test
./rwdatei
echo "# ./rxdatei" # die naechste zeile liefert output test
./rxdatei
echo "# ./wxdatei" # die naechste zeile liefert output test
./wxdatei
echo "# ./rwxdatei" # die naechste zeile liefert output test
./rwxdatei
# Lese-, Schreib- und Ausfuehrungsrecht fuer Verzechnisse testen
# Leserecht
echo
echo "Leserecht fuer Verzeichnisse"
echo
echo "# ls -l rdir"
ls -l rdir
echo "# ls -l wdir"
ls -l wdir
echo "# ls -l xdir"
ls -l xdir
echo "# ls -l rwdir"
ls -l rwdir
echo "# ls -l rxdir"
ls -l rxdir
echo "# ls -l wxdir"
ls -l wxdir
echo "# ls -l rwxdir"
ls -l rwxdir
# Schreibrecht
echo
echo "Schreibrecht fuer Verzeichnisse"
echo
echo "# echo test > rdir/test"
echo text > rdir/test
echo "# echo test > wdir/test"
echo text > wdir/test
echo "# echo test > xdir/test"
echo text > xdir/test
echo "# echo test > rwdir/test"
echo text > rwdir/test
echo "# echo test > rxdir/test"
echo text > rxdir/test
echo "# echo test > wxdir/test"
echo text > wxdir/test
echo "# echo test > rwxdir/test"
echo text > rwxdir/test
# Ausfuehrungsrecht
echo
echo "Ausfuehrungsrecht fuer Verzeichnisse"
echo
echo "# cd rdir"
cd rdir
pwd
echo "# cd wdir"
cd wdir
pwd
echo "# cd xdir"
cd xdir
pwd
cd .. # wieder ins vorige Verzeichnis zurueckwechseln
echo "# cd rwdir"
cd rwdir
pwd
echo "# cd rxdir"
cd rxdir
pwd
cd .. # wieder ins vorige Verzeichnis zurueckwechseln
echo "# cd wxdir"
cd wxdir
pwd
cd .. # wieder ins vorige Verzeichnis zurueckwechseln
echo "# cd rwxdir"
cd rwxdir
pwd
cd .. # wieder ins vorige Verzeichnis zurueckwechseln
