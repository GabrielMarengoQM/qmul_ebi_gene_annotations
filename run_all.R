## Run all scripts sequentially ----

# First, install and load libraries
source("install_libraries.R")

# Then, run the rest of your scripts
source("pull_data.R")
source("process_impc_data.R")
source("map_gene_ids.R")
source("to_json.R")