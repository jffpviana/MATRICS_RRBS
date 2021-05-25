#!/bin/bash
#SBATCH --ntasks 20
#SBATCH --time 1-0:0:0
#SBATCH --qos castles
#SBATCH --mail-type ALL

set -e

module purge; module load bluebear
module load R-bundle-Bioconductor/3.10-foss-2019b-R-3.6.2

export R_LIBS_USER=${HOME}/R/library/${EBVERSIONR}/${BB_CPU}

cd /rds/projects/v/vianaj-genomics-brain-development/MATRICS/jobs/CTR/PFC/


input_dir="/rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/PFC/analysis/"
output_dir="/rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/PFC/analysis/"
pheno_path="/rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/phenoCTR.csv"
function_path="/rds/projects/v/vianaj-genomics-brain-development/MATRICS/scripts/betaRegression3Groups.r"
region="PFC_ID"
cohort="CTR"


Rscript 5.DMPs.r $input_dir $output_dir $pheno_path $function_path $region $cohort
