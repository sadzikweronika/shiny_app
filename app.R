# library(shiny)
# 
# # Define UI ----
# ui <- fluidPage(
#   titlePanel("title panel"),
#   sidebarLayout(position = "right",
#     sidebarPanel("sidebar panel"),
#     mainPanel("main panel", h1("1st level", align='center'), h2("2nd level", align='center'), 
#               h3("3rd level", align='center'), h4("4th level", align='center'), 
#               h5("5th level", align='center'))
#   )
# )
# ui <- fluidPage(
#   titlePanel("My Shiny App"),
#   sidebarLayout(
#     sidebarPanel(),
#     mainPanel(
#       p("p creates a paragraph of text."),
#       p("A new p() command starts a new paragraph. Supply a style attribute to change the format of the entire paragraph.", style = "font-family: 'times'; font-si16pt"),
#       strong("strong() makes bold text."),
#       em("em() creates italicized (i.e, emphasized) text."),
#       br(),
#       code("code displays your text similar to computer code"),
#       div("div creates segments of text with a similar style. This division of text is all blue because I passed the argument 'style = color:blue' to div", style = "color:blue"),
#       br(),
#       p("span does the same thing as div, but it works with",
#         span("groups of words", style = "color:blue"),
#         "that appear inside a paragraph."),
#       img(src = "yoda.jpeg", height = 72, width = 72)
#     )
#   )
# )
# 
# ui <- fluidPage(
#   titlePanel("Basic widgets"),
#   
#   fluidRow(
#     
#     column(3,
#            h3("Buttons"),
#            actionButton("action", "Action"),
#            br(),
#            br(), 
#            submitButton("Submit")),
#     
#     column(3,
#            h3("Single checkbox"),
#            checkboxInput("checkbox", "Choice A", value = TRUE)),
#     
#     column(3, 
#            checkboxGroupInput("checkGroup", 
#                               h3("Checkbox group"), 
#                               choices = list("Choice 1" = 1, 
#                                              "Choice 2" = 2, 
#                                              "Choice 3" = 3),
#                               selected = 1)),
#     
#     column(3, 
#            dateInput("date", 
#                      h3("Date input"), 
#                      value = "2014-01-01"))   
#   ),
#   
#   fluidRow(
#     
#     column(3,
#            dateRangeInput("dates", h3("Date range"))),
#     
#     column(3,
#            fileInput("file", h3("File input"))),
#     
#     column(3, 
#            h3("Help text"),
#            helpText("Note: help text isn't a true widget,", 
#                     "but it provides an easy way to add text to",
#                     "accompany other widgets.")),
#     
#     column(3, 
#            numericInput("num", 
#                         h3("Numeric input"), 
#                         value = 1))   
#   ),
#   
#   fluidRow(
#     
#     column(3,
#            radioButtons("radio", h3("Radio buttons"),
#                         choices = list("Choice 1" = 1, "Choice 2" = 2,
#                                        "Choice 3" = 3),selected = 1)),
#     
#     column(3,
#            selectInput("select", h3("Select box"), 
#                        choices = list("Choice 1" = 1, "Choice 2" = 2,
#                                       "Choice 3" = 3), selected = 1)),
#     
#     column(3, 
#            sliderInput("slider1", h3("Sliders"),
#                        min = 0, max = 100, value = 50),
#            sliderInput("slider2", "",
#                        min = 0, max = 100, value = c(25, 75))
#     ),
#     
#     column(3, 
#            textInput("text", h3("Text input"), 
#                      value = "Enter text..."))   
#   )
#   
# )
# 
# ui <- fluidPage(
#   titlePanel("censusVis"),
#   
#   sidebarLayout(
#     sidebarPanel(
#   
#            helpText("Create democrates maps with", 
#                     "information from the 2010 US Census."),
#            selectInput("select", label = "Choose a variable to display", 
#                        choices = list("Percent White" = 1, "Percent Black" = 2,
#                                       "Percent Hispanic" = 3, "Percent Asian" = 4), 
#                                 selected = 1),
#            sliderInput("Range of interest", "Range of interest:",
#                       min = 0, max = 100, value = c(0, 100))
#     
# ),
# mainPanel()
# )
# )
# 
# ui <- fluidPage(
#   titlePanel("censusVis"),
#   
#   sidebarLayout(
#     sidebarPanel(
#       helpText("Create demographic maps with 
#                information from the 2010 US Census."),
#       
#       selectInput("var", 
#                   label = "Choose a variable to display",
#                   choices = c("Percent White", 
#                               "Percent Black",
#                               "Percent Hispanic", 
#                               "Percent Asian"),
#                   selected = "Percent White"),
#       
#       sliderInput("range", 
#                   label = "Range of interest:",
#                   min = 0, max = 100, value = c(0, 100))
#     ),
#     
#     mainPanel(
#       textOutput("selected_var"),
#       textOutput("selected_range")
#     )
#   )
# )
# # Define server logic ----
# server <- function(input, output) {
#   output$selected_var <- renderText({ 
#     paste("You have selected", input$var)
#   })
#   
#   output$selected_range <- renderText({ 
#     paste("You have chosen a range that goes from ", input$range[1], " to ", input$range[2])
#   })
# }
# # Run the app ----
# shinyApp(ui = ui, server = server)
# 
# library(maps)
# library(mapproj)
# counties <- readRDS("/Users/weronikasadzik/Desktop/AGH/R/APP_1/data/counties.rds")
# source("/Users/weronikasadzik/Desktop/AGH/R/APP_1/helpers.R")
# percent_map(counties$white, "darkgreen", "% White")


library(maps)
library(mapproj)
source("/Users/weronikasadzik/Desktop/AGH/R/APP_1/helpers.R")
counties <- readRDS("/Users/weronikasadzik/Desktop/AGH/R/APP_1/data/counties.rds")

head(counties)
# User interface ----
ui <- fluidPage(
  titlePanel("censusVis"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Create demographic maps with 
        information from the 2010 US Census."),
      
      selectInput("var", 
                  label = "Choose a variable to display",
                  choices = c("Percent White", "Percent Black",
                              "Percent Hispanic", "Percent Asian"),
                  selected = "Percent White"),
      
      sliderInput("range", 
                  label = "Range of interest:",
                  min = 0, max = 100, value = c(0, 100))
    ),
    
    mainPanel(plotOutput("map"))
  )
)

# Server logic ----
server <- function(input, output) {
  output$map <- renderPlot({
    data <- switch(input$var, 
                   "Percent White" = counties$white,
                   "Percent Black" = counties$black,
                   "Percent Hispanic" = counties$hispanic,
                   "Percent Asian" = counties$asian)
    
    colors <- switch(input$var, 
                    "Percent White" = "seagreen2",
                    "Percent Black" = "slateblue3",
                    "Percent Hispanic" = "firebrick1",
                    "Percent Asian" = "dodgerblue")
    
    legend <- switch(input$var, 
                     "Percent White" = "% White",
                     "Percent Black" = "% Black",
                     "Percent Hispanic" = "% Hispanic",
                     "Percent Asian" = "% Asian")
    
    percent_map(var=data, color=colors, legend.title=legend, min=input$range[1], max=input$range[2])
  })
}
# Run app ----
shinyApp(ui, server)

