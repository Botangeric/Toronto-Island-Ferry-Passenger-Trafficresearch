#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers
# Author: Bo Tang 
# Date: 24.9.2024 
# Contact: qinghe.tang@mail.utoronto.ca 
# License: 
# Pre-requisites: 
# Any other information needed? 

#### Workspace setup ####
library(tidyverse)

#### Clean data ####
library(readr)
options(scipen=999)
raw_data <- read_csv("Toronto-isolands-ferry-tickets/data/raw_data/raw_data.csv")
#Data for the most recent year#
# Read the CSV file
data <- raw_data

# Convert 'Timestamp' column to datetime format
data$Timestamp <- as.POSIXct(data$Timestamp, format="%Y-%m-%dT%H:%M:%S")

# Extract Year and Month from 'Timestamp'
data$YearMonth <- format(data$Timestamp, "%Y-%m")

# Summarize Redemption and Sales counts by each month
monthly_summary <- data %>%
  group_by(YearMonth) %>%
  summarise(Redemption_Count = sum(`Redemption Count`, na.rm = TRUE),
            Sales_Count = sum(`Sales Count`, na.rm = TRUE))

# Convert 'YearMonth' to date format for plotting
monthly_summary$YearMonth <- as.Date(paste0(monthly_summary$YearMonth, "-01"))

# Calculate basic statistics (mean, median, variance, standard deviation)
basic_stats <- data %>%
  summarise(
    Redemption_Mean = mean(`Redemption Count`, na.rm = TRUE),
    Redemption_Median = median(`Redemption Count`, na.rm = TRUE),
    Redemption_Var = var(`Redemption Count`, na.rm = TRUE),
    Redemption_SD = sd(`Redemption Count`, na.rm = TRUE),
    Sales_Mean = mean(`Sales Count`, na.rm = TRUE),
    Sales_Median = median(`Sales Count`, na.rm = TRUE),
    Sales_Var = var(`Sales Count`, na.rm = TRUE),
    Sales_SD = sd(`Sales Count`, na.rm = TRUE)
  )

# Convert 'date' column to Date type
cleaned_data_day$date <- as.Date(cleaned_data_day$date)

# Extract the day of the week
cleaned_data_day$day_of_week <- weekdays(cleaned_data_day$date)

# Summarize total sales by day of the week
sales_by_day <- cleaned_data_day %>%
  group_by(day_of_week) %>%
  summarise(total_sales = sum(total_sales))

raw_data <- raw_data %>%
  mutate(Timestamp = as.POSIXct(Timestamp, format="%Y-%m-%dT%H:%M:%S"))

# Extract the hour from the timestamp (adjust the column name accordingly)
raw_data <- raw_data %>%
  mutate(hour = hour(Timestamp))

# Filter data between 1:00 and 24:00
filtered_data <- raw_data %>%
  filter(hour >= 1 & hour <= 24)

# Group by hour and summarize the data (replace 'value_column' with the actual column name)
hour_data <- filtered_data %>%
  group_by(hour) %>%
  summarise(sales = sum(`Sales Count`, na.rm = TRUE),
            redemption = sum(`Redemption Count`, na.rm = TRUE))
#### Save data ####
write_csv(cleaned_data_day, "Toronto-isolands-ferry-tickets/data/analysis_data/analysis_data_day.csv")
write_csv(monthly_summary, "Toronto-isolands-ferry-tickets/data/analysis_data/analysis_data_month.csv")
write_csv(basic_stats, "Toronto-isolands-ferry-tickets/data/analysis_data/basic_stats.csv")
write_csv(sales_by_day, "Toronto-isolands-ferry-tickets/data/analysis_data/sales_by_day.csv")
write_csv(hour_data, "Toronto-isolands-ferry-tickets/data/analysis_data/hour_data.csv")