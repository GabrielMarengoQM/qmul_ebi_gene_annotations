# Libraries ----
library(data.table)
library(utils)

## Data retrieval ----
# 1 - Human protein coding genes (EBI) ----
protein.coding.genes <- utils::read.delim('https://storage.googleapis.com/public-download-files/hgnc/tsv/tsv/locus_types/gene_with_protein_product.txt')

# 2 - Mouse genes, viability and phenotypes (IMPC, MGI) ----
# IMPC viability, phenotypes
mouse.viability.impc <- fread(
  "http://ftp.ebi.ac.uk/pub/databases/impc/all-data-releases/release-22.1/results/viability.csv.gz"
)
mouse.phenotypes.impc <- fread(
  "http://ftp.ebi.ac.uk/pub/databases/impc/all-data-releases/release-22.1/results/genotype-phenotype-assertions-ALL.csv.gz"
)

