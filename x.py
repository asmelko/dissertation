import numpy as np


# generate a random 2d matrix
d = 3

X = np.random.randint(1, 100, (10, d))

# calculate covariance matrix
cov = np.cov(X)

def cov_matrix(X):
    # calculate the mean of each column
    means = np.mean(X.T, axis=1)
    print(means)
    cov_matrix = np.zeros((d, d))
    for i in range(d): 
        for j in range(d):
            cov_matrix[i, j] = np.mean((X[:, i] - means[i]) * (X[:, j] - means[j]))
    return cov_matrix

def cov_matrix2(X, Y, covX, covY):
    # calculate the mean of each column
    meansX = np.mean(X.T, axis=1)
    meansY = np.mean(Y.T, axis=1)
    cov_matrix = np.zeros((d, d))
    for i in range(d): 
        for j in range(d):
            cov_matrix[i, j] = covX[i, j] + covY[i, j] + (meansX[i] - meansY[i]) * (meansX[j] - meansY[j]) * (1/4) + (meansY[i] - meansX[i]) * (meansY[j] - meansX[j]) * (1/4)
    return cov_matrix / 2


# print(cov)
print(X.shape)
print(X)
print(X[:,1])
print(cov_matrix(X))

X = np.random.randint(1, 100, (10, d))
Y = np.random.randint(1, 100, (10, d))
covX = cov_matrix(X)
covY = cov_matrix(Y)
print(cov_matrix2(X, Y, covX, covY))
Z = np.concatenate((X, Y), axis=0)
print(Z.shape)
print(cov_matrix(Z))

meansX = np.mean(X.T, axis=1)
a = 0
for i in range(X.shape[0]):
    a += (X[i, 0] - meansX[0]) * 10
print(a)