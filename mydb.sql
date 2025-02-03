create database mydb;
use mydb;

-- Create Venues table
CREATE TABLE Venues (
  Venue_ID INT AUTO_INCREMENT PRIMARY KEY,
  Venue_Name VARCHAR(100) NOT NULL,
  Address VARCHAR(200) NOT NULL,
  Capacity INT NOT NULL,
  Contact_Person VARCHAR(100),
  Contact_Email VARCHAR(100),
  Contact_Phone VARCHAR(20)
);

INSERT INTO Venues (Venue_Name, Address, Capacity, Contact_Person, Contact_Email, Contact_Phone)
VALUES
  ('Convention Center', '1 Main St, Cityville', 2000, 'John Smith', 'john@conventioncenter.com', '123-456-7890'),
  ('Auditorium', '5 Park Ave, Townsville', 500, 'Jane Doe', 'jane@auditorium.com', '987-654-3210'),
  ('Art Gallery', '10 Museum Rd, Villagetown', 150, 'Alice Johnson', 'alice@artgallery.com', '111-222-3333'),
  ('Coworking Space', '15 Tech Lane, Hamletville', 100, 'Bob Brown', 'bob@coworking.com', '444-555-6666'),
  ('Hotel Grand', '20 Central Ave, Lodgetown', 800, 'Carol White', 'carol@hotelgrand.com', '777-888-9999');
  
  -- Create Participants table
CREATE TABLE Participants (
  Participant_ID INT AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(100) NOT NULL,
  Email VARCHAR(100) NOT NULL UNIQUE, -- Enforce unique email addresses
  Phone VARCHAR(20),
  Organization VARCHAR(100)
);

INSERT INTO Participants (Name, Email, Phone, Organization)
VALUES
  ('Michael Lee', 'michael.lee@gmail.com', '555-123-4567', 'Tech Company Inc.'),
  ('Sarah Jones', 'sarah.jones@yahoo.com', '222-333-4444', 'Marketing Agency'),
  ('David Williams', 'david.williams@outlook.com', '111-555-7777', 'University'),
  ('Emily Brown', 'emily.brown@hotmail.com', '999-888-6666', 'Freelancer'),
  ('Daniel Garcia', 'daniel.garcia@aol.com', '333-222-1111', 'Non-Profit Organization');
  
  -- Create Speakers table
CREATE TABLE Speakers (
  Speaker_ID INT AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(100) NOT NULL,
  Bio VARCHAR(500),
  Contact_Information VARCHAR(200)
);

-- Inserting data into the Speakers table
INSERT INTO Speakers (Name, Bio, Contact_Information) VALUES
('John Doe', 'Speaker bio for John Doe', 'john@example.com'),
('Jane Smith', 'Speaker bio for Jane Smith', 'jane@example.com'),
('Alice Johnson', 'Speaker bio for Alice Johnson', 'alice@example.com'),
('Michael Brown', 'Speaker bio for Michael Brown', 'michael@example.com'),
('Emily Davis', 'Speaker bio for Emily Davis', 'emily@example.com');


-- Create Staff table
CREATE TABLE Staff (
  Staff_ID INT AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(100) NOT NULL,
  Email VARCHAR(100) NOT NULL UNIQUE, -- Enforce unique email addresses
  Phone VARCHAR(20),
  Role VARCHAR(50)
);

INSERT INTO Staff (Name, Email, Phone, Role)
VALUES
  ('John Smith', 'john.smith@company.com', '555-123-4567', 'Event Manager'),
  ('Jane Doe', 'jane.doe@company.com', '222-333-4444', 'Marketing Specialist'),
  ('David Williams', 'david.williams@company.com', '111-555-7777', 'Technical Lead'),
  ('Emily Brown', 'emily.brown@company.com', '999-888-6666', 'Registration Coordinator'),
  ('Daniel Garcia', 'daniel.garcia@company.com', '333-222-1111', 'Logistics Coordinator');
  
  -- Create Sponsors table
CREATE TABLE Sponsors (
  Sponsor_ID INT AUTO_INCREMENT PRIMARY KEY,
  Sponsor_Name VARCHAR(100) NOT NULL,
  Contact_Person VARCHAR(100),
  Contact_Email VARCHAR(100),
  Contact_Phone VARCHAR(20),
  Sponsorship_Level VARCHAR(50),
  Amount_Sponsored DECIMAL(10,2) NOT NULL DEFAULT 0, -- Use DECIMAL for currency values
  CONSTRAINT chk_Amount_Sponsored CHECK (Amount_Sponsored >= 0) -- Check if amount sponsored is non-negative
);

