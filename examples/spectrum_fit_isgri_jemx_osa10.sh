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
echo "statistic chi" >>$xcmfile
echo "ignore bad">>$xcmfile
echo "ignore 1:300.-**">>$xcmfile
echo "ignore 1:**-20.">>$xcmfile
echo "ignore 2:20.-**">>$xcmfile
echo "ignore 2:3**-3.">>$xcmfile

echo  "model constant(cutoffpl + cutoffpl + relline)">>$xcmfile
echo  "              1         -1          0          0      1e+10      1e+10">>$xcmfile
echo  "      -0.216781       0.01         -3         -2          9         10">>$xcmfile
echo  "        11.9263       0.01       0.01          1        500        500">>$xcmfile
echo  "       0.255809       0.01          0          0      1e+20      1e+24">>$xcmfile
echo  "       0.643286       0.01         -3         -2          9         10">>$xcmfile
echo  "        50.8176       0.01       0.01          1        500        500">>$xcmfile
echo  "       0.430351       0.01          0          0      1e+20      1e+24">>$xcmfile
echo  "            6.4         -1       0.01        0.1         10        100">>$xcmfile
echo  "              3       -0.1        -10        -10         10         10">>$xcmfile
echo  "              3       -0.1        -10        -10         10         10">>$xcmfile
echo  "             15       -0.1          1          1        400       1000">>$xcmfile
echo  "          0.998        0.1     -0.998     -0.998      0.998      0.998">>$xcmfile
echo  "             30         -1          1          5         80         89">>$xcmfile
echo  "             -1       -0.1       -100       -100         -1         -1">>$xcmfile
echo  "            400       -0.1          1          1        400       1000">>$xcmfile
echo  "              0     -0.001          0          0         10         10">>$xcmfile
echo  "              0         -1          0          0          2          2">>$xcmfile
echo  "        0.90494       0.01          0          0      1e+20      1e+24">>$xcmfile
echo  "       0.748119       0.01          0          0      1e+10      1e+10">>$xcmfile
echo  "= p2">>$xcmfile
echo  "= p3">>$xcmfile
echo  "= p4">>$xcmfile
echo  "= p5">>$xcmfile
echo  "= p6">>$xcmfile
echo  "= p7">>$xcmfile
echo  "= p8">>$xcmfile
echo  "= p9">>$xcmfile
echo  "= p10">>$xcmfile
echo  "= p11">>$xcmfile
echo  "= p12">>$xcmfile
echo  "= p13">>$xcmfile
echo  "= p14">>$xcmfile
echo  "= p15">>$xcmfile
echo  "= p16">>$xcmfile
echo  "= p17">>$xcmfile
echo  "= p18">>$xcmfile
echo "fit 10000">>$xcmfile
echo "setplot rebin $reb 10">>$xcmfile
echo "plot eeufs">>$xcmfile
echo "iplot">>$xcmfile
echo "wdata $specname">>$xcmfile 
xspec <$xcmfile
