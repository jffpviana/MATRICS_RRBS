
#!/bin/sh
#PBS -V # export all environment variables to the batch job.
#PBS -q sq # submit to the serial queue
#PBS -l walltime=50:00:00 # Maximum wall time for the job.
#PBS -A Research_Project-129726 # research project to submit under. 
#PBS -l procs=1 # specify number of processors.
#PBS -m e -M j.f.viana@exeter.ac.uk # email me at job completion

module load R/3.3.1-foss-2016b #load R module


#####CTT_PFC samples####
#arguments:
cohort="CTT"
brain_region="PFC"
pdf_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_PFC/analysis/bisulfite_conversion_spikeins_"
pdf_path2="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_PFC/analysis/bisulfite_conversion_spikeins_mean_"

cd /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_PFC/bismark_alignment/ #change directory

mkdir /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_PFC/analysis/ #make analysis directory

gunzip -d /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_PFC/bismark_alignment/*bismark.cov.gz #unzip the DNA methylation coverage files

Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/1.plot_bis_conversion_spikeins_ISCA.r $cohort $brain_region $pdf_path
Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/1.plot_bis_conversion_spikeins_mean_ISCA.r $cohort $brain_region $pdf_path2




#####CTT_HC samples####
#arguments:
cohort="CTT"
brain_region="HC"
pdf_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_HC/analysis/bisulfite_conversion_spikeins_"
pdf_path2="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_HC/analysis/bisulfite_conversion_spikeins_mean_"


cd /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_HC/bismark_alignment/ #change directory

mkdir /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_HC/analysis/ #make analysis directory

gunzip -d /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_HC/bismark_alignment/*bismark.cov.gz #unzip the DNA methylation coverage files

Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/1.plot_bis_conversion_spikeins_ISCA.r $cohort $brain_region $pdf_path
Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/1.plot_bis_conversion_spikeins_mean_ISCA.r $cohort $brain_region $pdf_path2




#####CTT_HPT samples####
#arguments:
cohort="CTT"
brain_region="HPT"
pdf_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_HPT/analysis/bisulfite_conversion_spikeins_"
pdf_path2="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_HPT/analysis/bisulfite_conversion_spikeins_mean_"


cd /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_HPT/bismark_alignment/ #change directory

mkdir /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_HPT/analysis/ #make analysis directory

gunzip -d /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_HPT/bismark_alignment/*bismark.cov.gz #unzip the DNA methylation coverage files

Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/1.plot_bis_conversion_spikeins_ISCA.r $cohort $brain_region $pdf_path
Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/1.plot_bis_conversion_spikeins_mean_ISCA.r $cohort $brain_region $pdf_path2
