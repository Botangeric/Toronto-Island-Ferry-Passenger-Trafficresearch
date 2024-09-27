#### Preamble ####
# Purpose: Simulates... 
# Author: Bo Tang 
# Date: 24.9.2024 
# Contact: qinghe.tang@mail.utoronto.ca 
# License: 
# Pre-requisites: 
# Any other information needed? 


#### Workspace setup ####
library(tidyverse)


#### Simulate data ####
set.seed(304)

# Define the start and end date
start_date <- as.Date("2023-09-01")
end_date <- as.Date("2024-09-30")

# Generate a sequence of dates for each day in the range
date_seq <- seq.Date(start_date, end_date, by = "day")

# Simulate daily ticket sales, assuming daily sales range between 100 and 500
sales_count <- sample(100:500, length(date_seq), replace = TRUE)

# Create a dataframe containing the dates and corresponding sales counts
simulated_data <- data.frame(Date = date_seq, Sales_Count = sales_count)

# View the first few rows of the data
head(simulated_data)

#### Write_csv
write_csv(simulated_data, file = "Toronto-isolands-ferry-tickets/data/raw_data/simulated.csv")