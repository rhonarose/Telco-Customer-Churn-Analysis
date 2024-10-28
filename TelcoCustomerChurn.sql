SELECT *
FROM TelcoCustomerChurn


-- Checking for duplicate CustomerID values

SELECT CustomerID, COUNT(*) AS DuplicateCount
FROM TelcoCustomerChurn
GROUP BY CustomerID
HAVING COUNT(*) > 1


-- Total number of customers

SELECT COUNT(*) AS TotalCustomers
FROM TelcoCustomerChurn


-- Total number of customers who have either stayed or churned (Q3)

SELECT COUNT(*) AS TotalCustomers
FROM TelcoCustomerChurn
WHERE CustomerStatus <> 'Joined'


-- Total remaining customers (not churned)

SELECT COUNT(*) AS RemainingCustomers
FROM TelcoCustomerChurn
WHERE CustomerStatus <> 'Churned'


-- Calculate the Overall Churn Rate in the Q3

SELECT COUNT(*) AS ChurnCounts, (COUNT(*) * 1.0 / (SELECT COUNT(*) FROM TelcoCustomerChurn WHERE CustomerStatus <> 'Joined')) * 100 AS ChurnRate
FROM TelcoCustomerChurn
WHERE CustomerStatus = 'Churned'


-- Calculate churn rate by customers' gender for Q3

SELECT Gender, COUNT(*) AS ChurnCounts, (COUNT(*) * 1.0 / SUM(COUNT(*)) OVER ()) * 100 AS ChurnRate
FROM TelcoCustomerChurn
WHERE CustomerStatus = 'Churned'
GROUP BY Gender
ORDER BY ChurnRate DESC


-- Calculate churn rate by customers' age for Q3

SELECT Age, COUNT(*) AS ChurnCounts, (COUNT(*) * 1.0 / SUM(COUNT(*)) OVER ()) * 100 AS ChurnRate
FROM TelcoCustomerChurn
WHERE CustomerStatus = 'Churned'
GROUP BY Age
ORDER BY ChurnRate DESC, Age 


-- Calculate churn rate by customers' age groups for Q3

WITH Churned AS (
    SELECT 
        CASE
            WHEN Age BETWEEN 18 AND 39 THEN 'Young Adult (18-39)'
            WHEN Age BETWEEN 40 AND 59 THEN 'Middle-Aged (40-59)'
            WHEN Age BETWEEN 60 AND 100 THEN 'Senior (60+)'
        END AS AgeGroup, COUNT(*) AS ChurnCounts
    FROM TelcoCustomerChurn
    WHERE CustomerStatus = 'Churned'
    GROUP BY 
        CASE
            WHEN Age BETWEEN 18 AND 39 THEN 'Young Adult (18-39)'
            WHEN Age BETWEEN 40 AND 59 THEN 'Middle-Aged (40-59)'
            WHEN Age BETWEEN 60 AND 100 THEN 'Senior (60+)'
        END
)

SELECT AgeGroup, ChurnCounts, (ChurnCounts * 1.0 / SUM(ChurnCounts) OVER ()) * 100 AS ChurnRate  
FROM Churned
ORDER BY ChurnRate DESC


-- Calculate churn rate by age and gender for Q3

SELECT Age, Gender, COUNT(*) AS ChurnCounts, (COUNT(*) * 1.0 / SUM(COUNT(*)) OVER ()) * 100 AS ChurnRate
FROM TelcoCustomerChurn
WHERE CustomerStatus = 'Churned'
GROUP BY Age, Gender
ORDER BY ChurnRate DESC


-- Calculate churn rate by age groups and gender for Q3

WITH Churned AS (
    SELECT 
        CASE
            WHEN Age BETWEEN 18 AND 39 THEN 'Young Adult (18-39)'
            WHEN Age BETWEEN 40 AND 59 THEN 'Middle-Aged (40-59)'
            WHEN Age BETWEEN 60 AND 100 THEN 'Senior (60+)'
        END AS AgeGroup, Gender, COUNT(*) AS ChurnCounts
    FROM TelcoCustomerChurn
    WHERE CustomerStatus = 'Churned'
    GROUP BY 
        CASE
            WHEN Age BETWEEN 18 AND 39 THEN 'Young Adult (18-39)'
            WHEN Age BETWEEN 40 AND 59 THEN 'Middle-Aged (40-59)'
             WHEN Age BETWEEN 60 AND 100 THEN 'Senior (60+)'
        END, Gender
)

SELECT AgeGroup, Gender, ChurnCounts, (ChurnCounts * 1.0 / SUM(ChurnCounts) OVER ()) * 100 AS ChurnRate  
FROM Churned
ORDER BY ChurnRate DESC


-- Calculate churn rate based on marital status for Q3

