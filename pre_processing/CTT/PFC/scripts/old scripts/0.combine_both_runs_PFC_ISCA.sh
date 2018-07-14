#These samples were sequenced twice. After inspecting the raw reads of both runs separately (FACTQC) and check their quality I decided to combine both for further analysis


#request a node on ISCA
msub -I -X -l walltime=0:5:0,nodes=1:ppn=1 -q stq -A Research_Project-129726


cd /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_PFC/  # change directory to the MATRICS project directory, MATRICS folder and respective cohort within that

mkdir combined # create folder combined

cd combined

gunzip -d /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_PFC/Sample_CTT*PFC/raw_illumina_reads/*.fastq # Unzip the fasta files
gunzip -d /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_PFC/*.fq.gz #extra two samples that are not on "Sample" folders -these were sequences in a different batch
gunzip -d /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_PFC/repeat_sequencing*.fq.gz #re-run samples




for fasta in /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_PFC/Sample_CTT*PFC/raw_illumina_reads/*.fastq
do

	file=`basename $fasta`
	name=`echo $file | grep CTT.*PFC | cut -c -8`
	file1=`ls /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_PFC/Sample_CTT*PFC/raw_illumina_reads/*.fastq | grep $name`
	file2=`ls /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_PFC/repeat_sequencing/*.fq | grep $name`
	cat $file1 $file2 > $name.fq
	file3=`echo $name.fq`
	lines1=`echo $(cat $file1 | wc -l) / 4 | bc`
	lines2=`echo $(cat $file2 | wc -l) / 4 | bc`
	sum_lines=`echo "$(($lines1+$lines2))"`
	lines3=`echo $(cat $file3 | wc -l) / 4 | bc`

	head_comb=`head $file3`
	head_1=`head $file1`
	
	tail_comb=`head $file3`
	tail_1=`head $file1`

	if [ "$sum_lines" = "$lines3" ]
then
    echo $name" Pass reads"
else
    echo $name" Fail reads"
fi
	
	if [ "$head_comb" = "$head_1" ]
then
    echo $name" Pass head"
else
    echo $name" Fail head"
fi

if [ "$tail_comb" = "$tail_1" ]
then
    echo $name" Pass tail"
else
    echo $name" Fail tail"
fi	
done;

