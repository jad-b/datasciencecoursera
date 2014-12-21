# cachematrix.R
# =============
# Functions for caching matrix inversions.
# 
# `makeCacheMatrix` takes a matrixa and returns a list with a get/set 
# interface. Using this interface makes sure the underlying matrix and its 
# cached inversion stay consistent. 
#
# `cacheSolve` take the wrapped matrix object returned by `makeCacheMatrix` 
# and uses the provided get/set interface to return the matrix's inverse.
# 
# To Test:
#   `source('assn2_test.R')`

makeCacheMatrix <- function(x = matrix()) {
  # Cache a matrix inversion within a list
  # 
  # Args:
  #   x: The matrix to be cached, along with its inverse
  # 
  # Returns:
  #   A list with four function attributes:
  #     get: Return the original matrix
  #     set: Change the original matrix. Clears the cache.
  #     getInverse: Return the matrice's inverse.
  #     setInverse: Set the matrice's inverse.
  inverse <- NULL
  get <- function() x
  set <- function(y) {
    x <<- y           # Override the parent scope's matrix 
    inverse <<- NULL  # Null any existing cached inverse
  }
  getInverse <- function() inverse
  setInverse <- function(inv) inverse <<- inv 
  list(get=get,
       set=set,
       getInverse=getInverse,
       setInverse=setInverse)
}


cacheSolve <- function(x, ...) {
  # Return the inverse of a matrix. 
  # 
  # Caches the result of the inversion in the "special" matrix object passed
  # into the function.
  #
  # Args:
  #  x: Special cached "matrix" created by makeCacheMatrix
  #  ...: Optional parameters to pass along to solve()
  # 
  # Returns:
  #  The inverse of the "special" matrix, x.
  inverse <- x$getInverse()
  if(!is.null(inverse)) {
    message("Cached inversion found; returning")
    return(inverse)
  }
  mtrx <- x$get()           # Retrieve stored matrix
  inverse <- solve(mtrx, ...)  # Calculate the inverse
  x$setInverse(inverse)     # Save the inverse
  inverse                   # Return the inverse
}
