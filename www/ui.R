library(shiny)

shinyUI(fluidPage(
  # header
  headerPanel("Exploring Distribution"),

  # left panel: choosing distribution and its parameters
  sidebarPanel(
    # choosing type of distribution
    selectInput(inputId = "dist",
                label = "Choose Distribution:",
                choices = 
                  c("Binary",
                    "Normal",
                    "Poisson",
                    "Uniform"),
                selected = "Normal"),
    # choosing parameters per distribution
    uiOutput("type")
  ),
  
  # main right centered panel: histogram of distribution
  mainPanel(
    plotOutput("distPlot")
  )
))