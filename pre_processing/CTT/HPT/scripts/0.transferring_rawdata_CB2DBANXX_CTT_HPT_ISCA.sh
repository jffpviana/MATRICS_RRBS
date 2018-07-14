#request a node on ISCA

msub -I -X -l walltime=0:5:0,nodes=1:ppn=1 -q stq -A Research_Project-129726

cd /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_HPT/raw_data/CB2DBANXX


for i in 01 02 03 05 06 07 08 09 10 11 12 13 15 16 17 18 19 20 21 22 23 24 25 26
do

ftp_name="ftp://Project_2536:zwYmiXClopLkS@ftp.sequencing.exeter.ac.uk:/CB2DBANXX/Sample_CTT" #beginning of ftp path

sub_folders="HPT/raw_illumina_reads/*.fastq.gz" #end of ftp path

full_path=$ftp_name$i$sub_folders #full path for each sample with sample number

wget $full_path
done
