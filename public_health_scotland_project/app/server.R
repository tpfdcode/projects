server <- function(input, output, session){


   alpha_on <- reactive({

     if(input$winter_shading %% 2 != 0){
      0.3
    } else {
      0
    }
   })
   
   alpha_on2 <- reactive({
     
     if(input$winter_shading2 %% 2 != 0){
       0.3
     } else {
       0
     }
   })
   
   alpha_on3 <- reactive({
     
     if(input$winter_shading3 %% 2 != 0){
       0.3
     } else {
       0
     }
   })
  

  output$pre_plot <- renderPlot({
    percentage_occupancy(data = beds(),
                         input_hb = input$hb,
                         input_alpha = alpha_on3())
    
  })
  
  # Create plot of Hospital Admissions over time ----------
  output$admissions_plot <- renderPlot({
    create_hospital_admissions_plot(covid_admissions,
                                    input$admission_type_input,
                                    input$health_board_input,
                                    alpha_on())

  })
  
  # Create plot of average length of stay --------------
  output$length_of_stay_plot <- renderPlot({
  create_length_of_stay_plot(length_of_stay_data,
                             input$length_health_board_input,
                             input$length_admission_type_input,
                             input$length_age_input,
                             input$sex_input,
                             alpha_on2())
  })


  # create plot for age and sex
  
  output$age_and_sex_plot <- renderPlot({
    create_age_and_sex_plot(age_and_sex, 
                            input$age_input,
                            alpha_on())
                            # input$health_board_input,
                            # input$gender_input)
    
      
  })
  # create SIMD output
  
  output$simd_plot<- renderPlot({
    create_simd_plot(simd, 
                     input$health_board_input_s,
                     input$simd_level_input_s,
                     alpha_on2())
  })

#graph -----------------------------
  
  filtered_data <- eventReactive(input$submit, {
    joined_data %>%
      filter(year == input$year, quarter == input$quarter)
  })
  
  output$bedsPlot <- renderPlot({
    ggplot(data = filtered_data(), aes(geometry = geometry, fill = all_staffed_beddays)) +
      geom_sf(col = "white") +
      theme_void() +
      labs(fill = "Number of Staffed Beds") +
      scale_fill_binned(n.breaks = 6, labels = number_format()) +
      ggtitle("Available Beds by Health Board") +
      theme(
        plot.title = element_text(size = 18, face = "bold"),
        legend.text = element_text(size = 15, face = "bold"),
        legend.title = element_text(size = 15, face = "bold"),
        legend.key.size = unit(1, "cm")
      ) 
  })
  
  observeEvent(input$year, {
    choices <- if (input$year == 2017) {
      4 
      } else {
      1:4
    }
      updateSelectInput(session, "quarter",
                        choices = choices)
      
    })
  }
  
  
  