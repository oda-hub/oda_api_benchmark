#!/bin/sh
name=$1
reb=$2
specname="${name}_spectrum_osa10.txt"
xcmfile="$name.xcm"
specfile="${name}_spectrum_osa10.fits"
respfile="${name}_rmf_osa10.fits.gz"
arffile="${name}_arf_osa10.fits.gz"
if [ -f $xcmfile ]
then
  rm $xcmfile
fi
if [ -f $specname ]
then
  rm $specname
fi
touch $xcmfile
echo "statistic chi" >>$xcmfile
echo "data $specfile">>$xcmfile
echo "response $respfile" >>$xcmfile
echo "arf $arffile" >>$xcmfile
echo "setpl e">>$xcmfile
echo "ign bad">>$xcmfile
echo "ignore bad">>$xcmfile
echo "ignore **-20.">>$xcmfile
echo "ignore 300.-**">>$xcmfile
echo "model  po">>$xcmfile
echo "1 ">>$xcmfile
echo "1 ">>$xcmfile
echo "fit 1000">>$xcmfile
echo "setplot rebin $reb 10">>$xcmfile
echo "plot eeufs">>$xcmfile
echo "iplot">>$xcmfile
echo "wdata $specname">>$xcmfile 
xspec <$xcmfile
