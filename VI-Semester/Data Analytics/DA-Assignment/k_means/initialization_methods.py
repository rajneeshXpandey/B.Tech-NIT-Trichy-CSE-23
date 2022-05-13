import numpy as np

def forgy(X, row_count, n_clusters):
    return X [ np.random.choice(row_count, size=n_clusters, replace=False) ]

def macqueen(X, n_clusters):
    return X [:n_clusters]

def maximin(X, n_clusters):
    X_ = np.copy(X)
    initial_centers = np.zeros((n_clusters, X_.shape[1]))
    X_norms = np.linalg.norm(X_, axis = 1)
    X_norms_max_i = X_norms.argmax()
    initial_centers[0] = X_[X_norms_max_i]
    X_ = np.delete(X_, X_norms_max_i, axis = 0)
    for i in range(1, n_clusters):
        distances = np.zeros((X_.shape[0], i))
        for index, center in enumerate(initial_centers[:i]):
            distances[:, index] = np.linalg.norm(X_ - center, axis = 1)

        max_min_index = distances.min(axis = 1).argmax()

        initial_centers[i] = X_[max_min_index]
        X_ = np.delete(X_, max_min_index, axis = 0)
        
    return initial_centers
        

def var_part(X, n_clusters):
    X_ = np.append(X, np.zeros(X.shape[0])[:, np.newaxis], axis = 1)
    initial_centers = np.zeros((n_clusters, X.shape[1]))

    cluster_i = 1
    while cluster_i != n_clusters:
        within_clusters_sum_squares = np.zeros(cluster_i)
        for j in range(cluster_i):
            cluster_members = X_[ X_[:, -1] == j ]
            cluster_mean = cluster_members.mean(axis = 0)
            within_clusters_sum_squares[j] = np.linalg.norm(cluster_members - cluster_mean, axis = 1).sum()

        # Cluster which has greatest SSE
        max_sse_i = within_clusters_sum_squares.argmax()
        X_max_sse_i = X_[:, -1] == max_sse_i
        X_max_sse = X_ [ X_max_sse_i ]
        
        variances, means = X_max_sse.var(axis = 0), X_max_sse.mean(axis = 0)
        max_variance_i = variances.argmax()
        max_variance_mean = means [ max_variance_i ]

        X_smaller_mean = X_max_sse[:, max_variance_i] <= max_variance_mean
        X_greater_mean = X_max_sse[:, max_variance_i] > max_variance_mean

        initial_centers[max_sse_i] = X_max_sse [ X_smaller_mean ].mean(axis = 0)[:-1]
        initial_centers[cluster_i] = X_max_sse [ X_greater_mean ].mean(axis = 0)[:-1]

        X_[ (X_max_sse_i) & (X_ [:, max_variance_i] <= max_variance_mean), -1] = cluster_i
        X_[ (X_max_sse_i) & (X_ [:, max_variance_i] > max_variance_mean), -1] = max_sse_i

        cluster_i += 1  

    return initial_centers
