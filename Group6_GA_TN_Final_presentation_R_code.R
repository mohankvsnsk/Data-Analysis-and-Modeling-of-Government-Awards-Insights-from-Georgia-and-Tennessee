# Group6_GA_TN Final submission
# Poorva Joshi, Yash Gokhale, Krishna Mohan, Rohit Gupta
# ALY6010 Probability and Statistics -- Prof JiYoung Yun

# Required Libraries
library(ggplot2)
library(ggthemes)
library(ggeasy)
library(pacman)
library(lubridate)
library(janitor)
library(tidyverse)
library(dplyr)
library(scales)

# Reading the dataset
award_df <- read_csv("Group6_final_project_dataset_GA_TN.csv")

# Basic operations to check the dataset
dim(award_df)
head(award_df)
str(award_df)

# Checking the NA values
na_values <- is.na(award_df)
sum_na_values <- sum(na_values)
print(sum_na_values)

# Cleaning the data-set using the janitor package
award_df <- clean_names(award_df)
head(award_df)
names(award_df)

# Creating a subset of data using pipeline and other functions
award_count <- award_df |> group_by(company, state) |>
  summarise(count = n()) |> arrange(desc(count)) |> 
  filter( count > 35)
award_count

# Bar Plot of Awards Vs Companies
bar_plot <- ggplot(award_count, aes(x = company, y = count)) +
  geom_bar(stat = "identity", fill = "cyan") +
  labs(title = "Number Of Award for Each Company", xlab= "Comapny", ylab= "No. of Awards") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
bar_plot

# Sub-setting the dataset
award_clean = subset(award_df, select = -c(address1, address2, company_website, abstract,
                                           research_keywords, ri_poc_phone, ri_poc_name, ri_name, pi_phone,
                                           pi_email,pi_name, pi_title, contact_email, contact_phone, contact_title,
                                           contact_name, zip, duns, topic_code, solicitation_number))
award_clean

# Converting Data Types in cleaned data
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
str(award_clean$award_amount)

# Histogram
p_gd <- hist(award_clean$solicitation_year, plot = FALSE)
ad_g <- hist(award_clean$award_year, plot = FALSE)

# Set colors for the histograms
c1 <- "blue"
c2 <- "red"

# Plot the first histogram using a transparent color
plot(p_gd, col = alpha(c1, 1), main = "Overlayed Histograms of Grades", xlab = "Grades") 

# Add the second histogram using a different color
plot(ad_g, col = alpha(c2, 1), add = TRUE)

# A visualization which shows how has the funding improved overtime

# Converting data type to int
award_clean$award_amount <- as.numeric(gsub("[^0-9.]", "", award_clean$award_amount))
str(award_clean$award_amount)

# Summary of the award amount and the number of employees
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

# Calculate the mean of award_amount for the state of GA
mean_award_amount_GA <- award_clean %>%
  filter(state == "GA") %>%
  summarise(mean_award_amount_GA = mean(award_amount, na.rm = TRUE))

# Calculate the mean of award_amount for the state of TN
mean_award_amount_TN <- award_clean %>%
  filter(state == "TN") %>%
  summarise(mean_award_amount_TN = mean(award_amount, na.rm = TRUE))

# Display the results
print(mean_award_amount_GA)
print(mean_award_amount_TN)

mean_award_amount <- award_clean %>%
  group_by(state) %>%
  summarise(mean_award_amount = mean(award_amount, na.rm = TRUE))

# Create a bar plot
ggplot(mean_award_amount, aes(x = state, y = mean_award_amount, fill = state)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Mean Award Amounts by State", x = "State", y = "Mean Award Amount") +
  theme_minimal()+
  scale_y_continuous(labels = dollar_format(prefix="$"))

# T- Test: Georgia
disadvantaged_GA <- award_clean$award_amount[award_clean$socially_and_economically_disadvantaged == "Y" & award_clean$state == "GA"]

advantaged_GA <- award_clean$award_amount[award_clean$socially_and_economically_disadvantaged == "N" & award_clean$state == "GA"]

# Perform two sample t-test
t_test_result_GA <- t.test(disadvantaged_GA,advantaged_GA)
t_test_result_GA

# T- Test: Georgia
disadvantaged_TN <- award_clean$award_amount[award_clean$socially_and_economically_disadvantaged == "Y" & award_clean$state == "TN"]

advantaged_TN <- award_clean$award_amount[award_clean$socially_and_economically_disadvantaged == "N" & award_clean$state == "TN"]

# Perform two sample t-test
t_test_result_TN <- t.test(disadvantaged_TN,advantaged_TN)
t_test_result_TN

# Extract relevant information from t-test results for Georgia
t_test_summary_GA <- list(
  "mean_disadvantaged_GA" = t_test_result_GA$estimate[1],
  "mean_advantaged_GA" = t_test_result_GA$estimate[2],
  "p_value_GA" = t_test_result_GA$p.value
)

# Extract relevant information from t-test results for Tennessee
t_test_summary_TN <- list(
  "mean_disadvantaged_TN" = t_test_result_TN$estimate[1],
  "mean_advantaged_TN" = t_test_result_TN$estimate[2],
  "p_value_TN" = t_test_result_TN$p.value
)

# Compare means and p-values between Georgia and Tennessee
comparison_summary <- data.frame(
  "State" = c("Georgia", "Tennessee"),
  "Mean_Disadvantaged" = c(t_test_summary_GA$mean_disadvantaged_GA, t_test_summary_TN$mean_disadvantaged_TN),
  "Mean_Advantaged" = c(t_test_summary_GA$mean_advantaged_GA, t_test_summary_TN$mean_advantaged_TN),
  "P_Value" = c(t_test_summary_GA$p_value_GA, t_test_summary_TN$p_value_TN)
)

# Display the comparison summary
print(comparison_summary)

# Correlation
correlation <- cor(award_clean$award_year, award_clean$award_amount)
print(correlation)


# Adjusting bins and summarizing data with numeric midpoints
heatmap_data <- award_clean %>%
  mutate(
    award_amount_bins = cut(award_amount/100000, breaks = 10),  # Discretizing award_amount into 10 bins
  ) %>%
  group_by(award_year, award_amount_bins) %>%
  summarise(count = n())  # Calculate count of observations for each combination

# Displaying the modified heatmap_data with numeric bins
heatmap_data


heatmap <- ggplot(heatmap_data, aes(x = award_year, y = award_amount_bins, fill = count)) +
  geom_tile() +
  scale_fill_gradient(low = "white", high = "blue") +
  labs(title = "Heatmap-like plot between award_year and award_amount", y= "Award Amount in Millions", x= "Years") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotating x-axis labels for better readability

print(heatmap)

# Creating a model
model <- lm(award_amount~award_year, data = award_clean)

# Summary of the Linear regression
summary(model)

# Assuming your data frame is named award_clean
range_of_award_amount <- range(award_clean$award_amount)
min_value <- range_of_award_amount[1]  # Minimum value
max_value <- range_of_award_amount[2]  # Maximum value

# Print the minimum and maximum values
cat("Minimum award amount:", min_value, "\n")
cat("Maximum award amount:", max_value, "\n")

# Plotting the fitted regression line
plot(award_clean$award_year,award_clean$award_amount, xlab = "Award Year", ylab = "Award Amount")
abline(model,col="red")


# Predicting award_amount for the year 2025
new_data <- data.frame(award_year = 2025)  # Creating new data for the year 2025

predicted_amount_2025 <- predict(model, newdata = new_data)
print(predicted_amount_2025)

