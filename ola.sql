DROP TABLE IF EXISTS booking;

CREATE TABLE booking (
    Date VARCHAR(30),
    Time VARCHAR(30),
    Booking_ID VARCHAR(20),
    Booking_Status VARCHAR(40),
    Customer_ID VARCHAR(20),
    Vehicle_Type VARCHAR(40),
    Pickup_Location VARCHAR(50),
    Drop_Location VARCHAR(50),
    V_TAT VARCHAR(20),
    C_TAT VARCHAR(20),
    Canceled_Rides_by_Customer VARCHAR(200),
    Canceled_Rides_by_Driver VARCHAR(200),
    Incomplete_Rides VARCHAR(20),
    Incomplete_Rides_Reason VARCHAR(200),
    Booking_Value VARCHAR(20),
    Payment_Method VARCHAR(20),
    Ride_Distance VARCHAR(20),
    Driver_Ratings FLOAT,
    Customer_Rating FLOAT,
    Vehicle_Images VARCHAR(100)
);

DO $$
DECLARE
    col RECORD;
BEGIN
    FOR col IN
        SELECT column_name
        FROM information_schema.columns
        WHERE table_name = 'booking'
    LOOP
        EXECUTE format(
            'UPDATE booking 
             SET %I = NULL 
             WHERE %I::text = ''null''',
            col.column_name,
            col.column_name
        );
    END LOOP;
END $$;


select * from booking

SELECT *
FROM booking
WHERE driver_ratings IS NULL;

select count(booking_id) from booking



-- 1. Retrieve all successful bookings:
create view successful_bookings as
select * from booking where booking_status = 'Success'

select * from successful_bookings
-- 2. Find the average ride distance for each vehicle type:
create view ride_distance_for_each_vehicle_type as
select vehicle_type,round(avg(ride_distance::numeric),2) as avg_ride_distance
from booking
group by vehicle_type

select * from ride_distance_for_each_vehicle_type
-- 3. Get the total number of cancelled rides by customers:
create view cancelled_rides_by_customers as
select count(*)
from booking
where canceled_rides_by_customer is not null

select * from cancelled_rides_by_customers
-- 4. List the top 5 customers who booked the highest number of rides:
create view top_5_customers as
select customer_id , count(*) as counter
from booking
group by 1
order by 2 desc
limit 5

select * from top_5_customers
-- 5. Get the number of rides cancelled by drivers due to personal and car-related issues:
create view Rides_cancelled_by_Drivers_P_C_Issues as
select count(*)
from booking
where canceled_rides_by_driver = 'Personal & Car related issue'

select * from Rides_cancelled_by_Drivers_P_C_Issues
-- 6. Find the maximum and minimum driver ratings for Prime Sedan bookings:
create view Max_Min_Driver_Rating as
with cte as
(select vehicle_type,driver_ratings
from booking
where vehicle_type = 'Prime Sedan' and driver_ratings is not null
)

select max(driver_ratings) as max_driver_rating,min(driver_ratings) as min_driver_rating from cte

select * from Max_Min_Driver_Rating
-- 7. Retrieve all rides where payment was made using UPI:
create view UPI_Payment as
select booking_id
from booking
where payment_method = 'UPI' 

select * from UPI_Payment
-- 8. Find the average customer rating per vehicle type:
create view AVG_Cust_Rating as
select vehicle_type , round(avg(customer_rating::numeric),2) as avg_customer_rating
from booking
group by 1

select * from AVG_Cust_Rating
-- 9. Calculate the total booking value of rides completed successfully:
create view  total_successful_ride_value as
select sum(booking_value::numeric) as total_booking_value
from booking
where booking_status = 'Success'

select * from total_successful_ride_value
-- 10. List all incomplete rides along with the reason:
create view Incomplete_Rides_Reasons as
select booking_id,incomplete_rides_reason
from booking
where incomplete_rides_reason is not null

select * from Incomplete_Rides_Reasons
