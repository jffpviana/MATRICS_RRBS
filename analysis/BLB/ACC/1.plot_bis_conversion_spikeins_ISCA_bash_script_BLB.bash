#!/bin/bash
#SBATCH --ntasks 8
#SBATCH --time 4-0:0:0
#SBATCH --qos bbdefault
#SBATCH --mail-type ALL

set -e

module purge; module load bluebear
module load R-bundle-Bioconductor/3.10-foss-2019b-R-3.6.2




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
