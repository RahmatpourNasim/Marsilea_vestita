#!/bin/bash
# Submission script for Xanadu
####SBATCH --time=10-01:00:00 # days-hh:mm:ss
####SBATCH --mem=350GB
#SBATCH --job-name=gth
#SBATCH -o gth-%j.output
#SBATCH -e gth-%j.error
#SBATCH --mail-user=nasim.rahmatpour@uconn.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=10G
#SBATCH --partition=general
#SBATCH --qos=general
###SBATCH --array=1-9%9


module load genomethreader/1.7.1


gth -genomic /home/CAM/nrahmatpour/Nasim/Marsilea_genome/GenomeThreader/Azolla/Marsilea_vestita_genome_v1.fasta.masked -protein /home/CAM/nrahmatpour/Nasim/Marsilea_genome/GenomeThreader/Azolla/Azolla_filiculoides.protein.highconfidence_v1.1.fasta -gff3out -startcodon -finalstopcodon -dpminexonlen 20 -dpminintronlen 9 -skipalignmentout -o Azolla_graph_gth.gff3  


#------------------------
