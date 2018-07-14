#request a node on ISCA

msub -I -X -l walltime=0:5:0,nodes=1:ppn=1 -q stq -A Research_Project-129726

cd /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_HC/raw_data/CB2A9ANXX


for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 
do

ftp_name="ftp://Project_2495:pQ1beWaHt1x6E@ftp.sequencing.exeter.ac.uk/CB2A9ANXX/Sample_" #beginning of ftp path

sub_folders="/raw_illumina_reads/*.fastq.gz" #end of ftp path

full_path=$ftp_name$i$sub_folders #full path for each sample with sample number

wget $full_path
done

