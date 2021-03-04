#!/bin/bash
#$ -cwd
#$ -j y
#$ -pe smp 4
#$ -N WGBS-DL
#$ -S /bin/bash
#$ -l h_vmem=16g
#$ -l h_rt=20:00:00
#$ -t 1-4

echo This is task $SGE_TASK_ID

module load sra-toolkit/2.9.6-1

sourcedir=$(pwd)
indir=$sourcedir/00_fastq


mkdir -p $indir


accession=$(awk "NR==${SGE_TASK_ID}" $sourcedir/SraAccList.txt)
sample=$(awk "NR==${SGE_TASK_ID}" $sourcedir/sample_list.txt)
echo "Started task ${SGE_TASK_ID} for sample: ${sample} download"; date

cd $indir
fastq-dump --gzip --split-3 --accession $accession

mv ${accession}_1.fastq.gz ${sample}_1.fastq.gz
mv ${accession}_2.fastq.gz ${sample}_1.fastq.gz

