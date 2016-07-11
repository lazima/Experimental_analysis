# all combination of n objects 
now=tic();
#******************************Reading input from file**************************
fileID = fopen('test2_1.txt');

#n objects for combination
n_obj=fscanf(fileID,'%f',[1 1]);

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
[p b]=size(requested_object);

#********************Initially randomly opening feasible objects in caches**********************
initial_assgn=[];
vec=[];
% opening only requested objects
for w=1:object  
  for l=1:b
    if requested_object(1,l)==w
      vec=[vec w];% only feasible objects
      break;
    endif
   end
end
vec;
[y z]=size(vec);
for i=1:z
  initial_assgn= [initial_assgn vec(1,i)];
end
combi_obj_index=combnk(1:z,n_obj);
%xc=1:z;
%combi_obj_index=nchoosek(xc,n_obj)
[fg gh]=size(combi_obj_index);


vec=[vec 0];
for i=z+1:cache_cap*cache
  %after all feasible objects are included, take any random objects from them for remaining positions
  initial_assgn= [initial_assgn vec(1,randi([1 z+1]))];
end
initial_assgn;
%{
for i=1:18
  initial_assgn(1,i)=0;
end

initial_assgn(1,1)=1;
initial_assgn(1,2)=2;
initial_assgn(1,3)=3;
initial_assgn(1,4)=4;
initial_assgn(1,7)=4;
initial_assgn(1,8)=3;
initial_assgn(1,9)=3;
initial_assgn(1,10)=1;
initial_assgn(1,11)=1;
initial_assgn(1,14)=3;
initial_assgn(1,16)=1;
initial_assgn(1,17)=2;
initial_assgn(1,18)=1;

%}
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
  fg; % number of rows of 'combi_obj_index' matrix
#for all objects

  for k=1:fg 

  
  count_zero=0;
  pos=[];
  ac_pos=[];
  cxxxx=0000000000000000000000000000000000000000000;
  for i=1:n_obj
    vec(1,combi_obj_index(k,i));
  end
  gx=11111111111111111111111111111111111111111111;
#***************** selecting objects************************************
    for i=1:cache_cap*cache
       truth=0;
      for tr=1:n_obj
        if initial_assgn(1,i)== vec(1,combi_obj_index(k,tr))
           initial_assgn(1,i)=0;
           break;
        endif
      end
    end
initial_assgn;

#********************* which positions are now empty and the count of empty positions*************
    for i=1:cache_cap*cache
      if initial_assgn(1,i)==0
        pos=[pos i];
        count_zero++; % number of caches for data_placement problem instance
      endif
    end
count_zero;
pos;
#*************************** get the actual cache position***************
    [r c]=size(pos);
    for i=c
      ac_pos=[ac_pos ceil(pos/cache_cap)];
    end

    count_zero;
    initial_assgn;
    pos;
    ac_pos;

#************ coordinates of empty caches*************
    [ro co]=size(ac_pos);
    empty_cache_coor=[];
    for i=1:co
      for j=1:2
        empty_cache_coor=[empty_cache_coor N(j,ac_pos(1,i))];
      end
    end
    empty_cache_coor;

#*****************opening cost of object k  in empty caches*****************
    %op_cost1=[];
    %op_cost2=[];
    op_cost=[];

    for i=1:co
      for tr=1:n_obj
        op_cost=[op_cost O((ac_pos(1,i)+(vec(1,combi_obj_index(k,tr))-1)*cache),1)];
      end
    end
    op_cost;
    %op_cost=[op_cost1 op_cost2];

#*******************how many clients demand for requested objects and their coordinates*********
    cnt=[];
    coo_cli=[];
    size_coo_cli=[];
    size_coo_cli_total=[];
    temp_s_t=0;
    size_coo_cli_total=[size_coo_cli_total 0];
    q_=[];
    for ti=1:n_obj
    
   
      cnt1=0;
      q1=[];
      [a1 b1]=size(requested_object);
      for i=1:b1
        if requested_object(1,i)==vec(1,combi_obj_index(k,ti))
          cnt1++;
          q1=[q1 i];
        endif
      end
      cnt1;
      q1;
      [x1 y1]=size(q1);
      coo_cli1=[];
      for i=1:y1
        coo_cli1=[coo_cli1 client_coor(1,q1(1,i)*2-1)];
        coo_cli1=[coo_cli1 client_coor(1,q1(1,i)*2)];
      end
      coo_cli1;
      [br bc]=size(coo_cli1);
      size_coo_cli=[size_coo_cli bc];
      temp_s_t+=bc;
      size_coo_cli_total=[size_coo_cli_total temp_s_t];
      cnt=[cnt cnt1];
      coo_cli=[coo_cli coo_cli1];
    q_=[q_ q1];
    end
    coo_cli;
    size_coo_cli;
    size_coo_cli_total;
    cnt;
    %{
     cnt2=0;
    q2=[];
    [a2 b2]=size(requested_object);
    for i=1:b2
      if requested_object(1,i)==vec(1,combi_obj_index(k,2))
        cnt2++;
        q2=[q2 i];
      endif
    end
    cnt2;
    q2
    [x2 y2]=size(q2);
    coo_cli2=[];
    for i=1:y2
      coo_cli2=[coo_cli2 client_coor(1,q2(1,i)*2-1)];
      coo_cli2=[coo_cli2 client_coor(1,q2(1,i)*2)];
    end
    coo_cli2
    %}
    
    
    
 
