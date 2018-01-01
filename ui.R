#--------------------------------------------------
# R UI Code for the Capstone Project Shiny App
#--------------------------------------------------

suppressPackageStartupMessages(c(
    library(shinythemes),
    library(shiny),
    library(tm),
    library(stringr),
    library(markdown),
    library(stylo)))


#shinyUI(fluidPage(theme = shinytheme("simplex"),
shinyUI(navbarPage("Coursera Data Science Capstone", theme = shinytheme("flatly"),    
    # Application title
    h1(tags$b("Next Word Auto Completion"),align="center",style = "color:black;font-family:'Ariel';font-size: 36px; line-height: 32px;"),
    tags$hr(style="color: purple;"), #draw a line
    tags$style(".span12 {background-color: yellow;}"),
    
    fluidRow(HTML("<strong>Author: Sang Cho</strong>"),align="center" ),
    
    fluidRow(
        br(),
        p("This app will recommend the following word of <= 3 word(s) in partial sentence - based on word frequencies from provided data.",
          align="center",style = "color:gray;font-family:'Ariel';font-size: 24px; line-height: 32px;")),
    br(),
    br(),

    # Sidebar layout
    sidebarLayout(
        
        sidebarPanel(
            textInput("inputString", tags$p("Enter text(s) here",style = "color:black;font-family:'Ariel';font-size: 30px; line-height: 32px;"),value = ""),
            submitButton("Next Word")
        ),
        
        mainPanel(
            h4("The next suggesteed word is:",style = "color:black;font-family:'Ariel';font-size: 30px; line-height: 32px;"),
            verbatimTextOutput("prediction"),
            textOutput('text1')
            #textOutput('text2')
        )
    )
))