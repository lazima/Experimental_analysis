function [xopt,fopt] = data_placement_LP(cache,client,object,capacity,demand,O,a,demand_object)
%{
fname= 'test.csv';
Data= csvread(fname);
cache=Data(1,1);
client=Data(1,2);
object=Data(1,3);
capacity=Data(1,4);
%}
cache;
client;
object;
capacity;
demand;
O;
a;
demand_object;
[A,b]=data(cache,client,object,capacity,demand,a,demand_object);
A;
b;

C=O';
[r1 c1] = size(A);


lb = zeros(c1,1);
ub = ones(c1,1);
#lb=[];
#ub=[];


ctype = repmat("L",[1 client]);
#for data
ctype = [ctype repmat("L",[1 (cache*client)])];
#for data1
#ctype = [ctype repmat("L",[1 (cache*client*object)])];

ctype = [ctype repmat("U",[1 cache])];
ctype;

vartype = repmat("C",1,rows(C));

s = 1;
C;
A;
b;
[xopt, fopt] = glpk(C, A, b, lb, ub, ctype, vartype, s);
