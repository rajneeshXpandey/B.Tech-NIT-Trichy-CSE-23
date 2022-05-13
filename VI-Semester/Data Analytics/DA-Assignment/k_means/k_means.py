import numpy as np

import initialization_methods as init_methods

class KMeans:

    def __init__(self, n_clusters = 3, tolerance = 0.01, max_iter = 100, runs = 1, init_method="forgy"):
        self.n_clusters = n_clusters
        self.tolerance = tolerance
        self.cluster_means = np.zeros(n_clusters)
        self.max_iter = max_iter
        self.init_method = init_method

        # There is no need to run the algorithm multiple times if the 
        # initialization method is not a random process
        self.runs = runs if init_method == 'forgy' else 1
        
    def fit(self, X):
        row_count, col_count = X.shape
        
        X_values = self.__get_values(X)
        
        X_labels = np.zeros(row_count)
        
        costs = np.zeros(self.runs)
        all_clusterings = []

        for i in range(self.runs):
            cluster_means =  self.__initialize_means(X_values, row_count)

            for _ in range(self.max_iter):            
                previous_means = np.copy(cluster_means)
                
                distances = self.__compute_distances(X_values, cluster_means, row_count)
            
                X_labels = self.__label_examples(distances)
            
                cluster_means = self.__compute_means(X_values, X_labels, col_count)

                clusters_not_changed = np.abs(cluster_means - previous_means) < self.tolerance
                if np.all(clusters_not_changed) != False:
                    break
            
            X_values_with_labels = np.append(X_values, X_labels[:, np.newaxis], axis = 1)
            
            all_clusterings.append( (cluster_means, X_values_with_labels) )
            costs[i] = self.__compute_cost(X_values, X_labels, cluster_means)
        
        best_clustering_index = costs.argmin()

        self.cost_ = costs[best_clustering_index]
        
        return all_clusterings[best_clustering_index]
        
    def __initialize_means(self, X, row_count):
        if self.init_method == 'forgy':
            return init_methods.forgy(X, row_count, self.n_clusters)
        elif self.init_method == 'maximin':
            return init_methods.maximin(X, self.n_clusters)
        elif self.init_method == 'macqueen':
            return init_methods.macqueen(X, self.n_clusters)
        elif self.init_method == 'var_part':
            return init_methods.var_part(X, self.n_clusters)
        else:
            raise Exception('The initialization method {} does not exist or not implemented'.format(self.init_method))
        
    def __compute_distances(self, X, cluster_means, row_count):
        distances = np.zeros((row_count, self.n_clusters))
        for cluster_mean_index, cluster_mean in enumerate(cluster_means):
            distances[:, cluster_mean_index] = np.linalg.norm(X - cluster_mean, axis = 1)
            
        return distances
    
    def __label_examples(self, distances):
        return distances.argmin(axis = 1)
    
    def __compute_means(self, X, labels, col_count):
        cluster_means = np.zeros((self.n_clusters, col_count))
        for cluster_mean_index, _ in enumerate(cluster_means):
            cluster_elements = X [ labels == cluster_mean_index ]
            if len(cluster_elements):
                cluster_means[cluster_mean_index, :] = cluster_elements.mean(axis = 0)
                
        return cluster_means
    
    def __compute_cost(self, X, labels, cluster_means):
        cost = 0
        for cluster_mean_index, cluster_mean in enumerate(cluster_means):
            cluster_elements = X [ labels == cluster_mean_index ]
            cost += np.linalg.norm(cluster_elements - cluster_mean, axis = 1).sum()
        
        return cost
            
    def __get_values(self, X):
        if isinstance(X, np.ndarray):
            return X
        return np.array(X)
        
        
        