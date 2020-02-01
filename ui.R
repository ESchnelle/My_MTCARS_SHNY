library(shiny)
library(ggplot2)

dataset <- mtcars


mtcars_2 <- mtcars
mtcars_2$vs_factor <- factor(mtcars_2$vs, levels = c(0,1), labels = c("V-shaped", "Straight"))
mtcars_2$cyl_factor <- as.factor(mtcars_2$cyl)
mtcars_2$am_factor <- factor(mtcars_2$am, levels = c(0,1), labels = c("Automatic", "Manual"))
mtcars_2$gear_factor <- factor(mtcars_2$gear, levels = c(3,4,5))
mtcars_2$carb_factor <- factor(mtcars_2$carb, levels = c(1,2,3,4,6,8))
mtcars_3 <- data.frame(mtcars_2$mpg, mtcars_2$disp, mtcars_2$hp, mtcars_2$drat, mtcars_2$wt, mtcars_2$qsec, mtcars_2$vs_factor, mtcars_2$cyl_factor, mtcars_2$am_factor, mtcars_2$gear_factor, mtcars_2$carb_factor)
mtcars_3 <- setNames(mtcars_3, c("Miles_per_Gallon", "Engine_Displacement", "Horsepower", "Rear_Axle_Ratio", "Weight", "Qtr_Mile_Time", "V_or_Straight", "Cylinders", "Auto_or_Manual", "Gears", "Carburetors"))

factor_list <- c("Engine_Displacement", "Horsepower", "Rear_Axle_Ratio", "Weight", "Qtr_Mile_Time", "V_or_Straight", "Cylinders", "Auto_or_Manual", "Gears", "Carburetors")
target_list <- c("Miles_per_Gallon")

dataset <- mtcars_3

shinyUI(pageWithSidebar(
  
  headerPanel("Miles/Gallon (MPG) by Vehicle Aspect Plot Tool"),
  
  sidebarPanel(
    
    text_demo <- textInput(
      "ChrtTitle", 
      "Enter a different title for your chart if you want?",
      value = "Miles/Gallon (MPG) by "
    ),
    
    #Motor Trend Miles/Gallon Relationships MPG with Vehicle Aspects
    
    selectInput('x', 'Miles/Gallon Relationships MPG by which Aspect?', factor_list),
    selectInput('color', 'Alter Color by a second Aspect?', c('None', names(dataset))),
    checkboxInput('smooth', 'Add Smoothing Line?'),
    tags$br(),
    
    actionButton("show", "Need Help? click here...(documentation)"),
    
    
    tags$br(),
    tags$br(),
    h6("Source: Data from the 1974 Motor Trend US magazine, and comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973-74 models)")
    
  ),

  mainPanel(
    plotOutput('plot')
  )
))

