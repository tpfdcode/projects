library(tidyverse)
library(openxlsx)

bike_data <- read_csv("raw_data/london_merged.csv")

clean_bike_data <- bike_data %>% 
  rename(
    time = timestamp,
    count = cnt,
    temp_real_C = t1,
    temp_feels_like_C = t2,
    humidity_percent = hum,
    wind_speed_kph = wind_speed,
    weather = weather_code
  )

clean_bike_data %>% 
  mutate(humidity_percent = humidity_percent / 100)

clean_bike_data <- clean_bike_data %>% 
  mutate(
    season = recode(season,
                    `0` = "spring",
                    `1` = "autumn",
                    `2` = "summer",
                    `3` = "winter")
  )

clean_bike_data <- clean_bike_data %>% 
  mutate(
    weather = recode(weather,
                     `1` = "clear",
                     `2` = "scattered clouds",
                     `3` = "broken clouds",
                     `4` = "cloudy",
                     `7` = "rain",
                     `10` = "rain with thunder",
                     `26` = "snowfall")
  )

write.xlsx(clean_bike_data, "clean_data/clean_bike_data.xlsx")