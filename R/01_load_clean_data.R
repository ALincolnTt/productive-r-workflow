# Read data
# data <- read.csv("input/data.csv")
data <- readxl::read_xlsx("input/data.xlsx", na = "NA")

error_data <- dplyr::slice(data, c(23, 48))
clean_data <- dplyr::slice(data, -c(23, 48))
# penguins_nas   <- dplyr::filter(data, !complete.cases(data))
# penguins_clean <- dplyr::filter(data, complete.cases(data))

saveRDS(clean_data, file.path("input/clean_data.rds"))
