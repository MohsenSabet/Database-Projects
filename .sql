/*
-- TABLE DROP STATEMENTS

SET VERIFICATION OFF

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE USERS CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE USERLOCATION CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE RESERVATION CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE RENTAL CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE PROMOTION CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE PAYMENT CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE MAINTENANCE CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE LOCATION CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/    
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE INSURANCEPACKAGE CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE CUSTOMERPROMOTION CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/    
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE CUSTOMERLOCATION CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/  
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE CUSTOMER CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;   
END;
/
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE CARINSURANCE CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;   
END;
/
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE CAR CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;   
END;
/

*/

/*
*********************************************************************
Name: Car rental managment system
Final project of DBS211NDD - Introduction to Database Systems
Author: Mohsen Sabet (113205165, msabetkoohenjani@myseneca.ca)
Author: Farzaneh Jahanian (176014215, Fjahanian@myseneca.ca)
*********************************************************************
*/


SET ECHO OFF;

    
/* NEW TABLE CREATION */ 
PROMPT '*******  Starting Table Creation';


PROMPT '******* Create Location table';
CREATE TABLE Location (
    LocationID INT PRIMARY KEY,
    Address VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(20) NOT NULL,
    Email VARCHAR(100) NOT NULL
);

-- Data for the table 'Location' (DML)
INSERT ALL 
    INTO Location  VALUES (1, '123 Main Street', '416-555-1234', 'mainstreetlocation@rental.com')
    INTO Location  VALUES (2, '456 Yonge Street', '416-555-5678', 'yongelocation@rental.com')
    INTO Location  VALUES (3, '789 Bay Street', '416-555-9012', 'baystreetlocation@rental.com')
    INTO Location  VALUES (4, '321 Queen Street West', '416-555-3456', 'queenwestlocation@rental.com')
    INTO Location  VALUES (5, '555 University Avenue', '416-555-7890', 'universitylocation@rental.com')
SELECT * FROM dual;
COMMIT;

PROMPT '******* Location data inserted';


PROMPT '******* Create Users table';

-- Users (DDL)
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL,
    Password VARCHAR(50) NOT NULL,
    UserRole VARCHAR(50) NOT NULL
);

-- Data for the table 'Users' (DML)

INSERT ALL 
    INTO Users  VALUES (1, 'admin', 'password', 'administrator')
    INTO Users  VALUES (2, 'jane.smith', 'johndoe123', 'manager')
    INTO Users  VALUES (3, 'jane.doe', 'janedoe123', 'manager')
    INTO Users  VALUES (4, 'jack.smith', 'jacksmith123', 'customer rep')
    INTO Users  VALUES (5, 'jill.johnson', 'jilljohnson123', 'customer rep')
SELECT * FROM dual;

COMMIT;

PROMPT '******* Users data inserted';


PROMPT '******* Create UserLocation  table';

CREATE TABLE UserLocation (
    UserID INT NOT NULL,
    LocationID INT NOT NULL,
    PRIMARY KEY (UserID, LocationID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (LocationID) REFERENCES Location(LocationID)
);

-- Data for the table 'UserLocation' (DML)

INSERT ALL 
    INTO UserLocation  VALUES (1, 1)
    INTO UserLocation  VALUES (2, 2)
    INTO UserLocation  VALUES (3, 3)
    INTO UserLocation  VALUES (4, 4)
    INTO UserLocation  VALUES (5, 5)
SELECT * FROM dual;

COMMIT;

PROMPT '******* UserLocation data inserted';

PROMPT '******* Create Customer tables';
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(20) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    DateOfBirth DATE NOT NULL,
    DriversLicenseNumber VARCHAR(50) NOT NULL
);


/*Data for the table 'Customer' (DML) */
INSERT ALL 
    INTO Customer  VALUES (1, 'Alex', 'Johnson', '100 King St W', '416-555-1234', 'alex.johnson@gmail.com', TO_DATE('1988-06-15', 'YYYY-MM-DD'), '123456789')
    INTO Customer  VALUES (2, 'Emily', 'Wong', '200 Queen St E', '416-555-5678', 'emily.wong@hotmail.com', TO_DATE('1975-03-10', 'YYYY-MM-DD'), '987654321')
    INTO Customer  VALUES (3, 'Sam', 'Lee', '300 Bay St', '416-555-9012', 'sam.lee@yahoo.com', TO_DATE('1992-12-05', 'YYYY-MM-DD'), '654321987')
    INTO Customer  VALUES (4, 'Sophia', 'Garcia', '400 Yonge St', '416-555-3456', 'sophia.garcia@gmail.com', TO_DATE('1980-11-22', 'YYYY-MM-DD'), '789456123')
    INTO Customer  VALUES (5, 'Daniel', 'Kim', '500 University Ave', '416-555-7890', 'daniel.kim@hotmail.com', TO_DATE('1977-09-30', 'YYYY-MM-DD'), '456123789')
