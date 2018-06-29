assign_groups <- function(data_matrix, princomps) {
  eval_angle <- function(vec1, vec2) {
    acos(sum(vec1*vec2)/(norm(vec1, type = "2") * norm(vec2, type = "2")))
  }
  
  svd_object <- svd(data_matrix)
  v <- svd_object$v
  u <- svd_object$u
  
  return_labels <- rep(0, nrow(data_matrix))
  princomp_store <- rep(0, princomps)
  for(row in 1:nrow(data_matrix)) {
      for(p in 1:princomps) {
        princomp_store[p] <- eval_angle(v[,p], u[row,]%*%diag(svd_object$d, nrow = nrow(data_matrix), ncol = ncol(data_matrix)))
      }
    return_labels[row] <- which(princomp_store == min(princomp_store))
  }
  return(return_labels)
}
