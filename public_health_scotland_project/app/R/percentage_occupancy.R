percentage_occupancy <- function(data, input_hb, input_alpha) {
  beds %>%
    mutate(year_q = str_c(year, quarter, sep = " Q", collapse = NULL)) %>% 
    filter(specialty_name == "All Acute") %>%
    filter(hb_name == input_hb) %>%
    group_by(year_q) %>%
    summarise(avg = mean(percentage_occupancy)) %>%
    mutate(year = str_sub(year_q, 1, 4), 
           quarter = str_sub(year_q, 5)) %>% 
    ggplot() +
    aes(x = interaction(quarter, year), y = avg) +
    geom_line(group = 1, size = 2) +
    geom_point(size = 3) +
    theme(text = element_text(size = 60), face = "bold") +
    scale_x_discrete(guide = "axis_nested") +
    labs(x = "Quarter",
         y = "Bed Occupancy (%)",
         title = "Percentage Of Bed Occupancy Over Time") +
    annotate("rect", xmin = 1, xmax = 3, ymin = 0, ymax = 100, alpha = as.numeric(input_alpha),
      fill = "steelblue")  +
    annotate("rect", xmin = 5, xmax = 7, ymin = 0, ymax = 100, alpha = as.numeric(input_alpha),
      fill = "steelblue") +
    annotate("rect", xmin = 9, xmax = 11, ymin = 0, ymax = 100, alpha = as.numeric(input_alpha),
      fill = "steelblue") + 
    annotate("rect", xmin = 13, xmax = 15, ymin = 0, ymax = 100, alpha = as.numeric(input_alpha),
     fill = "steelblue") + 
    annotate("rect", xmin = 17, xmax = 19, ymin = 0, ymax = 100, alpha = as.numeric(input_alpha),
      fill = "steelblue") +
    geom_vline(xintercept = 11,
               size = 1.5,
               colour = "red") +
    geom_text(aes(x = 11.2, y = Inf, vjust = 1.2),
              label = "Covid Pandemic\n Start",
              size = 5, colour = "red", hjust = 0) +
    theme_light()+
    theme(axis.text.x = element_text(hjust = 1, size = 12),
          axis.text.y = element_text(size = 16),
          title  = element_text(size = 18, face = "bold"),
          legend.text = element_text(size = 14),
          legend.title = element_blank())

} 