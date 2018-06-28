source("required_functions.R")

mu0 <- runif(1000, -.1, .1)
mu1 <- rnorm(1000,-3,1.5)
theta0 <- runif(1000,0,1)
sigma <- abs(rnorm(1000, 0, 1))

large_sim_store <- sim(mu0 = mu0, mu1 = mu1, theta0 = theta0, sd = sigma, n = 170)