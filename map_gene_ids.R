# Libraries ----
library(dplyr)
library(arrow)

# GENES ----
genes <- protein.coding.genes %>%
  dplyr::select(hgnc_id, symbol, ensembl_gene_id) %>%
  # Convert empty strings to NA for all columns
  dplyr::mutate(across(everything(), ~na_if(.x, ""))) %>%
  # Add geneID column formatted as G00001, G00002, etc.
  dplyr::mutate(GeneID = sprintf("G%05d", row_number())) %>%
  # Move geneID column to the beginning
  dplyr::select(GeneID, everything())

# IMPC VIABILITY ----
impc_viability <- genes %>% 
  dplyr::select(GeneID, symbol) %>%
  dplyr::left_join(mouse.viability.impc3 , by = c("symbol" = "gene_symbol")) %>%
  dplyr::select(GeneID, everything(), -symbol)

# IMPC PHENOTYPES ----
impc_phenotypes <- genes %>% 
  dplyr::select(GeneID, symbol) %>%
  dplyr::left_join(mouse.phenotypes.impc2, by = c("symbol" = "gene_symbol")) %>%
  dplyr::select(GeneID, everything(), -symbol) 
