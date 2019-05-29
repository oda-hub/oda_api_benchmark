#!/bin/sh
name=$1
specname="${name}_spectrum.txt"
xcmfile="$name.xcm"
specfile="${name}_spectrum.fits"
respfile="${name}_rmf.fits.gz"
arffile="${name}_arf.fits.gz"
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
echo "ignore bad">>$xcmfile
echo "ignore **-20.">>$xcmfile
echo "ignore 1:300.-**">>$xcmfile
echo "method leven 10 0.01">>$xcmfile
echo "abund angr">>$xcmfile
echo "xsect bcmc">>$xcmfile
echo "cosmo 70 0 0.73">>$xcmfile
echo "xset delta 0.01">>$xcmfile
echo "systematic 0">>$xcmfile
echo "model  cutoffpl">>$xcmfile
echo "         1.43356       0.01         -3         -2          9         10">>$xcmfile>>$xcmfile
echo "         192.65       0.01       0.01          1        500        500">>$xcmfile>>$xcmfile
echo "      0.0104736       0.01          0          0      1e+20      1e+24">>$xcmfile>>$xcmfile
echo "fit 100">>$xcmfile
echo "setplot rebin 5 5">>$xcmfile
echo "plot eeufs">>$xcmfile
echo "iplot">>$xcmfile
echo "wdata $specname">>$xcmfile 
xspec <$xcmfile
