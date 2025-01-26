library(tidyverse)
library(haven)
library(janitor)


download.file("https://wwwn.cdc.gov/Nchs/Data/Nhanes/Public/2017/DataFiles/DEMO_J.xpt", demo <- tempfile(), mode="wb")
download.file("https://wwwn.cdc.gov/Nchs/Data/Nhanes/Public/2017/DataFiles/BMX_J.xpt", bmx <- tempfile(), mode="wb")
download.file("https://wwwn.cdc.gov/Nchs/Data/Nhanes/Public/2017/DataFiles/GHB_J.xpt", ghb <- tempfile(), mode="wb")

raw_demographics_17_18 <- foreign::read.xport(demo) %>% 
  clean_names()
raw_body_measurements_17_18 <- foreign::read.xport(bmx) %>% 
  clean_names()
raw_glycohemoglobin_17_18 <- foreign::read.xport(ghb) %>% 
  clean_names()

data <- raw_demographics_17_18 %>%
  left_join(raw_survey_responses_17_18, by = "seqn") %>%
  left_join(raw_body_measurements_17_18, by = "seqn") %>%
  left_join(raw_glycohemoglobin_17_18, by = "seqn") %>%
  select(age = ridageyr, bmi = bmxbmi, a1c = lbxgh) %>%
  drop_na()

write.csv(data, 'a1c_data.csv', row.names = F)
         
         