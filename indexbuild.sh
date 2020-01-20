#!/bin/bash
#SBATCH --job-name=indexbuild
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 8
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=END
#SBATCH --mail-user=nasim.rahmatpour@uconn.edu
#SBATCH --mem=50G
#SBATCH -o indexbuild_%j.out
#SBATCH -e indexbuild_%j.err
module load hisat2
hisat2-build -p 8 /home/CAM/nrahmatpour/Nasim/Marsilea_genome/4_RepeatMasker/Marsilea_vestita_genome_v1.fasta.masked  Marsilea_vestita.masked