INSERT INTO Sponsors (Sponsor_Name, Contact_Person, Contact_Email, Contact_Phone, Sponsorship_Level, Amount_Sponsored)
VALUES
  ('Tech Giant Inc.', 'Sarah Lee', 'sarah.lee@techgiant.com', '123-456-7890', 'Platinum', 10000.00),
  ('Marketing Agency', 'David Miller', 'david.miller@marketingagency.com', '555-222-1111', 'Gold', 5000.00),
  ('Software Solutions', 'Emily Jones', 'emily.jones@softwaresolutions.com', '987-654-3210', 'Silver', 2500.00),
  ('Cloud Provider', 'Michael Brown', 'michael.brown@cloudprovider.com', '444-333-2222', 'Bronze', 1000.00),
  ('Non-Profit Organization', 'Alice Garcia', 'alice.garcia@nonprofit.org', '777-888-9999', 'In-Kind', 2000.00);
  
  CREATE TABLE Events (
  Event_ID INT AUTO_INCREMENT PRIMARY KEY,
  Event_Name VARCHAR(100) NOT NULL,
  Event_Date DATE NOT NULL,
  Event_Time DATETIME NOT NULL,  -- DATETIME for combined date and time
  Venue_ID INT NOT NULL,
  Description VARCHAR(500),
  CONSTRAINT fk_Events_Venues FOREIGN KEY (Venue_ID) REFERENCES Venues(Venue_ID)
);

INSERT INTO Events (Event_Name, Event_Date, Event_Time, Venue_ID, Description)
VALUES
  ('Tech Conference 2024', '2024-06-15', '09-00-00', 1, 'A gathering of tech enthusiasts and industry leaders'),
  ('Art Exhibition Opening', '2024-05-20', '18-00-00', 3, 'Showcase of local and international contemporary art'),
  ('Community Workshop', '2024-07-10', '10-00-00', 4, 'Interactive session on sustainable living practices'),
  ('Networking Mixer', '2024-04-25', '17-00-00', 2, 'Opportunity to connect with professionals across various fields'),
  ('Summer Music Festival', '2024-08-12', '14-00-00', 5, 'Live music performances by popular artists');

-- Create Tickets table
CREATE TABLE Tickets (
  Ticket_ID INT AUTO_INCREMENT PRIMARY KEY,
  Event_ID INT NOT NULL,
  Price DECIMAL(10,2) NOT NULL, -- Use DECIMAL for currency values
  Type VARCHAR(50) NOT NULL,
  Availability INT NOT NULL DEFAULT 0,
  Sale_Date DATE,
  CONSTRAINT fk_Tickets_Events FOREIGN KEY (Event_ID) REFERENCES Events(Event_ID),
  CONSTRAINT chk_Ticket_Price CHECK (Price > 0), -- Check if ticket price is positive
  CONSTRAINT chk_Ticket_Availability CHECK (Availability >= 0) -- Check if availability is non-negative
);

-- Inserting data into the Tickets table
INSERT INTO Tickets (Event_ID, Price, Type, Availability, Sale_Date) VALUES
(1, 50.00, 'General Admission', 100, '2024-04-01'),
(1, 75.00, 'VIP', 50, '2024-04-01'),
(2, 30.00, 'Standard', 200, '2024-03-15'),
(2, 40.00, 'Premium', 150, '2024-03-15'),
(3, 20.00, 'Early Bird', 300, '2024-04-10');

-- Create Budget table
CREATE TABLE Budget (
  Budget_ID INT AUTO_INCREMENT PRIMARY KEY,
  Event_ID INT NOT NULL,
  Total_Budget DECIMAL(10,2) NOT NULL, -- Use DECIMAL for currency values
  Allocation_Details VARCHAR(500),
  Expenditure DECIMAL(10,2), -- Use DECIMAL for currency values
  CONSTRAINT fk_Budget_Events FOREIGN KEY (Event_ID) REFERENCES Events(Event_ID),
  CONSTRAINT chk_Total_Budget CHECK (Total_Budget >= 0), -- Check if total budget is non-negative
  CONSTRAINT chk_Expenditure CHECK (Expenditure >= 0) -- Check if expenditure is non-negative
);

