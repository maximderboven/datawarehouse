###Voor SA versie kan je eventueel de datums eerst 3 jaar terugdraaien. Doe dit niet op de grote databank.
#update rides
#set rides.StartTime = DATEADD(year,-3,rides.StartTime) 

UPDATE rides
SET rides.endtime = ride_end.new_end_time
FROM rides
JOIN
(SELECT ride.RideId, 
ride.distance, 
ride.distance/1000 distance_km, (ride.distance/(4+(CRYPT_GEN_RANDOM(2) % 300)/100.00))/(60*60*24) time_days,  --riding betwwen 15 and 25 Kph in minutes        
ride.StartTime, 
ride.StartTime+(ride.distance/(4+(CRYPT_GEN_RANDOM(2) % 300)/100.00))/(60*60*24) new_end_time --riding betwwen 15 and 25 Kph 
FROM
(
SELECT r.RideId, 
r.StartTime, 
r.EndTime,  
r.VehicleId , 
geography::STGeomFromText([startpoint].STAsText(),4326).STDistance(geography::STGeomFromText([endpoint].STAsText(),4326)) distance
FROM rides r) as ride) as ride_end
ON rides.RideId = ride_end.RideId;

