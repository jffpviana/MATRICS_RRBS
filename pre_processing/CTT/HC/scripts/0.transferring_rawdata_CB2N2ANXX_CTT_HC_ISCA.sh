#request a node on ISCA

msub -I -X -l walltime=0:5:0,nodes=1:ppn=1 -q stq -A Research_Project-129726

mkdir /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_HC/raw_data/CB2N2ANXX
cd /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_HC/raw_data/CB2N2ANXX


for i in 04 14
do

ftp_name="ftp://Project_2536:zwYmiXClopLkS@ftp.sequencing.exeter.ac.uk/CB2N2ANXX/01_raw_reads/2536_CTT" #beginning of ftp path

sub_folders="HC_r1.fq.gz" #end of ftp path

full_path=$ftp_name$i$sub_folders #full path for each sample with sample number

wget $full_path
done