SELECT Married, COUNT(*) AS ChurnCounts, (COUNT(*) * 1.0 / SUM(COUNT(*)) OVER ()) * 100 AS ChurnRate
FROM TelcoCustomerChurn
WHERE CustomerStatus = 'Churned'
GROUP BY Married
ORDER BY ChurnRate DESC


-- Calculate churn rate based on dependent status for Q3

SELECT Dependents, COUNT(*) AS ChurnCounts, (COUNT(*) * 1.0 / SUM(COUNT(*)) OVER ()) * 100 AS ChurnRate
FROM TelcoCustomerChurn
WHERE CustomerStatus = 'Churned'
GROUP BY Dependents
ORDER BY ChurnRate DESC


-- Calculate churn rate by number of dependents for Q3

SELECT NumberofDependents, COUNT(*) AS ChurnCounts, (COUNT(*) * 1.0 / SUM(COUNT(*)) OVER ()) * 100 AS ChurnRate
FROM TelcoCustomerChurn
WHERE CustomerStatus = 'Churned'
GROUP BY NumberofDependents
ORDER BY ChurnRate DESC


-- Calculate churn rate by gender, marriage status, and number of dependents for Q3

SELECT 
    Gender,
    Married,
    NumberofDependents,
    COUNT(*) AS ChurnCounts,
    (COUNT(*) * 1.0 / (SELECT COUNT(*) FROM TelcoCustomerChurn WHERE CustomerStatus = 'Churned')) * 100 AS ChurnRate
FROM TelcoCustomerChurn
WHERE CustomerStatus = 'Churned'
GROUP BY Gender, Married, NumberofDependents
ORDER BY ChurnRate DESC


-- Calculate churn rate by city for Q3

SELECT City, COUNT(*) AS ChurnCounts, (COUNT(*) * 1.0 / SUM(COUNT(*)) OVER ()) * 100 AS ChurnRate
FROM TelcoCustomerChurn
WHERE CustomerStatus = 'Churned'
GROUP BY City
ORDER BY ChurnRate DESC


-- Calculate churn rate by city for Q3 (with total customer)

SELECT City, COUNT(*) AS TotalCustomers, COUNT(CASE WHEN CustomerStatus = 'Churned' THEN 1 END) AS ChurnCounts, (COUNT(CASE WHEN CustomerStatus = 'Churned' THEN 1 END) * 1.0 / (SELECT COUNT(*) FROM TelcoCustomerChurn WHERE CustomerStatus = 'Churned')) * 100 AS ChurnRate
FROM TelcoCustomerChurn
GROUP BY City
ORDER BY ChurnRate DESC


-- Calculate churn rate by city for Q3 (with total population)

--SELECT City, SUM(Population) AS TotalPopulation, COUNT(*) AS TotalCustomers, COUNT(CASE WHEN CustomerStatus = 'Churned' THEN 1 END) AS ChurnCounts 
--FROM TelcoCustomerChurn
--GROUP BY City
--ORDER BY ChurnCounts DESC


-- Calculate churn rate by tenure years for Q3

SELECT 
    CASE 
        WHEN TenureinMonths BETWEEN 0 AND 12 THEN '0-1 year'
        WHEN TenureinMonths BETWEEN 13 AND 36 THEN '1-3 years'
        WHEN TenureinMonths BETWEEN 37 AND 60 THEN '3-5 years'
        ELSE '5+ years'
    END AS TenureRange,
    COUNT(*) AS ChurnCounts,
    (COUNT(*) * 1.0 / (SELECT COUNT(*) FROM TelcoCustomerChurn WHERE CustomerStatus = 'Churned')) * 100 AS ChurnRate
FROM TelcoCustomerChurn
WHERE CustomerStatus = 'Churned'
GROUP BY 
    CASE 
        WHEN TenureinMonths BETWEEN 0 AND 12 THEN '0-1 year'
        WHEN TenureinMonths BETWEEN 13 AND 36 THEN '1-3 years'
        WHEN TenureinMonths BETWEEN 37 AND 60 THEN '3-5 years'
        ELSE '5+ years'
    END
ORDER BY ChurnRate DESC



-- Calculate churn rate by received offer for Q3

SELECT Offer, COUNT(*) AS ChurnCounts, (COUNT(*) * 1.0 / SUM(COUNT(*)) OVER ()) * 100 AS ChurnRate
FROM TelcoCustomerChurn
WHERE CustomerStatus = 'Churned'
GROUP BY Offer
ORDER BY ChurnRate DESC


-- Calculate churn rate by phone service and multiple lines for Q3

SELECT PhoneService, MultipleLines, COUNT(*) AS ChurnCounts, (COUNT(*) * 1.0 / SUM(COUNT(*)) OVER ()) * 100 AS ChurnRate
FROM TelcoCustomerChurn
WHERE CustomerStatus = 'Churned'
GROUP BY PhoneService, MultipleLines
ORDER BY ChurnRate DESC


