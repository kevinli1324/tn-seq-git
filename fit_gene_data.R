require("rstan")
options(mc.cores = 8)

logfit <- read.delim("fit_logratios_good.tab.txt", quote = "" , as.is = T)
logfit_final <- data.matrix(logfit[, 5:170])
stanFeed <- list(N = nrow(logfit_final), J = ncol(logfit_final), y = logfit_final)

gene_data <- stan(file = 'full_bayes.stan',data = stanFeed,iter = 500, chains = 4, control = list( max_treedepth = 15))