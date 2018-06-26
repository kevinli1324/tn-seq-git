extract_plots_testparam <- function(row, models, data) {
  mu1 <- models[paste0("mu0[", row, "]")]
  mu2 <- models[paste0("mu1[", row, "]")]
  mix1 <- models[paste0("theta[",row,"]")]
  sigma <- models[paste0("sigma[",row,"]")]
  plot_mix_reparam(data[row,], mu1, mu2, sigma, mix1 = mix1, paste(2, "E", row))
  
}

plot_mix_reparam <- function(data, mean1, mean2, sd1, mix1, title) {
  
  temp_df <- data.frame(yay = as.numeric(data))
  ggplot() + geom_histogram(data = temp_df, aes(..density.., x = yay)) + 
    stat_function(data = temp_df,aes(x = yay),  fun = function(x, mean, sd) {dnorm(x, mean =mean, sd =sd)*mix1}, args = list(mean = mean1, sd = sd1), colour = "red") +
    stat_function(data = temp_df,aes(x = yay),  fun = function(x, mean, sd) {dnorm(x, mean =mean, sd =sd)*(1-mix1)}, args = list(mean = mean1 + mean2, sd = sd1), colour = "blue") +
    ggtitle(paste(title, "Stan"))
  
}
