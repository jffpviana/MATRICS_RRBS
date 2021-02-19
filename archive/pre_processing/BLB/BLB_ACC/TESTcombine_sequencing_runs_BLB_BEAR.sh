#!/bin/bash
#SBATCH --ntasks 1
#SBATCH --time 24:0:0
#SBATCH --qos bbdefault
#SBATCH --mail-type ALL

set -e

module purge; module load bluebear

#These samples were sequenced twice. After inspecting the raw reads of both runs separately (FACTQC) and check their quality I decided to combine both for further analysis


cd  /rds/projects/v/vianaj-genomics-brain-development/MATRICS/raw_data_test/ # change directory

mkdir combined # create folder combined



#combine ACC samples with the sam name :
for fasta in /rds/projects/v/vianaj-genomics-brain-development/MATRICS/raw_data_test/CB2N2ANXX/*.fq
do
	name=`basename $fasta`
	echo $fasta
	file1=`ls /rds/projects/v/vianaj-genomics-brain-development/MATRICS/raw_data_test/CB2N2ANXX/*.fq | echo $fasta | grep BLB.*ACC`
	file2=`ls /rds/projects/v/vianaj-genomics-brain-development/MATRICS/raw_data_test/CB30KANXX/*.fq | echo $file | grep BLB.*ACC`
	echo `$file1`
	echo `$file2`
done;
