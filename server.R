library(shiny)
library(ggplot2)


shinyServer(function(input, output) {
  
  mtcars_2 <- mtcars
  mtcars_2$vs_factor <- factor(mtcars_2$vs, levels = c(0,1), labels = c("V-shaped", "Straight"))
  mtcars_2$cyl_factor <- as.factor(mtcars_2$cyl)
  mtcars_2$am_factor <- factor(mtcars_2$am, levels = c(0,1), labels = c("Automatic", "Manual"))
  mtcars_2$gear_factor <- factor(mtcars_2$gear, levels = c(3,4,5))
  mtcars_2$carb_factor <- factor(mtcars_2$carb, levels = c(1,2,3,4,6,8))
  mtcars_3 <- data.frame(mtcars_2$mpg, mtcars_2$disp, mtcars_2$hp, mtcars_2$drat, mtcars_2$wt, mtcars_2$qsec, mtcars_2$vs_factor, mtcars_2$cyl_factor, mtcars_2$am_factor, mtcars_2$gear_factor, mtcars_2$carb_factor)
  mtcars_3 <- setNames(mtcars_3, c("Miles_per_Gallon", "Engine_Displacement", "Horsepower", "Rear_Axle_Ratio", "Weight", "Qtr_Mile_Time", "V_or_Straight", "Cylinders", "Auto_or_Manual", "Gears", "Carburetors"))

  y <- "Miles_per_Gallon"
  
  dataset <- reactive( {
    data.frame(mtcars_3[ , c("Miles_per_Gallon", "Engine_Displacement", "Horsepower", "Rear_Axle_Ratio", "Weight", "Qtr_Mile_Time", "V_or_Straight", "Cylinders", "Auto_or_Manual", "Gears", "Carburetors")])
    })
  
  # Help Dialog Window
  observeEvent(input$show, {
    showModal(modalDialog(
      title = "How to use this tool:",
      "This tool will interactively plot MPG to show relationship with any Vehicle Aspect you choose.",
      "It automatically produces scatterplots for ",tags$b(tags$i("continuous"))," numeric and box/whisker plots for  ",tags$b(tags$i("discrete"))," relationships.",
      "See instructions below on how to manipulate the tool to produce the output you'd like.",
      
      tags$br(),  
      tags$br(),    
      tags$b(tags$u("Enter a different title for your chart if you want?:")),
      "if you want enter a chart title otherwise the default title will be: 'Miles/Gallon (MPG) by ' ", 
      tags$b(tags$i("Primary Aspect")),
      "and if Secondary Aspect selected will include:", " ' colored by ", tags$b(tags$i("Secondary Aspect")), " '",
      tags$br(),
      
      tags$br(),  
      tags$br(),    
      tags$b(tags$u("Aspects you can choose to relate to Miles_per_Gallon include:")),
      tags$br(),
      "...select them from drop down...",
      tags$br(),
      
      tags$b(tags$i("Cylinders")), " = Number of engine Cylinders (discrete)",
      tags$br(),
      tags$b(tags$i("Engine_Displacement")), " = engine Displacement (cu.in.) (continuous)",
      tags$br(),
      tags$b(tags$i("Horsepower")), " = Gross engine horsepower (continuous)",
      tags$br(),
      tags$b(tags$i("Rear_Axle_Ratio")), " = Rear axle ratio (continuous)",
      tags$br(),
      tags$b(tags$i("Weight")), " = Weight (1000 lbs) (continuous)",
      tags$br(),
      tags$b(tags$i("Qtr_Mile_Time")), " = 1/4 mile time (continuous)",
      tags$br(),
      tags$b(tags$i("V_or_Straight")), " = Engine (0 = V-shaped, 1 = straight)",
      tags$br(),
      tags$b(tags$i("Auto_or_Manual")), " = Transmission: automatic or manual)",
      tags$br(),
      tags$b(tags$i("Gears")), " = Number of forward Gears",
      tags$br(),
      tags$b(tags$i("Carburetors")), " = Number of engine Carburetors",
      tags$br(),
      tags$br(),
      tags$b(tags$u("Alter Color by a second Aspect: ")), "Select a second vehicle ascpect to add to your plot by choosing a second Vehicle Aspect",
      "...select your secondary Aspect for color coding from drop down...",
      
      tags$br(),
      tags$br(),
      tags$b(tags$u("Add Smoothing Line?: ")), "Check this selector to produce a loess plot smoothing line on your scatterplots.",
      "If you have a second Aspect chosen (color coding) this will then produce separate smooothing lines for each secondary Aspect.",
      
      tags$br(),
      tags$br(),      
      tags$b(tags$i("Data Source: ")), tags$i("1974 Motor Trend US magazine, and comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973-74 models)."),
      easyClose = TRUE,
      footer = NULL
    ))
  })
  
  # #################
  
  output$plot <- reactivePlot(function() {
    
    # if selected a discreate factor then do a boxplot  
    if (paste(input$x) == "V_or_Straight")
      p <- ggplot(dataset(), aes_string(x=input$x, y=paste(y))) + geom_boxplot()
    if (paste(input$x) == "Cylinders")
      p <- ggplot(dataset(), aes_string(x=input$x, y=paste(y))) + geom_boxplot()  
    if (paste(input$x) == "Auto_or_Manual")
      p <- ggplot(dataset(), aes_string(x=input$x, y=paste(y))) + geom_boxplot()
    if (paste(input$x) == "Gears")
      p <- ggplot(dataset(), aes_string(x=input$x, y=paste(y))) + geom_boxplot()
    if (paste(input$x) == "Carburetors")
      p <- ggplot(dataset(), aes_string(x=input$x, y=paste(y))) + geom_boxplot()   
    
    # if selected a non-discreate factor then do a scatterplot  
    if (paste(input$x) == "Engine_Displacement")
      p <- ggplot(dataset(), aes_string(x=input$x, y=paste(y))) + geom_point()   
    if (paste(input$x) == "Horsepower")
      p <- ggplot(dataset(), aes_string(x=input$x, y=paste(y))) + geom_point()   
    if (paste(input$x) == "Rear_Axle_Ratio")
      p <- ggplot(dataset(), aes_string(x=input$x, y=paste(y))) + geom_point()   
    if (paste(input$x) == "Weight")
      p <- ggplot(dataset(), aes_string(x=input$x, y=paste(y))) + geom_point()   
    if (paste(input$x) == "Qtr_Mile_Time")
      p <- ggplot(dataset(), aes_string(x=input$x, y=paste(y))) + geom_point()   
  
   # if colors selected for second factor highlight by selected secondary factor
   if (input$color != 'None')
     p <- p + aes_string(color=input$color)
   
   # if user selected to see a loess smoothed curve based on scatter plot 
   # then give a smoothing line, or multiple smoothing lines if two factors are selected via colors
   if (input$smooth)
     p <- p + geom_smooth()
   
   # alter chart title based on factor inputs primary and secondary if chosen
   if (input$color != "None")
     p <- p + ggtitle(paste(input$ChrtTitle," ", input$x, " colored by ", input$color ))
   if (input$color == "None")
     p <- p + ggtitle(paste(input$ChrtTitle," ", input$x))
   
   # output plot with all features from above
   print(p)
  
   
}, height=500
)
  
})  
  