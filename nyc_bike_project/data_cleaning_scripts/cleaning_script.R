library(tsibbledata)
library(tidyverse)
library(geosphere)

nyc_bikes_df <- nyc_bikes

nyc_bikes_df <- nyc_bikes_df %>% 
  filter(birth_year > 1946)

nyc_bikes_df <- nyc_bikes_df %>% 
  mutate(
    date = date(start_time),
    day = wday(start_time,label = TRUE, abbr = TRUE),
    month = month(start_time, label = TRUE, abbr = TRUE),
    year = year(start_time)
  )

nyc_bikes_df <- nyc_bikes_df %>% 
  mutate(distance_meters = distGeo(matrix(c(start_long, start_lat), ncol = 2),
                                   matrix(c(end_long, end_lat), ncol = 2)))

nyc_bikes_df <- nyc_bikes_df %>% 
  mutate(journey_time = round(stop_time - start_time, 2))

nyc_bikes_clean <- nyc_bikes_df %>% 
  mutate(age = 2018  - birth_year ) %>% 
  mutate(age_group = case_when(
    age >= 0 & age <= 25 ~ "25 and under",
    age >= 26 & age <= 50 ~ "26 to 50",
    age > 50 ~ "50+"))

stations_start <- nyc_bikes_clean %>% 
  distinct(start_station, .keep_all = TRUE) %>% 
  select(lat = start_lat, long = start_long)  


station_end <- nyc_bikes_clean %>% 
  distinct(end_station, .keep_all = TRUE) %>% 
  select(lat = end_lat, long = end_long)  

stations <- rbind(stations_start, station_end) %>% 
  distinct(lat, long)

write.csv(nyc_bikes_clean,"clean_data/nyc_bikes_clean.csv")
write.csv(stations,"clean_data/stations.csv")
