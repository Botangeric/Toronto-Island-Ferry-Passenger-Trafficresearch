#### Preamble ####
# Purpose: Tests... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
monthly_summary <- read_csv("Toronto-isolands-ferry-tickets/data/analysis_data/analysis_data_month.csv")
basic_stats <- read_csv("Toronto-isolands-ferry-tickets/data/analysis_data/basic_stats.csv")
sales_by_day <- read_csv("Toronto-isolands-ferry-tickets/data/analysis_data/sales_by_day.csv")
hour_data <- read_csv("Toronto-isolands-ferry-tickets/data/analysis_data/hour_data.csv")

#### Test data ####
all_greater_than_zero <- all(monthly_summary$Redemption_Count >= 0) & all(monthly_summary$Sales_Count >= 0)

# Print result
if (all_greater_than_zero) {
  print("All counts are greater than zero.")
} else {
  print("Some counts are not greater than zero.")
}

# Test if all 'sales' and 'redemption' values are positive
all_positive <- all(hour_data$sales >= 0 & hour_data$redemption >= 0)

# Print the result
if (all_positive) {
  print("All sales and redemption values are positive")
} else {
  print("There are sales or redemption values that are not positive")
}
# Test if all 'total_sales' values are positive
all_sales_positive <- all(sales_by_day$total_sales > 0)

# Print the result
if (all_sales_positive) {
  print("All total_sales values are positive")
} else {
  print("There are total_sales values that are not positive")
}