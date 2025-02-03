-- Retrieve the names of participants registered for the event "Tech Conference 2024"
SELECT p.Name
FROM Participants p
INNER JOIN Registrations r ON p.Participant_ID = r.Participant_ID
INNER JOIN Events e ON r.Event_ID = e.Event_ID
WHERE e.Event_Name = 'Tech Conference 2024';

-- Retrieve unique email addresses from Participants and Staff tables
SELECT Email FROM Participants
UNION
SELECT Email FROM Staff;

-- Get details of Registrations including Event Name, Participant Name, and Registration Status
SELECT Events.Event_Name, Participants.Name AS Participant_Name, Registrations.Status
FROM Registrations
JOIN Events ON Registrations.Event_ID = Events.Event_ID
JOIN Participants ON Registrations.Participant_ID = Participants.Participant_ID;

-- Fetch Event Name, Venue Name, and Capacity along with respective Venues
SELECT Events.Event_Name, Venues.Venue_Name, Venues.Capacity
FROM Events
JOIN Venues ON Events.Venue_ID = Venues.Venue_ID;

-- Retrieve Sponsor details along with the Event they sponsored for
SELECT Events.Event_Name, Sponsors.Sponsor_Name, Sponsors.Sponsorship_Level
FROM Sponsors
JOIN Events ON Sponsors.Sponsor_ID = Events.Event_ID;

-- Get Event details along with the total number of Registrations
SELECT Events.Event_Name, COUNT(Registrations.Registration_ID) AS Total_Registrations
FROM Events
JOIN Registrations ON Events.Event_ID = Registrations.Event_ID
GROUP BY Events.Event_Name;

-- Combine unique Event Names from Events and Sessions tables
SELECT Event_Name FROM Events
UNION
SELECT Title AS Event_Name FROM Sessions;

-- Get the average rating for each Event
SELECT Event_ID,
       (SELECT AVG(Rating) FROM Feedback WHERE Feedback.Event_ID = Events.Event_ID) AS Average_Rating
FROM Events;

-- Find Participants who have provided feedback
SELECT Name
FROM Participants
WHERE Participant_ID IN (
    SELECT DISTINCT Participant_ID FROM Feedback
);

-- Find Events with no associated feedback
SELECT Event_Name
FROM Events
WHERE Event_ID NOT IN (
    SELECT DISTINCT Event_ID FROM Feedback
);
