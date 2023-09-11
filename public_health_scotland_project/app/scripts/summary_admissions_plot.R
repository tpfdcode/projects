library(shiny)
library(tidyverse)
library(janitor)
library(here)
library(lubridate)

covid_admissions <- read_csv(here("clean_data/hospital_admissions_postcovid.csv"))

health_board_list <- sort(unique(covid_admissions$hb_name))
admission_type_list <- sort(unique(covid_admissions$admission_type))

ui <- fluidPage(
  
  fluidRow(
    
    # Select Health Board ------------
    column(
      width = 3,
      selectInput("health_board_input",
                  "Health Board",
                  health_board_list,
                  selected = "All")
    ),
    
    # Select Admission Type -------------
    column(
      width = 3,
      radioButtons("admission_type_input",
                   "Admission Type",
                   admission_type_list,
                   inline = TRUE,
                   selected = "All")
    ),
    
    column(
      width = 2,
      "Choose All ages or All sex "
    )
  ),
  
  # Slider to determine time range?
  fluidRow(
    # sliderInput(
    #   "time_range_input",
    #   "Set Time Range",
    #   min = min(covid_admissions$week_ending),
    #   max = max(covid_admissions$week_ending),
    #   value = c(2020-01-05, 2023-06-25)
    # )
  ),
  
  fluidRow(
    # Plot of Hospital Admissions Over Time Compared to Pre-Covid ---------
    plotOutput("admissions_plot")
  )
)


server <- function(input, output, session) {
  
  observeEvent(input$sex_input, {
    choices <- 
      {if(input$sex_input != "All") {
        "All ages"
      } else {
        age_group_list
      }}
    updateSelectInput(session, "age_group_input", choices = choices)
  })
  
  observeEvent(input$age_group_input, {
    choices <-
      if(input$age_group_input != "All ages") {
        "All"
      } else {
        sex_list
      }
    updateRadioButtons(session, "sex_input", choices = choices)
  })
  
  # Create Plot of Hospital Admissions
  output$admissions_plot <- renderPlot({
    covid_admissions %>% 
      filter(
        !is.na(age_group_qf) & !is.na(sex_qf) & # remove lines for different ages and sexes
        admission_type == input$admission_type_input & # filter by type
          hb_name == input$health_board_input &
          #sex == input$sex_input &
          #age_group == input$age_group_input) %>% # filter by area
      group_by(week_ending) %>% 
      summarise(number_admissions = sum(number_admissions),
                pre_covid_admissions = sum(average20182019)) %>% 
      ggplot(aes(week_ending, number_admissions)) +
      geom_line() +
      geom_line(aes(y = pre_covid_admissions), linetype = "dashed")+
      ggtitle("Hospital Admissions") +
      scale_x_date(breaks = "3 months") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
}

shinyApp(ui, server)
