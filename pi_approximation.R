
library(parallel)
library(ggplot2)

# Non parallel ------------------------------------------------------------

# Approx algorithm
approx_pi <- function(n, k = 1000){
  serie <- sapply(seq_len(n), function(x)
    1 / (x ^ 2))
  sum_serie <- cumsum(serie)
  
  # Chop first k
  sum_serie <- sum_serie[-c(1:k)]
  
  results <- sqrt(6 * sum_serie) 
  error <- abs(results - pi)
  
  error
}

# With parallel processing ------------------------------------------------

# Same algorithm
approx_pi_parallel <- function(n, k = 1000) {
  # Set up a cluster
  cl <- makeCluster(detectCores() - 1) # Reserve one core for system processes
  
  # Vectorized computation over chunks
  parts <- parSapply(cl, seq_len(n), function(x) 1 / (x ^ 2))
  
  # Stop the cluster
  stopCluster(cl)
  
  sum_serie <- cumsum(parts)
  
  # Chop first 100
  sum_serie <- sum_serie[-c(1:k)]
  
  results <- sqrt(6 * sum_serie)
  error <- abs(results - pi)
  
  error
}

# Plot parallel -----------------------------------------------------------

n <- 1e6
k <- 1000

# Run the parallel function
errors <- approx_pi_parallel(n, k)

# Create a data frame for plotting
df <- data.frame(x = (k+1):n, y = errors)

# Generate the plot
ggplot(df, aes(x = x, y = y)) +
  geom_line(color = "blue") +
  scale_x_log10() +
  labs(title = paste("Approximation Error of Pi Over ", n, " Iterations"),
       x = "Iteration",
       y = "Absolute Error") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5)) 

# Compare both ------------------------------------------------------------

compare_both <- function(n){
  # Measure time for sequential function
  time_sequential <- system.time({
    result_sequential <- approx_pi(n)
  })
  
  # Measure time for parallel function
  time_parallel <- system.time({
    result_parallel <- approx_pi_parallel(n)
  })
  
  # Print the results
  performance <- time_sequential["elapsed"] / time_parallel["elapsed"] 
  cat("Parallel function is", round(performance, 1), "times faster.")
  
  # Return a list containing both times for further analysis if required
  result <- list(sequential = time_sequential, parallel = time_parallel)
  result
}

# Main result -------------------------------------------------------------

# Small n 
compare_both(1e4)

# Big n
compare_both(1e8)