-- Calculate churn rate by phone service and internet service for Q3

SELECT PhoneService, InternetService, COUNT(*) AS ChurnCounts, (COUNT(*) * 1.0 / SUM(COUNT(*)) OVER ()) * 100 AS ChurnRate
FROM TelcoCustomerChurn
WHERE CustomerStatus = 'Churned'
GROUP BY PhoneService, InternetService
ORDER BY ChurnRate DESC


-- Calculate churn rate based on internet service types for Q3

SELECT InternetType, COUNT(*) AS ChurnCounts, (COUNT(*) * 1.0 / SUM(COUNT(*)) OVER ()) * 100 AS ChurnRate
FROM TelcoCustomerChurn
WHERE CustomerStatus = 'Churned'
GROUP BY InternetType
ORDER BY ChurnRate DESC


-- Churn rate by internet service, internet service types, average monthly GB download for Q3

SELECT InternetService, InternetType, AvgMonthlyGBDownload, COUNT(*) AS ChurnCounts, (COUNT(*) * 1.0 / SUM(COUNT(*)) OVER ()) * 100 AS ChurnRate
FROM TelcoCustomerChurn
WHERE CustomerStatus = 'Churned'
GROUP BY InternetService, InternetType, AvgMonthlyGBDownload
ORDER BY ChurnRate DESC


-- Calculate Q3 churn rate based on customers' online security for Q3

SELECT OnlineSecurity, COUNT(*) AS ChurnCounts, (COUNT(*) * 1.0 / SUM(COUNT(*)) OVER ()) * 100 AS ChurnRate
FROM TelcoCustomerChurn
WHERE CustomerStatus = 'Churned'
GROUP BY OnlineSecurity
ORDER BY ChurnRate DESC


-- Calculate churn rate by online security, online backup, device protection, and premium tech support for Q3

SELECT OnlineSecurity, OnlineBackup, DeviceProtectionPlan, PremiumTechSupport, COUNT(*) AS ChurnCounts, (COUNT(*) * 1.0 / SUM(COUNT(*)) OVER ()) * 100 AS ChurnRate
FROM TelcoCustomerChurn
WHERE CustomerStatus = 'Churned'
GROUP BY OnlineSecurity, OnlineBackup, DeviceProtectionPlan, PremiumTechSupport
ORDER BY ChurnRate DESC


-- Calculate churn rate by streaming TV, streaming movies, and streaming music for Q3

SELECT StreamingTV, StreamingMovies, StreamingMusic, COUNT(*) AS ChurnCounts, (COUNT(*) * 1.0 / SUM(COUNT(*)) OVER ()) * 100 AS ChurnRate
FROM TelcoCustomerChurn
WHERE CustomerStatus = 'Churned'
GROUP BY StreamingTV, StreamingMovies, StreamingMusic
ORDER BY ChurnRate DESC


-- Calculate churn rate by contract 

SELECT Contract, COUNT(*) AS ChurnCounts, (COUNT(*) * 1.0 / SUM(COUNT(*)) OVER ()) * 100 AS ChurnRate
FROM TelcoCustomerChurn
WHERE CustomerStatus = 'Churned'
GROUP BY Contract
ORDER BY ChurnRate DESC


-- Calculate churn rate by  payment method


SELECT PaymentMethod, COUNT(*) AS ChurnCounts, (COUNT(*) * 1.0 / SUM(COUNT(*)) OVER ()) * 100 AS ChurnRate
FROM TelcoCustomerChurn
WHERE CustomerStatus = 'Churned'
GROUP BY PaymentMethod
ORDER BY ChurnRate DESC


-- Calculate churn rate by monthly charges

WITH Churned AS (
    SELECT 
        CASE
            WHEN MonthlyCharge BETWEEN 0 AND 25 THEN '0 - 25'
            WHEN MonthlyCharge BETWEEN 26 AND 50 THEN '26 - 50'
            WHEN MonthlyCharge BETWEEN 51 AND 75 THEN '51 - 75'
			ELSE '76+'
        END AS MonthlyCharges, COUNT(*) AS ChurnCounts
    FROM TelcoCustomerChurn
    WHERE CustomerStatus = 'Churned'
    GROUP BY 
        CASE
            WHEN MonthlyCharge BETWEEN 0 AND 25 THEN '0 - 25'
            WHEN MonthlyCharge BETWEEN 26 AND 50 THEN '26 - 50'
            WHEN MonthlyCharge BETWEEN 51 AND 75 THEN '51 - 75'
			ELSE '76+'
        END
)

SELECT MonthlyCharges, ChurnCounts, (ChurnCounts * 1.0 / SUM(ChurnCounts) OVER ()) * 100 AS ChurnRate  
FROM Churned
ORDER BY ChurnRate DESC


