#request a node on ISCA

msub -I -X -l walltime=0:5:0,nodes=1:ppn=1 -q stq -A Research_Project-129726

mkdir /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_PFC/raw_data/CB2N2ANXX
cd /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_PFC/raw_data/CB2N2ANXX


for i in 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26
do

ftp_name="ftp://Project_2536:zwYmiXClopLkS@ftp.sequencing.exeter.ac.uk/CB2N2ANXX/01_raw_reads/2536_CTT" #beginning of ftp path

sub_folders="PFC_r1.fq.gz" #end of ftp path

full_path=$ftp_name$i$sub_folders #full path for each sample with sample number

wget $full_path
done

