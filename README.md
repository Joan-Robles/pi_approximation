# Comparison of Sequential and Parallel Programming: Basel Problem Approximation

## Overview

This project compares the performance of sequential and parallel programming by approximating \( \pi \) using the Basel problem. The Basel problem involves calculating the sum of the reciprocals of squares of natural numbers, which converges to \( \pi^2/6 \). We use R's `parallel` package to demonstrate how parallel processing can speed up computations significantly compared to a sequential approach.

## Parallel Processing Context

Parallel processing is a method where multiple calculations or processes are carried out simultaneously, leveraging multi-core CPU architectures. This is particularly useful for computationally heavy tasks, such as summing a large number of terms in a series. By dividing the work across several CPU cores, the runtime can be reduced, making the process much more efficient. In this project, parallel programming is achieved by distributing the calculation of terms in the Basel problem series across multiple cores.

## Procedure Summary

1. **Sequential Approximation**: 
   The sequential function calculates the sum of the series using a loop, adding each term one at a time and calculating the approximation of \( \pi \).
   
2. **Parallel Approximation**:
   The parallel function divides the series calculation across multiple CPU cores, using R’s `parSapply` function from the `parallel` package to distribute the workload.

3. **Performance Comparison**: 
   The script includes a comparison function that measures and compares the time taken by both approaches to execute the task for a given number of iterations.

## Functions

### 1. `approx_pi(n, k = 1000)`
- **Description**: Sequential approximation of \( \pi \) based on the Basel problem.
- **Parameters**:
  - `n`: Number of iterations for the series.
  - `k`: Number of initial terms to be discarded (defaults to 1000).
- **Output**: Absolute error between the approximation and the actual value of \( \pi \).

### 2. `approx_pi_parallel(n, k = 1000)`
- **Description**: Parallel approximation of \( \pi \) using multiple CPU cores.
- **Parameters**:
  - `n`: Number of iterations for the series.
  - `k`: Number of initial terms to be discarded (defaults to 1000).
- **Output**: Absolute error between the approximation and the actual value of \( \pi \).

### 3. `compare_both(n)`
- **Description**: Compares the execution time of both sequential and parallel methods.
- **Parameters**:
  - `n`: Number of iterations for the comparison.
- **Output**: Prints the speedup factor of the parallel function compared to the sequential one.

## How to Run

1. Clone the repository:
   ```bash
   git clone <repo-url>
   ```
2. Open the R script in an R environment.
3. Run the script to execute the comparisons between sequential and parallel methods.
4. For graphical output, ensure `ggplot2` is installed. Install it using:
   ```R
   install.packages("ggplot2")
   ```

## Example
To compare the performance for different values of `n`, use the `compare_both(n)` function:
```R 
compare_both(1e4)  # Small number of iterations
compare_both(1e8)  # Large number of iterations
```

## Dependencies
- **R version**: 3.6+
- **Libraries**:
  - `parallel`
  - `ggplot2`

## Results and Conclusion

This project demonstrates that parallel processing can significantly reduce computation time for large iterative calculations. The performance improvement will depend on the number of CPU cores available and the size of the problem being solved.

By dividing the task of calculating the Basel problem series across multiple cores, the parallel version of the function can be significantly faster than the sequential one, as shown in the performance comparison.

