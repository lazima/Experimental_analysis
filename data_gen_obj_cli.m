fileID = fopen('t2.txt');
#Cache Capacity
K=fscanf(fileID,'%f',[1 1]);
cache_cap=K;

#no of caches, objects and clients
sizeA=[3 1];
M=fscanf(fileID,'%f',sizeA);
cache= M'(1,1);
object= M'(1,2);
client= M'(1,3);
new_object=object+5;

#cache co-ordinates
cache_coor=[];

sizeB=[2 cache];
N=fscanf(fileID,'%f',sizeB);
N
fileID1=fopen('t12.txt','w');

fprintf(fileID1,'%d\n%d\n%d\n%d\n',cache_cap,cache,new_object,client+10);

#****************************coordinates of caches***********************

for i=1:cache
  coo1_facility=N(1,i);
  coo2_facility=N(2,i);
  fprintf(fileID1,'%2d\t\t\t\t\t\t%2d\n',coo1_facility(1,1),coo2_facility(1,1));
end
%{
for i=1:10
  coo1_facility=randi([1 100],1,1);
  coo2_facility=randi([1 100],1,1);
  fprintf(fileID1,'%2d\t\t\t\t\t\t%2d\n',coo1_facility'(1,1),coo2_facility'(1,1));
end
%}
#*****************Object Opening cost in Caches*****************************
  %fprintf(fileID,'\nObject \t %d\t',j);
  %fprintf(fileID,'\n');

    sizeC=[object*cache 1];
    O=fscanf(fileID,'%f',sizeC);
    O;
O  
   
   for i=1:object*cache
      op_cost=O(i,1);
      fprintf(fileID1,'%2d\n',op_cost);
    end
  
    for i=1:5*cache
    cost_rand=randi([1 100],1,1);
    fprintf(fileID1,'%2d\n',cost_rand);
    end
 


#***************************Demanded objects, copy and coordinate of clients***************************
#co-ordinates and demand of clients 
requested_object=[];
demand=[];
client_coor=[];

sizeD=[4*client 1];
Q=fscanf(fileID,'%f',sizeD);
%for i=1:object:object*client
Q
%for i=1:object:object*client

for i=1:4:4*client
  requested_object=[requested_object Q(i,1)];
  demand=[demand Q(i+1,1)];
  client_coor=[client_coor Q(i+2,1)];
  client_coor=[client_coor Q(i+3,1)];
end
requested_object
demand
client_coor
client1=[];
client2=[];
for k=1:2:client*2
  client1=[client1 client_coor(1,k)];
  client2=[client2 client_coor(1,k+1)];
end
client1;
client2;

for i=1:client
  
  fprintf(fileID1,'%2d\t\t\t\t\t\t\t\t\t%2d\t\t\t\t\t\t\t\t\t%2d\t\t%2d\n',requested_object(1,i),demand(1,i),client1(1,i),client2(1,i));
end

for i=1:10
    demanded_object=randi([1 new_object],1,1);
    copies=randi([1 20],1,1);% Can demand atmost 20 copies
    coo1_client=randi([1 100],1,1);
    coo2_client=randi([1 100],1,1);
  fprintf(fileID1,'%2d\t\t\t\t\t\t\t\t\t%2d\t\t\t\t\t\t\t\t\t%2d\t\t%2d\n',demanded_object'(1,1),copies'(1,1),coo1_client'(1,1),coo2_client'(1,1));
    end
 

fclose(fileID);
fclose(fileID1);

