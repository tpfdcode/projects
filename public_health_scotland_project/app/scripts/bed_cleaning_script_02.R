library(tidyverse)

# Manipulating the data set to only include hospital admissions 

#READING

# reading in initial data
beds <- janitor::clean_names(read_csv("raw_data/beds_by_nhs_board_of_treatment_and_specialty.csv"))

# added to replace health board codes with location name
health_board <- janitor::clean_names(read_csv("raw_data/health_board.csv")) %>% 
  select(hb, hb_name)
# added to replace specialist board codes with location name
specialist_board <- janitor::clean_names(read_csv("raw_data/special_board.csv")) %>% 
  select(shb, shb_name)
#added to replace the hospital codes with location name
hospital_data <- janitor::clean_names(read_csv("raw_data/hospital.csv")) %>% 
  select(location, location_name)
# creting a row to add to health board codes as only one specialist area was a hospital
#add_row <- data.frame(hb = "SB0801", hb_name = "The Golden Jubilee National Hospital")
#binding the row 
#health_board <- rbind(health_board, add_row)

#CLEANING

beds_clean <- beds %>%
  mutate(year = str_sub(quarter, 1, 4), 
         quarter = str_sub(quarter, 5), #split the quarter col in to year and quarter
         quarter = str_replace(quarter, "Q", "")) %>% 
  filter(nchar(as.character(location)) == 5) # filtered to only include hospital data %>% 

#replacing the codes with location names
beds_clean <- merge(beds_clean, hospital_data, by = "location", all.x = TRUE)

beds_clean <- merge(beds_clean, health_board, by = "hb", all.x = TRUE)

#only selecting cols for analysis
beds_clean <- select(beds_clean, -hb, -specialty, -location, -quarter_qf, -hbqf, -location_qf, -specialty_qf, -specialty_name_qf,
                     -all_staffed_beddays_qf, -average_available_staffed_beds_qf, -average_occupied_beds_qf,
                     
                     -percentage_occupancy_qf, -total_occupied_beddays_qf)
#reordering cols

beds_clean <- select(beds_clean, year, quarter, location_name, hb_name, everything())

#removing uneeded objects from environment 

rm(beds,health_board,hospital_data,specialist_board)

write_csv(beds_clean, "clean_data/clean_bed_data")