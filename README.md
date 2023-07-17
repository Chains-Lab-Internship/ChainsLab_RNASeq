# ChainsLab_RNASeq

Project Report: Differential Gene Expression Analysis in Stickleback

Introduction: The aim of this project was to investigate the differential gene expression between marine and freshwater populations of three-spined stickleback (Gasterosteus aculeatus) and identify the genes that are upregulated and downregulated under different environmental conditions. The study focused on understanding the epigenetic adaptation of sticklebacks to freshwater environments, as well as the role of DNA methylation in this process.

Methods: To perform the analysis, the DESeq2 package in R was utilized. The count data and metadata were obtained from the paper titled "Genome-Wide DNA Methylation Profiling Reveals Epigenetic Adaptation of Stickleback to Marine and Freshwater Conditions" by Artem V Artemov et al. [PMID: 28873953, DOI: 10.1093/molbev/msx156].

The following steps were carried out in the R code provided:
Installation and loading of required libraries, including DESeq2, ggplot2, and readr.
Setting the working directory to the folder containing the count data and metadata.
Reading the count data from the "counts.csv" file and the metadata from the "metadata.txt" file.
Converting character variables in the metadata to factors.
Constructing a DESeqDataSet object using the count data and metadata, with the treatment variable ("Treatment") as the main factor of interest.
Running the DESeq function to perform differential expression analysis.
Extracting the differential expression results and sorting them by adjusted p-value.
Creating a volcano plot to visualize the log2 fold change versus the negative log10 p-value for all genes.
Highlighting differentially expressed genes based on significance (padj < 0.01) and fold change (log2FoldChange > 1 or log2FoldChange < -1).
Creating an MA plot to display the average expression level versus log2 fold change for all genes.
Highlighting upregulated genes (log2FoldChange > 1) and downregulated genes (log2FoldChange < -1).
Selecting the differentially expressed genes with significant fold change (padj < 0.01 and abs(log2FoldChange) > 1).
Sorting the genes by absolute fold change.
Converting the DESeqResults object to a data frame for further analysis and visualization.
Creating a bar plot showing the gene names and log2 fold change of the differentially expressed genes.
Highlighting upregulated genes in red and downregulated genes in blue.

Results: Based on the differential expression analysis, the following genes were found to be upregulated in the stickleback populations:
ENSGACG00000007454
ENSGACG00000012974
ENSGACG00000019485 (second most upregulated)
ENSGACG00000019490 (most upregulated)
ENSGACG00000020961
ENSGACG00000021780
On the other hand, the following genes were found to be downregulated:
ENSGACG00000000458
ENSGACG00000005896
ENSGACG00000018379
ENSGACG00000019379
ENSGACG00000019384
ENSGACG00000019519
The bar plot visualization provides a clear overview of the differential expression patterns for these genes, with upregulated genes shown in red and downregulated genes shown in blue. The log2 fold change values indicate the extent of expression changes between the marine and freshwater populations of sticklebacks.

Conclusion: In this project, differential gene expression analysis was performed using DESeq2 in R to investigate the epigenetic adaptation of sticklebacks to marine and freshwater environments. The results revealed several genes that were significantly upregulated or downregulated in response to environmental conditions.
The upregulated genes identified in this study, such as ENSGACG00000019490 and ENSGACG00000019485, may play important roles in the adaptation of sticklebacks to freshwater conditions. The downregulated genes, including ENSGACG00000000458 and ENSGACG00000018379, might be involved in processes specific to marine environments.
These findings contribute to a better understanding of the molecular mechanisms underlying the adaptation of sticklebacks to different ecological niches. Further studies could focus on the functional characterization of the identified genes to elucidate their roles in the adaptation process and their potential impacts on stickleback biology.
Overall, this project demonstrates the utility of DESeq2 for identifying differentially expressed genes and provides valuable insights into the epigenetic adaptation of sticklebacks to marine and freshwater environments.
