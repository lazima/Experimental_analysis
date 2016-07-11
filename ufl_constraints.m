function [facility,client,obj_fun_matrix,c,B] = ufl_constraints(facility,client,obj_fun_matrix);
%{
fileID = fopen('test1.txt');
abc=textscan(fileID,'%s',3,'Delimiter','');
sizeA=[3 Inf];
M=fscanf(fileID,'%f %f %f',sizeA);
facility= M'(1,1);
client= M'(1,2);
capacity= M'(1,3);
%}
%[facility,client,obj_fun_matrix]=localSearch
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
	%{
  fac_opening_cost=[];
  assignment_cost=[];
  obj_fun_matrix=[];
  

b=textscan(fileID,'%s',1,'Delimiter','');
sizeB=[facility Inf];
opening_cost=fscanf(fileID,'%f ',sizeB);
fac_opening_cost=opening_cost';

csdf=textscan(fileID,'%s',1,'Delimiter','');
sizeC = [4 Inf];
N = fscanf(fileID,'%f',sizeC);
Data=N';
prev = 0;

   
   [dataRow,dataCol] = size(Data);
   for i=1:dataRow
      j=3;
      if (client*(Data(i,1)-1)+Data(i,2))-prev>1 
        for k=1:(client*(Data(i,1)-1)+Data(i,2))-prev-1
          assignment_cost=[assignment_cost 99999];
         end
          assignment_cost=[assignment_cost Data(i,j)];
      else
        assignment_cost=[assignment_cost Data(i,j)];
      endif
      prev = client*(Data(i,1)-1)+Data(i,2);
      
    end	
  if Data(dataRow,2)!=client
    for l=Data(dataRow,2)+1:client
      assignment_cost=[assignment_cost 99999];  
    end
  endif
  assignment_cost;

  obj_fun_matrix=[fac_opening_cost assignment_cost];
  
  %}