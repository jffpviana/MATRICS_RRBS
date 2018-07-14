#request a node on ISCA

msub -I -X -l walltime=0:5:0,nodes=1:ppn=1 -q stq -A Research_Project-129726
module load Perl/5.24.1-GCCcore-6.3.0 #load module pearl

#first copy the spike-in fasta file from the Rat genome folder to the Mouse genome folder so it can be added 
cp /gpfs/ts0/home/jfv203/reference_files/Rat/Rnor6.0_GCA_000001895.4/Spike_in_Diagenode.fa /gpfs/ts0/home/jfv203/reference_files/Mouse/Mus_musculus.GRCm38.dna.primary_assembly

cd /gpfs/ts0/home/jfv203/reference_files/Mouse/Mus_musculus.GRCm38.dna.primary_assembly

#genome prepararion with Bismark:

#unzip referencegenome files
gzip -d *.fa.gz 

#do not append the spike in sequences to the reference genome because we have separate chromosomes, but move spike in fasta file to the same folder as the ref genome
#run bismark on ref genome + spike in #move the spike-in file to the folder where the unziped chromosome files are Spike_in_Diagenode.fa
#use shared bowtie2 copy, if I install on my local software folder it doesn't work

perl ~/software/Bismark-0.19.0/Bismark-0.19.0/bismark_genome_preparation --path_to_bowtie /gpfs/ts0/shared/software/Bowtie2/2.2.9-foss-2016a/bin --verbose /gpfs/ts0/home/jfv203/reference_files/Mouse/Mus_musculus.GRCm38.dna.primary_assembly
