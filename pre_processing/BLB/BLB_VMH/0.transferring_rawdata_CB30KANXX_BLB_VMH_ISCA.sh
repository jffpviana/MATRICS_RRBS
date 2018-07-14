#request a node on ISCA

msub -I -X -l walltime=0:5:0,nodes=1:ppn=1 -q stq -A Research_Project-129726

cd /gpfs/ts0/scratch/jfv203/MATRICS/BLB_VMH/raw_data/CB30KANXX



for i in 01 02 03 04 05 06 07 08 09 10 11 
do

ftp_name="ftp://Project_2536:zwYmiXClopLkS@ftp.sequencing.exeter.ac.uk/CB30KANXX/01_raw_reads/2536_BLB" #beginning of ftp path

sub_folders="VMH_r1.fq.gz" #end of ftp path



full_path=$ftp_name$i$sub_folders #full path for each sample with sample number

wget $full_path
done

