
library(dplyr)
library(ggplot2)
library(tidyr)
data <- read.table("salary.txt", header = TRUE)

# convert categorical variables to factors so R treats them as categories
data <- data %>% 
  mutate(
    sex = factor(sex),
    rank = factor(rank, levels = c("Assist","Assoc","Full")),
    deg = factor(deg),
    field = factor(field),
    admin = factor(admin, levels = c(0,1), labels = c("No","Yes"))
  )

# created an "experience" variable
data <- data %>% 
  mutate(experience = year - yrdeg)
data$experience

# dataset created for the final salary
latest_salary <- data %>% 
  group_by(id) %>% 
  filter(year == max(year)) %>% 
  ungroup()

# checked for negative or 0 experiences
sum(latest_salary$experience <= 0)
latest_salary <- latest_salary %>%  filter(experience > 0)

# shows overall gender salary gap
latest_salary %>% 
  group_by(sex) %>% 
  summarise(
    mean_salary = mean(salary),
    median_salary = median(salary),
    sd_salary = sd(salary),
    n = n()
  )

# mean and median salary by sex and rank
latest_salary %>% 
  group_by(rank, sex) %>% 
  summarise(
    mean_salary = mean(salary),
    median_salary = median(salary),
    n = n()
  )

# salary by gender boxplot
ggplot(latest_salary, aes(x = sex, y = salary, fill = sex)) + geom_boxplot() + labs(
  title = "Salary Distribution by Gender",
  x = "Gender",
  y = "Salary"
) + theme_minimal()

# salary by rank and gender boxplot
ggplot(latest_salary,aes(x = rank, y = salary, fill = sex)) + geom_boxplot() + labs(
  title = "Salary Distribution by Rank and Gender",
  x = "Rank",
  y = "Salary"
) + theme_minimal()

# scatterplot of salary growth patterns by gender
ggplot(latest_salary, aes(x = experience, y = salary, color = sex)) + geom_point(alpha = 0.6) + geom_smooth(method = "loess", se = FALSE) + labs(
  title = "Salary vs. Experience by Gender",
  x = "Years Since Highest Degree",
  y = "Salary"
) + theme_minimal()

# extracting starting salary for each faculty member
starting_salary <- data %>% 
  group_by(id) %>% 
  filter(year == startyr) %>% 
  select(id, start_salary = salary) %>%   ungroup()

latest_salary <- latest_salary %>% 
  left_join(starting_salary, by = "id")

head(latest_salary %>%  select(id, salary, start_salary, sex, rank, experience))

# linear regression model
model <- lm(salary ~ sex * rank + deg + experience + admin + start_salary, data = latest_salary)

summary(model)

coefs <- coef(model)

gap_assist <- coefs["sexM"]
gap_assoc <- coefs["sexM"] + coefs["sexM:rankAssoc"] 
gap_full <- coefs["sexM"] + coefs["sexM:rankFull"]

gender_gap <- data.frame(
  Rank = c("Assistant","Associate","Full"),
  Gap = c(gap_assist, gap_assoc, gap_full)
)

# plot
library(ggplot2)
ggplot(gender_gap, aes(x = Rank, y = Gap, fill = Rank)) + geom_col(width = 0.6) + geom_text(aes(label = round(Gap, 0)), vjust = -0.5, size = 5) + labs(
  title = "Estimated Gender Pay Gap by Rank",
  x = "Rank",
  y = "Salary Difference (in $)"
) +
  theme_minimal() +
  theme(legend.position = "none") +
  scale_fill_brewer(palette = "Set2") +
  ylim(0, max(gender_gap$Gap) * 1.2)




