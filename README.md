<div align="center">

# 🚖 Ola Ride Booking Analytics

### *Transforming Raw Ride Data into Actionable Business Intelligence*

[![SQL](https://img.shields.io/badge/SQL-PostgreSQL-336791?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)](https://powerbi.microsoft.com/)
[![Excel](https://img.shields.io/badge/Excel-217346?style=for-the-badge&logo=microsoft-excel&logoColor=white)](https://microsoft.com/excel)
[![DAX](https://img.shields.io/badge/DAX-Analytics-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)](https://learn.microsoft.com/en-us/dax/)
[![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge)](/)
[![Type](https://img.shields.io/badge/Type-Data%20Analytics-blue?style=for-the-badge)](/)

<br/>

> **End-to-end data analytics project** covering SQL-based data extraction, multi-page Power BI dashboarding, and business insight generation for a ride-booking platform — built to mirror real-world analyst workflows.

<br/>

<img width="865" height="480" alt="overall_dashboard" src="https://github.com/user-attachments/assets/3626a18c-e01c-4354-abef-7dba6db233c5" />


---

</div>

## 📌 Table of Contents

- [Business Problem](#-business-problem)
- [Project Objectives](#-project-objectives)
- [Tech Stack](#-tech-stack)
- [Dataset Overview](#-dataset-overview)
- [SQL Analysis](#-sql-analysis)
- [Power BI Dashboard](#-power-bi-dashboard)
- [Key Business Insights](#-key-business-insights)
- [KPIs Tracked](#-kpis-tracked)
- [Key Findings](#-key-findings)
- [Screenshots](#-screenshots)
- [Future Improvements](#-future-improvements)

---

## 🧩 Business Problem

Ride-hailing platforms generate massive volumes of transactional data daily — but raw data alone delivers no value. Ola, one of India's largest mobility platforms, needed a structured way to monitor booking trends, understand cancellation patterns, optimize revenue streams, and evaluate service quality across vehicle categories.

This project simulates the role of a **Data Analyst** embedded within Ola's operations team, tasked with building a robust analytics layer to support data-driven decisions across departments — from fleet management and customer experience to revenue strategy.

---

## 🎯 Project Objectives

- Analyze booking volume, ride success rates, and cancellation behavior across July 2024
- Identify top-performing vehicle types by revenue and ride distance
- Understand customer and driver cancellation triggers to reduce churn
- Track payment method distribution and revenue concentration
- Evaluate driver and customer ratings across vehicle segments
- Surface the top customers driving disproportionate booking value
- Deliver interactive, executive-ready dashboards for business stakeholders

---

## 🛠 Tech Stack

| Tool | Purpose |
|---|---|
| **PostgreSQL (SQL)** | Data extraction, transformation, view creation |
| **Power BI Desktop** | Multi-page interactive dashboard development |
| **DAX** | Calculated measures, KPIs, dynamic aggregations |
| **Microsoft Excel / CSV** | Raw data source and pre-processing |

---

## 📂 Dataset Overview

The dataset contains **103,024 ride booking records** from **July 2024**, with the following key attributes:

| Column | Description |
|---|---|
| `Booking_ID` | Unique identifier per ride |
| `Booking_Status` | Success / Canceled by Driver / Canceled by Customer / Driver Not Found |
| `Customer_ID` | Anonymized customer identifier |
| `Vehicle_Type` | Prime Sedan, Prime SUV, Prime Plus, Mini, Auto, Bike, E-Bike |
| `Pickup_Location` | Origin of the ride |
| `Drop_Location` | Destination of the ride |
| `Booking_Value` | Fare amount (INR) |
| `Payment_Method` | Cash, UPI, Credit Card, Debit Card |
| `Ride_Distance` | Distance covered (km) |
| `Driver_Ratings` | Post-trip driver score (out of 5) |
| `Customer_Rating` | Post-trip customer score (out of 5) |
| `Canceled_Rides_by_Customer` | Reason if customer canceled |
| `Canceled_Rides_by_Driver` | Reason if driver canceled |
| `Incomplete_Rides_Reason` | Reason if ride was not completed |

---

## 🗄 SQL Analysis

All analytical queries are encapsulated as **reusable SQL Views** for modularity and downstream BI tool consumption.

<details>
<summary><strong>📋 View all 10 SQL Questions & Queries</strong></summary>

<br/>

**1. Retrieve all successful bookings**
```sql
CREATE VIEW successful_bookings AS
SELECT * FROM booking WHERE booking_status = 'Success';
```

**2. Average ride distance per vehicle type**
```sql
CREATE VIEW ride_distance_for_each_vehicle_type AS
SELECT vehicle_type, ROUND(AVG(ride_distance::numeric), 2) AS avg_ride_distance
FROM booking
GROUP BY vehicle_type;
```

**3. Total cancelled rides by customers**
```sql
CREATE VIEW cancelled_rides_by_customers AS
SELECT COUNT(*) FROM booking
WHERE canceled_rides_by_customer IS NOT NULL;
```

**4. Top 5 customers by number of rides**
```sql
CREATE VIEW top_5_customers AS
SELECT customer_id, COUNT(*) AS ride_count
FROM booking
GROUP BY customer_id
ORDER BY ride_count DESC
LIMIT 5;
```

**5. Driver cancellations — Personal & Car related issues**
```sql
CREATE VIEW Rides_cancelled_by_Drivers_P_C_Issues AS
SELECT COUNT(*) FROM booking
WHERE canceled_rides_by_driver = 'Personal & Car related issue';
```

**6. Max & Min driver ratings — Prime Sedan**
```sql
CREATE VIEW Max_Min_Driver_Rating AS
WITH cte AS (
  SELECT vehicle_type, driver_ratings FROM booking
  WHERE vehicle_type = 'Prime Sedan' AND driver_ratings IS NOT NULL
)
SELECT MAX(driver_ratings) AS max_rating, MIN(driver_ratings) AS min_rating FROM cte;
```

**7. Rides paid via UPI**
```sql
CREATE VIEW UPI_Payment AS
SELECT booking_id FROM booking WHERE payment_method = 'UPI';
```

**8. Average customer rating per vehicle type**
```sql
CREATE VIEW AVG_Cust_Rating AS
SELECT vehicle_type, ROUND(AVG(customer_rating::numeric), 2) AS avg_customer_rating
FROM booking GROUP BY vehicle_type;
```

**9. Total revenue from successful rides**
```sql
CREATE VIEW total_successful_ride_value AS
SELECT SUM(booking_value::numeric) AS total_booking_value
FROM booking WHERE booking_status = 'Success';
```

**10. Incomplete rides with reasons**
```sql
CREATE VIEW Incomplete_Rides_Reasons AS
SELECT booking_id, incomplete_rides_reason
FROM booking WHERE incomplete_rides_reason IS NOT NULL;
```

</details>

---

## 📊 Power BI Dashboard

The Power BI report is structured across **5 dedicated pages**, each targeting a specific business domain:

| Page | Focus Area |
|---|---|
| **Overall** | Booking volume, ride status breakdown, trends over time |
| **Vehicle Type** | Performance metrics segmented by vehicle category |
| **Revenue** | Payment method analysis, top customers, revenue trends |
| **Cancellation** | Cancellation volume, driver vs. customer split, reasons |
| **Ratings** | Driver and customer ratings across vehicle types |

### ⚙️ Dashboard Features

- 📅 **Date range slicer** — filter all visuals dynamically across the full month
- 🍩 **Donut charts** — booking status and cancellation reason breakdowns
- 📈 **Line charts** — ride volume and revenue trends over time
- 📋 **Matrix/table visuals** — vehicle type performance comparison
- 🏆 **Top N visuals** — top 5 customers by booking value
- 🎛 **Cross-filtering** — all visuals interact across the report page
- 💡 **DAX Measures** — custom KPI cards with dynamic aggregations

---

## 💡 Key Business Insights

- **62.09% of all rides** completed successfully — indicating room to reduce the ~38% loss rate
- **Cash and UPI dominate** payment methods, together accounting for ~95% of revenue
- **Prime Sedan leads** in total booking value (₹8.30M), followed by Auto (₹8.09M) and E-Bike (₹8.18M)
- **Auto vehicles** show significantly shorter average ride distance (10.04 km) vs. other categories (~25 km) — pointing to distinct use cases
- **Driver cancellations** (18,434) outnumber customer cancellations (10,499) — a critical operational risk
- **"Personal & Car related issues"** are the leading driver cancellation reason (35.49%), suggesting fleet maintenance gaps
- **"Driver is not moving towards pickup"** is the top customer cancellation reason (30.24%)
- **Driver ratings** are highly consistent across vehicle types (3.99–4.01), suggesting a rating normalization effect
- **Top 5 customers** each contribute ~₹5,938–6,019 in booking value, indicating a high-value loyalty segment worth targeting

---

## 📈 KPIs Tracked

| KPI | Value |
|---|---|
| Total Bookings | 103,024 |
| Total Booking Value | ₹35M |
| Successful Bookings | 63,967 (62.09%) |
| Cancelled by Driver | 18,434 (17.89%) |
| Cancelled by Customer | 10,499 (10.19%) |
| Driver Not Found | 10,124 (9.83%) |
| Avg. Driver Rating | ~4.00 / 5 |
| Avg. Customer Rating | ~4.00 / 5 |

---

## 🔎 Key Findings

1. **Cancellation is the #1 revenue leak** — 37.91% of bookings never complete, representing significant lost revenue
2. **Driver-side cancellations are systemic** — not random; root causes are identifiable and addressable
3. **UPI adoption is high** but Cash still leads, indicating an opportunity to incentivize digital payments
4. **All vehicle types show near-identical ratings**, suggesting the ratings system may need recalibration for differentiation
5. **E-Bike and Prime Sedan** deliver the best combination of booking value and distance efficiency
6. **Customer loyalty is concentrated** — a small segment drives outsized revenue, making retention programs a high-ROI opportunity

---

## 📸 Screenshots


<img width="865" height="480" alt="overall_dashboard" src="https://github.com/user-attachments/assets/45ebbd10-8aaf-4e73-9b85-6348ce9bed4a" />
<img width="884" height="492" alt="cancellation" src="https://github.com/user-attachments/assets/fb1ac0d3-6ab9-48da-a11e-66c11cb94794" />

<img width="871" height="485" alt="vehicle_type" src="https://github.com/user-attachments/assets/720a533e-f8ce-43ab-a7d5-a3b5b5afd50b" />
<img width="882" height="496" alt="revenue" src="https://github.com/user-attachments/assets/ce09609d-75e2-4390-b380-f7d174453ff1" />
<img width="884" height="488" alt="ratings" src="https://github.com/user-attachments/assets/9fcbacd1-751e-40cc-a71f-9aa85fbd4a7a" />


---


## 🚀 Future Improvements

| Enhancement | Impact |
|---|---|
| **Predictive cancellation model** | Identify high-risk bookings before cancellation using ML |
| **Geospatial heatmaps** | Map pickup/drop hotspots for fleet optimization |
| **Real-time streaming dashboard** | Power BI with live data via DirectQuery |
| **Customer segmentation (RFM)** | Cluster customers by Recency, Frequency, and Monetary value |
| **Driver performance scoring** | Composite metric combining ratings, cancellations, and completion rate |
| **Revenue forecasting** | Time-series model to project monthly booking value |

---

## ✅ Conclusion

This project demonstrates a complete, production-style analytics workflow — from raw data modeling and SQL-based transformation to executive-ready Power BI dashboards. The analysis surfaces clear, prioritized business opportunities: reducing driver-side cancellations, accelerating UPI adoption, retaining high-value customers, and optimizing fleet allocation by vehicle type.

The project reflects skills directly applicable to roles in **Data Analytics, Business Intelligence, and Operations Analytics** — including SQL, DAX, dashboard design, and business storytelling.

---

</div>
