source("required_functions.R")
source("pca_functions.R")
library(parallel)

logfit <- read.delim("fit_logratios_good.tab.txt", as.is = T, quote = "")

logfit_final <- data.matrix(logfit[, 5:ncol(logfit)])

labels <- assign_groups(logfit_final, 10)


stan_list <- as.list(rep(NA, 10))

for(i in 1:10) {
  logfit_min <- logfit_final[which(labels == i),]
  stan_list[[i]] <- list(N = nrow(logfit_min), J = ncol(logfit_min), y = logfit_min)
}

model_store <- mclapply(
  stan_list,
  function(x) {
    stan(file = "simple_multivar.stan", iter = 500, chains = 1, 
         control = list(max_treedepth = 15),
         data = x)
  }
)


