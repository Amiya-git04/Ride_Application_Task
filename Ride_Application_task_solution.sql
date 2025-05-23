--- 1. Retrieve the names and contact details of all drivers with a rating of 4.5 or higher. 
SELECT 
    FirstName,
	LastName,
	Phone 
FROM
    Drivers
WHERE
    Rating > = 4.5;

--- 2. Find the total number of rides completed by each driver.
SELECT
    d.DriverID,
	d.FirstName,
	d.LastName,
	count(r.RideID) total_rides
FROM 
   Drivers d 
JOIN 
   Rides r ON d.DriverID = r.DriverID
WHERE
   r.RideStatus = 'Completed'
GROUP BY 
d.DriverID,d.FirstName,D.LastName

--- 3. List all riders who have never booked a ride. 
SELECT 
    r.FirstName,
	r.LastName,
	r.RiderID
FROM
   Riders r 
JOIN 
   Rides rd ON r.RiderID = rd.RiderID
WHERE
   rd.RideID is NULL

--- 4.Calculate the total earnings of each driver from completed rides. 
SELECT 
   d.FirstName,
   d.LastName,
   sum(r.Fare) as total_earning
FROM 
  Drivers d 
JOIN 
  Rides r ON d.DriverID = r.DriverID
where
r.RideStatus = 'Completed'
GROUP BY
d.FirstName,d.LastName

--- 5. Retrieve the most recent ride for each rider. 
SELECT 
    r.RideID,
    r.RiderID,
    r.DriverID,
    r.RideDate,
    r.PickupLocation,
    r.DropLocation,
    r.Distance,
    r.Fare,
    r.RideStatus
FROM Rides r
WHERE r.RideDate = (
    SELECT MAX(r2.RideDate)
    FROM Rides r2
    WHERE r2.RiderID = r.RiderID
);

--- 6. Count the number of rides taken in each city. 
SELECT
     Count(rd.RideID) as num_rides,
	 r.City
FROM 
     Riders r
JOIN 
     Rides rd ON r.RiderID = rd.RiderID
Group by 
r.City
ORDER BY
num_rides desc


--- 7. List all rides where the distance was greater than 20 km. 
SELECT
    RideID,
	Distance,
	PickupLocation,
	DropLocation,
	DriverID,
	RiderID
FROM 
   Rides
WHERE
   Distance > 20     

--- 8. Identify the most preferred payment method. 
SELECT TOP 1
    PaymentMethod
FROM
   Payments

--- 9. Find the top 3 highest-earning drivers. 
SELECT TOP 3
    d.FirstName,
	d.LastName,
	sum(r.Fare) as total_earning
FROM 
   Drivers d 
JOIN 
   Rides r ON d.DriverID = r.DriverID
Group by
   d.FirstName,d.LastName
ORDER BY
   total_earning desc

--- 10. Retrieve details of all cancelled rides along with the rider's and driver's names. 
SELECT 
    CONCAT(d.FirstName,' ',d.LastName) as Driver_name,
	r.Ridedate,
	r.PickupLocation,
	r.DropLocation,
	r.Distance,
	r.Fare,
	r.RideStatus,
	CONCAT(rd.FirstName,' ',rd.LastName) as Riders_name
FROM
    Drivers d
JOIN 
   Rides r  ON d.DriverID = r.DriverID
JOIN 
   Riders rd ON r.RiderId = rd.RiderID
WHERE 
r.RideStatus = 'Cancelled'






