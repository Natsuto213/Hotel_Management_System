-- Xóa database nếu đã tồn tại
IF DB_ID('HotelManagement') IS NOT NULL
BEGIN
    ALTER DATABASE HotelManagement SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE HotelManagement;
END
GO

-- Create Database
CREATE DATABASE HotelManagement;
GO

USE HotelManagement;
GO

-- ==========================
-- 1. Guest Table
-- ==========================
CREATE TABLE GUEST (
    GuestID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
	Username NVARCHAR(50) UNIQUE NOT NULL,
    PasswordHash NVARCHAR(255) NOT NULL,
    Phone NVARCHAR(20) UNIQUE,
    Email NVARCHAR(100) UNIQUE,
    Address NVARCHAR(200),
    IDNumber NVARCHAR(50),   -- Passport/ID Card
    DateOfBirth DATE
);
    
-- ==========================
-- 2. Room Type Table
-- ==========================
CREATE TABLE ROOM_TYPE (
    RoomTypeID INT IDENTITY(1,1) PRIMARY KEY,
    TypeName NVARCHAR(50) NOT NULL,
    Capacity INT NOT NULL CHECK (Capacity > 0),
    PricePerNight DECIMAL(10,2) NOT NULL CHECK (PricePerNight >= 0)
);

-- ==========================
-- 3. Room Table
-- ==========================
CREATE TABLE ROOM (
    RoomID INT IDENTITY(1,1) PRIMARY KEY,
    RoomNumber NVARCHAR(10) UNIQUE NOT NULL,
    RoomTypeID INT NOT NULL,
    Status NVARCHAR(20) CHECK (Status IN ('Available', 'Occupied', 'Dirty', 'Maintenance')),
    FOREIGN KEY (RoomTypeID) REFERENCES ROOM_TYPE(RoomTypeID)
);

-- ==========================
-- 4. Booking Table
-- ==========================
CREATE TABLE BOOKING (
    BookingID INT IDENTITY(1,1) PRIMARY KEY,
    GuestID INT NOT NULL,
    RoomID INT NOT NULL,
    CheckInDate DATE NOT NULL,
    CheckOutDate DATE NOT NULL,
    BookingDate DATE DEFAULT GETDATE(),
    Status NVARCHAR(20) CHECK (Status IN ('Reserved', 'Checked-in', 'Checked-out', 'Canceled', 'Completed')),
    FOREIGN KEY (GuestID) REFERENCES GUEST(GuestID),
    FOREIGN KEY (RoomID) REFERENCES ROOM(RoomID),
    CHECK (CheckOutDate > CheckInDate)
);

-- ==========================
-- 5. Service Table
-- ==========================
CREATE TABLE SERVICE (
    ServiceID INT IDENTITY(1,1) PRIMARY KEY,
    ServiceName NVARCHAR(100) NOT NULL,
    ServiceType NVARCHAR(50),  -- e.g., Food, Laundry, Spa
    Price DECIMAL(10,2) NOT NULL CHECK (Price >= 0)
);

-- ==========================
-- 6. Booking_Service Table
-- ==========================
CREATE TABLE BOOKING_SERVICE (
    Booking_Service_ID int identity(1,1) primary key,
    BookingID INT NOT NULL,
    ServiceID INT NOT NULL,
    Quantity INT DEFAULT 1 CHECK (Quantity > 0),
    ServiceDate DATE DEFAULT GETDATE(),   
	Status INT check(Status = 1 or Status = 0),
    FOREIGN KEY (BookingID) REFERENCES BOOKING(BookingID),
    FOREIGN KEY (ServiceID) REFERENCES SERVICE(ServiceID)
);

-- ==========================
-- 7. Invoice Table
-- ==========================
CREATE TABLE INVOICE (
    InvoiceID INT IDENTITY(1,1) PRIMARY KEY,
    BookingID INT NOT NULL UNIQUE,
    IssueDate DATE DEFAULT GETDATE(),
    TotalAmount DECIMAL(12,2) NOT NULL CHECK (TotalAmount >= 0),
    Status NVARCHAR(20) CHECK (Status IN ('Unpaid', 'Paid', 'Canceled')),
    FOREIGN KEY (BookingID) REFERENCES BOOKING(BookingID)
);

