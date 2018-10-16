# FENCE LIZARD
Analyses for my dissertation work with Sceloporus undulatus - Perry/Langkilde Labs, Penn State University

I've broken this project down into two distinct parts, Modern and Preserved, based on the source material from which I acquired DNA. Individuals of each type were processed in facilities designated for these tissue types. Please contact aps216@psu.edu for more information.

# PRESERVED
Raw sequence data directories:
3 YPM test lizards - /gpfs/group/ghp3/default/rawReadData/2018-07-23_SM-APS/genome.med.nyu.edu/results/external/PennState/2018-07-20/fastq

mkdir the following directories in scratch:
/storage/home/*username*/scratch/FenceLizard
/storage/home/*username*/scratch/FenceLizard/data
/storage/home/*username*/scratch/FenceLizard/data/preserved
/storage/home/*username*/scratch/FenceLizard/data/preserved/ConcatFQ
/storage/home/*username*/scratch/FenceLizard/data/preserved/aln
/storage/home/*username*/scratch/FenceLizard/data/preserved/FilterMap
/storage/home/*username*/scratch/FenceLizard/scripts
/storage/home/*username*/scratch/FenceLizard/pbs
/storage/home/*username*/scratch/FenceLizard/reports

Copy reference genome into scratch *data* directory:
cp /gpfs/group/ghp3/default/RefGenomes/Sceloporus_undulatus/jelly.out.fasta.gz /storage/home/*username*/scratch/FenceLizard/data

Create index, dictionary of unzipped reference genome (output copied below)
1.8G jelly.out.fasta
756K jelly.out.fasta.amb
1.7M jelly.out.fasta.ann
1.8G jelly.out.fasta.bwt
5.8M jelly.out.fasta.dict
1.7M jelly.out.fasta.fai
455M jelly.out.fasta.pac
909M jelly.out.fasta.sa

Copy raw sequence data files into scratch *data/preserved* directory: /storage/home/*username*/scratch/FenceLizard/data/preserved/

cat R1 and R2 data from different lanes for each individual:
cat *indiv-ID_S##*_L001_R1_001.fastq.gz *indiv-ID_S##*_L002_R1_001.fastq.gz *indiv-ID_S##*_L003_R1_001.fastq.gz *indiv-ID_S##*_L004_R1_001.fastq.gz > *indiv-ID_S##*R1.fastq.gz
cat *indiv-ID_S##*_L001_R2_001.fastq.gz *indiv-ID_S##*_L002_R2_001.fastq.gz *indiv-ID_S##*_L003_R2_001.fastq.gz *indiv-ID_S##*_L004_R2_001.fastq.gz > *indiv-ID_S##*R2.fastq.gz

Create text file that contains sample IDs: /storage/home/*username*/scratch/FenceLizard/data/preserved/AllSamples.txt
*indiv-ID_S##*
*indiv-ID_S##*
*indiv-ID_S##*

Adapter trimming with leehom (https://github.com/grenaud/leeHom)

Merging reads with cat: 
cat *indiv-ID_S##*.fq.gz *indiv-ID_S##*_r1.fq.gz *indiv-ID_S##*_r2.fq.gz > *indiv-ID_S##*_all.fq.gz
cat *indiv-ID_S##*.fq.gz *indiv-ID_S##*_r1.fq.gz > *indiv-ID_S##*_allr1.fq.gz
cat *indiv-ID_S##*.fq.gz *indiv-ID_S##*_r2.fq.gz > *indiv-ID_S##*_allr2.fq.gz
   
Map reads to reference with bwa-mem (https://github.com/lh3/bwa)
bwa mem ref.fa reads.fq.gz > aln-se.sam
bwa mem ref.fa read1.fq read2.fq > aln-pe.sam

Convert sam files to bam files, sort the bam files, and remove PCR duplicates with samtools (http://samtools.sourceforge.net/)

Filter by quality-length (min size 30bp and quality 30) and index bam files (IMPORTANT that the bam files are indexed or GATK won't work) with samtools

Check how many reads survived each step (mapping, removing duplicates, filtering) with samtools flagstat (http://www.htslib.org/doc/samtools.html)

Run mapdamage (https://ginolhac.github.io/mapDamage/)
module load mapdamage; mapDamage -i mymap.bam -r myreference.fasta

Convert bam to fasta for blast with samtools

Run blast with megablast (online version here: https://blast.ncbi.nlm.nih.gov/Blast.cgi??DATABASE=nr&PAGE=MegaBlast&FILTER=L&QUERY=AL954329)

