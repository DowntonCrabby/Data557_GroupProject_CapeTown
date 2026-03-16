# DATA 557: Applied Statistics and Experimental Design  
## Final Project — Cape Town Group

**Fatima Fazil, Priyal Jain, Sophia Koehn, Clark Roll, Katelyn Vu, Amber Yang**

Please find attached our group’s final project submission for **DATA 557**. Our project investigates potential gender differences in faculty salaries at a U.S. university using the provided longitudinal dataset covering the years **1976–1995**.

Our submission includes two primary deliverables:

- **Interactive Data Story (Python Jupyter/Colab Notebook)**
- **Case Study Analysis**

Together, these components address the project questions using statistical modeling, visual exploration, and written interpretation.

All analysis code and project deliverables can be found at:

**Project Repository:**  
https://github.com/DowntonCrabby/Data557_GroupProject_CapeTown

---

# Interactive Data Story
**Repo Location**:
Code/Data Story

**Contributors:**  
Sophia Koehn, Clark Roll, Katelyn Vu

### Questions Addressed

**Q2:** Does wage discrimination exist in granting promotions from Associate Professor to Full Professor?

### Description

The notebook presents the analysis as a step-by-step walkthrough combining statistical models, visualizations, and interpretation. The analysis evaluates promotion outcomes using three complementary approaches.

### Associated Analysis Files

- `FinalProject_Q2_DataStory` (Python Jupyter/Colab Notebook)  
- `FinalProject_DatasetCleaning` (Python Jupyter/Colab Notebook)  
- `cleaned_longitudinal_dataset.csv`

### Individual Contributions

#### Clark Roll
- Generated dataset cleaning notebook
- Prepared the analytical dataset used in the data story notebook
- Implemented the first two analytical approaches and interpretation of results:
  - Logistic regression examining probability of promotion
  - Linear regression examining time to promotion
- Wrote the project cover letter

#### Sophia Koehn
- Produced the final summary of the interactive story
- Implemented visualizations and interpretation of plots:
  - Promotion differences by sex — box plot
  - Promotion differences vs salary by sex — scatter plot
  - Number of men and women promoted — bar graph

#### Katelyn Vu
- Subsetted data to perform visualizations of promotion differences
- Created line plots and produced analysis for this subset
- Implemented linear regression to examine effects of sex on salary changes after promotion
- Produced interpretation of model outcomes

---

# Case Study Analysis

**Repo Location**:
Code/Case Study

**Contributors:**  
Fatima Fazil, Priyal Jain, Amber Yang, Katelyn Vu

### Questions Addressed

**Q1:** Does wage discrimination exist in the starting salaries of faculty members (i.e., salaries in the year hired)?  

**Q3:** Overall, how would you answer the question: *Is there wage discrimination in salaries at the university?*  

**Q4:** What issues are involved in generalizing your results?

### Description

This case study analysis examines potential gender-based disparities among university faculty by applying hypothesis testing, regression modeling, and permutation methods to analyze differences in starting salaries, promotions, and overall compensation.

### Associated Analysis Files

- `Q1_final(with permutation).R`
- `Q3_final.R`

### Individual Contributions

#### Fatima Fazil
- Code, analysis, and written interpretation for **Question 3**

#### Priyal Jain
- Code, analysis, and written interpretation for **Question 4**

#### Amber Yang
- Implemented permutation test code
- Conducted data analysis and write-up for **Question 1**

#### Katelyn Vu
Produced code for:

- Mean comparison boxplots by sex
- Mean comparison boxplots by sex and year
- Linear regression model for starting salary differences by sex
