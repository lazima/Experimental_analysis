now=tic();
fileID = fopen('test2.txt');
K=fscanf(fileID,'%f',[1 1]);
capacity=K;
#no of caches, objects and clients
sizeA=[3 1];
M=fscanf(fileID,'%f',sizeA);
cache= M'(1,1);
object= M'(1,2);
client= M'(1,3);

#cache co-ordinates
cache_coor=[];

sizeB=[2 cache];
N=fscanf(fileID,'%f',sizeB);
  
N;

#cost of opening objects in caches
sizeC=[cache*object 1];
Q=fscanf(fileID,'%f',sizeC);

O=[];
for j=1:cache
for i=j:cache:cache*object

  O=[O Q(i,1)];
end
end
O;

#co-ordinates and demand of clients 
requested_object=[];
demand=[];
client_coor=[];

sizeD=[4*client 1];
P=fscanf(fileID,'%f',sizeD);
P;
%for i=1:object:object*client
for i=1:4:4*client
  requested_object=[requested_object P(i,1)];
  demand=[demand P(i+1,1)];
  client_coor=[client_coor P(i+2,1)];
  client_coor=[client_coor P(i+3,1)];
end
requested_object;
demand;
client_coor;

[O,A,b]=data2(cache,client,object,capacity,requested_object,demand,O,N,client_coor);
C=O';
[r1 c1] = size(A);

A;
b;

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
fileID=fopen('t1out.txt','w');
[xopt, fopt] = glpk(C, A, b, lb, ub, ctype, vartype, s);

wholetime=toc(now);

%fprintf(fileID,'\nTotal Cost\t\t\t Time in seconds\n');
%fprintf(fileID,'%f\t\t\t%f\n',fopt,wholetime);
%fclose(fileID);
fopt
wholetime
  
