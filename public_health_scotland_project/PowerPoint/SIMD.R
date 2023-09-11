library(tidyverse)
library(here)

#SIMD 
simd <- read_csv("clean_data/simd_clean.csv")

simd %>% 
  mutate(Covid = case_when(
    Quarter %in% c("2017Q4","2018Q1","2018Q2","2018Q3", "2018Q4", "2019Q1", "2019Q2", "2019Q3", "2019Q4", "2020Q1") ~ "Pre-Covid 19",
    Quarter %in% c("2020Q2","2020Q3","2020Q4","2021Q1","2021Q2","2021Q3","2021Q4") ~ "During Covid 19",
    Quarter %in% c("2022Q1", "2022Q2","2022Q3","2022Q4") ~ "Post-Covid 19"
  )) %>% 
  mutate(Season = case_when(
    Quarter_single %in% c("Q2","Q3") ~ "Summer",
    Quarter_single %in% c("Q1","Q4") ~ "Winter"
  )) %>% 
  mutate(Covid = factor(Covid, levels = c("Pre-Covid 19", "During Covid_19", "Post-Covid 19"))) %>% 
  filter(AdmissionType == "Emergency Inpatients") %>% 
  group_by(SIMD, Season, Covid) %>% summarise(mean = mean(Stays), .groups = "drop") %>%
  ggplot(aes(x = SIMD, y = mean, fill = Covid))+
  geom_col(position = "dodge", colour = "white")+
  facet_wrap(~ Season)+
  labs(
    title = "\nThe Average Number of Stays 
for Emergency Inpatients per SIMD\n", 
x = "\nSIMD category\n",
y = "\nAverage number of admissions\n"
  )+ 
  theme_minimal()+
  scale_colour_manual(values = c("#1F3F49","#488A99" ,"#1C4E80","#4cb5f5" ,"#A5d8DD"  ))+
  theme(axis.text.x = element_text(hjust = 1, size = 12),
        axis.text.y = element_text(size = 20),
        title  = element_text(size = 15, face = "bold"), 
  )

ggsave(here("plots/admission_by_SIMD_allseasons.png"))
