#The following two lines create a folder for all the reference genomes. Just need to run this once for all datasets.
cd /gpfs/ts0/home/jfv203/
#mkdir reference_files/
cd reference_files

#download rat genome  from EMSEMBLE - separate chromosomes. Just need to run this once.

mkdir Mouse #make a directory for the rat reference genome
cd Mouse
mkdir Mus_musculus.GRCm38.dna.primary_assembly #make a directory for the rat reference genome
cd Mus_musculus.GRCm38.dna.primary_assembly
wget ftp://ftp.ensembl.org/pub/release-91/fasta/mus_musculus/dna/Mus_musculus.GRCm38.dna.primary_assembly.fa.gz

#downloaded on 13/02/2018

