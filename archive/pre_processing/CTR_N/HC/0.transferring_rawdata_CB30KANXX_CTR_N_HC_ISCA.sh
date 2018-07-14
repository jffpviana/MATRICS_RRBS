#request a node on ISCA

msub -I -X -l walltime=0:5:0,nodes=1:ppn=1 -q stq -A Research_Project-129726

cd /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_HC/raw_data/CB30KANXX


for i in 02 19 
do

ftp_name="ftp://Project_2536:zwYmiXClopLkS@ftp.sequencing.exeter.ac.uk/CB30KANXX/01_raw_reads/2536_CTR_N" #beginning of ftp path

sub_folders="HCrepeat_r1.fq.gz" #end of ftp path

full_path=$ftp_name$i$sub_folders #full path for each sample with sample number

wget $full_path
done

