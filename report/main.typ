#set text(size:12pt)
#show link: underline

#let title-page(title:[], names_ids:array, body) = {
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
  names_ids: ("Mohamed Elmosalamy 23-101283", 
              "Omar Mohammad 23-101288",
              "Omar Hesham 23-101302",
              "Mohamed Kotb 24-101222"),
  body
)



= Abstract
The gender pay gap remains a contentious and highly debated issue worldwide. This analysis investigates whether women earn less than their peers in *Egypt's tech industry*. 

The study aims to quantify salary differences between genders using publicly available data, offering insights into whether a significant gender-based wage gap exists.
= Introduction
The gender pay gap has been a global issue across labor markets. While considerable research has been done in wester countries, limited data-driven analysis exists in the Middle East. In Egypt This remains an unstudied topic. 

To reason about this, we had to define 3 methods to attack this problem.

+ Assessing the pay gap between genders
The first hypotehsis testing aims to address the gender pay gap in Egypt's tech industry, by conducting *Welch's independant t-test* on salaries for both genders. This analysis aims to answer the question *"Is there a pay gap between men and women in Egypt's tech industry?"*

*TODO OMAR* -> _Describe 2st hypothesis here_
+ Hypothesis 2nd

+ Estimating *The Cost of Being a Woman*
we define _The Cost of Being a Woman_ as the amount of disparity between salaries that a women loses (or potentially earns) compared to men per month. It's the amount a man with her skills, title, and years of experience would be expected to earn. The analysis aims to provide a confidence interval with $alpha=95%$ to find this cost.

= Research Questions
+ Is there a statistically significant difference in mean salaries between genders?
+ After controlling for years of experience, and other contributing factors, does the pay gap persist/vanish?
+ What is the cost of being a woman?, in other words, how much does a woman lose/gain in a month in comparison to a man with the same qualifications?

#pagebreak()
= Hypothesis

== Difference in mean salaries <diff_in_mean_hypo>
- Null hypothesis $(H_o)$: There is no significant pay gap between men and women.
- Alternative hypothesis $(H_alpha)$: There is a significant pay gap between men and women.
- Alpha value $(alpha)$: 0.05
== Controlled difference in mean salaries <controlled_diff_in_mean_hypo>
- Null hypothesis $(H_o)$: After controlling for all contributing factors such as years of experience, job title, job level, etc., there is no significant pay gap between men and women. 
- Alternative hypothesis $(H_alpha)$: After controlling for all contributing factors such as years of experience, job title, job level, etc., there is a significant pay gap between men and women.
- Alpha value $(alpha)$: 0.05

= Population of Interest 
All professionals working in the tech field in Egypt. 

= Dataset

The dataset used in this study comes from the popular #link("https://api.egytech.fyi/")[Egyptian Tech Market Survey API] conducted in 2024 on the technology sector in Egypt.

Below is a brief description of the relevant columns included in the dataset:
- *Gender:* gender of the subject (Male, Female).
- *Degree:* whether or not the subject has a bachelor degree (Yes, No)
- *Title:* professional title of the subject. (Data Analyst, Scrum Master, etc.)
- *Level:* professional level of the subject (Junior, Senior, Team lead, etc.)
- *YearsOfExperience:* number of years the subject has been working in the field.
- *Salary:* amount of money a subject is paid monthly in EGP currency.
- *IsEgp:* currency of the subject's salary. (EGP, Another Currency [e.g. USD], Hybrid)
- *ProgrammingLanguages:* programming languages that can be written by subject (Python, C++, etc.)
- *BusinessMarket:* market scope of the subject's company (Regional, Global, Local)
- *BusinessSize:* size of the subject's company (Start-up, Small and Medium, Large)
- *WorkSetting:* working condition of the subject. (Office, Remote, etc.)
- *CompanyLocation:* state/city where the subject's company operates.

Number of samples used: *2649*.

= Analysis

*TODO MOHA* -> insert visualizations and descriptions from the python notebook 

= Hypothesis Testing Steps

== Difference in mean salaries

We chose #link("https://en.wikipedia.org/wiki/Welch%27s_t-test")[*Welch’s Independent T-Test*] for this hypothesis.

• Step 1: First, we formulated the null and alternative hypotheses (mentioned in #link(<diff_in_mean_hypo>)[section 4.1]).

• Step 2: Then, we assumed our significance level ($alpha$) to be the standard 0.05.

• Step 3: Next, we selected and cleaned our dataset to ensure no missing or erroneous values existed within the comparison groups.

• Step 4: We used the `scipy.stats.ttest_ind()` function with `equal_var=False` to perform Welch’s t-test, which is ideal for comparing the means of two groups when their variances are unequal.

• Step 5: Finally, we compared the p-value produced by the test with our alpha value to decide whether to reject or fail to reject the null hypothesis.

== Controlled difference in mean salaries
For this complicated hypothesis test, we used #link("https://en.wikipedia.org/wiki/Blinder%E2%80%93Oaxaca_decomposition")[*Blinder–Oaxaca decomposition*].

• Step 1: First, we formulated the null and alternative hypotheses (mentioned in #link(<controlled_diff_in_mean_hypo>)[section 4.2]).

• Step 2: We set the significance level ($alpha$) to 0.05, as is standard in most social science research.

• Step 3: We selected and cleaned our dataset, and then processed the data to define the outcome variable and explanatory variables clearly.

• Step 4: We ran separate regressions for the two groups and applied the Blinder–Oaxaca decomposition using the `statsmodels`. This allowed us to break down the mean outcome gap into an explained component and an unexplained component.

• Step 5: We interpreted the decomposition output by examining the coefficients, p-values, and contribution of each variable. We assessed whether the overall gap, explained portion, or unexplained portion were statistically significant and derived conclusions about which factors contributed to inequality and how much remained unexplained.

== Cost of Being a woman

We can define the cost of begin a woman as following

$ "Cost" := "Expected salary based on objective factors" - "Current Salary" $

To estimate the cost of being a woman, we need to find the objective factors that should dictate one's salary and use them to predict their salaries regardless of gender.

The objective factors used in this study are:

+ Years of Experience
+ Title
+ Level 

We used a multiple regression model to predict each woman's expected salary. This model captures how salary is determined for male employees based on their qualifications, creating a baseline for equitable pay.

The idea behind this is to have the explanatory variables all the columns in the dataset except for `gender` and train this model solely on men data. Therefore, this model treats the entire workforce as men. The trained model is applied to the female workforce to find their expected salary based on objective factors. 

Now, we use the current salary given in the dataset, and use this distribution to create a confidence interval.
= Conclusion

== Difference in mean salaries


The result of the salary comparison by experience bracket and gender:
#image("salaries_differences_across_years_of_expereinces.png")

Key observations:

+ The average salary for both genders increases with experience
+ In the first two years, the average salary is around 18000 for both genders
+ In the first 10 years, men appear to have higher average salaries, small at the first two years, and increases as time goes on
+ After the first 10 years, women have far higher salaries them men in the tech industry. After 15+ years, women have 12000 EGP more than men on average.

== Controlled difference in mean salaries

*TODO OMAR* -> Insert 

== The Cost of Being a Woman

The resultant confidence interval is the following:
#image("cost_of_being_a_woman_CI.png")

We are 95% confident that the _cost of being a woman_ lies between -1950.41 and 1590.81.

we can reach an important conclusion: the value *0* is included in the 95% interval, showing that that 0 is a possible estimate for the cost of being a woman, indicating that the cost might be zero.

= Any potential issues

*TODO MOHA* -> discuss outliers and the scarcity of female records in the dataset
