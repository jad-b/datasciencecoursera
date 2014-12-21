m <- matrix(rnorm(16), 4)

test.cachematrix <- function() {
  cm <- makeCacheMatrix()
  # Assert we use a default empty matrix
  checkEquals(matrix(), cm$get())
  # Assert we don't set the inverse
  checkEquals(NULL, cm$getInverse())
  # Assert we use a given matrix
  cm <- makeCacheMatrix(m)
  checkEquals(m, cm$get())
  # Assert inverse is still unset
  checkEquals(NULL, cm$getInverse())
}

test.cachesolve <- function() {
  cm <- makeCacheMatrix(m)
  inv <- solve(m)
  # Predicate: We have not yet set 
  # Assert we get back the inverse
  checkEquals(inv, cacheSolve(cm))
  # Assert we cache the inverse
  checkEquals(inv, cm$getInverse())
}