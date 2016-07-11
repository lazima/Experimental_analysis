function [c, B] = data(cache,client,object,capacity,demand,a,demand_object)
%{
fname= 'test.csv';
Data= csvread(fname);
cache=Data(1,1)
client=Data(1,2)
object=Data(1,3)
capacity=Data(1,4)
%}

demand;
%{

#******************************************** Constraint Matrix ************************************************************************

#C1 Matrix for constraint: Each client can be assigned to exactly one faility
  c1=zeros(client,facility+(facility*client));
	for i=1:client
    for j=i+facility:client:(facility*client)+facility
      c1(i,j)=1;
     
    end
  end
	c1;

#C2 Matrix for constraint: If Client is assigned to any facility, that facility must be open
	c2=zeros(facility*client,facility+(facility*client));
  for j=1:facility
    for i=1:client
      c2(i+(j-1)*client,j)=1;
    end
  end
  
  for k=1:(facility*client)
    l=k+facility;
    c2(k,l)=-1;
  end
  c2;
 
c=[c1;c2];
#************************************ B Matrix**********************************************

	B0 = ones(size(c1,1),1);
	B1 = zeros(size(c2,1),1);
	
	B = [B0;B1];
	B;
  
  
#******************************** Matrix for objective function **************************************
	
  fac_opening_cost=[];
  assignment_cost=[];
  obj_fun_matrix=[];
  
  for i=1:facility
    fac_opening_cost=[fac_opening_cost Data(2,i)];
  end	
 
  for i=3:3+facility-1
    for j=1:client
      assignment_cost=[assignment_cost Data(i,j)];
    end	
  end
  assignment_cost;
  obj_fun_matrix=[fac_opening_cost assignment_cost];
  
  %}
  
  
  #******************************************** Constraint Matrix ************************************************************************

#C1 Matrix for constraint: Each client must be assigned to a cache
     
  c1=zeros(client,((cache*object)+(cache*client)));
	for i=1:client
    for j=i+(cache*object):client:((cache*object)+(cache*client))
	    c1(i,j)=1;
     end
  end
	c1;

 
 #C2 Matrix for constraint: If Client is assigned to any cache, required object must be in that cache
 %{
 demand_object=[];
 

  for i=1:client
     % demand_object=[demand_object Data((2*cache+3),i)];
     demand_object=[demand_object demand(1,i)];
  end
 %}
 demand_object; #which client demand which object
 client;
 object;
 
 %{
 a=[];
 for i=1:client
  for j=1:object
    a(i,demand_object(1,i))=1;
  end
 end
 %}
    a ;#demand in matrix form
 
 c2=zeros((cache*client),((cache*object)+(cache*client)));
 c21=[];
 c22=[];


 c21= kron(eye(cache),a); # Demand matrix pattern is repeated cache times for y variable
 c21;
 for k=1:client
     
      c22(k,k)=-1;        #for x variable of constraint 2
 end
 c22=kron(eye(cache),c22);
 c21;
 c22;
 
 c2=[c21 c22];
 #C3 Matrix for constraint: object stored in each cache must be atmost its capacity
  
  c3= zeros(cache,((cache*object)+(cache*client)));
  #c31=[];
  #for i=1:object
  #  c31=[c31 1];
  #end
  for j=1:object
    c31(1,j)=1;
  end
  c31;
  c3= kron(eye(cache),c31);
  
  c3= [c3 zeros(cache,(cache*client))];
  c3;
 
  c=[c1;c2;c3];
  
  
  #************************************ B Matrix**********************************************
  cap=[];
	B0 = ones(size(c1,1),1);
	B1 = zeros(size(c2,1),1);
  for i=1:cache 
    cap(1,i)=capacity;
  end
  
  B2=cap';
	
	B = [B0;B1;B2];
	B;
  
  #******************************** Matrix for objective function **************************************
	%{
  obj_opening_cost=[];
  assignment_cost=[];
  demand=[];
  demand_assgn=[];
  obj_fun_matrix=[];
  d_a=[];
  #cost of opening objects in cache
  for i=2:cache+1
    for j=1:object
    obj_opening_cost=[obj_opening_cost Data(i,j)];
    end
  end	
  obj_opening_cost;
  
 #demand
    i=cache+2;
    for j=1:client
    demand=[demand Data(i,j)];
    end

  demand;
  
  #cost of assigning clients in caches
   for i=cache+3:i+cache
    for j=1:client
    assignment_cost=[assignment_cost Data(i,j)];
    end
  end
  assignment_cost;
  
  #for dj*cij
  for i=1:client
    for j=i:client:cache*client
       demand_assgn=[demand_assgn demand(1,i)*assignment_cost(1,j)];
    end
  end
  demand_assgn;
  
 for i=1:cache
    for j=i:cache:cache*client
       d_a=[d_a demand_assgn(1,j)];
    end
 end
d_a;
  obj_fun_matrix=[obj_opening_cost d_a];
  %}