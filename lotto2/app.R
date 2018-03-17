library(shiny)
if(!require(devtools))install.packages('devtools') else library(devtools)
library(devtools)
#if(!require('DUcj'))devtools::install_github('qkdrk777777/DUcj',force=T)
library(DUcj)
#if(!require(lotto2))devtools::install_github('qkdrk777777/lotto2',force=T)
library(lotto2)

ui<-fluidPage(title='lotto sample',
              numericInput('drop','drop:',0,min=1,max=45),
              numericInput('keep','keep:',0,min=1,max=45),
              numericInput('hold','hold:',0,min=1,max=45),
              numericInput('n','n:',10,min=1,max=100000),
              numericInput('header','header',10,min=1,max=100),
              dataTableOutput('type2')
)
server<-function(input, output,session){
  output$type2<-renderDataTable({lotto2(drop=input$drop,keep=input$keep,
                                        hold=input$hold,n=input$n,
                                        header=input$header)})

}


shinyApp(ui,server)
