library(shiny)
source("donorapp.R")

server <- function(input, output) {
        output$blood_type_plot <- renderPlot({
        one_donor_type_data <- df %>%
        filter(Donor.Type == input$Donor.Type) %>%
        filter(Organ == input$Organ)
        
        # drops all ABO rows
        one_donor_type_data<-one_donor_type_data[!(one_donor_type_data$Blood.Type=="All ABO"),]
        # drops the To Date column
        one_donor_type_data <- within(one_donor_type_data, rm(To.Date))
        
        
        # melts data so that it can be easily plotted
        m_donor_type_data <- melt(one_donor_type_data, id.vars=c("Donor.Type","Blood.Type","Organ"))
        
        # for each blood type, create x and y values that are associated w that blood type
        for (blood_type in c("A", "B", "O", "AB")){
            # filter to only that blood type
            temp_df <- m_donor_type_data[(m_donor_type_data$Blood.Type==blood_type), ]
            # create x_O, x_A, x_B.... etc.
            x_name <- paste("x_", blood_type, sep = "")
            # set name to formatted date type
            assign(x_name, as.numeric(format(as.Date(sub('.', '', temp_df$variable),format="%Y"),'%Y')))
            
            # create y_O, y_A,.... etc.
            y_name <- paste("y_", blood_type, sep = "")
            # set variable to the numeric values of that year
            assign(y_name, as.numeric(temp_df$value))
            
        }
        
        
        # plot the defined x and y points for each blood type on same plot
        p2 <- ggplot() +
            geom_line(mapping = aes(x = x_A, y = y_A), color = "blue") +
            geom_line(mapping = aes(x = x_B, y = y_B), color = "red") +
            geom_line(mapping = aes(x = x_O, y = y_O), color = "green") +
            geom_line(mapping = aes(x = x_AB, y = y_AB), color = "black")
        p2
        })
        
        output$blood_type_plot <- renderPlot({
            p1
            
        })
    }

