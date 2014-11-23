# Sample Unit Tests
# > setwd("c:/coursera/programmingassignment2")
# > source("cachematrix.r")
# > cm<-makeCacheMatrix(matrix(c(1,2,3,4), nrow=2, ncol=2))
# > cm$get()
# [,1] [,2]
# [1,]    1    3
# [2,]    2    4
# > cm$getinverse()
# NULL
# > cacheSolve(cm)
# [,1] [,2]
# [1,]   -2  1.5
# [2,]    1 -0.5
# > cacheSolve(cm)
# getting cached data
# [,1] [,2]
# [1,]   -2  1.5
# [2,]    1 -0.5
# > cm$getinverse()
# [,1] [,2]
# [1,]   -2  1.5
# [2,]    1 -0.5
# > cm$set(matrix(c(0,5,10,345), nrow=2, ncol=2))
# > cm$get()
# [,1] [,2]
# [1,]    0   10
# [2,]    5  345
# > cm$getinverse()
# NULL
# > cacheSolve(cm)
# [,1] [,2]
# [1,] -6.9  0.2
# [2,]  0.1  0.0
# > cm$setinverse(matrix(c(20,54,15,99), nrow=2, ncol=2))
# > cm$getinverse()
# [,1] [,2]
# [1,]   20   15
# [2,]   54   99
# > cm$get()
# [,1] [,2]
# [1,]    0   10
# [2,]    5  345
# > cm$getinverse()
# [,1] [,2]
# [1,]   20   15
# [2,]   54   99
# > cacheSolve(cm)
# getting cached data
# [,1] [,2]
# [1,]   20   15
# [2,]   54   99
# > cm$set(matrix(c(0,5,10,345), nrow=2, ncol=2))
# > cm$getinverse()
# NULL
# > cacheSolve(cm)
# [,1] [,2]
# [1,] -6.9  0.2
# [2,]  0.1  0.0

setwd("c:/coursera/programmingassignment2")
source("cachematrix.r")
cm<-makeCacheMatrix(matrix(c(1,2,3,4), nrow=2, ncol=2))
cm$get()
cm$getinverse()
cacheSolve(cm)
cacheSolve(cm)
cm$getinverse()
cm$set(matrix(c(0,5,10,345), nrow=2, ncol=2))
cm$get()
cm$getinverse()
cacheSolve(cm)
cm$setinverse(matrix(c(20,54,15,99), nrow=2, ncol=2))
cm$getinverse()
cm$get()
cm$getinverse()
cacheSolve(cm)
cm$set(matrix(c(0,5,10,345), nrow=2, ncol=2))
cm$getinverse()
cacheSolve(cm)
