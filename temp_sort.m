clc

t0 = [-40.7917	1
-36.3069	2
-30.1705	4];

t1 = [-34.0153	3];

t2 = [];

t3 = [];



t0 = [t0, zeros(size(t0,1),1)];
t1 = [t1, ones(size(t1,1),1)];
t2 = [t2, 2*ones(size(t2,1),1)];
t3 = [t3, 3*ones(size(t3,1),1)];


S = [t0; t1; t2; t3];

[index,i] = sort(S(:,2));

S(i,[1 3])