#*******************Calculating demand_object*************************************** 
 demand_object=[];
 bn=0;
 cnt_total=0;
  for cd=1:n_obj
    for cdd=bn+1:cnt(1,cd)+bn
      demand_object=[demand_object vec(1,combi_obj_index(k,cd))];
    end
    bn=cnt(1,cd);
    cnt_total+=cnt(1,cd);
  end
 
 demand_object;
 q_;
 [wq wr]=size(q_);
 demand;
 dem_q=[];
 for n=1:wr
    dem_q=[dem_q demand(1,q_(1,n))];
 end
 dem_q;
 [jk lm]=size(demand_object);
 lm;
 dem_obj=[];
 counter_1=0;
 counter_obj=0;
#*********** for handling the case 1113344 where 2 is missing****** 
for h=1:lm
    if demand_object(1,h)!=counter_obj
        counter_1++;
        dem_obj=[dem_obj counter_1];
        counter_obj=demand_object(1,h);
    else
       dem_obj=[dem_obj counter_1];
    endif
end
dem_obj;
%{
    for j=1:cnt1
      %a(j,1)=1;
      %a(j,2)=0;
      
    end
    for j=cnt1+1:cnt1+cnt2
      %a(j,1)=0;
      %a(j,2)=1;
        demand_object=[demand_object vec(1,combi_obj_index(k,2))];
    end
    
  %}
    %cnt1
    %cnt2
  
#*******************Calculating 'a' matrix*******************************
 a=zeros(lm,n_obj);
  for i=1:cnt_total
      a(i,dem_obj(1,i))=1;  
   end
  %{
for i=1:cnt1+cnt2
 
    if op<= cnt1
      a(i,1)=1;
      a(i,2)=0;
    else
      a(i,1)=0;
      a(i,2)=1;
    endif
  op++;
 end
 %}
% demand_object
 a;
 #**********************calculating assignment_cost************************
    assgn_cost=[];
    [e f]=size(empty_cache_coor);
    %[g1 h1]=size(coo_cli);
    %[g2 h2]=size(coo_cli2);
 
     f;
    for i=1:2:f-1
    vv=0;
      for vb=1:n_obj
        h1=size_coo_cli(1,vb);
        
      for j=1:2:h1-1
        vv++;
        assgn_cost=[assgn_cost (sqrt((empty_cache_coor(1,i)-coo_cli(1,j+size_coo_cli_total(1,vb))).^2 +(empty_cache_coor(1,i+1)-coo_cli(1,j+1+size_coo_cli_total(1,vb))).^2))*dem_q(1,vv)];
      end
     end
      %{
      for j=1:2:h2-1
        assgn_cost=[assgn_cost sqrt((empty_cache_coor(1,i)-coo_cli2(1,j)).^2 +(empty_cache_coor(1,i+1)-coo_cli2(1,j+1)).^2)];
      end
      %}
      end
    assgn_cost;
    
   % assgn_cost=[];
%{
 
    for i=1:2:f-1
      for j=1:2:h2-1
        assgn_cost=[assgn_cost sqrt((empty_cache_coor(1,i)-coo_cli2(1,j)).^2 +(empty_cache_coor(1,i+1)-coo_cli2(1,j+1)).^2)];
      end
    end
    assgn_cost2
    assgn_cost=[assgn_cost1 assgn_cost2]
    %}
    
