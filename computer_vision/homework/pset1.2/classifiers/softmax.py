import numpy as np
from random import shuffle

def softmax_loss_naive(W, X, y, reg):
    """
    Softmax loss function, naive implementation (with loops)
    
    Inputs have dimension D, there are C classes, and we operate on minibatches
    of N examples.
    
    Inputs:
    - W: A numpy array of shape (D, C) containing weights.
    - X: A numpy array of shape (N, D) containing a minibatch of data.
    - y: A numpy array of shape (N,) containing training labels; y[i] = c means
      that X[i] has label c, where 0 <= c < C.
    - reg: (float) regularization strength
    
    Returns a tuple of:
    - loss as single float
    - gradient with respect to weights W; an array of same shape as W
    """
    # Initialize the loss and gradient to zero.
    loss = 0.0
    dW = np.zeros_like(W)

    #############################################################################
    # TODO: Compute the softmax loss and its gradient using explicit loops.     #
    # Store the loss in loss and the gradient in dW. If you are not careful     #
    # here, it is easy to run into numeric instability. Don't forget the        #
    # regularization!                                                           #
    #############################################################################
    lossarr = np.dot(X, W)
    for i in range(lossarr.shape[0]):
        maxval = lossarr[i].max()
        expval = [np.exp(j-maxval) for j in lossarr[i]]
        lossarr[i] = [k/sum(expval) for k in expval]
        loss -= np.log(lossarr[i][y[i]])
    for i in range(X.shape[0]):
        li = np.zeros_like(W)
        for j in range(W.shape[1]):
            if j == y[i]:
                li[:,j] = (lossarr[i, y[i]]-1)*np.transpose(X[i])
            else:
                li[:,j] = lossarr[i,j]*np.transpose(X[i])
        dW += li
    dW = dW/X.shape[0] + reg*W
    loss = loss/X.shape[0] + 0.5*reg*(np.linalg.norm(W)**2)
    #############################################################################
    #                          END OF YOUR CODE                                 #
    #############################################################################
    
    return loss, dW


def softmax_loss_vectorized(W, X, y, reg):
    """
    Softmax loss function, vectorized version.
    
    Inputs and outputs are the same as softmax_loss_naive.
    """
    # Initialize the loss and gradient to zero.
    loss = 0.0
    dW = np.zeros_like(W)
    
    #############################################################################
    # TODO: Compute the softmax loss and its gradient using no explicit loops.  #
    # Store the loss in loss and the gradient in dW. If you are not careful     #
    # here, it is easy to run into numeric instability. Don't forget the        #
    # regularization!                                                           #
    #############################################################################
    lossarr = np.dot(X, W)
    lossarr = np.exp(lossarr - np.max(lossarr, axis=1, keepdims=True))
    lossarr /= np.sum(lossarr, axis=1, keepdims=True)
    loss = -np.sum(np.log(lossarr[np.arange(X.shape[0]), y]))/X.shape[0] + 0.5*reg*(np.linalg.norm(W)**2)
    yo = np.zeros((y.shape[0],W.shape[1]))
    for i,val in enumerate(y):
        yo[i,val] = 1
    dW = np.dot(np.transpose(X), (lossarr - yo))/X.shape[0] + reg*W
    #############################################################################
    #                          END OF YOUR CODE                                 #
    #############################################################################
    
    return loss, dW

