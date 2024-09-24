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

#Data for the most recent year#
filtered_data <- raw_data %>%
  filter(Timestamp >= as.POSIXct("2023-09-02 00:00:00"))

#Sales per day#
daily_sales <- filtered_data %>%
  mutate(date = as.Date(Timestamp)) %>%  
  group_by(date) %>%                    
  summarise(total_sales = sum(`Sales Count`))
#sales per month#
monthly_sales <- daily_sales %>%
  mutate(month = format(date, "%Y-%m")) %>% 
  group_by(month) %>%                        
  summarise(total_sales = sum(total_sales))

cleaned_data_day <- daily_sales
cleaned_data_month <- monthly_sales

ggplot(monthly_sales, aes(x = month, y = total_sales)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Monthly Sales Comparison", x = "month", y = "monthly sales") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


#### Save data ####
write_csv(cleaned_data_day, "starter_folder-main/data/analysis_data/analysis_data_day.csv")
write_csv(cleaned_data_month, "starter_folder-main/data/analysis_data/analysis_data_month.csv")
