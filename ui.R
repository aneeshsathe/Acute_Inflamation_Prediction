
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Diagnosing Acute Inflamations: "),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel( "Here",
      sliderInput("temp",
                  "Select Body Temperature",
                  min = 35,
                  max = 42,
                  value = 35.9, step=0.1),
      selectInput("naus", "Do you feel  nausea?",
                  choices = c(
                          'Yes' = 'yes',
                          'No' = 'no'
                  ),
                  selected = 'no'
      ),
      selectInput("LumPain", "Do you Lumbar Pain? (Lower Back Pain)",
                  choices = c(
                          'Yes' = 'yes',
                          'No' = 'no'
                  ),
                  selected = 'no'
      ),
      selectInput("UrinePushing", "Do you have a continuous need for urination?",
                  choices = c(
                          'Yes' = 'yes',
                          'No' = 'no'
                  ),
                  selected = 'yes'
      ),
      selectInput("MictPain", "Is urinating painful?",
                  choices = c(
                          'Yes' = 'yes',
                          'No' = 'no'
                  ),
                  selected = 'yes'
      ),
      selectInput("burning", "Do you have any of the following symptoms: Burning of urethra, itch, swelling of urethra outlet",
                  choices = c(
                          'Yes' = 'yes',
                          'No' = 'no'
                  ),
                  selected = 'yes'
      ),
      submitButton("Submit")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      
      h2(htmlOutput("BPred")),
      br(),
      br(),
      p("This app is based on the \"Acute Inflamations Data Set\" available from the", a("UCI
        Machine Learning Repository",href="https://archive.ics.uci.edu/ml/datasets/Acute+Inflammations"),
        "The idea is to diagnose possible inflamation based on input of specific symptoms from the user."),
      p("The predictions are based on a",em("Random Forest")," machine learning model for the inputs on the right."),
      p("To help you test, here are some examples that will generate yes and no outputs for the tests:"),
      p(" Both results \"no\":
        35.5
        no
        yes
        no
        no
        no
        "
      ),
      
      
      p(" Both results \"yes\":
        40.5
      yes
      yes
      yes
      yes
      no
      "
      ),
      p(" First \"yes\", Second \"no\":
      37.9
      no
      no
      yes
      no
      no"),
      
      p(" First \"no\", Second \"yes\":
      38.0
      no
      yes
      yes
      no
      yes
      no
      "),
      br(),
      br(),
      br(),
      p(strong("Note: This is meant as a demonstration and does not represent an actual diagnosis. 
               If you suffer from any of the symptoms please approach a doctor." ))
      
    
    
    )
  )
))
