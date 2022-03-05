# Author: FSN
# Maintainers: FSN
# Copyright:   2022, FSN GPL v2 or later
# EXPLORATORY DATA ANALYSIS
# =============================================

#first summary of important variables among the different datasets
# summary(comparedf(test_1, test_2))
# see the general characteristics of the whole datasets
glimpse(data)
skim(data)


data_partB = data %>%
    select(id, gender, race, age_at_release, education_level, prison_offense, dependents,
           prison_years, condition_cog_ed, condition_mh_sa, condition_other, percent_days_employed,
           jobs_per_year, employment_exempt, recidivism_within_3years, recidivism_arrest_year1, recidivism_arrest_year2, recidivism_arrest_year3,
           supervision_level_first) %>%
    pivot_longer(cols = c(condition_cog_ed, condition_mh_sa, condition_other), names_to = "condition", values_to = "value")

#question 2 EDA
data_b_filtered = data_partB %>%
    filter(value ==T)

data_b_filtered %>%
    tabyl(condition, education_level)%>%
    adorn_totals(c("row", "col")) %>%
    adorn_percentages("row") %>%
    adorn_pct_formatting(rounding = "half up", digits = 0) %>%
    adorn_ns() %>%
    adorn_title(
        row_name = "Condition",
        col_name = "Education Level",
        placement = "combined") %>%
    flextable::flextable() %>%
    flextable::autofit()


data_b_filtered %>%
    tabyl(condition, gender)%>%
    adorn_totals(c("row", "col")) %>%
    adorn_percentages("row") %>%
    adorn_pct_formatting(rounding = "half up", digits = 0) %>%
    adorn_ns() %>%
    adorn_title(
        row_name = "Condition",
        col_name = "Gender",
        placement = "combined") %>%
    flextable::flextable() %>%
    flextable::autofit()


data_b_filtered %>%
    tabyl(condition, race)%>%
    adorn_totals(c("row", "col")) %>%
    adorn_percentages("row") %>%
    adorn_pct_formatting(rounding = "half up", digits = 0) %>%
    adorn_ns() %>%
    adorn_title(
        row_name = "Condition",
        col_name = "Race",
        placement = "combined") %>%
    flextable::flextable() %>%
    flextable::autofit()




data_model = data_b_filtered %>%
    mutate(condition = case_when(condition == "condition_mh_sa" ~ "mental",
                                 condition == "condition_cog_ed" ~ "cognitive",
                                 condition == "condition_other" ~ "other"))
%>%
    ggplot(aes(x=condition, fill = condition))+
    geom_bar(stat="count", position = position_dodge())+
    facet_grid(gender ~ education_level)+
    theme(plot.caption = element_text(hjust = 0.5))+
    theme(legend.title=element_blank())+
    theme(plot.title = element_text(hjust = 0.5))+
    labs(title = "Paroles conditions of supervision",
         subtitle = "Desagregated by sex and education")+
    theme(
        panel.grid.minor.y = element_blank(),
        panel.grid.major.y = element_blank(),
        legend.position="none",
        plot.title = element_text(size=12),
        plot.subtitle = element_text(size=10))



data_b_filtered %>%
    mutate(condition = case_when(condition == "condition_mh_sa" ~ "mental",
                                 condition == "condition_cog_ed" ~ "cognitive",
                                 condition == "condition_other" ~ "other")) %>%
    ggplot(aes(x=condition, fill  = condition))+
    geom_bar(stat="count", position = position_dodge())+
    facet_grid(race ~ gender)+
    theme(plot.caption = element_text(hjust = 0.5))+
    theme(legend.title=element_blank())+
    theme(plot.title = element_text(hjust = 0.5))+
    labs(title = "Paroles conditions of supervision",
         subtitle = "Desagregated by sex and race")+
    theme(
        panel.grid.minor.y = element_blank(),
        panel.grid.major.y = element_blank(),
        legend.position="none",
        plot.title = element_text(size=12),
        plot.subtitle = element_text(size=10))

#model
model1 = rpart(supervision_level_first  ~gender+race+education_level+prison_offense+dependents+
               prison_years+jobs_per_year+employment_exempt+recidivism_within_3years+
                 condition, data = data_model)
rpart.plot(model1, type=3, digits=3, fallen.leaves=TRUE)