SELECT * FROM dual;

COMMIT;

PROMPT '******* Customer data inserted';

PROMPT '******* Create Car table';

CREATE TABLE Car (
    VIN VARCHAR(17) PRIMARY KEY,
    Make VARCHAR(50) NOT NULL,
    Model VARCHAR(50) NOT NULL,
    Year INT NOT NULL,
    Color VARCHAR(50) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    RentalRate DECIMAL(6,2) NOT NULL,
    LocationID INT NOT NULL,
    Status VARCHAR(50) NOT NULL,
    CONSTRAINT FK_Car_Location FOREIGN KEY (LocationID)
        REFERENCES Location(LocationID)
);


INSERT ALL 
    INTO Car  VALUES ('1G1YY26E385133258', 'Chevrolet', 'Corvette', 2018, 'Black', 'Sports Car', 150.00, 1, 'Available')
    INTO Car  VALUES ('JN8AS5MV2DW106547', 'Nissan', 'Rogue', 2013, 'Silver', 'SUV', 75.00, 2, 'Available')
    INTO Car  VALUES ('1FAHP2E85DG174263', 'Ford', 'Taurus', 2013, 'White', 'Sedan', 65.00, 3, 'Available')
    INTO Car  VALUES ('KMHDN46D24U864675', 'Hyundai', 'Elantra', 2004, 'Red', 'Sedan', 40.00, 4, 'Not Available')
    INTO Car  VALUES ('2C3CDXCT6EH185923', 'Dodge', 'Charger', 2014, 'Blue', 'Sedan', 80.00, 5, 'Available')
SELECT * FROM dual;

COMMIT;

PROMPT '******* Car data inserted';


PROMPT '******* Create Reservation table';
CREATE TABLE Reservation (
    ReservationID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    CarVIN VARCHAR(17) NOT NULL,
    LocationID INT NOT NULL,
    PickUpDateTime TIMESTAMP NOT NULL,
    ReturnDateTime TIMESTAMP NOT NULL,
    CONSTRAINT FK_Reservation_Customer FOREIGN KEY (CustomerID)
        REFERENCES Customer(CustomerID),
    CONSTRAINT FK_Reservation_Car FOREIGN KEY (CarVIN)
        REFERENCES Car(VIN),
    CONSTRAINT FK_Reservation_Location FOREIGN KEY (LocationID)
        REFERENCES Location(LocationID)
);


