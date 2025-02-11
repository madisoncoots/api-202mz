library(tidyverse)

nlsy <- read_csv("https://5harad.com/datasets/API201/nlsy79_2012.csv") %>% 
  filter(education != 0) %>%
  drop_na(male, education, urban, family_income, age_at_first_child) %>%
  mutate(family_income = if_else(family_income == 0, 1 + family_income, family_income))

write.csv(nlsy, '/Users/madisoncoots/Documents/harvard/teaching/api202mz/api-202mz-repo/nlsy.csv', row.names = F)
