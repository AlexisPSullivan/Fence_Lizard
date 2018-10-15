#!/bin/sh

#  aDNApipeline.sh
#  
#  Original pipeline created by Lua Admin Acct on 7/6/17.
#
#  Modified by APS on 2018-10-10.
#

# setting variables
ALL_SAMPLES=$(cat /storage/home/aps216/scratch/FenceLizard/data/preserved/AllSamples.txt)

RAWREADS=$(echo "/storage/home/aps216/scratch/FenceLizard/data/preserved/")
READSDIR=$(echo "/storage/home/aps216/scratch/FenceLizard/data/preserved/ConcatFQ")

# adapter trimming and merge reads
for i in $ALL_SAMPLES
do
        module load leehom; leeHom --ancientdna -fq1 ${RAWREADS}/${i}_R1.fastq.gz -fq2 ${RAWREADS}/${i}_R2.fastq.gz -fqo ${READSDIR}/${i}
done

exit;
