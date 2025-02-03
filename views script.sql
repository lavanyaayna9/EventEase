CREATE VIEW EventRegistrations AS
SELECT e.Event_Name, p.Name, r.Registration_Date, r.Status
FROM Events e
INNER JOIN Registrations r ON e.Event_ID = r.Event_ID
INNER JOIN Participants p ON r.Participant_ID = p.Participant_ID;

describe EventRegistrations;

CREATE VIEW AvailableTickets AS
SELECT e.Event_Name, t.Type, t.Price, t.Availability
FROM Events e
INNER JOIN Tickets t ON e.Event_ID = t.Event_ID
WHERE t.Availability > 0;

describe AvailableTickets;