library(tidyverse)
library(janitor)

health_boards <- clean_names(read_csv("raw_data/health_board.csv"))

scotland <- c(hb = "S92000003", hb_name = "All Scotland")

health_boards_clean <- health_boards %>% 
  select(hb, hb_name) %>% 
  bind_rows(scotland)

write_csv(health_boards_clean, "clean_data/health_boards.csv")
