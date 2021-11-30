#!/usr/bin/env nextflow

params.out_dir = "My_out"
params.rawReads="$baseDir/*_{1,2}.fq.gz"
params.ncbi_api_key = 'PLEASE_ENTER_YOUR_KEY'

params.accession = ['ERR908507']

reads = Channel.fromSRA(params.accession, apiKey: params.ncbi_api_key)

process runFastQC{

    input:
        set sample, file(in_fastq) from reads

    output:
        file("${sample}_fastqc/*.zip") into fastqc_files

    """
    mkdir ${sample}_fastqc
    fastqc --outdir ${sample}_fastqc \
    -t ${task.cpus} \
    ${in_fastq.get(0)} \
    ${in_fastq.get(1)}
    """
}

process runMultiQC{

    input:
        file('*') from fastqc_files.collect()

    output:
        file('multiqc_report.html')

    """
    multiqc .
    """
}

workflow.onComplete {

    println ( workflow.success ? """
        Pipeline execution summary
        ---------------------------
        Completed at: ${workflow.complete}
        Duration    : ${workflow.duration}
        Success     : ${workflow.success}
        workDir     : ${workflow.workDir}
        exit status : ${workflow.exitStatus}
        """ : """
        Failed: ${workflow.errorReport}
        exit status : ${workflow.exitStatus}
        """
    )
}
