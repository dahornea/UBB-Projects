import math
from random import randrange
from copy import deepcopy
from errors import *
import sys

def read_file(file_path):
    file = open(file_path, "r")
    n, m = map(int, file.readline().split())
    g = Graph(n)
    for _ in range(m):
        vertex1, vertex2, edge_cost = map(int, file.readline().split())
        g.add_edge(vertex1, vertex2, edge_cost)
    file.close()
    return g

def write_file(file_path, g):
    file = open(file_path, "w")
    file.write("{0} {1}\n".format(g.count_vertices(), g.count_edges()))
    for node in g.vertices_iterator():
        for neighbour in g.neighbours_iterator(node):
            file.write("{0} {1} {2}\n".format(node, neighbour, g.get_edge_cost(node, neighbour)))
    file.close()


def random_graph(vertices_no, edges_no):
    g = Graph()
    for i in range(vertices_no):
        g.add_vertex(i)
    for j in range(edges_no):
        vertex1 = randrange(vertices_no)
        vertex2 = randrange(vertices_no)
        while g.is_edge(vertex1, vertex2):
            vertex1 = randrange(vertices_no)
            vertex2 = randrange(vertices_no)
        g.add_edge(vertex1, vertex2, randrange(1000000))


class Graph:
    def __init__(self, n=0, m=0):
        self._vertices = set()
        self._neighbours = dict()
        self._transpose = dict()
        self._cost = dict()
        for i in range(n):
            self.add_vertex(i)
        for j in range(m):
            vertex1 = randrange(n)
            vertex2 = randrange(n)
            while self.is_edge(vertex1, vertex2):
                vertex1 = randrange(n)
                vertex2 = randrange(n)
            self.add_edge(vertex1, vertex2, randrange(1000000))

    def vertices_iterator(self):
        """
        :return: Iterator for the vertices
        """
        for vertex in self._vertices:
            yield vertex

    def neighbours_iterator(self, vertex):
        """
        :return: Iterator for the neighbours of a vertex
        """
        if not self.is_vertex(vertex):
            raise VertexError("Invalid vertex")
        for neighbour in self._neighbours[vertex]:
            yield neighbour

    def transpose_iterator(self, vertex):
        """
        :return: Iterator for the inbound neighbours of a vertex
        """
        if not self.is_vertex(vertex):
            raise VertexError("Invalid vertex")
        for neighbour in self._transpose[vertex]:
            yield neighbour

    def edges_iterator(self):
        """
        :return: Iterator for the edges
        """
        for key, value in self._cost.items():
            yield key[0], key[1], value

    def is_vertex(self, vertex):
        """
        Check if a vertex belongs to the graph
        """
        return vertex in self._vertices

    def is_edge(self, vertex1, vertex2):
        """
        Check if the edge of vertex1 and vertex2 belongs to the graph
        """
        return vertex1 in self._neighbours and vertex2 in self._neighbours[vertex1]

    def count_vertices(self):
        """
        :return: Number of vertices in the graph
        """
        return len(self._vertices)

    def count_edges(self):
        """
        :return: Number of edges in the graph
        """
        return len(self._cost)

    def in_degree(self, vertex):
        """
        :return: Number of edges with endpoint vertex
        """
        if vertex not in self._transpose:
            raise VertexError("Invalid vertex")
        return len(self._transpose[vertex])

    def out_degree(self, vertex):
        """
        :return: Number of edges with startpoint vertex
        """
        if vertex not in self._neighbours:
            raise VertexError("Invalid vertex")
        return len(self._neighbours[vertex])

    def get_edge_cost(self, vertex1, vertex2):
        """
        :return: The cost of an edge
        """
        if (vertex1, vertex2) not in self._cost:
            raise EdgeError("Invalid edge")
        return self._cost[(vertex1, vertex2)]

    def set_edge_cost(self, vertex1, vertex2, new_cost):
        """
        Set the cost of an edge
        """
        if (vertex1, vertex2) not in self._cost:
            raise EdgeError("Invalid edge")
        self._cost[(vertex1, vertex2)] = new_cost

    def add_vertex(self, vertex):
        """
        Add a vertex to the graph
        """
        if self.is_vertex(vertex):
            raise VertexError("Vertex already exixts")
        self._vertices.add(vertex)
        self._neighbours[vertex] = set()
        self._transpose[vertex] = set()

    def add_edge(self, vertex1, vertex2, edge_cost = 0):
        """
        Add an edge to the graph
        """
        if self.is_edge(vertex1, vertex2):
            raise EdgeError("Edge already exists")
        if not self.is_vertex(vertex1) or not self.is_vertex(vertex2):
            raise EdgeError("The vertices are invalid")
        self._neighbours[vertex1].add(vertex2)
        self._transpose[vertex2].add(vertex1)
        self._cost[(vertex1, vertex2)] = edge_cost

    def remove_edge(self, vertex1, vertex2):
        """
        Remove edge from the graph
        """
        if not self.is_edge(vertex1, vertex2):
            raise EdgeError("Invalid edge")
        del self._cost[(vertex1, vertex2)]
        self._neighbours[vertex1].remove(vertex2)
        self._transpose[vertex2].remove(vertex1)

    def remove_vertex(self, vertex):
        """
        Remove a vertex from the graph
        """
        if not self.is_vertex(vertex):
            raise VertexError("Vertex doesn't exist")
        to_remove = []
        for node in self._neighbours[vertex]:
            to_remove.append(node)
        for node in to_remove:
            self.remove_edge(vertex, node)
        to_remove = []
        for node in self._transpose[vertex]:
            to_remove.append(node)
        for node in to_remove:
            self.remove_edge(node, vertex)
        del self._neighbours[vertex]
        del self._transpose[vertex]
        self._vertices.remove(vertex)

    def copy(self):
        """
        :return: Deepcopy of the graph
        """
        return deepcopy(self)


    def findLowestLengthPathBFS(self, start, end):
        '''
        find the lowest length path between start and end, in graph, using a forward BFS from the starting vertex
        if start or end are not valid vertices in the graph, we raise VertexError
        if there is no path between start and end, we raise ValueError
        :param start: the starting vertex
        :param end: the ending vertex
        :return: returns the path from start to end if it exists, otherwise it raises ValueError
        '''
        # if the start or end are not valid, we raise ValueError
        if not self.is_vertex(start) or not self.is_vertex(end):
            raise VertexError("invalid start / end!")
        # we remember all the visited nodes
        visited = []
        # we remember all the possible paths in a queue
        queue = [[start]]
        if start == end:
            return []  # case when start = end, the path is empty
        while queue:  # while we have paths unchecked
            # we pop the first path from the queue
            path = queue.pop(0)
            # we get the last node in the path
            vertex = path[-1]
            # if the vertex is not visited, for each of its outbound vertex, we create a new path from the
            # previous one by adding the outbound vertex. If the outbound vertex coincides with the end vertex
            # we return the path we just created
            if vertex not in visited:
                outboundVertices = self._neighbours[vertex]
                for outbound in outboundVertices:
                    newPath = list(path)
                    newPath.append(outbound)
                    queue.append(newPath)
                    if outbound == end:
                        return newPath
                # we add the vertex to the list of visited vertices
                visited.append(vertex)
        # if we got there means we've visited all vertices that can be visited from start, and we couldn't find
        # a path between start and end, so we raise a ValueError
        raise ValueError("No path between start and end")

    def min_key(self, key, mst_set):
        min_k = sys.maxsize

        min_index = -1

        for v in self.vertices_iterator():
            if v not in mst_set and key[v] < min_k:
                min_k = key[v]
                min_index = v

        return min_index

    def get_mst_prim(self):
        key = [sys.maxsize] * self.count_vertices()
        parent = [None] * self.count_vertices()
        key[0] = 0

        mst_set = set()

        for count in range(self.count_vertices()):
            u = self.min_key(key, mst_set)

            mst_set.add(u)

            for v in self.vertices_iterator():
                if self.is_edge(u, v) and v not in mst_set and key[v] > self.get_edge_cost(u, v):
                    key[v] = self.get_edge_cost(u, v)
                    parent[v] = u

        return mst_set, parent

    def get_minimum_cost_hamiltonian(self, start, visited):
        #The array will keep track of the already visited vertices and form the needed cycle
        visited.append(start)
        v = start
        mincost = 0
        #we go through every vertex left unvisited
        while(len(visited) != self.count_vertices()):
            mini = math.inf
            x = -1
            #we go through the neighbours of the current vertex
            for i in self.neighbours_iterator(v):
                if i not in visited and self.get_edge_cost(v, i) < mini:
                    mini = self.get_edge_cost(v, i)
                    x = i
            #this is only for the last edge
            if len(visited) == self.count_vertices()-1 and self.is_edge(v, start) and self.get_edge_cost(v, start)<mini:
                mini = self.get_edge_cost(v, start)
                x = start
            #if we find the next vertex
            if(x != -1):
                mincost += mini
                visited.append(x)
                v = x
            #we find another vertex
            else:
                for i in self.vertices_iterator():
                    if i not in visited:
                        v=i
                        break
        #complete the cycle
        if(v!=start):
            visited.append(start)
            mincost += self.get_edge_cost(v, start)
        return mincost