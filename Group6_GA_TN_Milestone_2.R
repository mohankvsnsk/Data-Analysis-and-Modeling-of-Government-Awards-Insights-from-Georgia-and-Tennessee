# ALY 6010 -- Final Project- Milestone 2
# Team Members -- Poorva Joshi, Krishna Mohan, Yash Gokhale, Rohit Gupta

#setwd("C:/Users/kvsns/OneDrive/Documents/Rprojects")

#Required Libraries
library(ggplot2)
library(ggthemes)
library(ggeasy)
library(pacman)
library(lubridate)
library(janitor)
library(tidyverse)

library(scales)

#Reading the dataset
award_df <- read_csv("Group6_final_project_dataset_GA_TN.csv")

#Basic operations to check data
dim(award_df)
head(award_df)
str(award_df)

#Cleaning data using janitor package
award_df <- clean_names(award_df)

#Subsetting the dataset
award_clean = subset(award_df, select = -c(address1, address2, company_website, abstract,
                                           research_keywords, ri_poc_phone, ri_poc_name, ri_name, pi_phone,
                                           pi_email,pi_name, pi_title, contact_email, contact_phone, contact_title,
                                           contact_name, zip, duns, topic_code, solicitation_number))
award_clean

#Converting Data Types in cleaned data
award_clean$proposal_award_date <- mdy(award_clean$proposal_award_date)
str(award_clean$proposal_award_date)

award_clean$contract_end_date <- mdy(award_clean$contract_end_date)
str(award_clean$contract_end_date)

sum(is.na(award_clean$contract_end_date))
sum(is.na(award_clean$proposal_award_date))
award_clean$solicitation_year <- as.integer(award_clean$solicitation_year)
str(award_clean$solicitation_year)

award_clean$award_year <- as.integer(award_clean$award_year)
str(award_clean$award_year)

award_clean$award_amount <- as.numeric(gsub("[^0-9.]", "", award_clean$award_amount))
str(award_clean$award_amount)

str(award_clean)

#Creating a subset of data using pipeline and other functions

award_count <- award_df |> group_by(company, state) |>
  summarise(count = n()) |> arrange(desc(count)) |> 
  filter( count > 35)
award_count

# Assuming 'award_amount' is a column representing the award amounts
# 'socially_and_economically_disadvantaged' indicates if a company is disadvantaged
# Subset data for disadvantaged and non-disadvantaged companies
disadvantaged <- award_clean$award_amount[award_clean$socially_and_economically_disadvantaged == "Y"]
non_disadvantaged <- award_clean$award_amount[award_clean$socially_and_economically_disadvantaged == "N"]

# Perform two-sample t-test
t_test_result1 <- t.test(disadvantaged, non_disadvantaged)
t_test_result1

# Assuming 'award_amount' is a column representing the award amounts
# 'program' represents different program types (e.g., SBIR, Phase I, Phase II)
# T test
t_test_result2 <- t.test(award_amount ~ program, data = award_clean)
summary(t_test_result2)

# Assuming 'number_employees' is a column representing the number of employees
# 'state' represents different states

# Perform T test
t_test_result3 <- t.test(number_employees ~ state, data = award_clean)
summary(t_test_result3)

# Calculate mean number of employees per state
mean_employees <- aggregate(number_employees ~ state, data = award_clean, FUN = mean)

# Barplot to visualize average number of employees by state
barplot(mean_employees$number_employees, names.arg = mean_employees$state,
        main = "Average Number of Employees by State",
        xlab = "State", ylab = "Average Number of Employees")

# Boxplot to visualize number of employees across different states using ggplot
ggplot(award_clean, aes(x = state, y = number_employees)) +
  geom_boxplot() +
  labs(title = "Number of Employees by State",
       x = "State", y = "Number of Employees")


