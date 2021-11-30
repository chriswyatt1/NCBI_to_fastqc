# Nextflow FASTQC workflow  

A Nextflow workflow that runs FastQC on fastq reads downloaded from NCBI and then combines them into a single MultiQC report. 
FastQC and MutliQC are setup on a Docker container, which are converted init a Singularity container to run on a Sun Grid Engine cluster. 
The current nextflow.config file is set up to run on UCL myriad.

## To run

 `nextflow run main.nf -bg -resume --ncbi_api_key 'Enter Your Key'` 

## To get a NCBI API Key. 

Go to : www.ncbi.nlm.nih.gov/

Click top right button to "Sign into NCBI". Follow their instructions.

Once into your account, click the button at top right, left of My NCBI, usually your ID.

Scroll down to API key section. Copy your key.


## Then choose a SRA name to run from:
```
Important flags:

--accession 'SRA0000000'
```
