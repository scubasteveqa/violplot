library(shiny)
library(vioplot)  # Uncommon package for violin plots

# Create some sample data
set.seed(123)
group1 <- rnorm(100, mean = 2, sd = 1)
group2 <- rnorm(100, mean = 3, sd = 1.5)
group3 <- rnorm(100, mean = 1.5, sd = 0.8)

ui <- fluidPage(
  titlePanel("Violin Plot Demo with vioplot Package"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("wex", "Violin Width:",
                  min = 0.1, max = 2, value = 0.7, step = 0.1),
      
      sliderInput("alpha", "Violin Transparency:",
                  min = 0, max = 1, value = 0.5, step = 0.1),
      
      radioButtons("col", "Violin Colors:",
                   choices = c("Green" = "forestgreen", 
                               "Blue" = "dodgerblue", 
                               "Red" = "firebrick",
                               "Purple" = "purple"),
                   selected = "forestgreen"),
      
      checkboxInput("add_box", "Add Boxplot Inside", value = TRUE)
    ),
    
    mainPanel(
      plotOutput("violinPlot"),
      hr(),
      p("This app demonstrates the 'vioplot' package, which provides enhanced violin plots."),
      p("Violin plots show the distribution of data similar to boxplots but include a density estimate."),
      p("The vioplot package extends base R's plotting capabilities with more customizable violin plots.")
    )
  )
)

server <- function(input, output) {
  output$violinPlot <- renderPlot({
    # Create base plot
    plot(0, 0, type = "n", xlim = c(0.5, 3.5), ylim = c(-2, 6),
         main = "Distribution Comparison", xlab = "Groups", ylab = "Values",
         xaxt = "n") # suppress x axis
    
    # Add x-axis labels manually
    axis(1, at = 1:3, labels = c("Group 1", "Group 2", "Group 3"))
    
    # Create the violin plot using lower-level functions
    vioplot(group1, at = 1, col = input$col, 
            alpha = input$alpha, wex = input$wex, 
            drawRect = input$add_box, add = TRUE)
    vioplot(group2, at = 2, col = input$col, 
            alpha = input$alpha, wex = input$wex, 
            drawRect = input$add_box, add = TRUE)
    vioplot(group3, at = 3, col = input$col, 
            alpha = input$alpha, wex = input$wex, 
            drawRect = input$add_box, add = TRUE)
  })
}

shinyApp(ui = ui, server = server)
