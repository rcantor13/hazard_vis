library(ggplot2)

mu_a <- 0.4
mu_b <- 0.2
mu_c <- 0.1

time_start <- 0
time_stop <- 10
time_interval <-0.1


t <- seq(time_start, time_stop, by=time_interval)

plot_data_a <- data.frame(t=t, h=mu_a,
                          g='a')

plot_data_b <- data.frame(t=t,
                          h=mu_b,
                          g='b')

plot_data_c <- data.frame(t=t,
                          h=mu_c,
                          g='c')

plot_data <- rbind(plot_data_a, plot_data_b, plot_data_c)

plot_data$cdf <- plot_data$t * plot_data$

#GGPLOT
qplot(x=t, y=h, 
      data=plot_data, 
      colour=g, 
      main="GGPLOT line plot with groups") +
  geom_line()

#GGPLOT
qplot(x=t, y=cdf, 
      data=plot_data, 
      colour=g, 
      main="GGPLOT line plot with groups") +
  geom_line()