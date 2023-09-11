library(shiny)
library(shinydashboard)

ui <- dashboardPage( skin = "blue",
                     dashboardHeader(title = tags$h3("PHS Dashboard ")),
                     dashboardSidebar(
                       sidebarMenu(
                         menuItem("Admissions", tabName = "admissions",
                                  icon = icon("fa-solid fa-folder", class = NULL,
                                              lib = "font-awesome")),
                         menuItem("Length Of Stay", tabName = "length_of_stay",
                                  icon = icon("fa-solid fa-clock", class = NULL,
                                              lib = "font-awesome")),
                         menuItem("Beds", tabName = "beds",
                                  icon = icon("fa-duotone fa-map", class = NULL,
                                              lib = "font-awesome"))
                       )),
                     dashboardBody(
                       tags$style(HTML("
    .selectize-control.single .selectize-input {
      font-size: 20px;
    }
  ")),
  
  
  
                       tabItems(
                         # Admissions Tab -----------------
                         tabItem(tabName = "admissions",
                                 ## Admissions Inputs --------------------
                                 fluidRow(
                                   box(width = 12, background = "navy",
                                       column(width = 2,
                                              actionButton("winter_shading",
                                                           "Winter", 
                                                           icon = icon("fa-light fa-snowflake", 
                                                                       class = NULL,
                                                                       lib = "font-awesome"), 
                                                           width = 200, class = "btn-info",
                                                           style = "padding:25px; font-size:100%")),
                                       column(
                                         width = 4,
                                         selectInput("health_board_input",
                                                     "Health Board",
                                                     health_board_list,
                                                     selected = "All", width = 400)
                                       ),
                                       column(
                                         width = 5,
                                         
                                         radioButtons("admission_type_input",
                                                      tags$h4("Admission Type"),
                                                      admission_type_list,
                                                      inline = TRUE,
                                                      selected = "All")
                                       )
                                       
                                   )),
                                 ## Admissions Plot --------------------
                                 fluidRow(
                                   column(
                                     width = 12,
                                     box(width = 12,  plotOutput("admissions_plot"))
                                   )
                                   
                                 ),
                                 
                                 
                                 ## Age Sex Plot ------------------------
                                 fluidRow(
                                   column(
                                     width = 9,  
                                     box(width = 12, plotOutput("age_and_sex_plot"))
                                   ),
                                   column(
                                     width = 3,
                                     ## Age and Sex Inputs ---------------------
                                     
                                            box(width = 12, background = "purple",       
                                                 selectInput("age_input",
                                                             "Age",
                                                             age, 
                                                             selected = "80-89 years")
                                            )
                                     
                                   ))),
                         # Length of Stay Tab ------------------
                         tabItem(tabName = "length_of_stay",
                                 
                                 fluidRow(
                                   box(width = 12, background = "navy",
                                       ## Length of stay inputs ---------------------
                                       column(width = 2,
                                              actionButton("winter_shading2",
                                                           "Winter", 
                                                           icon = icon("fa-light fa-snowflake", 
                                                                       class = NULL,
                                                                       lib = "font-awesome"), 
                                                           width = 200, class = "btn-info", style = "padding:25px; font-size:100%")),
                                       column(
                                         width = 2,
                                         selectInput("length_health_board_input",
                                                     "Health Board",
                                                     choices = length_health_board_list)),
                                       
                                       column(width = 4,
                                              radioButtons("length_admission_type_input",
                                                           tags$h4("Admission Type"),
                                                           c("Emergency Inpatients",
                                                             "Elective Inpatients",
                                                             "All Inpatients"),
                                                           inline = TRUE))
                                       ,
                                       
                                       column(
                                         width = 2,
                                         selectInput("length_age_input",
                                                     "Age Group",
                                                     age_group_list,
                                                     selected = "80-89 years")
                                       ),
                                       
                                       column(
                                         width = 2,
                                         radioButtons("sex_input",
                                                      tags$h4("Sex"),
                                                      sex_list,
                                                      inline = TRUE)
                                         
                                       ))),
                                 
                                 ## Length of stay plot -------------
                                 fluidRow(
                                   column(
                                     width = 12,
                                     box(width = 12, plotOutput("length_of_stay_plot"))
                                   )
                                 ),
                                 
                                 
                                 ## SIMD Plot ----------------
                                 fluidRow( 
                                   column(
                                     width = 9,
                                     box(width = 12, plotOutput("simd_plot")) 
                                   ),
                                   ## SIMD inputs ------------------------
                                   column(
                                     width = 3, 
                                     box(width = 12, title = "Controls",
                                         background = "purple",
                                       
                                                 selectInput("health_board_input_s",
                                                             "Health Board",
                                                             choices = hb_names),
                                         
                                                selectInput("simd_level_input_s",
                                                            "SIMD Level",
                                                            choices = simd_level))
                                   )
                                   
                                   # Beds tab -----------------      
                                 )),
                         tabItem(tabName = "beds",
                                 fluidRow(
                                   box(width = 12, background = "navy",
                                       ## Beds input ------------------
                                       column(width = 2,
                                              actionButton("winter_shading3",
                                                           "Winter", 
                                                           icon = icon("fa-light fa-snowflake", 
                                                                       class = NULL, lib = "font-awesome"), 
                                                           width = 200, class = "btn-info",
                                                           style = "padding:25px; font-size:100%")),
                                       column(width = 5,
                                              selectInput("hb",
                                                          "Health Board",
                                                          choices = hb_names)
                                       ))),
                                 ## Beds plot ------------------
                                 fluidRow(
                                   column(
                                     width = 12,
                                     box(width = 12, plotOutput("pre_plot"))
                                   )
                                 ),
                                 fluidRow(
                                   column(
                                     width = 9,
                                     box(width = 12, plotOutput("bedsPlot"))
                                   ),
                                   ## Beds map inputs ----------------------------
                                   column(
                                     width = 3,
                                     box(width = 12, background = "purple", title = "Create Map",
                                         selectInput("year", "Select Year:",
                                                     choices = sort(unique(joined_data$year))),
                                         selectInput("quarter", "Select Quarter:",
                                                     choices = sort(unique(joined_data$quarter))),
                                         actionButton("submit", "Submit"))
                                   )
                                 ),
                                 
                         )
                       )
                     )
)


