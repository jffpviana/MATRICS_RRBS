
#!/bin/sh
#PBS -V # export all environment variables to the batch job.
#PBS -q sq # submit to the serial queue
#PBS -l walltime=50:00:00 # Maximum wall time for the job.
#PBS -A Research_Project-129726 # research project to submit under. 
#PBS -l procs=1 # specify number of processors.
#PBS -m e -M j.f.viana@exeter.ac.uk # email me at job completion




#These samples were sequenced twice. After inspecting the raw reads of both runs separately (FACTQC) and check their quality I decided to combine both for further analysis


cd /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_PFC/raw_data  # change directory to the MATRICS project directory, MATRICS folder and respective cohort within that

mkdir combined # create folder combined

###all samples excluding CTT04HC and CTT14HC were sequenced in clusters CB2N2ANXX and HTKFHBCXY

#combine those samples:
for fasta in /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_PFC/raw_data/HTKFHBCXY/*.fastq
do
	file=`basename $fasta`
	name=`echo $file | grep CTT.*PFC | cut -c -8`
	file1=`ls /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_PFC/raw_data/HTKFHBCXY/*.fastq | grep $name`
	file2=`ls /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_PFC/raw_data/CB2N2ANXX/*.fq | grep $name`

	
	cat $file1 $file2 > /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_PFC/raw_data/combined/$name.fastq
	file3=/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_PFC/raw_data/combined/$name.fastq
	echo $file3
	lines1=`echo $(cat $file1 | wc -l) / 4 | bc`
	lines2=`echo $(cat $file2 | wc -l) / 4 | bc`
	sum_lines=`echo "$(($lines1+$lines2))"`
	lines3=`echo $(cat $file3 | wc -l) / 4 | bc`

	if [ "$sum_lines" = "$lines3" ]
then
    echo $name" Pass reads"
else
    echo $name" Fail reads"
fi
		
done;

###samples CTT04HC and CTT14HC were sequenced in clusters CB2N2ANXX and CB30KANXX
#combine those samples:
for fasta in /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_PFC/raw_data/CB30KANXX/*.fq
do
	file=`basename $fasta`
	name=`echo $file | grep CTT.*PFC | cut -c -13`

	file1=`ls /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_PFC/raw_data/CB30KANXX/*.fq | grep $name`
	file2=`ls /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_PFC/raw_data/CB2N2ANXX/*.fq | grep $name`

	cat $file1 $file2 > /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_PFC/raw_data/combined/$name.fq
	file3=/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_PFC/raw_data/combined/$name.fq
	echo $file3
	lines1=`echo $(cat $file1 | wc -l) / 4 | bc`
	lines2=`echo $(cat $file2 | wc -l) / 4 | bc`
	sum_lines=`echo "$(($lines1+$lines2))"`
	lines3=`echo $(cat $file3 | wc -l) / 4 | bc`

	if [ "$sum_lines" = "$lines3" ]
then
    echo $name" Pass reads"
else
    echo $name" Fail reads"
fi
		
done;



