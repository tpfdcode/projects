create_age_and_sex_plot <- function(data, age_input, input_alpha){
  
  age_and_sex %>% #filter(HBName == health_board_input_s) %>%
    filter(Age == age_input) %>% 
    
    group_by(Year, Quarter_single, Age, Sex) %>% summarise(number_admissions = sum(Stays), .groups = "drop")%>% 
    
    ggplot(aes(x = interaction(Quarter_single, Year), y = number_admissions, group = Sex, colour = Sex)) +
    scale_x_discrete(NULL, guide = "axis_nested")+
    geom_vline(xintercept = 11, size = 1.5, colour = "red")+
    geom_text(aes(x = 11.2, y = Inf, vjust = 1.2),
              label = "Covid Pandemic\n Start",
              size = 5, colour = "red", hjust = 0) +
    annotate("rect", xmin = 1, xmax = 3, ymin = 0, ymax =17000, alpha = as.numeric(input_alpha), fill = "steelblue" ) +
    annotate("rect", xmin = 5, xmax = 7, ymin = 0, ymax = 17000, alpha = as.numeric(input_alpha), fill = "steelblue") +
    annotate("rect", xmin = 9, xmax = 11, ymin = 0, ymax = 17000, alpha = as.numeric(input_alpha), fill = "steelblue") +
    annotate("rect", xmin = 13, xmax = 15, ymin = 0, ymax = 17000, alpha = as.numeric(input_alpha), fill = "steelblue") +
    annotate("rect", xmin = 17, xmax = 19, ymin = 0, ymax = 17000, alpha = as.numeric(input_alpha), fill = "steelblue") +
    annotate("rect", xmin = 21, xmax = 22, ymin = 0, ymax = 17000, alpha = as.numeric(input_alpha), fill = "steelblue") +
    geom_line(aes(x = interaction(Quarter_single, Year), y = number_admissions, group = Sex, colour = Sex), size = 1.5)+
    scale_x_discrete(guide = "axis_nested")+
    scale_y_continuous(labels = scales::comma)+
    
    theme_light()+
    scale_colour_manual(values = c("#1F3F49","#EA6A47" ,"#1C4E80","#4cb5f5" ,"#A5d8DD", "#488A99" ,"#7E909A", "#AC3E31", "#484848", "#DBAE58", "#20283E"  ))+
    
    theme(axis.text.x = element_text(hjust = 1, size = 12),
          axis.text.y = element_text(size = 16),
          title  = element_text(size = 18, face = "bold"),
          legend.text = element_text(size = 14),
          legend.title = element_blank()
          
    )+
    labs(
      title = "\nHospital Admissions by Age and Gender\n", 
      x = "\nQuarter\n", 
      y = "\nNumber of Admissions\n"
    )}


