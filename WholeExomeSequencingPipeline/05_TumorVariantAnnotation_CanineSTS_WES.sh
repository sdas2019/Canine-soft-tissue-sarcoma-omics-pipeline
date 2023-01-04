#Running vcf2maf.pl to annotate simple variants
#This code was accessed from https://github.com/mskcc/vcf2maf

#Running this with annotation of ensembl - v99. 

#Unzippng variant call file
gzip -d -c PATHNAME/sample.name \
        > PATHNAME/unzipsample

#Running vcf2maf
perl ~/vcf2maf/vcf2maf.pl \
        --vep-path /home/sdas/miniconda3/envs/ensembl/bin/ \
        --cache-version 99 \
        --input-vcf PATHNAME/unzipsample \
        --output-maf OUTFILEPATH/fname.code_Tool_v99.maf \
        --tumor-id fname.code \
        --normal-id  normal.name \
        --vcf-tumor-id fname.code \
        --vcf-normal-id normal.name \
        --species canis_familiaris \
        --ref-fasta ~/Documents/CanFamDatabases/DogGenome/Canis_familiaris.CanFam3.1.dna.fa \
        --ncbi-build CanFam3.1 \
        --tmp-dir ./vepVCF \
        --retain-info INFO2RETAIN

rm PATHNAME/unzipsample
