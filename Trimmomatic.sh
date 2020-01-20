#!/bin/bash
#SBATCH --job-name=Trimmomatic
#SBATCH -o Trimmomatic-%j.output
#SBATCH -e Trimmomatic-%j.error
#SBATCH --mail-user=nasim.rahmatpour@uconn.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=10G
#SBATCH --partition=general
#SBATCH --qos=general

module load Trimmomatic/0.36

java -jar $Trimmomatic PE -threads 8 Marsilea_vestita_S31_L002_R1_001.fastq Marsilea_vestita_S31_L002_R2_001.fastq leaf_paired_1.fq leaf_unpaired_1.fq leaf_paired_2.fq leaf_unpaired_2.fq ILLUMINACLIP:/isg/shared/apps/Trimmomatic/0.36/adapters/TruSeq3-PE.fa:2:30:10 -phred33 SLIDINGWINDOW:4:25 MINLEN:36
