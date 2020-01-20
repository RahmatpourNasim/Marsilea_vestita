#!/bin/bash
#SBATCH --job-name=Stringtie
#SBATCH -o stringtie-%j.output
#SBATCH -e stringtie-%j.error
#SBATCH --mail-user=nasim.rahmatpour@uconn.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=20G
#SBATCH --partition=himem
#SBATCH --qos=himem

module load stringtie/2.0.3
stringtie 1-2hr_sorted_paired.bam -p 8 -m 300 -o 1-2hr
stringtie 12_2_sorted_paired.bam -p 8 -m 300 -o 12_2
stringtie 1-2B_sorted_paired.bam -p 8 -m 300 -o 1-2B
stringtie 35_4_sorted_paired.bam -p 8 -m 300 -o 35_4
stringtie 3-5B_sorted_paired.bam -p 8 -m 300 -o 3-5B
stringtie 3-5hr_sorted_paired.bam -p 8 -m 300 -o 3-5hr
stringtie 68_5_sorted_paired.bam -p 8 -m 300 -o 68_5
stringtie 6-8B_sorted_paired.bam -p 8 -m 300 -o 6-8B
stringtie 6-8hr_sorted_paired.bam -p 8 -m 300 -o 6-8hr
stringtie Actinomycin_sorted_paired.bam -p 8 -m 300 -o Actinomycin
stringtie AlphaAma_sorted_paired.bam -p 8 -m 300 -o AlphaAma
stringtie CPSF_sorted_paired.bam -p 8 -m 300 -o CPSF
stringtie leaf_sorted_paired.bam -p 8 -m 300 -o leaf
stringtie MvU620range1_sorted_paired.bam -p 8 -m 300 -o MvU620range1
stringtie MvU620range2_sorted_paired.bam -p 8 -m 300 -o MvU620range2
stringtie PRP_sorted_paired.bam -p 8 -m 300 -o PRP
stringtie RdRp_sorted_paired.bam -p 8 -m 300 -o RdRp
stringtie RNApolIII_sorted_paired.bam -p 8 -m 300 -o RNApolIII
stringtie SPD_sorted_paired.bam -p 8 -m 300 -o SPD    