-- Inserting data into the Budget table
INSERT INTO Budget (Event_ID, Total_Budget, Allocation_Details, Expenditure) VALUES
(1, 5000.00, 'Venue rental, catering, marketing materials', 3500.00),
(2, 8000.00, 'Speaker fees, audio-visual equipment, advertising', 6000.00),
(3, 3000.00, 'Decorations, refreshments, volunteer expenses', 2500.00),
(4, 6000.00, 'Entertainment, prizes, event staff', 4500.00),
(5, 4000.00, 'Food, beverages, transportation', 3500.00);

-- Create Registrations table
CREATE TABLE Registrations (
    Registration_ID INT PRIMARY KEY,
    Event_ID INT NOT NULL,
    Participant_ID INT NOT NULL,
    Registration_Date DATE NOT NULL,
    Status VARCHAR(50) NOT NULL,
    FOREIGN KEY (Event_ID) REFERENCES Events(Event_ID),
    FOREIGN KEY (Participant_ID) REFERENCES Participants(Participant_ID)
);

-- Inserting data into the Registrations table
INSERT INTO Registrations (Registration_ID, Event_ID, Participant_ID, Registration_Date, Status) VALUES
(1, 1, 1, '2024-03-01', 'Confirmed'),
(2, 1, 2, '2024-03-02', 'Confirmed'),
(3, 2, 3, '2024-03-03', 'Pending'),
(4, 3, 4, '2024-03-04', 'Confirmed'),
(5, 3, 5, '2024-03-05', 'Cancelled');

-- Create Feedback table
CREATE TABLE Feedback (
    Feedback_ID INT AUTO_INCREMENT PRIMARY KEY,
    Event_ID INT NOT NULL,
    Participant_ID INT NOT NULL,
    Rating INT NOT NULL,
    Comments VARCHAR(500),
    CONSTRAINT fk_Feedback_Events FOREIGN KEY (Event_ID) REFERENCES Events(Event_ID),
    CONSTRAINT fk_Feedback_Participants FOREIGN KEY (Participant_ID) REFERENCES Participants(Participant_ID),
    CONSTRAINT chk_Rating CHECK (Rating >= 1 AND Rating <= 5) -- Check if rating is within valid range
);

-- Inserting data into the Feedback table
INSERT INTO Feedback (Event_ID, Participant_ID, Rating, Comments) VALUES
(1, 1, 4, 'Great event overall. Enjoyed the sessions.'),
(1, 2, 5, 'Excellent organization and content. Would attend again.'),
(2, 3, 3, 'Good event, but could have been more interactive.'),
(3, 4, 5, 'Fantastic experience. Highly recommended.'),
(3, 5, 2, 'Disappointed with the lack of variety in sessions.');

-- Create Vendors table
CREATE TABLE Vendors (
    Vendor_ID INT AUTO_INCREMENT PRIMARY KEY,
    Vendor_Name VARCHAR(100) NOT NULL,
    Contact_Person VARCHAR(100),
    Contact_Email VARCHAR(100),
    Contact_Phone VARCHAR(20),
    Services_Provided VARCHAR(200)
);

-- Inserting data into the Vendors table
INSERT INTO Vendors (Vendor_Name, Contact_Person, Contact_Email, Contact_Phone, Services_Provided) VALUES
('ABC Catering', 'John Smith', 'john@example.com', '123-456-7890', 'Catering services'),
('XYZ Rentals', 'Alice Johnson', 'alice@example.com', '987-654-3210', 'Event equipment rentals'),
('PQR Decorations', 'Emily Davis', 'emily@example.com', '456-789-0123', 'Event decorations'),
('EFG Sound Systems', 'Michael Brown', 'michael@example.com', '789-012-3456', 'Sound system rental'),
('LMN Photography', 'Sarah Wilson', 'sarah@example.com', '321-654-9870', 'Event photography');

-- Create Transportation table
CREATE TABLE Transportation (
    Transportation_ID INT AUTO_INCREMENT PRIMARY KEY,
    Event_ID INT NOT NULL,
    Mode_of_Transportation VARCHAR(100) NOT NULL,
    Departure_Date DATETIME NOT NULL,
    Arrival_Date DATETIME NOT NULL,
    Pickup_Dropoff_Locations VARCHAR(200),
    CONSTRAINT fk_Transportation_Events FOREIGN KEY (Event_ID) REFERENCES Events(Event_ID),
    CONSTRAINT chk_Transportation_Dates CHECK (Departure_Date < Arrival_Date) -- Check if departure date is before arrival date
);

