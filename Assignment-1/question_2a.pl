% edge(Node1,Node2) tells whether there is a directed edge from Node1 to Node2
% connected(Node1, Node2) tells whether Node1 and Node2 are connected through a directed path

% rules for connected
connected(Node1,Node2):- edge(Node1,Node2) .
connected(Node1,Node2):- edge(Node1,X) ,connected(X,Node2) .

% facts for edges
edge(a,b).
edge(a,d).
edge(b,c).
edge(d,c).
edge(d,g).
edge(d,e).
edge(g,e).
edge(g,i).
edge(e,f).
