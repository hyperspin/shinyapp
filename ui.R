## Fertility  Prediction: ui.R Part 1


library(shiny)
shinyUI(fluidPage(
        titlePanel("Predict Fertility from Education"),
        sidebarLayout(
                sidebarPanel(
                        sliderInput("sliderEdu", "What is the Education ?", 0, 40, value = 20),
                        checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
                        checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE),
                        submitButton("Submit")
                ),
                ## Fertility Prediction: ui.R Part 2

                mainPanel(
                        plotOutput("plot1"),
                        h3("Predicted Fertility from Model 1:"),
                        textOutput("pred1"),
                        h3("Predicted Fertility from Model 2:"),
                        textOutput("pred2")
                )
        )
))