-- Calculate churn rate by total revenue

WITH Churned AS (
    SELECT 
        CASE
			WHEN TotalRevenue BETWEEN 0 AND 1000 THEN '0 - 1000'
			WHEN TotalRevenue BETWEEN 1001 AND 3000 THEN '1001 - 3000'
			WHEN TotalRevenue BETWEEN 3001 AND 5000 THEN '3001 - 5000'
			ELSE '5000+'
		END AS TotalRevenue, COUNT(*) AS ChurnCounts
    FROM TelcoCustomerChurn
    WHERE CustomerStatus = 'Churned'
    GROUP BY 
        CASE
			WHEN TotalRevenue BETWEEN 0 AND 1000 THEN '0 - 1000'
			WHEN TotalRevenue BETWEEN 1001 AND 3000 THEN '1001 - 3000'
			WHEN TotalRevenue BETWEEN 3001 AND 5000 THEN '3001 - 5000'
			ELSE '5000+'
		END
)

SELECT TotalRevenue, ChurnCounts, (ChurnCounts * 1.0 / SUM(ChurnCounts) OVER ()) * 100 AS ChurnRate  
FROM Churned
ORDER BY ChurnRate DESC


-- Calculate churn rate by satisfaction score for Q3

SELECT SatisfactionScore, COUNT(*) AS CustomerCounts, (COUNT(*) * 1.0 / SUM(COUNT(*)) OVER ()) * 100 AS Percentage
FROM TelcoCustomerChurn
GROUP BY SatisfactionScore
ORDER BY Percentage DESC

SELECT SatisfactionScore, COUNT(*) AS ChurnCounts, (COUNT(*) * 1.0 / SUM(COUNT(*)) OVER ()) * 100 AS ChurnRate
FROM TelcoCustomerChurn
WHERE CustomerStatus = 'Churned'
GROUP BY SatisfactionScore
ORDER BY ChurnRate DESC

 
 -- Calculate churn rate by customer status

SELECT CustomerStatus, COUNT(*) AS CustomerCounts, (COUNT(*) * 1.0 / (SELECT COUNT(*) FROM TelcoCustomerChurn)) * 100 AS Rate
FROM TelcoCustomerChurn
GROUP BY CustomerStatus
ORDER BY CustomerCounts DESC


-- Calculate average monthly charge by customer status

SELECT CustomerStatus, AVG(MonthlyCharge) AS AvgMonthlyCharge
FROM TelcoCustomerChurn
GROUP BY CustomerStatus


-- Calculate churn rate by churn category

SELECT ChurnCategory, COUNT(*) AS Count, (COUNT(*) * 1.0 / SUM(COUNT(*)) OVER ()) * 100 AS ChurnRate
FROM TelcoCustomerChurn
WHERE ChurnCategory IS NOT NULL
GROUP BY ChurnCategory
ORDER BY Count DESC


-- Calculate churn rate by churn reason

SELECT ChurnReason, COUNT(*) AS Count, (COUNT(*) * 1.0 / SUM(COUNT(*)) OVER ()) * 100 AS ChurnRate
FROM TelcoCustomerChurn
WHERE ChurnCategory IS NOT NULL
GROUP BY ChurnReason
ORDER BY Count DESC


-- Churn rate by CLTV segment for Q3

WITH CLTVSegments AS (
    SELECT 
        CASE 
            WHEN CLTV < 1000 THEN 'Low Value'
            WHEN CLTV BETWEEN 1000 AND 5000 THEN 'Mid Value'
            ELSE 'High Value'
        END AS CLTVSegment,
        COUNT(*) AS TotalCustomers,
        SUM(CASE WHEN CustomerStatus = 'Churned' THEN 1 ELSE 0 END) AS ChurnCounts,
        AVG(CLTV) AS AvgCLTV
    FROM TelcoCustomerChurn
    GROUP BY 
        CASE 
            WHEN CLTV < 1000 THEN 'Low Value'
            WHEN CLTV BETWEEN 1000 AND 5000 THEN 'Mid Value'
            ELSE 'High Value'
        END
)
SELECT 
    CLTVSegment, 
    ChurnCounts, 
    TotalCustomers,
    (ChurnCounts * 1.0 / TotalCustomers) * 100 AS ChurnRate, 
    AvgCLTV 
FROM CLTVSegments


-- Calculate overall retention rate

SELECT (COUNT(CASE WHEN CustomerStatus <> 'Churned' THEN 1 END) * 1.0 / COUNT(*)) * 100 AS RetentionRate
FROM TelcoCustomerChurn


-- Calculate total revenue lost due to churned customers

SELECT SUM(TotalRevenue) AS TotalRevenueLost
FROM TelcoCustomerChurn
WHERE CustomerStatus = 'Churned'










