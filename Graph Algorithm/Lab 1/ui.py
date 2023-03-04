import graph
from graph import *

class UI:
    def __init__(self, graph_type):
        self.graph_type = graph_type
        self.graph = None
        self.graphs = []

    def empty_graph(self):
        self.graph = self.graph_type()
        print("Finished")

    def n_graph(self):
        n = input("Enter number of vertices:")
        try:
            self.graph = self.graph_type(int(n))
            print("Finished")
        except Exception as e:
            print(e)

    def m_graph(self):
        n = input("Enter number of vertices:")
        m = input("Enter number of edges:")
        try:
            self.graph = self.graph_type(int(n), int(m))
            print("Finished")
        except Exception as e:
            print(e)

    def add_vertex(self):
        n = input("Enter the vertex you want to add:")
        try:
            self.graph.add_vertex(int(n))
        except Exception as e:
            print(e)

    def add_edge(self):
        vertex1 = input("Enter the first vertex of the edge:")
        vertex2 = input("Enter the second vertex of the edge:")
        c = input("Enter the cost of the edge:")
        try:
            self.graph.add_edge(int(vertex1), int(vertex2), int(c))
        except Exception as e:
            print(e)

    def remove_vertex(self):
        n = input("Enter the vertex you want to remove:")
        try:
            self.graph.remove_vertex(int(n))
        except Exception as e:
            print(e)

    def remove_edge(self):
        vertex1 = input("Enter the first vertex of the edge:")
        vertex2 = input("Enter the second vertex of the edge:")
        try:
            self.graph.remove_edge(int(vertex1), int(vertex2))
        except Exception as e:
            print(e)

    def change_edge(self):
        vertex1 = input("Enter the first vertex of the edge:")
        vertex2 = input("Enter the second vertex of the edge:")
        c = input("Enter the cost of the edge:")
        try:
            self.graph.set_edge_cost(int(vertex1), int(vertex2), int(c))
        except Exception as e:
            print(e)

    def print_edge(self):
        vertex1 = input("Enter the first vertex of the edge:")
        vertex2 = input("Enter the second vertex of the edge:")
        try:
            print("The cost of the edge is {0}".format(self.graph.get_edge_cost(int(vertex1), int(vertex2))))
        except Exception as e:
            print(e)

    def in_degree(self):
        n = input("Enter the vertex for which you want to find the in degree:")
        try:
            print(self.graph.in_degree(int(n)))
        except Exception as e:
            print(e)

    def out_degree(self):
        n = input("Enter the vertex for which you want to find the out degree:")
        try:
            print(self.graph.out_degree(int(n)))
        except Exception as e:
            print(e)

    def count_vertices(self):
        print("There are {0} vertices".format(self.graph.count_vertices()))

    def count_edges(self):
        print("There are {0} edges".format(self.graph.count_edges()))

    def is_vertex(self):
        n = input("Enter the vertex you want to check:")
        try:
            if self.graph.is_vertex(int(n)):
                print("The vertex belongs to the graph")
            else:
                print("The vertex doesn't belong to the graph")
        except Exception as e:
            print(e)

    def is_edge(self):
        vertex1 = input("Enter the first vertex of the edge:")
        vertex2 = input("Enter the second vertex of the edge:")
        try:
            if self.graph.is_edge(int(vertex1), int(vertex2)):
                print("The edge exists.")
            else:
                print("The edge doesn't exist")
        except Exception as e:
            print(e)

    def print_vertex_list(self):
        for node in self.graph.vertices_iterator():
            print(node, end="")
        print()

    def print_neighbour_list(self):
        n = input("Enter the vertex you want to find neighbours for:")
        try:
            anyone = False
            for node in self.graph.neighbours_iterator(int(n)):
                print(node, end=" ")
                anyone = True
            if not anyone:
                print("Vertex {0} has no neighbours".format(n))
            else:
                print()
        except Exception as e:
            print(e)

    def print_transpose_list(self):
        n = input("Enter the vertex you want to find inbound neighbours for:")
        try:
            anyone = False
            for node in self.graph.transpose_iterator(int(n)):
                print(node, end=" ")
                anyone = True
            if not anyone:
                print("Vertex {0} has no inbound neighbours".format(n))
            else:
                print()
        except Exception as e:
            print(e)

    def print_edges(self):
        anyone = False
        for triple in self.graph.edges_iterator():
            print("Vertices {0}, {1} and cost {2}".format(triple[0], triple[1], triple[2]))
            anyone = True
        if not anyone:
            print("No edges in the graph")

    def read_file(self):
        path = input("Type the file from which you want to read:")
        try:
            self.graph = read_file(path)
        except Exception as e:
            print(e)

    def write_file(self):
        path = input("Type the file you want to write to:")
        try:
            write_file(path, self.graph)
        except Exception as e:
            print(e)

    def print_lowest_length(self):
        start = input("Enter the starting vertex:")
        end = input("Enter the end vertex:")
        try:
            path = self.graph.findLowestLengthPathBFS(int(start), int(end))
            print(path)
        except Exception as e:
            print(e)

    def print_hamiltonian_cycle(self):
        cycle = []
        mincost = self.graph.get_minimum_cost_hamiltonian(0, cycle)
        print("Minimum cost Hamiltonian cycle is:")
        print(cycle)
        print("Cost:", mincost)

    def prim_algorithm(self):
        g = Graph(7)
        g.add_edge(0, 1, 2)
        g.add_edge(1, 0, 2)

        g.add_edge(0, 6, 4)
        g.add_edge(6, 0, 4)

        g.add_edge(1, 2, 3)
        g.add_edge(2, 1, 3)

        g.add_edge(1, 4, 2)
        g.add_edge(4, 1, 2)

        g.add_edge(1, 5, 3)
        g.add_edge(5, 1, 3)

        g.add_edge(2, 6, 3)
        g.add_edge(6, 2, 3)

        g.add_edge(2, 3, 4)
        g.add_edge(3, 2, 4)

        g.add_edge(2, 4, 2)
        g.add_edge(4, 2, 2)

        g.add_edge(3, 4, 5)
        g.add_edge(4, 3, 5)

        g.add_edge(4, 5, 3)
        g.add_edge(5, 4, 3)

        g.add_edge(5, 6, 5)
        g.add_edge(6, 5, 5)

        mst_set, parent = Graph.get_mst_prim(g)

        total_cost = 0
        for i in range(1, g.count_vertices()):
            print(parent[i], "-", i)
            total_cost += g.get_edge_cost(parent[i], i)

        print(total_cost)




    def menu(self):
        commands = {"1": self.empty_graph,
                    "2": self.n_graph,
                    "3": self.m_graph,
                    "4": self.add_vertex,
                    "5": self.add_edge,
                    "6": self.remove_vertex,
                    "7": self.remove_edge,
                    "8": self.change_edge,
                    "9": self.print_edge,
                    "10": self.in_degree,
                    "11": self.out_degree,
                    "12": self.count_vertices,
                    "13":self.count_edges,
                    "14": self.is_vertex,
                    "15":self.is_edge,
                    "16":self.print_vertex_list,
                    "17":self.print_neighbour_list,
                    "18":self.print_transpose_list,
                    "19":self.print_edges,
                    "20":self.read_file,
                    "21":self.write_file,
                    "22":self.print_lowest_length,
                    "23":self.prim_algorithm,
                    "24":self.print_hamiltonian_cycle}

        while True:
            print("1. Create an empty graph")
            print("2. Create a graph with N vertices")
            print("3. Create a graph with N vertices and M random edges")
            print("4. Add a vertex")
            print("5. Add an edge")
            print("6. Remove a vertex")
            print("7. Remove an edge")
            print("8. Change the cost of an edge")
            print("9. Print the cost of an edge")
            print("10. Print the in degree of a vertex")
            print("11. Print the out degree of a vertex")
            print("12. Print the number of vertices")
            print("13. Print the number of edges")
            print("14. Check whether a vertex belongs to the graph")
            print("15. Check whether an edge belongs to the graph")
            print("16. Print the list of vertices")
            print("17. Print the list of outbound neighbours of a vertex")
            print("18. Print the list of inbound neighbours of a vertex")
            print("19. Print the list of edges")
            print("20. Read the graph from a file")
            print("21. Write the graph to a file")
            print("22. Find Lowest Length Path BFS (Lab2).")
            print("23. Prim's algorithm (Lab4)")
            print("24. Lowest cost Hamiltonian cycle(Lab 5).")
            print("0. Exit program")
            cmd = input(">>>")
            if cmd in commands:
                commands[cmd]()
            elif cmd == "0":
                break
            else:
                print("Invalid command")


if __name__ == "__main__":
    UI(Graph).menu()