-- ==========================
-- 8. Payment Table
-- ==========================
CREATE TABLE PAYMENT (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    BookingID INT NOT NULL,
    PaymentDate DATE DEFAULT GETDATE(),
    Amount DECIMAL(12,2) NOT NULL CHECK (Amount >= 0),
    PaymentMethod NVARCHAR(50) CHECK (PaymentMethod IN ('Cash', 'Credit Card', 'Debit Card', 'Online')),
    Status NVARCHAR(20) CHECK (Status IN ('Pending', 'Completed', 'Failed')),
    FOREIGN KEY (BookingID) REFERENCES BOOKING(BookingID)
);

-- ==========================
-- 9. Staff Table
-- ==========================
CREATE TABLE STAFF (
    StaffID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Role NVARCHAR(50) CHECK (Role IN ('Receptionist', 'Manager', 'Housekeeping', 'ServiceStaff', 'Admin')),
    Username NVARCHAR(50) UNIQUE NOT NULL,
    PasswordHash NVARCHAR(255) NOT NULL, -- store hashed password
    Phone NVARCHAR(20),
    Email NVARCHAR(100)
);


-- ==========================
-- Sample Data (Optional)
-- ==========================

INSERT INTO SERVICE (ServiceName, ServiceType, Price)
VALUES
('Breakfast', 'Food', 10.00),
('Laundry', 'Laundry', 5.00),
('Spa Massage', 'Spa', 30.00);

-- ==========================
-- UPDATE ROOM_TYPE (Giữ nguyên 6 loại, điều chỉnh capacity & price)
-- ==========================
INSERT INTO ROOM_TYPE (TypeName, Capacity, PricePerNight)
VALUES
('Single', 1, 1500000.00),
('Double', 2, 2500000.00),
('Deluxe', 4, 4999000.00),
('Suite', 4, 6999000.00),
('Family', 6, 9999000.00),
('Presidential', 6, 11999000.00);

-- ==========================
-- INSERT ROOM (20 phòng)
-- ==========================

INSERT INTO ROOM (RoomNumber, RoomTypeID, Status)
VALUES
('101', 2002, 'Available'),
('102', 2002, 'Available'),
('103', 2002, 'Available'),
('104', 2003, 'Available'),
('105', 2003, 'Available'),
('201', 2003, 'Available'),
('202', 2003, 'Available'),
('203', 2004, 'Available'),
('204', 2004, 'Available'),
('301', 2004, 'Available'),
('302', 2004, 'Available'),
('303', 2005, 'Available'),
('304', 2005, 'Available'),
('401', 2005, 'Available'),
('402', 2006, 'Available'),
('403', 2006, 'Available'),
('501', 2006, 'Available'),
('502', 2007, 'Available'),
('503', 2007, 'Available'),
('504', 2007, 'Available');

-- ==========================
-- INSERT STAFF (15 nhân viên đủ các role)
-- ==========================
INSERT INTO STAFF (FullName, Role, Username, PasswordHash, Phone, Email)
VALUES
-- ✳ Receptionist (3)
('Nguyen Thu Hang', 'Receptionist', 'recept_hang', 'hash123', '0901000101', 'hang.recept@hotel.com'),
('Tran Quoc Khanh', 'Receptionist', 'recept_khanh', 'hash123', '0901000102', 'khanh.recept@hotel.com'),
('Pham Ngoc Bich', 'Receptionist', 'recept_bich', 'hash123', '0901000103', 'bich.recept@hotel.com'),

-- ✳ Manager (2)
('Le Minh Hoang', 'Manager', 'manager_hoang', 'hash123', '0901000104', 'hoang.manager@hotel.com'),
('Vu Thi Hong Nhung', 'Manager', 'manager_nhung', 'hash123', '0901000105', 'nhung.manager@hotel.com'),

-- ✳ Housekeeping (3)
('Ngo Van Dung', 'Housekeeping', 'house_dung', 'hash123', '0901000106', 'dung.house@hotel.com'),
('Dang Thi Cuc', 'Housekeeping', 'house_cuc', 'hash123', '0901000107', 'cuc.house@hotel.com'),
('Luu Thanh Tam', 'Housekeeping', 'house_tam', 'hash123', '0901000108', 'tam.house@hotel.com'),

