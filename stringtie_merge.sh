#!/bin/bash
#SBATCH --job-name=Stringtie_merge
#SBATCH -o stringtie-%j.output
#SBATCH -e stringtie-%j.error
#SBATCH --mail-user=nasim.rahmatpour@uconn.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=20G
#SBATCH --partition=himem
#SBATCH --qos=himem

module load stringtie/2.0.3
stringtie --merge -p 16 -o merged stringtie_merged.gtf mergelist.txt
