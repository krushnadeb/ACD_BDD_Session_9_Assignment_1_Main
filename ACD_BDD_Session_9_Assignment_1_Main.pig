---Q:1. What is the total amount of petrol in volume sold by every distributer?
distbdata = LOAD 'Session9_Assign1_Petroldataset.txt' USING PigStorage(',') as (DistrictID:chararray,Distributername:chararray,Buyrate_million:chararray,Sellrate_million:chararray
,volumeIN_millioncubiclitter:int,volumeOUT_millioncubiclitter:int,Year:int);

groupBydistbname = GROUP distbdata BY Distributername;

SoldBydistbname = FOREACH groupBydistbname GENERATE group,SUM(distbdata.volumeIN_millioncubiclitter)-SUM(distbdata.volumeOUT_millioncubiclitter) as SoldByVolume;

DUMP SoldBydistbname;


(shell,24246)
(Bharat,26943)

(reliance,27100)

(hindustan,22587)



------------------------------Q :2. Which are the top 10 distributers ID's for selling petrol? Also display the amount of petrol sold in volume.
distbdata = LOAD 'Session9_Assign1_Petroldataset.txt' USING PigStorage(',')as (DistrictID:chararray,Distributername:chararray,Buyrate_million:chararray,Sellrate_million:chararray
,volumeIN_millioncubiclitter:int,volumeOUT_millioncubiclitter:int,Year:int);

groupBydistrictid = GROUP distbdata BY DistrictID;

SoldBydistrictid= FOREACH groupBydistrictid GENERATE group,SUM(distbdata.volumeIN_millioncubiclitter)-SUM(distbdata.volumeOUT_millioncubiclitter) as SoldByVolume;

SoldBydistrictid_order = ORDER SoldBydistrictid BY SoldByVolume DESC;

SoldBydistrictid_order_limit= limit SoldBydistrictid_order 10;

DUMP SoldBydistrictid_order_limit;


(E6U 0I2,483)

(R3W 2E3,480)

(I2N 7S1,478)

(A7Z 3L9,474)

(V8S 4P6,464)

(C0G 8G1,460)

(C9B 3Q8,457)

(M1J 2H6,455)

(T4L 8D0,452)

(J7Z 9V4,446)



------------------------------Q 3:List 10 years where consumption of petrol is more with the distributer id who sold it.

distbdata = LOAD 'Session9_Assign1_Petroldataset.txt' USING PigStorage(',')as (DistrictID:chararray,Distributername:chararray,Buyrate_million:chararray,Sellrate_million:chararray
,volumeIN_millioncubiclitter:int,volumeOUT_millioncubiclitter:int,Year:int);

groupByYear = GROUP distbdata BY Year;

SoldByYear= FOREACH groupByYear GENERATE group As Year,SUM(distbdata.volumeIN_millioncubiclitter)-SUM(distbdata.volumeOUT_millioncubiclitter) as SoldByVolume;

SoldByYear_order = ORDER SoldByYear BY SoldByVolume DESC;

SoldByYear_order_limit= limit SoldByYear_order 10;

distb_YearDisticID = foreach distbdata Generate Year,DistrictID;

SoldYearDistricidJoin= join SoldByYear_order_limit by Year,distb_YearDisticID  by Year;

distb_result = foreach SoldYearDistricidJoin Generate SoldByYear_order_limit::Year,SoldByVolume,DistrictID;

distb_result_order = ORDER distb_result BY SoldByVolume DESC; 

dump distb_result_order;



(1646,483,E6U 0I2)

(1767,480,R3W 2E3)

(1935,478,I2N 7S1)

(1795,474,A7Z 3L9)

(1732,464,V8S 4P6)

(1843,460,C0G 8G1)

(1782,457,C9B 3Q8)

(1693,455,M1J 2H6)

(2000,452,T4L 8D0)

(1748,446,J7Z 9V4)



--------------Q 4:Find the distributer name who sold petrol in least amount
distbdata = LOAD 'Session9_Assign1_Petroldataset.txt' USING PigStorage(',')as (DistrictID:chararray,Distributername:chararray,Buyrate_million:chararray,Sellrate_million:chararray
,volumeIN_millioncubiclitter:int,volumeOUT_millioncubiclitter:int,Year:int);
groupBydistbname = GROUP distbdata BY Distributername;

SoldBydistbname = FOREACH groupBydistbname GENERATE group,SUM(distbdata.volumeIN_millioncubiclitter)-SUM(distbdata.volumeOUT_millioncubiclitter) as SoldByVolume;

SoldByDistb_order = ORDER SoldBydistbname BY SoldByVolume ASC;

SoldByDistb_order_limit = limit SoldByDistb_order 1;

DUMP SoldByDistb_order_limit ;



(hindustan,22587)
