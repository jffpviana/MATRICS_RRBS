#!/bin/bash
#SBATCH --ntasks 8
#SBATCH --time 4-0:0:0
#SBATCH --qos bbdefault
#SBATCH --mail-type ALL

set -e

module purge; module load bluebear
module load R-bundle-Bioconductor/3.10-foss-2019b-R-3.6.2


#set cohort and region specific options
input_dir="/rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/PFC/methylation/"
plots_dir="/rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/PFC/QC/plots/"

Rscript /rds/projects/v/vianaj-genomics-brain-development/MATRICS/jobs/1.plot_bis_conversion_spikeins.r $input_dir $plots_dir
