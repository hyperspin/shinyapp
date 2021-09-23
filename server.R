## Fertility Prediction: server.R Part 1


library(shiny)
shinyServer(function(input, output) {
        swiss$edusp <- ifelse(swiss$Education - 10 > 0, swiss$Education - 10, 0)
        model1 <- lm(Fertility ~ Education, data = swiss)
        model2 <- lm(Fertility ~ edusp + Education, data = swiss)


        model1pred <- reactive({
                eduInput <- input$sliderEdu
                predict(model1, newdata = data.frame(Education = eduInput))
        })

        model2pred <- reactive({
                eduInput <- input$sliderEdu
                predict(model2, newdata =
                                data.frame(Education = eduInput,
                                           edusp = ifelse(eduInput - 10 > 0,
                                                          eduInput - 10, 0)))
        })


        ## Fertility Prediction: server.R Part 2


        output$plot1 <- renderPlot({
                eduInput <- input$sliderEdu

                plot(swiss$Education, swiss$Fertility, xlab = "Education",
                     ylab = "fertility", bty = "n", pch = 16,
                     xlim = c(0, 40), ylim = c(40, 100))
                if (input$showModel1) {
                        abline(model1, col = "red", lwd = 2)
                }
                if (input$showModel2) {
                        model2lines <- predict(model2, newdata = data.frame(
                                Education = 0:40, edusp = ifelse(0:40 - 10 > 0, 0:40 - 10, 0)
                        ))
                        lines(0:40, model2lines, col = "blue", lwd = 2)
                }


                ## Fertility Prediction: server.R Part 3


                legend(25, 250, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16,
                       col = c("red", "blue"), bty = "n", cex = 1.2)
                points(eduInput, model1pred(), col = "red", pch = 16, cex = 2)
                points(eduInput, model2pred(), col = "blue", pch = 16, cex = 2)
        })

        output$pred1 <- renderText({
                model1pred()
        })

        output$pred2 <- renderText({
                model2pred()
        })
})
