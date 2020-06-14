#!/bin/sh
name=$1
reb=$2
specname="${name}_spectrum_osa10.txt"
xcmfile="$name.xcm"

specfile="${name}_spectrum_osa10.fits"
respfile="${name}_rmf_osa10.fits.gz"
arffile="${name}_arf_osa10.fits.gz"

specfile_j="${name}_spectrum_osa10_jemx1.fits"
respfile_j="${name}_rmf_osa10_jemx1.fits.gz"
arffile_j="${name}_arf_osa10_jemx1.fits.gz"

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
echo "data 1:1 $specfile">>$xcmfile
echo "response 1 $respfile" >>$xcmfile
echo "arf 1 $arffile" >>$xcmfile
echo "data 2:2 $specfile_j">>$xcmfile
echo "response 2 $respfile_j" >>$xcmfile
echo "arf 2 $arffile_j" >>$xcmfile

echo "ignore bad">>$xcmfile
echo "ignore 1:500.-**">>$xcmfile
echo "ignore 1:**-20.">>$xcmfile
echo "ignore 2:20.-**">>$xcmfile
echo "ignore 2:**-3.">>$xcmfile
echo "syst 0.02">>$xcmfile
echo  "model  constant*powerlaw">>$xcmfile
echo  " 	     1         -1	   0	      0      1e+10	1e+10">>$xcmfile
echo  "        2.09873       0.01	  -3	     -2 	 9	   10">>$xcmfile
echo  "        9.53165       0.01	   0	      0      1e+20	1e+24">>$xcmfile
echo  "        1.04752       0.01	   0	      0      1e+10	1e+10">>$xcmfile
echo  "= p2								     ">>$xcmfile
echo  "= p3								     ">>$xcmfile

echo "fit 1000">>$xcmfile
echo "flux 30. 300.">>$xcmfile 
echo "flux error">>$xcmfile 
echo "setplot rebin $reb 10">>$xcmfile
echo "plot eeufs">>$xcmfile
echo "iplot">>$xcmfile
echo "wdata $specname">>$xcmfile 
xspec <$xcmfile
