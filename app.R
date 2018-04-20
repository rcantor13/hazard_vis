library(shiny)
library(ggplot2)

ui <- fluidPage(
      # headerPanel('Constant Hazard Visualization'),
      fluidRow(
          column( 2,
                  "Hazard Values",
                  
                  numericInput(inputId = "haz_a",
                               label = "Group A",
                               value = 0.4,
                               step = 0.02),
                  
                  numericInput(inputId = "haz_b",
                               label = "Group B",
                               value = 0.2,
                               step = 0.02),
                  numericInput(inputId = "haz_c",
                               label = "Group C",
                               value = 0.1,
                               step = 0.02),
                  
                  "Plot Setup",
                  
                  numericInput(inputId = "time_start",
                               label = "Time Start",
                               value = 0,
                               step = 0.02),
                  
                  numericInput(inputId = "time_stop",
                               label = "Time Stop",
                               value = 10,
                               step = 10),
                  
                  numericInput(inputId = "time_interval",
                               label = "Time Interval",
                               value = 0.1,
                               step = 0.1)       
                  
          ),
          column(5,
               plotOutput("survival", height = 300),
               plotOutput("hazard", height = 300)      
               ),
          
        column(5,
               plotOutput("cdf", height = 300),
               plotOutput("pdf", height = 300)
               )
  
))

server <- function(input, output) {
  output$survival <- renderPlot({
    t <- seq(input$time_start, input$time_stop, by=input$time_interval)
    plot_data_a <- data.frame(t=t, h=input$haz_a, g='a')
    plot_data_b <- data.frame(t=t, h=input$haz_b, g='b')
    plot_data_c <- data.frame(t=t, h=input$haz_c, g='c')
    plot_data <-rbind(plot_data_a, plot_data_b, plot_data_c)
    plot_data$s <- exp(- plot_data$t * plot_data$h)
    p<- qplot(x=t, y=s,data=plot_data,colour=g, main="Survival", geom = "line")+ geom_line(size=1)
    print(p)
  })
  
  output$hazard <- renderPlot({
    t <- seq(input$time_start, input$time_stop, by=input$time_interval)
    plot_data_a <- data.frame(t=t, h=input$haz_a, g='a')
    plot_data_b <- data.frame(t=t, h=input$haz_b, g='b')
    plot_data_c <- data.frame(t=t, h=input$haz_c, g='c')
    plot_data <-rbind(plot_data_a, plot_data_b, plot_data_c)
    p<- qplot(x=t, y=h, data=plot_data, colour=g, main="Hazard Function", geom = "line" )+ geom_line(size=1)
    print(p)
  })
  output$cdf <- renderPlot({
    t <- seq(input$time_start, input$time_stop, by=input$time_interval)
    plot_data_a <- data.frame(t=t, h=input$haz_a, g='a')
    plot_data_b <- data.frame(t=t, h=input$haz_b, g='b')
    plot_data_c <- data.frame(t=t, h=input$haz_c, g='c')
    plot_data <-rbind(plot_data_a, plot_data_b, plot_data_c)
    plot_data$cdf <- plot_data$t * plot_data$h
    p<- qplot(x=t, y=cdf, data=plot_data, colour=g, main="Cumulative Hazard Function" , geom = "line") + geom_line(size=1)
    print(p)
  })
  output$pdf <- renderPlot({
    t <- seq(input$time_start, input$time_stop, by=input$time_interval)
    plot_data_a <- data.frame(t=t, h=input$haz_a, g='a')
    plot_data_b <- data.frame(t=t, h=input$haz_b, g='b')
    plot_data_c <- data.frame(t=t, h=input$haz_c, g='c')
    plot_data <-rbind(plot_data_a, plot_data_b, plot_data_c)
    plot_data$pdf <-plot_data$h* exp(- plot_data$t * plot_data$h)
    
    p<- qplot(x=t, y=pdf, data=plot_data, colour=g, main="PDF" , geom = "line") + geom_line(size=1)
    print(p)
  })  
  
  
  
}

shinyApp(ui = ui, server = server)  
    
    
    
  

  
