library(shiny)
library(tidyverse)

ui <- fluidPage(
  titlePanel("proxy server converter"),
  p('Put the link to your journal article below (for e.g., https://onlinelibrary.wiley.com/doi/10.1111/cogs.13008)'),
  textInput("link", ""),
  actionButton("go", "Go"),
  p(''),
  htmlOutput("new_link"),
)

server <- function(input, output) {
  output$new_link <- renderText({
    buffer <- gsub('https', 'http', input$link) %>% # convert to http
      gsub('.com', '.com.libproxy1.nus.edu.sg', .)  # proxy server 
    paste0("<a href='", buffer, "'>", buffer, "</a>") # convert to hyperlink 
  }) %>% 
    bindEvent(input$go) 
}

shinyApp(ui, server)
