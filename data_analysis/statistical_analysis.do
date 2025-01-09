* statistical_analysis.do

* Load the cleaned dataset (assuming it's saved as a CSV)
import delimited "path/to/cleaned_slum_conditions.csv", clear

* Descriptive statistics for key variables
summarize income_level education_level health_outcomes

* T-tests to compare means between groups (e.g., income levels)
ttest health_outcomes, by(income_level)

* ANOVA to test differences among multiple groups (e.g., education levels)
anova health_outcomes education_level

* Regression analysis to explore relationships
regress health_outcomes income_level education_level

* Save results to a file for reporting purposes
outreg2 using "path/to/statistical_results.doc", replace
