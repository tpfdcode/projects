library(shiny)
t_and_s <-
  read_csv("data/inpatient_and_daycase_by_nhs_board_of_treatment_and_specialty.csv")
names <- read_csv("data/names")


h_names <- names %>%
  distinct(HB_name) %>%
  pull()


s_names <- t_and_s %>%
  distinct(SpecialtyName) %>%
  pull()

# Define UI for application that draws a histogram
ui <- fluidPage(
  selectInput("specialty_choice",
              "Which Specialty",
              choices = s_names),
  plotOutput("specialty_plot"),
  
  
  fluidRow(column(width = 3,
     selectInput("specialty_choice2",
                "Which Specialty",
                choices = s_names)),
    column(width = 3,
           selectInput("health_board",
                "Health Board",
                choices = h_names)
    )
  ),
  plotOutput("specialty_plot2"),
  
  fluidRow(column(width = 3,
                  selectInput("specialty_choice3",
                              "Which Specialty",
                              choices = s_names)),
           column(width = 3,
                  selectInput("health_board2",
                              "Health Board",
                              choices = h_names)
           ),
  
  plotOutput("specialty_plot_spells")
  
  )
)



# Define server logic required to draw a histogram
server <- function(input, output) {
  output$specialty_plot <- renderPlot({
    t_and_s %>%
      filter(SpecialtyName == input$specialty_choice) %>%
      select(Quarter, SpecialtyName, Episodes) %>%
      group_by(SpecialtyName, Quarter) %>%
      summarise(count = sum(Episodes)) %>%
      ggplot(aes(x = Quarter, y = count, group = SpecialtyName)) +
      geom_line() +
      labs(y = "number of episodes") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
    
  })
  
  output$specialty_plot2 <- renderPlot({
    names %>%
      filter(SpecialtyName == input$specialty_choice2) %>%
      filter(HB_name == input$health_board) %>%
      select(Quarter, SpecialtyName, Episodes) %>%
      group_by(SpecialtyName, Quarter) %>%
      summarise(count = sum(Episodes)) %>%
      ggplot(aes(x = Quarter, y = count, group = SpecialtyName)) +
      geom_line() +
      labs(y = "number of episodes") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
    
  })
  
  output$specialty_plot_spells <- renderPlot({
    names %>%
      filter(SpecialtyName == input$specialty_choice3) %>%
      filter(HB_name == input$health_board2) %>%
      select(Quarter, SpecialtyName, Spells) %>%
      group_by(SpecialtyName, Quarter) %>%
      summarise(count = sum(Spells)) %>%
      ggplot(aes(x = Quarter, y = count, group = SpecialtyName)) +
      geom_line() +
      labs(y = "number of episodes") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
    
  })
  
  
}

# Run the application
shinyApp(ui = ui, server = server)
