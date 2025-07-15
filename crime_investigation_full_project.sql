INSERT INTO Officers (Name, Rank, Department) VALUES ('Ravi Kumar', 'Inspector', 'Homicide'), ('Anita Sharma', 'Sub-Inspector', 'Cyber Crime');
INSERT INTO Cases (Title, Status, OpenDate, OfficerID) VALUES ('Bank Robbery', 'Open', '2024-01-05', 1), ('Cyber Fraud', 'Closed', '2023-11-10', 2);
INSERT INTO Suspects (Name, DOB, Address, CaseID) VALUES ('Arjun Verma', '1985-03-21', 'Delhi', 1),
('Rita Sen', '1990-09-10', 'Mumbai', 2);
INSERT INTO Evidence (Type, Description, CaseID, CollectedBy) VALUES ('Video Footage', 'CCTV Footage from bank', 1, 1),
('Laptop', 'Hacked laptop recovered', 2,2);

-- Officer workload
CREATE VIEW OfficerWorkload AS SELECT o.OfficerID, o.Name, COUNT(c.CaseID) AS TotalCases
FROM Officers o
LEFT JOIN Cases c ON o.OfficerID = c.OfficerID
GROUP BY o.OfficerID, o.Name;

--Trigger function
CREATE OR REPLACE FUNCTION update_chain_timestamp()
RETURNS TRIGGER AS $$
BEGIN 
    NEW.ChainUpdated := CURRENT_TIMESTAMP;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Trigger
CREATE TRIGGER trg_update_chain
BEFORE UPDATE ON Evidence
FOR EACH ROW
EXECUTE FUNCTION update_chain_timestamp();

--Solved vs Unsolved cases
SELECT Status, COUNT(*) FROM Cases GROUP BY Status;

--Summary of each case
SELECT
    c.CaseID,
	c.Title,
	c.Status,
	COUNT(DISTINCT s.SuspectID) AS SuspectCount,
	COUNT(DISTINCT e.EvidenceID) AS EvidenceCount
FROM Cases c
LEFT JOIN Suspects s ON c.CaseID = s.CaseID
LEFT JOIN Evidence e ON c.CaseID = e.CaseID
GROUP BY c.CaseID;