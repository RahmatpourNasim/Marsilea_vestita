#!/bin/bash
#SBATCH --job-name=Braker
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 20
#SBATCH --partition=himem
#SBATCH --qos=himem
#SBATCH --mail-type=END
#SBATCH --mail-user=nasim.rahmatpour@uconn.edu
#SBATCH --mem=200G
#SBATCH -o Braker_%j.out
#SBATCH -e Braker_%j.err

module load BRAKER/2.0.5
module unload GeneMark-ET/4.38
#module rm  perl/5.28.0-clean
#module unload perl/5.28.1
#module load perl/5.24.0

export PATH=/home/CAM/nrahmatpour/software/augustus/3.2.3/scripts:$PATH
export AUGUSTUS_CONFIG_PATH=/home/CAM/nrahmatpour/software/augustus/3.2.3/config

module load samtools/1.7 
module load bamtools/2.4.1
#export AUGUSTUS_CONFIG_PATH=$HOME/augustus/config
#export TMPDIR=/home/CAM/$USER/tmp/
export BAMTOOLS_PATH=/isg/shared/apps/bamtools/2.4.1/bin/
export PERL5LIB=/labs/Wegrzyn/perl5/lib/perl5/
export PERLINC=/labs/Wegrzyn/perl5/lib/perl5/
cp  ~/gm_key_64  ~/.gm_key

org="/home/CAM/nrahmatpour/Nasim/Marsilea_genome/Braker"
bam="/home/CAM/nrahmatpour/Nasim/Marsilea_genome/Braker"
protein="/home/CAM/nrahmatpour/Nasim/Marsilea_genome/Braker/all.gff3"
genome="/home/CAM/nrahmatpour/Nasim/Marsilea_genome/4_RepeatMasker/Marsilea_vestita_genome_v1.fasta.masked" 
species="Marsilea_vestita"
braker.pl --genome="$genome" --species="$species" --bam all_sorted.bam --prot_aln="$protein" --prg=gth --gth2traingenes --softmasking 1 --GENEMARK_PATH=/labs/Wegrzyn/local_software/gm_et_linux_64/gmes_petap/ --gff3 --useexisting

