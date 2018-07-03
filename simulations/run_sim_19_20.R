source("pca_functions.R")
mu0 <- rnorm(10, 0, .05)
mu1 <- -abs(rnorm(10, 1, 2))
theta0  <- runif(10, .1, .9)
sd <- abs(rnorm(10, 0, 1))
test <- gen_matrix(mu0, mu1, theta0, sd)

gen_data <- test$sample
gen_labels <- test$labels
see <- run_pca_simulation(gen_data = gen_data, gen_labels = gen_labels, 21, test$params, multicore = F)

param_frame <- as.data.frame(see$params)
names(param_frame) <- c("mu0", "mu1", "theta0", "sd")

woof <- see$metrics
woof <- cbind(woof, param_frame)
woof <- mutate(woof, 
               entropy_diff = mc_entropy - mm_entropy,
               perf_diff = mm_perf - mc_perf, 
               rank_diff = mm_perf - rank_perf,
               mod_dist  = abs(mu0 - mu1)/sd - mc_perf)
hist(woof$entropy_diff)
hist(woof$perf_diff)
hist(woof$rank_diff)

plot_woof <-
  melt(
    woof,
    id.vars= c("theta0", "mod_dist"),
    measure.vars = c(
      "mc_entropy",
      "mm_entropy",
      "rank_entropy",
      "rank_perf",
      "mc_perf",
      "mm_perf",
      "rank_false",
      "mm_false",
      "mc_false",
      "rank_neg_class",
      "mc_neg_class",
      "mm_neg_class",
      "rank_pos_class",
      "mm_pos_class",
      "mc_pos_class"
    )
  )
ggplot(data = filter(plot_woof, variable %in% c("rank_perf", "mm_perf", "mc_perf")), aes(value, fill = variable)) + geom_histogram(position = "dodge", bins = 20)

ggplot(data = filter(plot_woof, variable %in% c("rank_perf", "mm_perf", "mc_perf")), aes(x = mod_dist, value)) + geom_point() + facet_grid(.~ variable)


ggplot(data = filter(plot_woof, variable %in% c("theta0","rank_entropy","mm_entropy", "mc_entropy")), aes(value, fill = variable)) + geom_histogram(position = "dodge") 

ggplot(data = filter(plot_woof, variable %in% c("theta0","mm_false", "mc_false")), aes( x= theta0, y = value)) + geom_point() + facet_grid(.~variable)

ggplot(data = filter(plot_woof, variable %in% c("theta0","mm_false", "mc_false")), aes( value, fill = variable)) + geom_histogram(position = "dodge")
