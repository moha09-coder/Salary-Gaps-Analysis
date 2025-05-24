#set text(size: 12pt)
#show link: underline

#let title-page(title: [], names_ids: array, body) = {
  set page(margin: (top: 1.5in, rest: 2in))
  set text(font: "Source Sans Pro", size: 14pt)
  set heading(numbering: "1.1.1")
  line(start: (0%, 0%), end: (8.5in, 0%), stroke: (thickness: 2pt))
  align(top + right)[
    #image("EUI Logo.png", width: 12em)
    Egypt University of Informatics \
    Computing and Information Sciences \
    Data Analysis Course
  ]

  align(horizon + left)[
    #text(size: 24pt, title) \
    #v(2em)
    Supervised by: \
    #h(1em) Dr. Mohamed Taher Alrefaie
    #v(1em)
    Submitted by: \
    #h(1em)#names_ids.join("\n     ")
  ]

  align(bottom + left)[2025-05-24]
  pagebreak()
  set page(fill: none, margin: auto)
  align(horizon, outline(indent: auto))
  pagebreak()
  body
}

#show: body => title-page(
  title: [A Study on the Gender \ Pay Gap in Egypt's Tech Market],
  names_ids: (
    "Mohamed Elmosalamy 23-101283", 
    "Omar Mohammad 23-101288",
    "Omar Hesham 23-101302",
    "Mohamed Kotb 24-101222"
  ),
  body
)

= Abstract
The gender pay gap remains a contentious and widely debated issue worldwide. This analysis investigates whether women earn less than their peers in *Egypt's tech industry*.

The study aims to quantify salary differences between genders using publicly available data, offering insights into whether a significant gender-based wage gap exists.

= Introduction
The gender pay gap has been a global issue across labor markets. While considerable research has been done in Western countries, limited data-driven analysis exists in the Middle East. In Egypt, this remains a largely unstudied topic.

To address this, we define three methods of investigation:

+ *A straightforward assessment of the gender pay gap*

  The first hypothesis tests for the presence of a gender pay gap in Egypt's tech industry by conducting a *Welch's independent t-test* on male and female salaries. This analysis aims to answer: *"Is there a pay gap between men and women in Egypt's tech industry?"*

+ *Assessing the gender pay gap after controlling for all contributing factors*

  *TODO OMAR* -> Describe 2nd Hypothesis

+ *Estimating The Cost of Being a Woman* 

  _The Cost of Being a Woman_ is defined as the monthly salary disparity a woman faces compared to a man with identical skills, title, and experience. We aim to provide a 95% confidence interval for this cost.

= Research Questions
+ Is there a statistically significant difference in mean salaries between genders?
+ After controlling for years of experience and other contributing factors, does the pay gap persist?
+ What is the cost of being a woman—how much does a woman gain or lose per month compared to an equally qualified man?

= Hypothesis
== Difference in mean salaries <diff_in_mean_hypo>
- Null hypothesis $(H_o)$: There is no significant pay gap between men and women.
- Alternative hypothesis $(H_alpha)$: There is a significant pay gap between men and women.
- Significance level $(alpha)$: 0.05

== Controlled difference in mean salaries <controlled_diff_in_mean_hypo>
- Null hypothesis $(H_o)$: After controlling for contributing factors (experience, title, level, etc.), there is no significant gender pay gap.
- Alternative hypothesis $(H_alpha)$: A significant pay gap persists even after controlling for these factors.
- Significance level $(alpha)$: 0.05

= Population of Interest 
All professionals working in Egypt's tech field.

= Dataset
The dataset used comes from the #link("https://api.egytech.fyi/")[Egyptian Tech Market Survey API], conducted in 2024.

*Dataset columns include:*
- *Gender:* Male, Female
- *Degree:* Bachelor’s degree (Yes, No)
- *Title:* Professional title (e.g., Data Analyst, Scrum Master)
- *Level:* Professional level (e.g., Junior, Senior, Team Lead)
- *YearsOfExperience:* Number of years in the tech field
- *Salary:* Monthly salary in EGP
- *IsEgp:* Currency used (EGP, foreign, hybrid)
- *ProgrammingLanguages:* Languages the subject can write
- *BusinessMarket:* Scope (Local, Regional, Global)
- *BusinessSize:* Company size (Start-up, SME, Large)
- *WorkSetting:* Working environment (Office, Remote, etc.)
- *CompanyLocation:* City/state of the company

Sample size: *2649*

= Analysis
*TODO MOHA* -> Insert visualizations and summaries from Python notebook

= Hypothesis Testing Steps
== Difference in mean salaries
We used #link("https://en.wikipedia.org/wiki/Welch%27s_t-test")[*Welch’s Independent T-Test*]:

1. Hypotheses defined (see #link(<diff_in_mean_hypo>)[Section 4.1])
2. Significance level set to 0.05
3. Data cleaned and prepared
4. Used `scipy.stats.ttest_ind(equal_var=False)`
5. Decision made based on resulting p-value vs. alpha

== Controlled difference in mean salaries
For this, we applied the #link("https://en.wikipedia.org/wiki/Blinder%E2%80%93Oaxaca_decomposition")[*Blinder–Oaxaca decomposition*]:

1. Hypotheses defined (see #link(<controlled_diff_in_mean_hypo>)[Section 4.2])
2. Significance level set to 0.05
3. Data cleaned and outcome/explanatory variables defined
4. Ran group regressions, decomposed results using `statsmodels`
5. Interpreted contributions of each factor (explained/unexplained)

== Cost of Being a Woman

Cost is defined as:

$"Cost" := "Expected Salary based on objective factors" - "Actual Salary"$

*Objective factors used:*
- Years of Experience
- Title
- Level

We trained a regression model on male data using all variables except gender, then applied it to female employees to estimate expected salaries. This allowed us to construct a 95% confidence interval around the cost of being a woman.

= Conclusion
== Difference in mean salaries
*P-value:* 0.2668 — well above the 0.05 threshold. We fail to reject the null hypothesis. No significant evidence of a gender-based pay gap exists.

== Controlled difference in mean salaries

#image("salaries_differences_across_years_of_expereinces.png")

*Insights:*
- Average salaries rise with experience for both genders
- Men earn slightly more in the first 10 years
- After 10 years, women’s average salaries exceed those of men

== The Cost of Being a Woman

#image("cost_of_being_a_woman_CI.png")

The 95% confidence interval ranges from *-1950.41 to 1590.81 EGP*. Since zero lies within this interval, it suggests that the "cost of being a woman" may, statistically, be zero.

= Any Potential Issues
*TODO MOHA* -> Discuss outliers and scarcity of female records in the dataset
