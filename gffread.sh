#!/bin/bash
#SBATCH --job-name=gffread
#SBATCH -o gffread-%j.output
#SBATCH -e gffread-%j.error
#SBATCH --mail-user=nasim.rahmatpour@uconn.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=20G
#SBATCH --partition=himem
#SBATCH --qos=himem

module load gffread/0.9.12
gffread -w transcripts.fa -g /home/CAM/nrahmatpour/Nasim/Marsilea_genome/4_RepeatMasker/Marsilea_vestita_genome_v1.fasta.masked stringtie_merged.gtf 