-- Inserting data into the Transportation table
INSERT INTO Transportation (Event_ID, Mode_of_Transportation, Departure_Date, Arrival_Date, Pickup_Dropoff_Locations) VALUES
(1, 'Bus', '2024-04-01 08:00:00', '2024-04-01 10:00:00', 'Airport - Event Venue'),
(1, 'Shuttle', '2024-04-01 08:30:00', '2024-04-01 09:30:00', 'Hotel - Event Venue'),
(2, 'Car Rental', '2024-03-15 10:00:00', '2024-03-15 12:00:00', 'Airport - Event Venue'),
(3, 'Train', '2024-04-10 09:00:00', '2024-04-10 11:00:00', 'Station - Event Venue'),
(4, 'Taxi', '2024-05-01 14:00:00', '2024-05-01 16:00:00', 'Airport - Event Venue');

-- Create Tasks table
CREATE TABLE Tasks (
    Task_ID INT AUTO_INCREMENT PRIMARY KEY,
    Event_ID INT NOT NULL,
    Description VARCHAR(500) NOT NULL,
    Assigned_To VARCHAR(100) NOT NULL,
    Deadline DATE NOT NULL,
    Status VARCHAR(50) NOT NULL,
    CONSTRAINT fk_Tasks_Events FOREIGN KEY (Event_ID) REFERENCES Events(Event_ID)
    );
    
    -- Inserting data into the Tasks table
INSERT INTO Tasks (Event_ID, Description, Assigned_To, Deadline, Status) VALUES
(1, 'Prepare presentation slides', 'John Doe', '2024-04-01', 'Pending'),
(1, 'Setup event venue', 'Jane Smith', '2024-04-01', 'In Progress'),
(2, 'Arrange transportation', 'Alice Johnson', '2024-03-15', 'Completed'),
(3, 'Decorate event hall', 'Michael Brown', '2024-04-10', 'Pending'),
(4, 'Confirm guest list', 'Emily Davis', '2024-05-01', 'In Progress');

-- Create Sessions table
CREATE TABLE Sessions (
    Session_ID INT AUTO_INCREMENT PRIMARY KEY,
    Event_ID INT NOT NULL,
    Title VARCHAR(100) NOT NULL,
    Description VARCHAR(500),
    Session_Date DATE NOT NULL,
    Session_Time DATETIME NOT NULL,
    CONSTRAINT fk_Sessions_Events FOREIGN KEY (Event_ID) REFERENCES Events(Event_ID)
);

-- Inserting data into the Sessions table
INSERT INTO Sessions (Event_ID, Title, Description, Session_Date, Session_Time) VALUES
(1, 'Keynote Address', 'Opening keynote by renowned speaker', '2024-04-01', '2024-04-01 09:00:00'),
(1, 'Panel Discussion', 'Panel discussion on industry trends', '2024-04-01', '2024-04-01 11:00:00'),
(2, 'Workshop: Data Analytics', 'Hands-on workshop on data analysis techniques', '2024-03-15', '2024-03-15 10:00:00'),
(2, 'Networking Lunch', 'Networking session over lunch', '2024-03-15', '2024-03-15 12:30:00'),
(3, 'Product Showcase', 'Showcasing latest products and innovations', '2024-04-10', '2024-04-10 11:00:00');

-- Create Contracts table
CREATE TABLE Contracts (
    Contract_ID INT AUTO_INCREMENT PRIMARY KEY,
    Event_ID INT NOT NULL,
    Counterparty VARCHAR(100),
    Contract_Type VARCHAR(50),
    Terms_and_Conditions VARCHAR(500),
    Start_Date DATE,
    End_Date DATE,
    CONSTRAINT fk_Contracts_Events FOREIGN KEY (Event_ID) REFERENCES Events(Event_ID)
);

-- Inserting data into the Contracts table
INSERT INTO Contracts (Event_ID, Counterparty, Contract_Type, Terms_and_Conditions, Start_Date, End_Date) VALUES
(1, 'ABC Catering', 'Catering Services', 'Agreed upon catering services for the event', '2024-04-01', '2024-04-03'),
(2, 'XYZ Rentals', 'Equipment Rental', 'Rental of audio-visual equipment for the event', '2024-03-15', '2024-03-16'),
(3, 'PQR Decorations', 'Decoration Services', 'Decoration services for the event venue', '2024-04-10', '2024-04-12'),
(4, 'EFG Sound Systems', 'Sound System Rental', 'Rental of sound systems for the event', '2024-05-01', '2024-05-03'),
(5, 'LMN Photography', 'Photography Services', 'Photography services coverage for the event', '2024-06-15', '2024-06-16');

show tables;
describe Events;
select *from Events;



