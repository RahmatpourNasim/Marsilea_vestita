#!/bin/bash
# Submission script for Xanadu
#SBATCH --job-name=repeatmasker
#SBATCH -o repeatmasker-%j.output
#SBATCH -e repeatmasker-%j.error
#SBATCH --mail-user=nasim.rahmatpour@uconn.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=50G
#SBATCH --cpus-per-task=8
#SBATCH --partition=general
#SBATCH --qos=general
# Run the program                 

module load RepeatMasker/4.0.6

RepeatMasker Marsilea_vestita_genome_v1.fasta -dir /home/CAM/nrahmatpour/Nasim/Marsilea_genome/new_RepeatMasker/ -lib /home/CAM/nrahmatpour/Nasim/Marsilea_genome/new_RepeatMasker/LTR-retriever_RM_renamed.libnoProtFinal -pa 4 -gff -a -noisy -low -xsmall| tee output_Marsilea_vestita_genome.masked.fasta

