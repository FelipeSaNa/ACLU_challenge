# Author: FSN
# Maintainers: FSN
# Copyright:   2022, FSN GPL v2 or later
# DATA IMPORT
# =============================================

pacman::p_load(tidyverse, skimr, janitor, here, naniar, PerformanceAnalytics, GGally, rpart, rpart.plot)

data = read_csv(here("data", "raw", "NIJ_s_Recidivism_Challenge_Full_Dataset.csv")) %>% clean_names
#import training data
training_data = read_csv(here("data", "raw", "NIJ_s_Recidivism_Challenge_Training_Dataset.csv"))

#import test data
test_1 = read_csv(here("data", "raw", "NIJ_s_Recidivism_Challenge_Test_Dataset1.csv"))
test_2 = read_csv(here("data", "raw", "NIJ_s_Recidivism_Challenge_Test_Dataset2.csv"))
test_3 = read_csv(here("data", "raw", "NIJ_s_Recidivism_Challenge_Test_Dataset3.csv"))


