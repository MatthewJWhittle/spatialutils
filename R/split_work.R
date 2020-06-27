#' Define parallel work splits
#'
#' Define an index of work splits for parallel processing
#'
#' This function accepts an integar defining the length of you object to be split and will return a list
#' of length equal to n_cores. This can be used to split up an  object for use in parallel processing such
#' as mclapply
#' @param length the length of an object to split (nrows, list length, etc)
#' @param cores the number of cores available on your machine. Typically \code{parallel::detectCores() - 1}.
#' @return a list of length equal to the value of \code{cores}
#' @export split_work
split_work <-
  function(length, cores){
    # Define a sequence of 0 to length, by cores
    # This is then used to generate vectors of the work split
    split <-
      seq(from = 0,
          to = length,
          by = round(length / cores))

    # Ensure the final split ends on the number of squares
    split[length(split)] <- length

    ind <- c(1:(length(split) - 1))
    # Generate vectors
    work_division <-
      lapply(ind,
             function(i) {
               (split[i] + 1):split[i + 1]
             })

    return(work_division)
  }
