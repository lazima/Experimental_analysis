#!/bin/bash
######################################### for Data Placement ILP ###############################
>a.out
total_fopt=0
total_time=0
hw_avg=20
#run the octave file 20 times
for ((i=0;i<hw_avg;i++));
        
	do
		octave data_place.m >> a.out    
    	done 
#read two lines at a time from a.out
#cat a.out | 
while read -r line1; read -r line2
do 
	#split line using '='
	IFS='='
	read -a split_opt <<< "${line1}"
    	read -a split_time<<< "${line2}"
	
	fopt=${split_opt[1]}
	time=${split_time[1]}

	#cumilitive sum of fopt and time 
	total_fopt=$(awk "BEGIN {printf \"%.2f\",${total_fopt}+${fopt}; exit(0)}")
	total_time=$(awk "BEGIN {printf \"%.2f\",${total_time}+${time}; exit(0)}")
    #echo "Two lines $line1 and $line2 $total_fopt"	
done < a.out
#average of fopt and time
avg_fopt=$(awk "BEGIN {printf \"%.2f\",${total_fopt}/${hw_avg}; exit(0)}") 
avg_time=$(awk "BEGIN {printf \"%.2f\",${total_time}/${hw_avg}; exit(0)}") 
echo $avg_fopt > cl90_DP_opt.txt
echo $avg_time > cl90_DP_time.txt

###################################### for UFL ILP ##########################################

>b.out
ttl_fopt=0
ttl_time=0
#run the octave file 20 times
for ((i=0;i<hw_avg;i++));
        
	do
		octave localSearch.m >> b.out    
    	done 
#read two lines at a time from b.out
while read -r line1; read -r line2
do 
	#split line using '='
	IFS='='
	read -a split_op <<< "${line1}"
    	read -a split_tm<<< "${line2}"
	
	op=${split_op[1]}
	tm=${split_tm[1]}

	#cumilitive sum of fopt and time 
	ttl_fopt=$(awk "BEGIN {printf \"%.2f\",${ttl_fopt}+${op}; exit(0)}")
	ttl_time=$(awk "BEGIN {printf \"%.2f\",${ttl_time}+${tm}; exit(0)}")
    #echo "Two lines $line1 and $line2"	
done < b.out
#average of op and tm
avg_op=$(awk "BEGIN {printf \"%.2f\",${ttl_fopt}/${hw_avg}; exit(0)}") 
avg_tm=$(awk "BEGIN {printf \"%.2f\",${ttl_time}/${hw_avg}; exit(0)}") 
echo $avg_op > cl90_UFL_opt.txt
echo $avg_tm > cl90_UFL_time.txt

###################################### for DP_1_opt ##########################################

>c.out
t_fopt=0
t_time=0
#run the octave file 20 times
for ((i=0;i<hw_avg;i++));
        
	do
		octave data_place_n_objects_cost_demand.m >> c.out    
    	done 
#read two lines at a time from b.out
while read -r line1; read -r line2
do 
	#split line using '='
	IFS='='
	read -a split_val <<< "${line1}"
    	read -a split_t<<< "${line2}"
	
	val=${split_val[1]}
	t=${split_t[1]}

	#cumilitive sum of fopt and time 
	t_fopt=$(awk "BEGIN {printf \"%.2f\",${t_fopt}+${val}; exit(0)}")
	t_time=$(awk "BEGIN {printf \"%.2f\",${t_time}+${t}; exit(0)}")
    #echo "Two lines $line1 and $line2"	
done < c.out
#average of op and tm
avg_val=$(awk "BEGIN {printf \"%.2f\",${t_fopt}/${hw_avg}; exit(0)}") 
avg_t=$(awk "BEGIN {printf \"%.2f\",${t_time}/${hw_avg}; exit(0)}") 
echo $avg_val > cl90_DP_1opt.txt
echo $avg_t > cl90_DP_1opt_time.txt

###################################### for DP_2_opt ##########################################

>d.out
tl_fopt=0
tl_time=0
#run the octave file 20 times
for ((i=0;i<hw_avg;i++));
        
	do
		octave data_place_2opt.m >> d.out    
    	done 
#read two lines at a time from b.out
while read -r line1; read -r line2
do 
	#split line using '='
	IFS='='
	read -a splt_val <<< "${line1}"
    	read -a splt_t<<< "${line2}"
	
	value=${splt_val[1]}
	tme=${splt_t[1]}

	#cumilitive sum of fopt and time 
	tl_fopt=$(awk "BEGIN {printf \"%.2f\",${tl_fopt}+${value}; exit(0)}")
	tl_time=$(awk "BEGIN {printf \"%.2f\",${tl_time}+${tme}; exit(0)}")
    #echo "Two lines $line1 and $line2"	
done < d.out
#average of op and tm
av_val=$(awk "BEGIN {printf \"%.2f\",${tl_fopt}/${hw_avg}; exit(0)}") 
av_t=$(awk "BEGIN {printf \"%.2f\",${tl_time}/${hw_avg}; exit(0)}") 
echo $av_val > cl90_DP_2opt.txt
echo $av_t > cl90_DP_2opt_time.txt

###################################### for DP_3_opt ##########################################

>e.out
total_opt=0
total_t=0
#run the octave file 20 times
for ((i=0;i<hw_avg;i++));
        
	do
		octave data_place_3opt.m >> e.out    
    	done 
#read two lines at a time from b.out
while read -r line1; read -r line2
do 
	#split line using '='
	IFS='='
	read -a split_result <<< "${line1}"
    	read -a splt_time<<< "${line2}"
	
	result=${split_result[1]}
	t=${splt_time[1]}

	#cumilitive sum of fopt and time 
	total_opt=$(awk "BEGIN {printf \"%.2f\",${total_opt}+${result}; exit(0)}")
	total_t=$(awk "BEGIN {printf \"%.2f\",${total_t}+${t}; exit(0)}")
    #echo "Two lines $line1 and $line2"	
done < e.out
#average of op and tm
average_result=$(awk "BEGIN {printf \"%.2f\",${total_opt}/${hw_avg}; exit(0)}") 
average_t=$(awk "BEGIN {printf \"%.2f\",${total_t}/${hw_avg}; exit(0)}") 
echo $average_result > cl90_DP_3opt.txt
echo $average_t > cl90_DP_3opt_time.txt


