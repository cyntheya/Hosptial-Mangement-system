CREATE DATABASE HospitalManagement;


USE HospitalManagement;

CREATE TABLE Department
(
    Department_ID INT PRIMARY KEY,
    Department_Name VARCHAR(100) NOT NULL
);

CREATE TABLE Doctor
(
    Doctor_ID INT PRIMARY KEY,
    Doctor_Name VARCHAR(100) NOT NULL,
    Specialization VARCHAR(100),
    Department_ID INT,
    Salary DECIMAL(10,2),

    FOREIGN KEY (Department_ID)
    REFERENCES Department(Department_ID)
);

CREATE TABLE Patients
(
    Patient_ID INT PRIMARY KEY,
    Patient_Name VARCHAR(100) NOT NULL,
    Gender VARCHAR(10),
    Age INT,
    Phone VARCHAR(15),
    City VARCHAR(50)
);

CREATE TABLE Appointments
(
    Appointment_ID INT PRIMARY KEY,
    Patient_ID INT,
    Doctor_ID INT,
    Appointment_Date DATE,
    Appointment_Status VARCHAR(30),

    FOREIGN KEY (Patient_ID)
    REFERENCES Patients(Patient_ID),

    FOREIGN KEY (Doctor_ID)
    REFERENCES Doctor(Doctor_ID)
);
CREATE TABLE Treatments
(
    Treatment_ID INT PRIMARY KEY,
    Patient_ID INT,
    Doctor_ID INT,
    Treatment_Name VARCHAR(100),
    Treatment_Cost DECIMAL(10,2),

    FOREIGN KEY (Patient_ID)
    REFERENCES Patients(Patient_ID),

    FOREIGN KEY (Doctor_ID)
    REFERENCES Doctor(Doctor_ID)
);

CREATE TABLE Payments
(
    Payment_ID INT PRIMARY KEY,
    Patient_ID INT,
    Treatment_ID INT,
    Payment_Date DATE,
    Amount DECIMAL(10,2),
    Payment_Status VARCHAR(30),

    FOREIGN KEY (Patient_ID)
    REFERENCES Patients(Patient_ID),

    FOREIGN KEY (Treatment_ID)
    REFERENCES Treatments(Treatment_ID)
);

INSERT INTO Department VALUES
(1, 'Cardiology'),
(2, 'Neurology'),
(3, 'Orthopedics'),
(4, 'General Medicine'),
(5, 'Pediatrics');


INSERT INTO Appointments VALUES
(301, 201, 101, '2026-09-01', 'Completed'),
(302, 202, 102, '2026-09-03', 'Completed'),
(303, 203, 103, '2026-09-05', 'Pending'),
(304, 204, 104, '2026-09-10', 'Completed'),
(305, 205, 105, '2026-09-12', 'Completed'),
(306, 201, 101, '2026-09-15', 'Completed');

INSERT INTO Patients VALUES
(201, 'Rahul', 'Male', 35, '9876543210', 'Bangalore'),
(202, 'Priya', 'Female', 28, '9876543211', 'Chennai'),
(203, 'Arun', 'Male', 45, '9876543212', 'Bangalore'),
(204, 'Divya', 'Female', 32, '9876543213', 'Madurai'),
(205, 'Karthik', 'Male', 10, '9876543214', 'Trichy');

INSERT INTO Doctor VALUES
(101, 'Dr. Arun', 'Cardiologist', 1, 90000),
(102, 'Dr. Priya', 'Neurologist', 2, 85000),
(103, 'Dr. Kumar', 'Orthopedic', 3, 80000),
(104, 'Dr. Anitha', 'General Physician', 4, 70000),
(105, 'Dr. Ravi', 'Pediatrician', 5, 75000);

INSERT INTO Treatments VALUES
(401, 201, 101, 'Heart Checkup', 5000),
(402, 202, 102, 'Brain Scan', 8000),
(403, 203, 103, 'Bone Treatment', 6000),
(404, 204, 104, 'General Checkup', 2000),
(405, 205, 105, 'Child Checkup', 1500),
(406, 201, 101, 'ECG Test', 3000);

INSERT INTO Payments VALUES
(501, 201, 401, '2026-09-01', 5000, 'Success'),
(502, 202, 402, '2026-09-03', 8000, 'Success'),
(503, 203, 403, '2026-09-05', 6000, 'Pending'),
(504, 204, 404, '2026-09-10', 2000, 'Success'),
(505, 205, 405, '2026-09-12', 1500, 'Success'),
(506, 201, 406, '2026-09-15', 3000, 'Success');

SELECT * 
FROM Patients;

SELECT 
    P.Patient_Name,
    D.Doctor_Name,
    A.Appointment_Date,
    A.Appointment_Status
FROM Patients P
JOIN Appointments A
    ON P.Patient_ID = A.Patient_ID
JOIN Doctor D
    ON A.Doctor_ID = D.Doctor_ID;

    SELECT
    D.Doctor_Name,
    D.Specialization,
    DP.Department_Name
FROM Doctor D
JOIN Department DP
    ON D.Department_ID = DP.Department_ID;

    SELECT 
    SUM(Amount) AS Total_Revenue
FROM Payments
WHERE Payment_Status = 'Success';

SELECT
    P.Patient_Name,
    SUM(PY.Amount) AS Total_Amount
FROM Patients P
JOIN Payments PY
    ON P.Patient_ID = PY.Patient_ID
WHERE PY.Payment_Status = 'Success'
GROUP BY P.Patient_Name;

SELECT
    D.Doctor_Name,
    COUNT(A.Appointment_ID) AS Total_Appointments
FROM Doctor D
JOIN Appointments A
    ON D.Doctor_ID = A.Doctor_ID
GROUP BY D.Doctor_Name;

SELECT
    D.Doctor_Name,
    COUNT(A.Appointment_ID) AS Total_Appointments
FROM Doctor D
JOIN Appointments A
    ON D.Doctor_ID = A.Doctor_ID
GROUP BY D.Doctor_Name
HAVING COUNT(A.Appointment_ID) > 1;

SELECT TOP 1
    Treatment_Name,
    Treatment_Cost
FROM Treatments
ORDER BY Treatment_Cost DESC;

SELECT
    Payment_Status,
    COUNT(*) AS Total_Payments,
    SUM(Amount) AS Total_Amount
FROM Payments
GROUP BY Payment_Status;

SELECT *
FROM Patients
WHERE City = 'Bangalore';

SELECT
    MONTH(Payment_Date) AS Payment_Month,
    SUM(Amount) AS Monthly_Revenue
FROM Payments
WHERE Payment_Status = 'Success'
GROUP BY MONTH(Payment_Date)
ORDER BY Payment_Month;


