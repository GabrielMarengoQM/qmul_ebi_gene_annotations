## Mouse viability and phenotypes from knockouts ----

# Human mouse gene mappings from EBI ----
human_mouse_genes <- protein.coding.genes %>%
  separate_rows(mgd_id, sep = "\\|") %>%
  dplyr::select(symbol, mgd_id) %>%
  dplyr::rename(gene_symbol = symbol, mgi_id = mgd_id)

# IMPC viability ----
mouse.viability.impc2 <- mouse.viability.impc %>%
  dplyr::filter(Comment == "") %>% # Remove conflicting evidence
  dplyr::select('Gene Accession Id', 'Viability Phenotype HOMs/HEMIs') %>%
  dplyr::rename(mgi_id = 'Gene Accession Id',
                impc_viability = 'Viability Phenotype HOMs/HEMIs') %>%
  distinct() %>%
  left_join(human_mouse_genes) %>%  # Join gene symbols to mouse viability
  dplyr::filter(!is.na(gene_symbol)) %>%
  dplyr::select(-mgi_id) %>%
  distinct()

conflicts <- mouse.viability.impc2 %>% # remove conflicts that arise from one2many mappings
  distinct() %>%
  count(gene_symbol) %>%
  filter(n == 1)

mouse.viability.impc3 <- mouse.viability.impc2 %>%
  filter(gene_symbol %in% conflicts$gene_symbol) %>%
  distinct()
# final = mouse.viability.impc3 

# IMPC phenotypes ----
mouse.phenotypes.impc2 <- mouse.phenotypes.impc %>%
  dplyr::select(marker_symbol, marker_accession_id, zygosity, mp_term_name, mp_term_id) %>%
  dplyr::rename(mgi_id = marker_accession_id,
                mouse_symbol = marker_symbol,
                impc_zygosity = zygosity,
                impc_phenotypes = mp_term_name,
                mp_id = mp_term_id) %>%
  dplyr::distinct() %>%
  left_join(human_mouse_genes) %>%
  dplyr::filter(!is.na(gene_symbol)) %>% 
  dplyr::select(gene_symbol, impc_phenotypes, impc_zygosity) %>% 
  distinct()
# final = mouse.phenotypes.impc2

#