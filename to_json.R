## Process DFs to JSON ----

# IMPC phenotypes ----
impc_phenotypes_nested <- impc_phenotypes %>%
  group_by(GeneID) %>%
  nest(impc_phenotype_info = c(impc_zygosity, impc_phenotypes))

# IMPC viability ----
impc_viability_nested <- impc_viability %>%
  group_by(GeneID) %>%
  nest(impc_viability_info = c(impc_viability))

# Combines DFs 
combined <- genes %>%
  left_join(impc_phenotypes_nested, by = "GeneID") %>% 
  left_join(impc_viability, by = "GeneID") 

# Convert to JSON
json_data <- toJSON(combined, pretty = TRUE, auto_unbox = TRUE, na = "null")
cat(json_data)

# Exmaple to Query specific gene
json_data %>% jq('.[] | select(.symbol == "HIRA")')

