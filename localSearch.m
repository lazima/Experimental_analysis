%function [count_zero,cnt,obj_fun_matrix] = localSearch
#Reading input from file
now=tic();
fileID = fopen('test2.txt');

#Cache Capacity
K=fscanf(fileID,'%f',[1 1]);
cache_cap=K;

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
O=fscanf(fileID,'%f',sizeC);
O;

#co-ordinates and demand of clients 
requested_object=[];
demand=[];
client_coor=[];

sizeD=[4*client 1];
P=fscanf(fileID,'%f',sizeD);
%for i=1:object:object*client
P;
for i=1:4:4*client
  requested_object=[requested_object P(i,1)];
  demand=[demand P(i+1,1)];
  client_coor=[client_coor P(i+2,1)];
  client_coor=[client_coor P(i+3,1)];
end
requested_object;
demand;
client_coor;
[p b]=size(requested_object);
#********************Initially randomly opening feasible objects in caches**********************
initial_assgn=[];
vec=[];
% opening only requested objects
for w=1:object  
  for l=1:b
    if requested_object(1,l)==w
      vec=[vec w];
      break;
    endif
   end
end
[y z]=size(vec);
for i=1:z
  initial_assgn= [initial_assgn vec(1,i)];
end
vec=[vec 0];
for i=z+1:cache_cap*cache
  initial_assgn= [initial_assgn vec(1,randi([1 z+1]))];
end
initial_assgn;
%{
for i=1:cache_cap*cache
  initial_assgn(1,i)=0;
end
initial_assgn(1,1)=1;
initial_assgn(1,2)=2;
initial_assgn(1,3)=3;
initial_assgn(1,4)=4;
initial_assgn(1,5)=5;
initial_assgn(1,6)=2;
initial_assgn(1,7)=3;
initial_assgn(1,8)=2;
initial_assgn(1,9)=0;
initial_assgn(1,10)=2;
initial_assgn(1,11)=3;
initial_assgn(1,12)=2;
initial_assgn(1,13)=0;
initial_assgn(1,14)=2;
initial_assgn(1,15)=1;
initial_assgn(1,16)=2;
initial_assgn(1,17)=5;
initial_assgn(1,18)=0;
initial_assgn(1,19)=1;
initial_assgn(1,20)=4;

initial_assgn(1,21)=1;
initial_assgn(1,22)=2;
initial_assgn(1,23)=1;
initial_assgn(1,24)=1;
initial_assgn(1,25)=5;
initial_assgn(1,26)=4;
initial_assgn(1,27)=2;
initial_assgn(1,28)=4;
initial_assgn(1,29)=5;
initial_assgn(1,30)=2;
initial_assgn(1,31)=1;
initial_assgn(1,32)=2;
initial_assgn(1,33)=1;
initial_assgn(1,34)=2;
initial_assgn(1,35)=1;
initial_assgn(1,36)=1;
initial_assgn(1,37)=5;
initial_assgn(1,38)=3;
initial_assgn(1,39)=1;
initial_assgn(1,40)=2;
%}
initial_assgn;
%{
for i=1:cache_cap*cache
  initial_assgn= [initial_assgn randi([0 object])];
end
%}
initial_assgn;
init=initial_assgn;
final_op_cost=0;
final_ass_cost=0;
#finding optimal value while there are some improvement through local change
while 1==1
  init=initial_assgn;
  opening=0;
  assignment=0;

#for all objects
  for k=1:object  

  count_zero=0;
  pos=[];
  ac_pos=[];
#***************** selecting objects************************************
    for i=1:cache_cap*cache
        if initial_assgn(1,i)==k
          initial_assgn(1,i)=0;
        endif
    end


% which positions are now empty and the count of empty positions
    for i=1:cache_cap*cache
      if initial_assgn(1,i)==0
        pos=[pos i];
        count_zero++;
      endif
    end

% get the actual cache position
    [r c]=size(pos);
    for i=c
      ac_pos=[ac_pos ceil(pos/cache_cap)];
    end

    count_zero;
    initial_assgn;
    pos;
    ac_pos;

% coordinates of empty caches
    [ro co]=size(ac_pos);
    empty_cache_coor=[];
    for i=1:co
      for j=1:2
        empty_cache_coor=[empty_cache_coor N(j,ac_pos(1,i))];
      end
    end
    empty_cache_coor;

%opening cost of object1 in empty caches
    op_cost=[];

    for i=1:co
      op_cost=[op_cost O((ac_pos(1,i)+(k-1)*cache),1)];
  
    end
    op_cost;

%how many clients demand for requested objects and their coordinates
    cnt=0;
    q=[];
    [a b]=size(requested_object);
    for i=1:b
      if requested_object(1,i)==k
        cnt++;
        q=[q i];
      endif
    end
    cnt;
    q;
    [x y]=size(q);
    coo_cli=[];
    for i=1:y
      coo_cli=[coo_cli client_coor(1,q(1,i)*2-1)];
      coo_cli=[coo_cli client_coor(1,q(1,i)*2)];
    end
    coo_cli;
 
 %calculating assignment_cost
    assgn_cost=[];
    [e f]=size(empty_cache_coor);
    [g h]=size(coo_cli);
 q;
    for i=1:2:f-1
      for j=1:2:h-1
        demand(1,q(1,floor((j+1)/2)));
        assgn_cost=[assgn_cost demand(1,q(1,floor((j+1)/2)))*sqrt((empty_cache_coor(1,i)-coo_cli(1,j)).^2 +(empty_cache_coor(1,i+1)-coo_cli(1,j+1)).^2)];
      end
    end
    empty_cache_coor;
    coo_cli;
    assgn_cost;
%objective function matrix
    obj_fun_matrix=[];
    obj_fun_matrix=[op_cost assgn_cost];
    initial_assgn;
    if cnt!=0
      [xopt fopt]=ufl_LP(count_zero,cnt,obj_fun_matrix);

      v=[];
      for i=1:count_zero
        if xopt(i,1)==1
          v=[v i];
        endif
      end
      v;
      O;
      [s t]=size(v);
      o_cost=0;
      for i=1:t
        counter=0;
        for j=1:cache*cache_cap
          if initial_assgn(1,j)==0 || initial_assgn(1,j)==k %if cache has 0 or the object k
            counter++;
            if counter==v(1,i)
              initial_assgn(1,j)=k;% for object1
              o_cost+=O(ceil(j/cache_cap)+(k-1)*cache,1);
              break;
            endif
          endif
        end
      end

      as_cost=fopt-o_cost;
      o_cost;
      as_cost;
      initial_assgn;
      opening+=o_cost;
      assignment+=as_cost;
    endif
  end %end of for loop for objects

    if initial_assgn==init
      final_op_cost=opening;
      final_ass_cost=assignment;
      break;
    endif 
end %end of while
fileID=fopen('t1out.txt','w');
  initial_assgn;
  final_op_cost;
  final_ass_cost;
  optimal_cost=final_op_cost+final_ass_cost;
  wholetime=toc(now);
#fprintf(fileID,'\nOpening Cost\t\t\t\tAssignment Cost\t\t\t\tTotal Cost\t\t\t Time in seconds\n');
#fprintf(fileID,'%f\t\t\t\t\t\t%f\t\t\t\t\t\t\t%f\n%f',final_op_cost,final_ass_cost,optimal_cost,wholetime);
#fclose(fileID);
  optimal_cost
  wholetime
