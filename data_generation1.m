facility=100;
client=50;
capacity=1;
object=100;
fileID=fopen('test1.txt','w');

fprintf(fileID,'%d\n%d\n%d\n%d\n',capacity,facility,object,client);

#****************************coordinates of caches***********************

for i=1:facility
  coo1_facility=randi([1 100],1,1);
  coo2_facility=randi([1 100],1,1);
  fprintf(fileID,'%2d\t\t\t\t\t\t%2d\n',coo1_facility'(1,1),coo2_facility'(1,1));
end

#*****************Object Opening cost in Caches*****************************
  %fprintf(fileID,'\nObject \t %d\t',j);
  %fprintf(fileID,'\n');
for j=1:object

  for i=1:facility
    opening_cost=randi([1 100],facility,1);
    fprintf(fileID,'%d ',opening_cost'(1,i));
     fprintf(fileID,'\n');
  end
  %fprintf(fileID,'\n');
end


#***************************Demanded objects, copy and coordinate of clients***************************

for i=1:client
  demanded_object=randi([1 object],1,1);
  copies=randi([1 20],1,1);% Can demand atmost 20 copies
  coo1_client=randi([1 100],1,1);
  coo2_client=randi([1 100],1,1);
  fprintf(fileID,'%2d\t\t\t\t\t\t\t\t\t%2d\t\t\t\t\t\t\t\t\t%2d\t\t%2d\n',demanded_object'(1,1),copies'(1,1),coo1_client'(1,1),coo2_client'(1,1));
end
fclose(fileID);