/*Data for the table Reservation */
INSERT ALL 
    INTO Reservation  VALUES (1, 1, '1G1YY26E385133258', 1, TO_DATE('2023-05-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-05-03 17:00:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO Reservation  VALUES (2, 2, 'JN8AS5MV2DW106547', 2, TO_DATE('2023-05-05 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-05-08 15:00:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO Reservation  VALUES (3, 3, '1FAHP2E85DG174263', 3, TO_DATE('2023-05-10 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-05-12 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO Reservation  VALUES (4, 4, '2C3CDXCT6EH185923', 5, TO_DATE('2023-05-15 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-05-19 11:00:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO Reservation  VALUES (5, 5, '1G1YY26E385133258', 1, TO_DATE('2023-05-22 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-05-25 18:00:00', 'YYYY-MM-DD HH24:MI:SS'))
SELECT * FROM dual;

COMMIT;

PROMPT '******* Reservation data inserted';

PROMPT '******* Create Rental table';

CREATE TABLE Rental (
    RentalID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    CarVIN VARCHAR(17) NOT NULL,
    LocationID INT NOT NULL,
    PickUpDateTime TIMESTAMP NOT NULL,
    ReturnDateTime TIMESTAMP NOT NULL,
    AdditionalCharges DECIMAL(6,2) NOT NULL,
    CONSTRAINT FK_Rental_Customer FOREIGN KEY (CustomerID)
        REFERENCES Customer(CustomerID),
    CONSTRAINT FK_Rental_Car FOREIGN KEY (CarVIN)
        REFERENCES Car(VIN),
    CONSTRAINT FK_Rental_Location FOREIGN KEY (LocationID)
        REFERENCES Location(LocationID)
);


/*Data for the table 'Rental' */
INSERT ALL 
    INTO Rental  VALUES (1, 1, '1G1YY26E385133258', 1, TO_DATE('2023-05-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-05-03 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0.00)
    INTO Rental  VALUES (2, 2, 'JN8AS5MV2DW106547', 2, TO_DATE('2023-05-05 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-05-08 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0.00)
    INTO Rental  VALUES (3, 3, '1FAHP2E85DG174263', 3, TO_DATE('2023-05-10 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-05-12 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 50.00)
    INTO Rental  VALUES (4, 4, '2C3CDXCT6EH185923', 5, TO_DATE('2023-05-15 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-05-19 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 100.00)
    INTO Rental  VALUES (5, 5, '1G1YY26E385133258', 1, TO_DATE('2023-05-22 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-05-25 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 25.00)
SELECT * FROM dual;
COMMIT;

PROMPT '******* Rental data inserted';

PROMPT '******* Create Maintenance table';
CREATE TABLE Maintenance (
    MaintenanceID INT PRIMARY KEY,
    CarVIN VARCHAR(17) NOT NULL,
    ServiceDate DATE NOT NULL,
    ServicePerformed VARCHAR(100) NOT NULL,
    ServiceProvider VARCHAR(50) NOT NULL,
    CONSTRAINT FK_Maintenance_Car FOREIGN KEY (CarVIN)
        REFERENCES Car(VIN)
);


/*Data for the table 'Maintenance' */
INSERT ALL 
    INTO Maintenance  VALUES (1, '1G1YY26E385133258', TO_DATE('2022-10-01', 'YYYY-MM-DD'), 'Oil change', 'Joe''s Auto')
    INTO Maintenance  VALUES (2, 'JN8AS5MV2DW106547', TO_DATE('2023-01-15', 'YYYY-MM-DD'), 'Brake pad replacement', 'Tony''s Auto')
    INTO Maintenance  VALUES (3, '1FAHP2E85DG174263', TO_DATE('2023-02-05', 'YYYY-MM-DD'), 'Tire rotation', 'Steve''s Auto')
    INTO Maintenance  VALUES (4, '2C3CDXCT6EH185923', TO_DATE('2023-03-20', 'YYYY-MM-DD'), 'Air filter replacement', 'Mike''s Auto')
    INTO Maintenance  VALUES (5, '1G1YY26E385133258', TO_DATE('2023-04-10', 'YYYY-MM-DD'), 'Transmission fluid flush', 'Bob''s Auto')
SELECT * FROM dual;

COMMIT;

PROMPT '******* Maintenance data inserted';


PROMPT '******* Create Promotion table';
CREATE TABLE Promotion (
    PromotionID INT PRIMARY KEY,
    PromotionName VARCHAR(50),
    Description VARCHAR(100),
    StartDate DATE,
    EndDate DATE,
    DiscountPercentage DECIMAL(5,2)
);


/*Data for the table Promotion */
INSERT ALL 
    INTO Promotion  VALUES (1, 'Spring Sale', 'Get 20% off your rental rate this spring!', TO_DATE('2023-04-01', 'YYYY-MM-DD'), TO_DATE('2023-05-31', 'YYYY-MM-DD'), 20.00)
    INTO Promotion  VALUES (2, 'Summer Special', 'Rent for 7 days, get 2 days free!', TO_DATE('2023-06-01', 'YYYY-MM-DD'), TO_DATE('2023-08-31', 'YYYY-MM-DD'), 28.57)
    INTO Promotion  VALUES (3, 'Back to School', 'Get a free GPS rental with any car rental!', TO_DATE('2023-09-01', 'YYYY-MM-DD'), TO_DATE('2023-09-30', 'YYYY-MM-DD'), 0.00)
    INTO Promotion  VALUES (4, 'Fall Foliage', 'Rent for 4 days, get 1 day free!', TO_DATE('2023-10-01', 'YYYY-MM-DD'), TO_DATE('2023-11-30', 'YYYY-MM-DD'), 25.00)
    INTO Promotion  VALUES (5, 'Winter Wonderland', 'Get 10% off your rental rate this winter!', TO_DATE('2023-12-01', 'YYYY-MM-DD'), TO_DATE('2024-02-28', 'YYYY-MM-DD'), 10.00)
SELECT * FROM dual;


COMMIT;

PROMPT '******* Promotion data inserted';

PROMPT '******* Create CustomerPromotion  table';
CREATE TABLE CustomerPromotion (
    CustomerID INT,
    PromotionID INT,
    PRIMARY KEY (CustomerID, PromotionID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (PromotionID) REFERENCES Promotion(PromotionID)
);



/*Data for the table CustomerPromotion  */
INSERT ALL 
    INTO CustomerPromotion  VALUES (1, 1)
    INTO CustomerPromotion  VALUES (2, 2)
    INTO CustomerPromotion  VALUES (3, 3)
    INTO CustomerPromotion  VALUES (4, 4)
    INTO CustomerPromotion  VALUES (5, 5)
SELECT * FROM dual;

COMMIT;

PROMPT '******* CustomerPromotion data inserted';

PROMPT '******* Create InsurancePackage  table';
CREATE TABLE InsurancePackage (
    InsuranceID INT PRIMARY KEY,
    InsuranceName VARCHAR(50),
    Description VARCHAR(100),
    CoverageDetails VARCHAR(200),
    Price DECIMAL(10,2)
);


/*Data for the table InsurancePackage  */
INSERT ALL 
    INTO InsurancePackage  VALUES (1, 'Basic Coverage', 'Covers collision, theft, and damage up to $25K.', 'Collision, theft, and damage coverage up to $25K.', 15.00)
    INTO InsurancePackage  VALUES (2, 'Premium Coverage', 'Covers collision, theft, and damage up to $50K.', 'Collision, theft, and damage coverage up to $50K and liability up to $1M.', 25.00)
    INTO InsurancePackage  VALUES (3, 'Full Coverage', 'Covers collision, theft, and damage up to $100K.', 'Collision, theft, and damage coverage up to $100K, liability up to $2M, and medical up to $25K.', 35.00)
SELECT * FROM dual;

COMMIT;

PROMPT '******* InsurancePackage data inserted';


PROMPT '******* Create CarInsurance  table';
CREATE TABLE CarInsurance (
    CarVIN VARCHAR(17),
    InsuranceID INT,
    PRIMARY KEY (CarVIN, InsuranceID),
    FOREIGN KEY (CarVIN) REFERENCES Car(VIN),
    FOREIGN KEY (InsuranceID) REFERENCES InsurancePackage(InsuranceID)
);

INSERT ALL 
    INTO CarInsurance  VALUES ('1G1YY26E385133258', 1)
    INTO CarInsurance  VALUES ('1G1YY26E385133258', 2)
    INTO CarInsurance  VALUES ('JN8AS5MV2DW106547', 2)
    INTO CarInsurance  VALUES ('1FAHP2E85DG174263', 1)
    INTO CarInsurance  VALUES ('2C3CDXCT6EH185923', 3)
SELECT * FROM dual;

COMMIT;
PROMPT '******* CarInsurance data inserted';



PROMPT '******* Create CustomerLocation  table';
CREATE TABLE CustomerLocation (
    CustomerID INT,
    LocationID INT,
    PRIMARY KEY (CustomerID, LocationID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (LocationID) REFERENCES Location(LocationID)
);

/*Data for the table CustomerLocation  */
INSERT ALL 
    INTO CustomerLocation  VALUES (1, 1)
    INTO CustomerLocation  VALUES (2, 2)
    INTO CustomerLocation  VALUES (3, 3)
    INTO CustomerLocation  VALUES (4, 4)
    INTO CustomerLocation  VALUES (5, 5)
SELECT * FROM dual;

COMMIT;
PROMPT '******* CustomerLocation data inserted';


/*Table structure for table 'Payment' */

PROMPT '******* Create Payment  table';
CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    RentalID INT,
    PaymentMethod VARCHAR(50),
    Amount DECIMAL(10,2),
    PaymentDate DATE,
    CONSTRAINT fk_payment_rental
        FOREIGN KEY (RentalID)
        REFERENCES Rental(RentalID)
);


/*Data for the table Payment  */
INSERT ALL
	INTO Payment  VALUES (1, 1, 'Credit Card', 150.00, TO_DATE('2022-01-05', 'YYYY-MM-DD'))
	INTO Payment  VALUES (2, 2, 'Debit Card', 75.00, TO_DATE('2022-01-10', 'YYYY-MM-DD'))
	INTO Payment  VALUES (3, 3, 'Cash', 65.00, TO_DATE('2022-02-12', 'YYYY-MM-DD'))
	INTO Payment  VALUES (4, 4, 'Credit Card', 40.00, TO_DATE('2022-02-20', 'YYYY-MM-DD'))
	INTO Payment  VALUES (5, 5, 'Debit Card', 80.00, TO_DATE('2022-03-01', 'YYYY-MM-DD'))
SELECT * FROM dual;

COMMIT;
PROMPT '******* Payment data inserted';



PROMPT '******* CREATION SCRIPT COMPLETED ************';
SET VERIFICATION ON
SET ECHO ON