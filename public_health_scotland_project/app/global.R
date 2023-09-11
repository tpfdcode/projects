library(tidyverse)
library(shiny)
library(ggplot2)
library(dplyr)
library(sf)
library(scales)
library(ggh4x)

health_boards <- (read_csv("clean_data/health_boards.csv"))
health_board_list <- sort(unique(health_boards$hb_name))

health_boards <- (read_csv("clean_data/health_boards.csv"))
health_board_list <- sort(unique(health_boards$hb_name))

# Percent plot -------------
beds <- read_csv("clean_data/clean_bed_data")
hb_names <- sort(unique(beds$hb_name))

source("R/percentage_occupancy.R")

# Hospital Admissions data ------------
covid_admissions <- read_csv("clean_data/hospital_admissions_postcovid.csv")

admission_type_list <- sort(unique(covid_admissions$admission_type))
source("R/hospital_admissions_summary.R")

# Length of stay data -------------
length_of_stay_data <- read_csv("clean_data/length_of_stay_data.csv")
age_group_list <- sort(unique((length_of_stay_data$age)))
length_health_board_list <- sort(unique(length_of_stay_data$hb_name))
sex_list <- unique(length_of_stay_data$sex)
source("R/length_of_stay.R")


# Age and sex data
age_and_sex <- read_csv("clean_data/age_and_sex.csv")
admission_type <- age_and_sex %>% distinct(AdmissionType)
#hb_names <- age_and_sex %>% distinct(HBName)
gender <- age_and_sex %>% distinct(Sex)
age <- age_and_sex %>% distinct(Age)
source("R/age_and_sex.R")


# simd data

simd <- read_csv("clean_data/simd_clean.csv")
simd_level <- sort(unique(simd$SIMD))
source("R/simd.R")


#graph stuff ----------------------

health_boards_shapes <- st_read(dsn = "raw_data/map_files/", 
                                layer = "SG_NHS_HealthBoards_2019")

beds_clean <- read_csv("clean_data/clean_bed_data")

beds_clean <- beds_clean %>% 
  filter(specialty_name == "All Acute") %>% 
  select(year,quarter,all_staffed_beddays,hb_name,specialty_name)

beds_clean <- beds_clean %>% 
  na.omit() %>% 
  rename(HBName = hb_name)

beds_clean$HBName <- sub("^NHS ", "", beds_clean$HBName)

joined_data <- left_join(beds_clean, health_boards_shapes, by = "HBName")


