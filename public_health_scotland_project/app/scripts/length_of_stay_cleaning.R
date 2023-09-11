library(janitor)
library(tidyverse)

length_of_stay <- clean_names(read_csv(here("raw_data/inpatient_and_daycase_by_nhs_board_of_treatment_age_and_sex.csv")))
health_boards <- clean_names(read_csv("raw_data/health_board.csv")) %>% 
  select(hb, hb_name)

length_of_stay_clean <- length_of_stay %>% 
  select(-(episodes:average_length_of_episode_qf)) %>% 
  filter(is.na(average_length_of_stay_qf)) %>% 
  left_join(health_boards, by = "hb") %>% 
  mutate(hb_name = case_when(hb == "S92000003" ~ "All Scotland",
                             .default = hb_name)) %>% 
  filter(!is.na(hb_name))
  
write_csv(length_of_stay_clean, "clean_data/length_of_stay_data.csv")