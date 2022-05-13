import networkx as nx
import matplotlib.pyplot as plt
import sys
sys.path.append('../')

class GN:
    def __init__(self, G):
        self.G_copy = G.copy()
        self.G = G
        self.partition = [[n for n in G.nodes()]]
        self.all_Q = []
        self.max_Q = 0.0
        self.partitionNum = len([list(c) for c in list(nx.connected_components(self.G))])
		
    #Using max_Q to divide communities 
    def run(self):
        # append 0 if the graph alreade has partition initially
        # cont = 0
        if self.partitionNum > 1:
            for num in range(1,self.partitionNum):
                print(num)
                self.all_Q.append(0.0)
        self.all_Q.append(self.cal_Q([list(c) for c in list(nx.connected_components(self.G))], self.G_copy))
        #Until there is no edge in the graph
        while len(self.G.edges()) != 0:
            print("Edges number : " + str(len(self.G.edges())))
			#Find the most betweenness edge
            edge = max(nx.edge_betweenness_centrality(self.G).items(),key=lambda item:item[1])[0]
			#Remove the most betweenness edge
            self.G.remove_edge(edge[0], edge[1])
			#List the the connected nodes
            components = [list(c) for c in list(nx.connected_components(self.G))]

            # if cont > 20:
            #     print(nx.edge_betweenness_centrality(self.G))
            #     print(nx.edge_betweenness_centrality(self.G).items())
            #     print(list(nx.connected_components(self.G)))
            #     print(components)
                #break
            if len(components) != self.partitionNum :
				#compute the Q
                self.partitionNum = len(components)
                
                cur_Q = self.cal_Q(components, self.G_copy)
                print(self.partitionNum,cur_Q)
                #print(cur_Q,components,self.partition)
                #if cur_Q not in self.all_Q:
                self.all_Q.append(cur_Q)
                if cur_Q > self.max_Q:
                    self.max_Q = cur_Q
                    self.partition = components
            # cont += 1
            
        print('-----------the Max Q and divided communities-----------')
        print('The number of Communites:', len(self.partition))
        print("Communites:", self.partition)
        print('Max_Q:', self.max_Q)
        return self.partition, self.all_Q, self.max_Q
    
	#Dividing communities by number
    def run_n(self, k):
        while len(self.G.edges()) != 0:
            edge = max(nx.edge_betweenness_centrality(self.G).items(),key=lambda item:item[1])[0]
            self.G.remove_edge(edge[0], edge[1])
            components = [list(c) for c in list(nx.connected_components(self.G))]
            if len(components) <= k:
                cur_Q = self.cal_Q(components, self.G_copy)
                if cur_Q not in self.all_Q:
                    self.all_Q.append(cur_Q)
                if cur_Q > self.max_Q:
                    self.max_Q = cur_Q
                    self.partition = components
        print('-----------Using number to divide communities and the Q-----------')
        print('The number of Communites', len(self.partition))
        print("Communites: ", self.partition)
        print('Max_Q: ', self.max_Q)
        return self.partition, self.all_Q, self.max_Q
    
    #the process of divding the network
    #Return a list containing the result of each division, until each node is a community
    def run_to_all(self):
        divide = []
        all_Q = []
        while len(self.G.edges()) != 0:
            edge = max(nx.edge_betweenness_centrality(self.G).items(),key=lambda item:item[1])[0]
            self.G.remove_edge(edge[0], edge[1])
            components = [list(c) for c in list(nx.connected_components(self.G))]
            if components not in divide:
                divide.append(components)
            cur_Q = self.cal_Q(components, self.G_copy)
            if cur_Q not in all_Q:
                all_Q.append(cur_Q)
        return divide, all_Q
       
	#Drawing the graph of Q and divided communities
    def draw_Q(self):
        plt.plot([x for x in range(1,len(self.all_Q)+1)],self.all_Q)
        my_x_ticks = [x for x in range(1,len(self.all_Q)+1)]
        plt.xticks(my_x_ticks)
        plt.axvline(len(self.partition),color='black',linestyle="--")
        #plt.axvline(2, color='black',linestyle="--")
        #plt.axhline(self.all_Q[3],color='red',linestyle="--")
        plt.show()
    
	#Computing the Q
    def cal_Q(self,partition,G):
        L = len(G.edges(None, False))
        ds = []
        ls = []
    
        for community in partition:
            t = 0.0
            for node in community:
                t += len([x for x in G.neighbors(node)])
            ds.append(t/(2*L))
        
        for community in partition:
            t = 0.0
            for i in range(len(community)):
                for j in range(len(community)):
                    if(G.has_edge(community[i], community[j])):
                        t += 1.0
            ls.append(t/(2*L))
        
        q = 0.0
        for li,di in zip(ls,ds):
            q += (li - di**2) 
        return q 
    
    def add_group(self):
        num = 0
        nodegroup = {}
        for partition in self.partition:
            for node in partition:
                nodegroup[node] = {'group':num}
            num = num + 1  
        nx.set_node_attributes(self.G_copy, nodegroup)
        
    def to_gml(self):
        nx.write_gml(self.G_copy, 'outputofGN.gml')
        
if __name__ == '__main__':
    G=nx.read_gml('../datasets/input.gml',label='id') #Using max_Q to divide communities 
    
    G_copy = G.copy()
    algorithm = GN(G)
    (partition, all_Q, max_Q) = algorithm.run()
    print(partition)
    algorithm.add_group()
    algorithm.to_gml()
    color = [0] * len(G.nodes())
    for index in range(len(partition)):
        for item in partition[index]:
            color[item-1] = index
    print(color)
    nx.draw(G_copy,node_color = color,edge_color = 'r',with_labels = True)
    plt.show()  