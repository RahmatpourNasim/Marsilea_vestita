#!/bin/bash

# RepeatModeler
perl /home/fay-wei/bin/RepeatModeler-open-1.0.11/BuildDatabase -name Anthoceros_punctatus_asm_v1.fa_db -engine ncbi ../Anthoceros_punctatus_asm_v1.fa
mkdir 1_RepeatModeler
cd 1_RepeatModeler
perl /home/fay-wei/bin/RepeatModeler-open-1.0.11/RepeatModeler -pa 45 -database ../../Anthoceros_punctatus_asm_v1.fa_db -engine ncbi ../../Anthoceros_punctatus_asm_v1.fa
/home/fay-wei/bin/Custom-Repeat-Library/repeatmodeler_parse.pl --fastafile consensi.fa.classified --unknowns repeatmodeler_unknowns.fasta --identities repeatmodeler_identities.fasta
blastx -query repeatmodeler_unknowns.fasta -db /home/fay-wei/bin/Tpases020812 -evalue 1e-10 -num_descriptions 10 -out modelerunknown_blast_results.txt -num_threads 40
perl /home/fay-wei/bin/Custom-Repeat-Library/transposon_blast_parse.pl --blastx modelerunknown_blast_results.txt --modelerunknown repeatmodeler_unknowns.fasta
mv unknown_elements.txt ModelerUnknown.lib
cat identified_elements.txt repeatmodeler_identities.fasta > ModelerID.lib
cd ../..

# LTR_retriever
mkdir 2_LTR_retriever
cd 2_LTR_retriever
gt suffixerator -db ../../Anthoceros_punctatus_asm_v1.fa -indexname Anthoceros_punctatus_asm_v1 -tis -suf -lcp -des -ssp -sds -dna
gt ltrharvest -index Anthoceros_punctatus_asm_v1 -minlenltr 100 -maxlenltr 7000 -mintsd 4 -maxtsd 6 -motif TGCA -motifmis 1 -similar 85 -vic 10 -seed 20 -seqids yes > Anthoceros_punctatus_asm_v1.harvest.scn
/home/fay-wei/bin/LTR_Finder/source/ltr_finder -D 15000 -d 1000 -L 7000 -l 100 -p 20 -C -M 0.85 ../../Anthoceros_punctatus_asm_v1.fa > Anthoceros_punctatus_asm_v1.finder.scn
/home/fay-wei/bin/LTR_retriever/LTR_retriever -genome ../../Anthoceros_punctatus_asm_v1.fa -inharvest Anthoceros_punctatus_asm_v1.harvest.scn -infinder Anthoceros_punctatus_asm_v1.finder.scn -threads 40
./extract_unknownLTR.py
blastx -query Anthoceros_punctatus_asm_v1.fa.LTRlib.unknown.fa -db /home/fay-wei/bin/Tpases020812 -evalue 1e-10 -num_descriptions 10 -out Anthoceros_punctatus_asm_v1.fa.LTRlib.unknown.blastout -num_threads 40
perl /home/fay-wei/bin/Custom-Repeat-Library/transposon_blast_parse.pl --blastx Anthoceros_punctatus_asm_v1.fa.LTRlib.unknown.blastout --modelerunknown Anthoceros_punctatus_asm_v1.fa.LTRlib.unknown.fa
cat Anthoceros_punctatus_asm_v1.fa.LTRlib.known.fa identified_elements.txt > Anthoceros_punctatus_asm_v1.fa.LTRlib.known.final.fa
mv unknown_elements.txt Anthoceros_punctatus_asm_v1.fa.LTRlib.unknown.final.fa
cd ..

# MITE_hunter
# perl /home/fay-wei/bin/MITE_Hunter/MITE_Hunter_manager.pl -i ../Anthoceros_agrestis_Oxford_asm_v1.fa -n 45 -S 12345678 -P 1

# Combine repeat libraries
mkdir 3_ProtExclude
cd 3_ProtExclude
cat ../1_RepeatModeler/RM_3575.WedApr171624012019/ModelerID.lib ../1_RepeatModeler/RM_3575.WedApr171624012019/ModelerUnknown.lib ../2_LTR_retriever/Anthoceros_punctatus_asm_v1.fa.mod.LTRlib.unknown.final.fa ../2_LTR_retriever/Anthoceros_punctatus_asm_v1.fa.mod.LTRlib.known.final.fa > LTR-retriever_RM.lib
./rename_seq.py

# Exclude proteins
blastx -db /home/fay-wei/bin/uniprot/uniprot_sprot_plants.fasta -query LTR-retriever_RM_renamed.lib -out repeats2uniprot_plant_blast.out -num_threads 44
perl /home/fay-wei/bin/ProtExcluder1.1/ProtExcluder.pl repeats2uniprot_plant_blast.out LTR-retriever_RM_renamed.lib
cd ..

# RepeatMasker
mkdir 4_RepeatMasker
cd 4_RepeatMasker
/usr/local/RepeatMasker/RepeatMasker -noisy -a -gff -u -pa 45 -lib ../3_ProtExclude/LTR-retriever_RM_renamed.libnoProtFinal ../../Anthoceros_punctatus_asm_v1.fa

perl /usr/local/RepeatMasker/util/buildSummary.pl -species my_species -useAbsoluteGenomeSize Anthoceros_punctatus_asm_v1.fa.out > Anthoceros_punctatus_asm_v1.fa.out.detailed
