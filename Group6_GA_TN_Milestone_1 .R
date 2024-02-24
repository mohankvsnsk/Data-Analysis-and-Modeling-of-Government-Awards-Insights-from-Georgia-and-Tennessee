setwd("C:/Users/kvsns/OneDrive/Documents/Rprojects")
#Required Libraries
library(ggplot2)
library(ggthemes)
library(ggeasy)
library(pacman)
library(lubridate)
library(janitor)
library(tidyverse)

#Reading the dataset
award_df <- read_csv("Group6_final_project_dataset_GA_TN.csv")

#Basic operations to check data
dim(award_df)
head(award_df)
str(award_df)

#Check NA values
is.na(award_df)

#Cleaning data using janitor package
award_df <- clean_names(award_df)
head(award_df)
names(award_df)

#Creating a subset of data using pipeline and other functions
award_count <- award_df |> group_by(company, state) |>
  summarise(count = n()) |> arrange(desc(count)) |> 
  filter( count > 35)
award_count

#Bar Plot of Awards Vs Companies
bar_plot <- ggplot(award_count, aes(x = company, y = count)) +
  geom_bar(stat = "identity", fill = "cyan") +
  labs(title = "Number Of Award for Each Company", xlab= "Comapny", ylab= "No. of Awards") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
bar_plot

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

#Histogram
p_gd <- hist(award_clean$solicitation_year, plot = FALSE)
ad_g <- hist(award_clean$award_year, plot = FALSE)

# Set colors for the histograms
c1 <- "blue"
c2 <- "red"

# Plot the first histogram using a transparent color
plot(p_gd, col = alpha(c1, 1), main = "Overlayed Histograms of Grades", xlab = "Grades") 

# Add the second histogram using a different color
plot(ad_g, col = alpha(c2, 1), add = TRUE)

#Scatter Plot
# Filter the data for award years between 1983 and 2023
filtered_data <- subset(award_clean, award_year %in% c(1983,2023))

# Create a scatterplot between award_year and award_amount
ggplot(filtered_data, aes(x = award_year, y = award_amount)) +
  geom_point() +
  labs(x = "Award Year", y = "Award Amount") +
  ggtitle("Scatterplot of Award Year vs. Award Amount")
  #scale_y_discrete(labels = scales::dollar_format())

#Converting data type to int
award_clean$award_amount <- as.numeric(gsub("[^0-9.]", "", award_clean$award_amount))
str(award_clean$award_amount)

#Summary of the award amount and the number of employees
award_clean$award_amount

summary_award <- summary(award_clean$award_amount)
summary_award

str(award_clean$number_employees)
summary_emp <- summary(award_clean$number_employees)
summary_emp

na_count <- sum(is.na(award_clean$number_employees))

median_val <- median(award_clean$number_employees, na.rm = TRUE)

# Replace NA values with the calculated median
award_clean$number_employees[is.na(award_clean$number_employees)] <- median_val

# Assuming award_clean$number_employees is numeric or can be coerced to numeric

# Create a boxplot for the number_employees column
# Create a boxplot using ggplot2
ggplot(award_clean, aes(x = number_employees)) +
  geom_boxplot() +
  labs(title = "Boxplot of Number of Employees", x = "Number of Employees")

view(award_df)
