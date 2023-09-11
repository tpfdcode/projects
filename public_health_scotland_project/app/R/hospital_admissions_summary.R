
create_hospital_admissions_plot <- function(data, admission_type_input,
                                            health_board, alpha_input){
  
  pre_covid_text <- str_wrap("Pre-covid 2018-2019 Average", 8)
  
  data %>% 
    filter(
      !is.na(age_group_qf) & !is.na(sex_qf) & # remove lines for different ages and sexes
        admission_type == admission_type_input & # filter by type
        hb_name == health_board # filter by area
    ) %>% 
    group_by(week_ending) %>% 
    summarise(number_admissions = sum(number_admissions),
              pre_covid_admissions = sum(average20182019)) %>% 
    ggplot(aes(week_ending, number_admissions, colour = "Post-covid")) +
    geom_line(size = 2) + # Main data (post covid)
    geom_line(aes(y = pre_covid_admissions, # Pre covid average
                  colour = "Pre-covid\n 2018-2019\n Average"),
              linetype = "dotted", size = 1.5) +
    annotate("rect", xmin = as.Date("2020-01-05"),
             xmax = as.Date("2020-04-05"),
             ymin = -Inf, ymax = Inf,
             fill = "steelblue", alpha = as.numeric(alpha_input)) +
    annotate("rect", xmin = as.Date("2020-10-04"),
             xmax = as.Date("2021-04-04"),
             ymin = -Inf, ymax = Inf,
             fill = "steelblue", alpha = as.numeric(alpha_input)) +
    annotate("rect", xmin = as.Date("2021-10-03"),
             xmax = as.Date("2022-04-03"),
             ymin = -Inf, ymax = Inf,
             fill = "steelblue",alpha = as.numeric(alpha_input)) +
    annotate("rect", xmin = as.Date("2022-10-02"),
             xmax = as.Date("2023-04-02"),
             ymin = -Inf, ymax = Inf,
             fill = "steelblue",alpha = as.numeric(alpha_input)) +
    scale_colour_manual(name = "", # Add legend
                        breaks = c("Pre-covid\n 2018-2019\n Average", "Post-covid"),
                        values = c("Pre-covid\n 2018-2019\n Average" = "tomato1",
                                   "Post-covid" = "black")) +
    scale_x_date(date_breaks = "3 months",
                 date_minor_breaks = "1 month",
                 date_labels = "%b %Y") +
    scale_y_continuous(labels = scales::comma) +
    labs(
      title = "Weekly Hospital Admissions",
      x = "Date",
      y = "Total Weekly Number of Admissions"
    ) +
    theme_light() +
    theme(
      axis.text.x = element_text(angle = 45, hjust = 1),
      text = element_text(size = 15),
      line = element_line(size = 5),
      panel.grid = element_line(size = 1),
      axis.ticks = element_line(size = 1),
      title = element_text(size = 18, face = "bold"),
      axis.text.y = element_text(size = 16),
      legend.text = element_text(size = 14)
      
    ) 
}

