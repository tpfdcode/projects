library(tidyverse)
library(janitor)
library(here)

covid_admissions <- clean_names(read_csv(here("raw_data/hospital_admissions_hb_agesex_20230706.csv")))
health_boards <- clean_names(read_csv(here("raw_data/health_board.csv"))) %>% 
  select(hb, hb_name)

covid_admissions_clean <- covid_admissions %>% 
  left_join(health_boards, by = "hb") %>% 
  mutate(week_ending = ymd(week_ending),
         hb_name = coalesce(hb_name, "All Scotland"),
         admission_type = coalesce(admission_type, "All"),
         month = month(week_ending, label = TRUE),
         year = year(week_ending))

write_csv(covid_admissions_clean, "clean_data/hospital_admissions_postcovid.csv")
