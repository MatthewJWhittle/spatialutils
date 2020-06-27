split_work <-
  function(x_length, cores){
    split <-
      seq(from = 0,
          to = x_length,
          by = round(x_length / cores))
    
    # Ensure the final split ends on the number of squares
    split[length(split)] <- x_length
    
    ind <- c(1:(length(split) - 1))
    
    work_division <-
      lapply(ind,
             function(i) {
               (split[i] + 1):split[i + 1]
             })
    
    return(work_division)
  }