-- ✳ ServiceStaff (3)
('Phan Huu Toan', 'ServiceStaff', 'service_toan', 'hash123', '0901000109', 'toan.service@hotel.com'),
('Nguyen My Linh', 'ServiceStaff', 'service_linh', 'hash123', '0901000110', 'linh.service@hotel.com'),
('Tran Dang Khoa', 'ServiceStaff', 'service_khoa', 'hash123', '0901000111', 'khoa.service@hotel.com'),

-- ✳ Admin (4)
('Bui Duc Anh', 'Admin', 'admin_anh', 'adminhash', '0901000112', 'anh.admin@hotel.com'),
('Doan Hai Yen', 'Admin', 'admin_yen', 'adminhash', '0901000113', 'yen.admin@hotel.com'),
('Nguyen Hoang Phuc', 'Admin', 'admin_phuc', 'adminhash', '0901000114', 'phuc.admin@hotel.com'),
('Trinh Minh Trang', 'Admin', 'admin_trang', 'adminhash', '0901000115', 'trang.admin@hotel.com');

-- ==========================
-- INSERT GUEST (20 khách)
-- ==========================
INSERT INTO GUEST (FullName, Username, PasswordHash, Phone, Email, Address, IDNumber, DateOfBirth)
VALUES
('Nguyen Minh Khang', 'khang01', 'guesthash', '0912000001', 'khang01@gmail.com', 'Hanoi', '012345001', '1995-01-10'),
('Tran Thi Lan', 'lan02', '123', '0912000002', 'lan02@gmail.com', 'Hanoi', '012345002', '1997-03-12'),
('Le Van Tuan', 'tuan03', '123', '0912000003', 'tuan03@gmail.com', 'Hue', '012345003', '1992-07-15'),
('Pham Thi Mai', 'mai04', '123', '0912000004', 'mai04@gmail.com', 'Da Nang', '012345004', '1999-12-01'),
('Do Quang Huy', 'huy05', '123', '0912000005', 'huy05@gmail.com', 'HCMC', '012345005', '1994-06-21'),
('Nguyen Thi Ngoc', 'ngoc06', '123', '0912000006', 'ngoc06@gmail.com', 'HCMC', '012345006', '1998-11-18'),
('Tran Van Phuc', 'phuc07', '123', '0912000007', 'phuc07@gmail.com', 'Da Lat', '012345007', '1991-08-03'),
('Le Thi Kim', 'kim08', '123', '0912000008', 'kim08@gmail.com', 'Hai Phong', '012345008', '1996-02-19'),
('Pham Van Long', 'long09', '123', '0912000009', 'long09@gmail.com', 'Nha Trang', '012345009', '1990-05-27'),
('Bui Thi Hoa', 'hoa10', '123', '0912000010', 'hoa10@gmail.com', 'Can Tho', '012345010', '1993-09-15'),
('Vo Thanh Nam', 'nam11', '123', '0912000011', 'nam11@gmail.com', 'Hanoi', '012345011', '1989-04-09'),
('Nguyen Van Quang', 'quang12', '123', '0912000012', 'quang12@gmail.com', 'HCMC', '012345012', '1997-10-20'),
('Tran Thi Yen', 'yen13', '123', '0912000013', 'yen13@gmail.com', 'Hue', '012345013', '1998-07-11'),
('Do Anh Duc', 'duc14', '123', '0912000014', 'duc14@gmail.com', 'Da Nang', '012345014', '1994-12-23'),
('Hoang Thi Hanh', 'hanh15', '123', '0912000015', 'hanh15@gmail.com', 'Ha Long', '012345015', '1995-06-17'),
('Le Minh Tri', 'tri16', '123', '0912000016', 'tri16@gmail.com', 'HCMC', '012345016', '1993-03-08'),
('Nguyen Thi Huong', 'huong17', '123', '0912000017', 'huong17@gmail.com', 'Hanoi', '012345017', '1999-01-25'),
('Tran Van Tien', 'tien18', '123', '0912000018', 'tien18@gmail.com', 'Da Nang', '012345018', '1992-11-29'),
('Pham Ngoc Bao', 'bao19', '123', '0912000019', 'bao19@gmail.com', 'Hue', '012345019', '1990-02-22'),
('Do Thi Linh', 'linh20', '123', '0912000020', 'linh20@gmail.com', 'Hanoi', '012345020', '1996-09-09');
