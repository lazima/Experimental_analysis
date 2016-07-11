#!/bin/bash
>bb.out
ttl_fopt=0
ttl_time=0
#run the octave file 20 times
for ((i=0;i<hw_avg;i++));
        
	do
		octave localSearch.m >> bb.out    
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
done < bb.out
#average of op and tm
avg_op=$(awk "BEGIN {printf \"%.2f\",${ttl_fopt}/${hw_avg}; exit(0)}") 
avg_tm=$(awk "BEGIN {printf \"%.2f\",${ttl_time}/${hw_avg}; exit(0)}") 
echo $avg_op > LP_cap1_UFL_opt.txt
echo $avg_tm > LP_cap1_UFL_time.txt

