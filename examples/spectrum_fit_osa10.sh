#!/bin/sh
export HEADAS=/opt/local/heasoft-6.27.2/x86_64-apple-darwin16.7.0
. $HEADAS/headas-init.sh
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
echo "ignore bad">>$xcmfile
echo "ignore **-20.">>$xcmfile
echo "ignore 100.-**">>$xcmfile
echo "model  pegpwrlw">>$xcmfile
echo "         1.      0.01         -3         -2          9         10">>$xcmfile
echo "         20       ">>$xcmfile
echo "         100      ">>$xcmfile
echo "         0.01       0.01          0          0      1e+20      1e+24">>$xcmfile
echo "fit 1000">>$xcmfile
echo "err 1">>$xcmfile
echo "err 4">>$xcmfile
echo "flux 18. 55.0 1000">>$xcmfile
echo "flux err">>$xcmfile
echo "setplot rebin $reb 10">>$xcmfile
echo "plot eeufs">>$xcmfile
echo "iplot">>$xcmfile
echo "wdata $specname">>$xcmfile 
xspec <$xcmfile
© 2020 GitHub, Inc.