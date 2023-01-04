#!/bin/bash
#SBATCH -J FMC_fname.code
#SBATCH -p shas
#SBATCH --qos Normal
#SBATCH -t 24:00:00
#SBATCH -N 1
#SBATCH --mem=40000
#SBATCH --output=fname.code_Mutect2.out

# Loading module
module load jdk/1.8.0

# Running Mutect2
gatk --java-options '-DGATK_STACKTRACE_ON_USER_EXCEPTION=true' \
Mutect2 \
	-R /projects/sdas\@colostate.edu/CanFamDatabases/DogGenome/Canis_familiaris.CanFam3.1.dna.fa \
	-I ../BAM/fname.code_recal_reads.bam \
	-I ../BAM/fname.code_recal_reads.bam \
	-tumor fname.code \
	-normal normal.name \
	-pon /projects/sdas\@colostate.edu/Germline/2021.08.21_PON_Mutect2_FMC_OxoG_Passonly_gatk_118samples.vcf.gz \
	--germline-resource /projects/sdas\@colostate.edu/Germline/722g.990.SNP.INDEL.8Cols.vcf.gz \
	--af-of-alleles-not-in-resource 0.0000025 \
	--disable-read-filter MateOnSameContigOrNoMappedMateReadFilter \
	-O ../Mutect2/T1834_somatic_m2-GR.vcf.gz \
	-bamout ../Mutect2/BAM/T1834_tumor_normal_m2-GR.bam

#Moving the variants called by Mutect2 to intermediary folder
mv ../Mutect2/fname.code* ../Mutect2/intermediary/

#Filtering the mutect Calls
gatk FilterMutectCalls -V ../Mutect2/intermediary/fname.code_somatic_m2-GR.vcf.gz \
-R /projects/sdas\@colostate.edu/CanFamDatabases/DogGenome/Canis_familiaris.CanFam3.1.dna.fa \
-O ../Mutect2/intermediary/fname.code_somatic_m2_GR_FMC.vcf.gz


#Filtering by orientation bias

gatk FilterByOrientationBias \
-AM G/T \
-AM C/T \
-V ../Mutect2/intermediary/fname.code_somatic_m2_GR_FMC.vcf.gz \
-P ../Metrics/SeqArtifact/fname.code.pre_adapter_detail_metrics.txt \
-O ../Mutect2/fname.code_somatic_m2_GR_FMC_OxoGfiltered.vcf.gz

#Selecting PASS variants
 
gatk SelectVariants -V ../Mutect2/fname.code_somatic_m2_GR_FMC_OxoGfiltered.vcf.gz \
	--exclude-filtered TRUE \
	-O ../Mutect2/PassOnly/fname.code_somatic_m2-GR_FMC_OxoGfiltered_PASSonly.vcf.gz

