%{
fname= 'newdata.csv';
Data= csvread(fname);
facility=Data(1,1);
client=Data(1,2);
%}
function [xopt,fopt] = ufl(facility,client,obj_fun_matrix);

[facility,client,O,A,b]=ufl_constraints(facility,client,obj_fun_matrix);
facility;
client;
%[O,A,b]=constraintMatrix2;
C=O';
[r1 c1] = size(A);
[r c]=size(O);

lb = zeros(c1,1);
ub = ones(c1,1);

#lb=[];
#ub=[];


ctype = repmat("S",[1 client]);
ctype = [ctype repmat("L",[1 facility*client])];

ctype;

vartype = repmat("I",1,rows(C));

s = 1;

[xopt, fopt,status,extra] = glpk(C, A, b, lb, ub, ctype, vartype, s);
