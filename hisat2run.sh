#!/bin/bash
#SBATCH --job-name=hisat2run
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 16
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=END
#SBATCH --mail-user=nasim.rahmatpour@uconn.edu
#SBATCH --mem=50G
#SBATCH -o hisat2run_%j.out
#SBATCH -e hisat2run_%j.err
module load hisat2
module load samtools
hisat2 -x Marsilea_vestita.masked -1 leaf_paired_1.fq -2 leaf_paired_2.fq -p 16 -S leaf_paired.sam
samtools view -@ 16 -uhS leaf_paired.sam | samtools sort -@ 16 -o  leaf_sorted_paired.bam

