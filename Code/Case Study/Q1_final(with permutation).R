library(dplyr)
library(ggplot2)
library(tidyr)
data <- read.table("salary.txt", header = TRUE)

#checking data
#negative salary or 0
sum(data$salary <= 0, na.rm = TRUE)

#checking gender column
unique(data$sex)

#checking deg
unique(data$deg)

#field
unique(data$field)

#checking rank
unique(data$rank)
na_rows_rank <- data %>%
  filter(is.na(rank))
na_rows_rank

#admin
unique(data$admin)

#years
range(data$year, na.rm = TRUE)
range(data$startyr)

#Question 1: Does wage discrimation exist in the starting salaries of faculty members (i.e., salaries in the year hired)?

#Get where start year is equal to year
starting_salary_data <- data %>%
  filter(year == startyr) %>%
  filter(!is.na(salary)) 

#Compute Mean Comparisons Per year
mean_comp <- starting_salary_data %>%
  group_by(year,sex) %>%
  summarise(
    avg_starting_pay = mean(salary, na.rm = TRUE),
    n_faculty = n(),
    sd_pay = sd(salary, na.rm = TRUE),
    .groups = 'drop'
  )

print(mean_comp)

#Generating P-value for overall 
t_test_result <- t.test(salary ~ sex, data = starting_salary_data, var.equal = FALSE)

print(t_test_result)

#Generating boxplot for overall
ggplot(starting_salary_data, aes(x = sex, y = salary, fill = sex)) +
  geom_boxplot() +
  stat_summary(fun = mean, geom = "point") + # Adds the Mean point
  labs(title = "Starting Salary Distribution by Gender",
       subtitle = "Dots represent the Mean; Lines represent the Median") 

#Generatig p value for each year: 
yearly_gap_test <- starting_salary_data %>%
  group_by(year) %>%
  summarise(
    male_mean = mean(salary[sex == "M"], na.rm = TRUE),
    female_mean = mean(salary[sex == "F"], na.rm = TRUE),
    diff = male_mean - female_mean,
    # This runs a T-test for every year that has enough data
    p_val = if(n_distinct(sex) == 2) t.test(salary ~ sex)$p.value else NA
  )
print(yearly_gap_test)

#Generating boxplots for each year
ggplot(starting_salary_data, aes(x = factor(year), y = salary, fill = sex)) +
  geom_boxplot(alpha = 0.7) +
  labs(
    title = "Starting Salaries Comparison by Year and Gender",
    subtitle =  "Data limited to IDs where start year is equal to year",
    y = "Salary ($)",
    x = "year of hire",
    fill = "Gender"
  )+
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#Linear Model
model_start <- lm(salary ~ sex + rank + deg + year, data = starting_salary_data)
summary(model_start)
#The estimate for sexM (301.753) tells us how much more a male earn than a female, assuming that they have the same rank, degree, and hired the same year
#Confidence interval for the gender effect 
confint(model_start)
# sexM (175.15653, 428.3491)

#Permutation test
obs_diff <- mean(starting_salary_data$salary[starting_salary_data$sex == "M"], na.rm = TRUE) - 
  mean(starting_salary_data$salary[starting_salary_data$sex == "F"], na.rm = TRUE)

n_permutations <- 10000
perm_diffs <- numeric(n_permutations)

set.seed(42)
for (i in 1:n_permutations) {
  shuffled_sex <- sample(starting_salary_data$sex)
  perm_diffs[i] <- mean(starting_salary_data$salary[shuffled_sex == "M"], na.rm = TRUE) - 
    mean(starting_salary_data$salary[shuffled_sex == "F"], na.rm = TRUE)
}

p_value_perm <- mean(abs(perm_diffs) >= abs(obs_diff))

cat("Observed Mean Difference:", obs_diff, "\n")
cat("Permutation P-value:", p_value_perm, "\n")


hist(perm_diffs, breaks = 50, col = "skyblue", border = "white",
     main = "Permutation Distribution",
     xlab = "Simulated Difference")
abline(v = obs_diff, col = "red", lwd = 2, lty = 2)