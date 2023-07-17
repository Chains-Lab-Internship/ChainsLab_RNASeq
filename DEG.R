# Set the path for the user-specific library
user_lib <- "~/R_libs"

# Create the directory if it doesn't exist
if (!dir.exists(user_lib)) {
  dir.create(user_lib)
}

# Set the user-specific library as the default library location
.libPaths(user_lib)

# Install DESeq2 package
BiocManager::install("DESeq2", lib = user_lib)

# Load required libraries
library(DESeq2, lib.loc = user_lib)
library(ggplot2)
library(readr)

# Set the working directory to the folder containing the count data and metadata
setwd("~/RNASeq")

# Read count data and metadata
countData <- read.csv("counts.csv", header = TRUE, sep = ",")
metadata <- read_csv("metadata.txt")

# Convert character variables to factors
metadata$Treatment <- factor(metadata$Treatment)

# Construct DESeqDataSet object
dds <- DESeqDataSetFromMatrix(countData = countData,
                              colData = metadata,
                              design = ~ Treatment,
                              tidy = TRUE)


# Run DESeq function
dds <- DESeq(dds)

# Get differential expression results
res <- results(dds)

# Print head of the results table
head(results(dds, tidy = TRUE))

# Sort results by adjusted p-value
res <- res[order(res$padj), ]

# Create volcano plot
with(res, plot(log2FoldChange, -log10(pvalue), pch = 20, main = "Volcano plot", xlim = c(-3, 3)))

# Add colored points: blue if padj < 0.01, red if log2FC > 1 and padj < 0.05
with(subset(res, padj < 0.01), points(log2FoldChange, -log10(pvalue), pch = 20, col = "blue"))
with(subset(res, padj < 0.01 & abs(log2FoldChange) > 1), points(log2FoldChange, -log10(pvalue), pch = 20, col = "red"))

# Calculate the average expression level (mean of normalized counts)
res$average_expression <- rowMeans(counts(dds, normalized = TRUE))

# Create MA plot
with(res, plot(average_expression, log2FoldChange, pch = 20, main = "MA plot"))

# Highlight upregulated genes (log2FoldChange > 1)
with(subset(res, log2FoldChange > 1), points(average_expression, log2FoldChange, pch = 20, col = "red"))

# Highlight downregulated genes (log2FoldChange < -1)
with(subset(res, log2FoldChange < -1), points(average_expression, log2FoldChange, pch = 20, col = "blue"))

# Create a subset of differentially expressed genes
de_genes <- subset(res, padj < 0.01 & abs(log2FoldChange) > 1)
de_genes$Gene <- rownames(de_genes)

# Set the color based on upregulation (red) and downregulation (blue)
de_genes$Color <- ifelse(de_genes$log2FoldChange > 1, "red", "blue")

# Sort genes by absolute fold change
de_genes <- de_genes[order(-abs(de_genes$log2FoldChange)), ]

# Convert DESeqResults object to data frame
de_genes_df <- as.data.frame(de_genes)

# Create a bar plot with gene names and expression levels
ggplot(de_genes_df, aes(x = Gene, y = log2FoldChange, fill = Color)) +
  geom_bar(stat = "identity", color = "black") +
  labs(x = "Gene", y = "log2 Fold Change") +
  scale_fill_manual(values = c("red", "blue")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
  ggtitle("Differentially Expressed Genes") +
  guides(fill = FALSE)
