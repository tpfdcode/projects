
library(ggh4x)
create_simd_plot <- function(data, health_board_input_ss, simd_level_input_s){
  
  simd %>% 
    filter(HBName == health_board_input_ss) %>% 
    filter(SIMD == simd_level_input_s) %>% 
    ggplot(aes(x = interaction(Quarter_single, Year), y = AverageLengthOfStay, group = AdmissionType, colour = AdmissionType)) +
    scale_x_discrete(NULL, guide = "axis_nested")+

    geom_vline(xintercept = 11, size = 1.5, colour = "red")+
    annotate("rect", xmin = 1, xmax = 3, ymin = 0, ymax =10, alpha = 0.2, fill = "lightblue" ) +
    annotate("rect", xmin = 5, xmax = 7, ymin = 0, ymax = 10, alpha = 0.2, fill = "lightblue") +
    annotate("rect", xmin = 9, xmax = 11, ymin = 0, ymax = 10, alpha = 0.2, fill = "lightblue") +
    annotate("rect", xmin = 13, xmax = 15, ymin = 0, ymax = 10, alpha = 0.2, fill = "lightblue") +
    annotate("rect", xmin = 17, xmax = 19, ymin = 0, ymax = 10, alpha = 0.2, fill = "lightblue") +
    annotate("rect", xmin = 21, xmax = 22, ymin = 0, ymax = 10, alpha = 0.2, fill = "lightblue") +
    geom_point()+
    geom_line(size = 1)+
    theme_light()+
    scale_colour_manual(values = c("#1F3F49","#488A99" ,"#1C4E80","#4cb5f5" ,"#A5d8DD"  ))+
    # scale_x_discrete(labels = c("2017Q4" = "2017   Q4", "2018Q1" = "2018   Q1", "2018Q2" = "Q2", "2018Q3" = "Q3", "2018Q4" = "Q4", "2019Q1" = "2019   Q1", "2019Q2" = "Q2", "2019Q3" = "Q3", "2019Q4" = "Q4", "2020Q1" = "2020   Q1", "2020Q2" = "Q2", "2020Q3" = "Q3", "2020Q4" =  "Q4","2021Q1" = "2021   Q1", "2021Q2" = "Q2", "2021Q3" = "Q3", "2021Q4" = "Q4", "2022Q1" = "2022   Q1", "2022Q2" = "Q2", "2022Q3" = "Q3", "2022Q4" = "Q4"))+
    theme(axis.text.x = element_text(hjust = 1, size = 12),
          axis.text.y = element_text(size = 16),
          title  = element_text(size = 14, face = "bold")
    )+
    labs(
      title = "\nAverage length of stay by Health Board, Admission Type and SIMD\n",
      x = "\nQuarter\n",
      y = "\nAverage length of stay (days)\n"
    )
}

