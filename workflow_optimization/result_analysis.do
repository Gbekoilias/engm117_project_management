* results_analysis.do

* Load the simulation results dataset (assuming it's saved as a CSV)
import delimited "path/to/simulation_results.csv", clear

* Descriptive statistics for key variables (e.g., outcomes)
summarize housing_outcome sanitation_outcome education_outcome

* Compare means between different intervention types using ANOVA
anova housing_outcome intervention_type
anova sanitation_outcome intervention_type
anova education_outcome intervention_type

* Regression analysis to explore relationships between resources and outcomes 
regress housing_outcome resource_1 resource_2 resource_3 if intervention_type == "housing"
regress sanitation_outcome resource_1 resource_2 if intervention_type == "sanitation"
regress education_outcome resource_1 resource_2 resource_3 if intervention_type == "education"

* Save results to a file for reporting purposes
outreg2 using "path/to/analysis_results.doc", replace
