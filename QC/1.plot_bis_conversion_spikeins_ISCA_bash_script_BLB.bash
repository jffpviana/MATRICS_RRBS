
#!/bin/sh
#PBS -V # export all environment variables to the batch job.
#PBS -q sq # submit to the serial queue
#PBS -l walltime=50:00:00 # Maximum wall time for the job.
#PBS -A Research_Project-129726 # research project to submit under. 
#PBS -l procs=1 # specify number of processors.
#PBS -m e -M j.f.viana@exeter.ac.uk # email me at job completion

module load R/3.3.1-foss-2016b #load R module


#####BLB_ACC samples####
#arguments:
cohort="BLB"
brain_region="ACC"
pdf_path="/gpfs/ts0/scratch/jfv203/MATRICS/BLB_ACC/analysis/bisulfite_conversion_spikeins_"
pdf_path2="/gpfs/ts0/scratch/jfv203/MATRICS/BLB_ACC/analysis/bisulfite_conversion_spikeins_mean_"

cd /gpfs/ts0/scratch/jfv203/MATRICS/BLB_ACC/bismark_alignment/ #change directory

mkdir /gpfs/ts0/scratch/jfv203/MATRICS/BLB_ACC/analysis/ #make analysis directory

gunzip -d /gpfs/ts0/scratch/jfv203/MATRICS/BLB_ACC/bismark_alignment/*bismark.cov.gz #unzip the DNA methylation coverage files

Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/1.plot_bis_conversion_spikeins_ISCA.r $cohort $brain_region $pdf_path
Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/1.plot_bis_conversion_spikeins_mean_ISCA.r $cohort $brain_region $pdf_path2




#####BLB_MCC samples####
#arguments:
cohort="BLB"
brain_region="MCC"
pdf_path="/gpfs/ts0/scratch/jfv203/MATRICS/BLB_MCC/analysis/bisulfite_conversion_spikeins_"
pdf_path2="/gpfs/ts0/scratch/jfv203/MATRICS/BLB_MCC/analysis/bisulfite_conversion_spikeins_mean_"


cd /gpfs/ts0/scratch/jfv203/MATRICS/BLB_MCC/bismark_alignment/ #change directory

mkdir /gpfs/ts0/scratch/jfv203/MATRICS/BLB_MCC/analysis/ #make analysis directory

gunzip -d /gpfs/ts0/scratch/jfv203/MATRICS/BLB_MCC/bismark_alignment/*bismark.cov.gz #unzip the DNA methylation coverage files

Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/1.plot_bis_conversion_spikeins_ISCA.r $cohort $brain_region $pdf_path
Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/1.plot_bis_conversion_spikeins_mean_ISCA.r $cohort $brain_region $pdf_path2




#####BLB_VMH samples####
#arguments:
cohort="BLB"
brain_region="VMH"
pdf_path="/gpfs/ts0/scratch/jfv203/MATRICS/BLB_VMH/analysis/bisulfite_conversion_spikeins_"
pdf_path2="/gpfs/ts0/scratch/jfv203/MATRICS/BLB_VMH/analysis/bisulfite_conversion_spikeins_mean_"


cd /gpfs/ts0/scratch/jfv203/MATRICS/BLB_VMH/bismark_alignment/ #change directory

mkdir /gpfs/ts0/scratch/jfv203/MATRICS/BLB_VMH/analysis/ #make analysis directory

gunzip -d /gpfs/ts0/scratch/jfv203/MATRICS/BLB_VMH/bismark_alignment/*bismark.cov.gz #unzip the DNA methylation coverage files

Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/1.plot_bis_conversion_spikeins_ISCA.r $cohort $brain_region $pdf_path
Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/1.plot_bis_conversion_spikeins_mean_ISCA.r $cohort $brain_region $pdf_path2
