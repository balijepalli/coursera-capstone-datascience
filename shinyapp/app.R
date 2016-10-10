
# =================================================
# : Coursera.org
# : Data Science Specialization - Capstone Project
# : October 2016
# :
# : Shiny Application: Predicting Next Word
# :
# : Author  - Preetam Balijepalli
# : twitter - @balijepalli
# =================================================

library(shiny)

source("nextword.R")

#load("data/badwords.rds")
#load("data/unigrams.rds")
#load("data/bigrams.rds")
#load("data/trigrams.rds")
#load("data/fourgrams.rds")


# Define UI for application that draws a histogram
ui <- shinyUI(
  fluidPage(
    # Application title
    titlePanel("Swift Key:John Hopkins Data science capstone project"),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
      sidebarPanel(
        textInput(inputId ="text",
                  label = h5("Input the sentence"),
                  value ="John Hopkins"),
        numericInput("n",
                     h5("Numbers of predicted words"),
                     value = 3),
        br(),
        submitButton("Predict"),
        HTML('<script type="text/javascript">
             document.getElementById("text").focus();
             </script>')
        ),
      
      # Show a plot of the generated distribution
      mainPanel(
        tabsetPanel(type = "tabs",
                    tabPanel("Result",
                             conditionalPanel(
                               condition = "input.text != ''",
                               verbatimTextOutput("text"),
                               verbatimTextOutput("cleaned"), verbatimTextOutput("msg"),
                               selectInput("predicts","Word predictions:",choices=c(""))
                             ),
                             hr(),
                             h3("Top 5 Possibilities:", align="center"),
                             div(tableOutput("alts"), align="center")
                    ),
                    
                    tabPanel("Documentation",
                             htmlOutput("help"),
                             tags$div(id="help",
                                      HTML("<iframe id='ifrHelp' src='help.html' height='550' width='650'>
                                           Documentation Text
                                           </iframe>"))
                                      ),
                    
                    tabPanel("References",
                             htmlOutput("references"),
                             tags$div(id="references",
                                      HTML("<iframe id='ifrHelp' src='references.html' height='550' width='650'>
                                           Documentation Text
                                           </iframe>"))
                                      )
                                      ) )
                    )  ,
    
    fluidRow(
      HTML("<div style='margin-left:18px;margin-bottom:12px;color:green;'>
           <strong>Creation date: Oct 2016</strong>
           </div>")
      ),
    fluidRow(HTML("<div style='margin-left:18px;margin-bottom:12px;margin-top:-12px;color:green;'>
                  <strong><big>By <a title='Write to me!...'
                  href='mailto:preetam.balijepalli@gmail.com'>Preetam Balijepalli</a>
                  </big></strong>&nbsp;&nbsp;&nbsp;&nbsp;
                  <br/>&spades;&nbsp;&nbsp;<a title='Know my blog' target='_blank' href='http://balijepalli.com/about/'>About me</a>&nbsp;&nbsp;&spades;</div>") )
    
    
    )
    )

server <- shinyServer(function(input, output,session) {
  
  output$text <- renderText({
    paste("Input text is:", input$text)
  })
  
  observe({
    iniTime <- Sys.time()
    
    textCleansed <- cleanPhrases(input$text)
    if(textCleansed != " ")
    {
      
      output$cleaned <- renderText({
        paste0("Cleansed text: [",textCleansed,"]")
      })
      
      textCleansed <- gsub(" \\* "," ",textCleansed)    # not taking account of badwords
      
      predictWords <- predict_model(textCleansed)
      
      updateSelectInput(session = session, inputId = "predicts", choices = predictWords)
      
      endTime <- Sys.time()
      
      output$msg <- renderText({
        paste(msg, "\n", sprintf("- Total time processing = %6.3f msecs",1000*(endTime-iniTime)))
      })
      gc()
    }
    
  })
  
  
})  

# Run the application
shinyApp(ui = ui, server = server)
