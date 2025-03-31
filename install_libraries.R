## Install libraries ----

# Define a vector of required packages
required_packages <- c("data.table", "dplyr", "tidyr", "jsonlite", "jqr")

for (pkg in required_packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg, dependencies = TRUE)
  }
}

# Load the packages
lapply(required_packages, library, character.only = TRUE)


# Load libraries ---
library(data.table)
library(utils)
library(dplyr)
library(tidyr)
library(jsonlite)
library(jqr)