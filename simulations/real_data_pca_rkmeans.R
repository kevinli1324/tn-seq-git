source("pca_functions.R")
logfit <- read.delim("fit_logratios_good.tab.txt", quote = "" , as.is = T)
logfit_final <- data.matrix(logfit[, 5:ncol(logfit)])

real_data_pca <- pca_wrapper(logfit_final, princomps = 50, method = "r_kmeans")

