
  library(xml2)
  library(devtools)
  library(DUcj)
  install_github('qkdrk777777/lotto2')
  library(lotto2)
  library(progress)
  library(rvest)
  options(shiny.sanitize.errors = F)
  ui<-fluidPage(
    #fileInput("selFile", "Choose CSV File",multiple = TRUE,accept = c("text/csv","text/comma-separated-values,text/plain",".csv")),
              title='lotto sample',
                numericInput('drop','drop:',0,min=1,max=45),
                numericInput('keep','keep:',0,min=1,max=45),
                numericInput('hold','hold:',0,min=1,max=45),
                numericInput('n','n:',10,min=1,max=100000),
                numericInput('header','header',10,min=1,max=100),
                uiOutput('type2')
  )
  server<-function(input, output,session){

    output$type1<-renderDataTable({
      lotto2::lotto2(drop=input$drop,keep=input$keep,
                                          hold=input$hold,n=input$n,
                                          header=input$header)
      })
  output$type2<-renderUI({dataTableOutput('type1')})
  }


  shinyApp(ui,server)

