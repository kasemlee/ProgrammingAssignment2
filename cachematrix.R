# Author: Kasem Leekumjorn
# Matrix inversion is usually a costly computation and there may be some 
# benefit to caching the inverse of a matrix rather than compute it repeatedly.
# The following two functions demonstrate how the scoping rules work and how 
# they can be manipulated to preserve state inside of an R object. They also 
# show the uses of the special assignment operator "<<-".

# For this assignment, assume that the matrix supplied is always invertible.

# This function creates a special "matrix" object that can cache its inverse.
# x = The matrix to be inversed
# m = The inverse matrix (The result)
# Sample call: cm<-makeCacheMatrix(matrix(c(1,2,3,4), nrow=2, ncol=2))
makeCacheMatrix <- function(x = matrix()) {
    # Initialize the inverse matrix to NULL during the first call to 
    # makeCacheMatrix.
    # This is needed because ig getinverse() is called immediately after
    # the makeCacheMatrix function is constructed, without a call to setinverse.
    # We know we must first get the inverse of the matrix in cacheSolve.  
    m <- NULL
    
    # This function sets a new value for the underlying matrix
    # this invalidates the cached inverse matrix, m
    set <- function(y) {
        # we use the <<- operator to set the value of x and m because we want 
        # to modify x and m defined in the enclosing environment (created 
        # when makeCacheMatrix was first called), not in the environment local 
        # to set(), in which x and m are undefined.
        x <<- y
        
        # We must reset m to NULL since we are modifying the underlying
        # matrix and the cached value is no longer the valid.
        m <<- NULL
    }

    # This function returns the underlying matrix to be inveresed
    # In R the return value of a function is the last statement.
    # all of these functions could have been written as:
    # return(x), etc... as the last line.
    # Sample call: cm$get()
    get <- function() 
        x
    
    # setinverse should be used carefully as what we pass to this function will
    # be what the setinverse returns, which might not be the real inverse of 
    # the underlying matrix x if we call this function directly. (Not called 
    # after calling solve() in cashSolve).
    setinverse <- function(inverse) 
        m <<- inverse
    
    # Returns the inverse matrix.  Will be null if setmean has not been called 
    # or if set() is called after the last call to setinverse.
    # Sample Call: cm$getinverse()
    getinverse <- function()        
        m
    
    # Here is a technique used to expose objects (ig functions, variables) as 
    # public.
    # In this case the return value of the makeCacheMatrix function is a list
    # of functions (and variables if we wish) that we want to expose
    # as public.  these are accessed with the $ operator.  Any variables
    # declared inside makeCacheMatrix but not exported as part of this list
    # are private...they are inaccessible to any caller of makeCacheMatrix.
    list(set = set, get = get,
         setinverse = setinverse,
         getinverse = getinverse)
}


# This function computes the inverse of the special "matrix" returned by 
# makeCacheMatrix above. If the inverse has already been calculated (and 
# the matrix has not changed), then cacheSolve should retrieve the inverse 
# from the cache.
cacheSolve <- function(x) {
    # Return a matrix that is the inverse of 'x'
    m <- x$getinverse()
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    
    # Call get() to get the underlying matrix to be inversed
    data <- x$get()
    
    # Computing the inverse of a square matrix can be done with the solve 
    # function in R. For example, if X is a square invertible matrix, then 
    # solve(X) returns its inverse.
    m <- solve(data)
    
    # Now set the inverse matrix in x so we cache it and dont need to needlessly
    # recompute it.
    x$setinverse(m)
    
    # Return the caching inverse matrix.
    m
}