#**************************objective function matrix*************************
    obj_fun_matrix=[];
    obj_fun_matrix=[op_cost assgn_cost];
    initial_assgn;
    
    op_cost;
   % dem=ones(1,cnt_total)% number of copies of required objects 
      dem_q;
    %if cnt1!=0 || cnt2!=0
      [xopt fopt]=data_placement_LP(count_zero,cnt_total,n_obj,1,dem_q,obj_fun_matrix,a,demand_object);
    %for 2 objects 
     for x=1:n_obj*count_zero
           x;
           xopt(x,1);
      end
      g=0;
      h=0;
      x=1;
      c_o=zeros(count_zero,n_obj);
      x_opt_v=0;
      for i=1:count_zero
        for j=1:n_obj
          x_opt_v++;
          if xopt(x_opt_v,1)==1
            c_o(i,j)=-1;
          endif
        end
      end
      
      c_o;%which objects are open in which cache
 n_obj;
  
  for j=1:n_obj
  ctr=1;
    for i=1:count_zero
      while initial_assgn(1,ctr)!=0
        ctr++;
      end
      if c_o(i,j)==-1
        % j must be changed
        c_o(i,j)=ctr;
      endif
      ctr++;
    end
    
  end
 c_o;
 combi_obj_index(k,:);
 adjust_combi=[];% 123 is changed to 124
 for i=1:n_obj
        adjust_combi=[adjust_combi vec(1,combi_obj_index(k,i))]; 
 end
 adjust_combi;
 for i=1:n_obj
  for j=1:count_zero
    if c_o(j,i)!=0
      initial_assgn(1,c_o(j,i))=adjust_combi(1,i);
    endif
  end
  
 end
 initial_assgn;
 %{     
      for i=1:n_obj
        g=0;
        h=0;
        for j=1:cache *cache_cap
          if initial_assgn(1,j)==0
            h++;
          else
            g++;
            if c_o(g,i)==-1
              c_o(g,i)=j;
            endif
          endif
          if g>=count_zero
            break;
          endif
        end
      end
      
      for i=1:n_obj
        for j=1:cache*cache_cap
          if c_o(i,j)!=0
            initial_assgn(1,c_o(i,j))=j;
          endif
        end
      end
   %}   
      initial_assgn;
   %{
   while x<=cache_cap*cache
        if initial_assgn(1,x)==0
            g++;
            if xopt(g*cache_cap,1)==1 || xopt(g*cache_cap-1,1)==1
              %xz=mod(g,2);
              if xopt(g*cache_cap,1)==1
                xz=vec(1,combi_obj_index(k,2));
              else
                xz=vec(1,combi_obj_index(k,1));
              endif
            initial_assgn(1,g+h)=xz;
            endif
        else
          h++;
        endif
        x++;
      end
      %}
      
      initial_assgn;
      
%{
      v=[];
      for i=1:count_zero
        if xopt(i,1)==1
          v=[v i];
        endif
      end
      v;
      [s t]=size(v);
      o_cost=0;
      for i=1:t
        counter=0;
        for j=1:cache*cache_cap
          if initial_assgn(1,j)==0
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
      o_cost
      as_cost
      initial_assgn
      opening+=o_cost;
      assignment+=as_cost;
      %}
    %endif
   
  end %end of for loop for objects

    if initial_assgn==init
      %final_op_cost=opening;
      %final_ass_cost=assignment;
      break;
    endif 
    
end %end of while
fileID=fopen('t11out.txt','w');
cache_coor;
opening_cost=0;
for i=1:cache_cap*cache
   ac_position=ceil(i/cache_cap);
   
   if initial_assgn(1,i)!=0
        obj=initial_assgn(1,i); 
        opening_cost+=O((obj-1)*cache+ac_position,1);
   endif
end



[req1 req2]=size(requested_object);
assignment_cost=0;
for i=1:req2
      x_cli=client_coor(1,(i*2)-1);
      y_cli=client_coor(1,(i*2));%coordinates of the client
      
      obj_demanded=requested_object(i);%get object number requested by the client
      find_obj=[];
      find_obj=[find_obj find(initial_assgn==obj_demanded)];%get the positions in initial_assgn
      %where the object is present
      
      [f_s1 f_s]=size(find_obj);%size of find_obj vector
      
      min_cost=Inf;
      for j=1:f_s
        actual_pos=ceil(find_obj(1,j)/cache_cap);
        
        cache_x=N(1,actual_pos);
        cache_y=N(2,actual_pos);
        demand(1,i);
        (sqrt((x_cli-cache_x)^2+(y_cli-cache_y)^2));
        dis_c=(sqrt((x_cli-cache_x)^2+(y_cli-cache_y)^2))*demand(1,i);
        
          if dis_c<min_cost
              min_cost=dis_c;
          endif
      end
      assignment_cost+=min_cost;
end
opening_cost;
assignment_cost;
total_cost=assignment_cost+opening_cost;
wholetime=toc(now);

fprintf(fileID,'\nOpening Cost\t\t\t\tAssignment Cost\t\t\t\tTotal Cost\t\t\tTime in seconds\n');
fprintf(fileID,'%f\t\t\t\t\t\t%f\t\t\t\t\t\t\t%f\t\t\t%f\n',opening_cost,assignment_cost,total_cost,wholetime);
fclose(fileID);

  initial_assgn;
  total_cost
  wholetime
  %final_op_cost
  %final_ass_cost
  %optimal_cost=final_op_cost+final_ass_cost
  
