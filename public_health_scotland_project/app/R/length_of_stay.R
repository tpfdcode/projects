create_length_of_stay_plot <- function(data, length_health_board_input, 
                                       admission_type_input, age_input,
                                       sex_input, alpha_input) {
  
  # Filter data for inputs
  length_data <- length_of_stay_data %>% 
    filter(
      admission_type == admission_type_input &  
        hb_name == length_health_board_input & 
        age == age_input &
        sex == sex_input
    ) %>% 
    group_by(quarter) %>% 
    summarise(avg_stay = sum(length_of_stay)/sum(stays)) %>% 
    mutate(year = str_extract(quarter, "[0-9]{4}"),
           quarter = str_remove(quarter, "[0-9]{4}"))
  
  years <- unique(length_data$year)
  
  # Plot
  length_data %>% 
    ggplot(aes(interaction(quarter, year), avg_stay), size = 5) +
    scale_x_discrete(guide = "axis_nested") +
    geom_line(group = 1, size = 2) +
    geom_point(size = 3) +
    annotate("rect", xmin = 0, xmax = 2, ymin = -Inf, ymax = Inf,
             fill = "steelblue", alpha = alpha_input) +
    annotate("rect", xmin = 4, xmax = 6, ymin = -Inf, ymax = Inf,
             fill = "steelblue",alpha = alpha_input) +
    annotate("rect", xmin = 8, xmax = 10, ymin = -Inf, ymax = Inf,
             fill = "steelblue",alpha = alpha_input) +
    annotate("rect", xmin = 12, xmax = 14, ymin = -Inf, ymax = Inf,
             fill = "steelblue",alpha = alpha_input) +
    annotate("rect", xmin = 16, xmax = 18, ymin = -Inf, ymax = Inf,
             fill = "steelblue",alpha = alpha_input) +
    geom_vline(xintercept = 11, size = 1.5, colour = "red") +
    geom_text(aes(x = 11.2, y = Inf, vjust = 1.2),
                  label = "Covid Pandemic\nStart", size = 5, colour = "red",
              hjust = 0) +
    scale_colour_manual(name = "", # Add legend
                        breaks = "Pre-covid 2018-2019 Average",
                        values = c("Pre-covid 2018-2019 Average" = "red")) +
    theme_light() +
    theme(
      text = element_text(size = 15),
      axis.text.y = element_text(size = 16),
      title  = element_text(size = 18, face = "bold")
      
    ) +
    labs(
      title = "Average Length of Stay for Inpatients by Demographic",
      x = "Quarter",
      y = "Average Length of Stay (days)"
    )
  
}