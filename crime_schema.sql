-- Officers
CREATE TABLE Officers( OfficerID SERIAL PRIMARY KEY, Name VARCHAR(100), Rank VARCHAR(50), Department VARCHAR(100)
);
-- Cases
CREATE TABLE Cases (CaseID SERIAL PRIMARY KEY, Title TEXT, Status VARCHAR(20) CHECK (Status IN ('Open', 'Closed')),
OpenDate DATE, CloseDate DATE, OfficerID INT REFERENCES Officers(OfficerID)
);
--Suspects
CREATE TABLE Suspects ( SuspectID SERIAL PRIMARY KEY, Name VARCHAR(100), DOB DATE, Address TEXT, CaseID INT REFERENCES Cases(CaseID)
);
-- Evidence
CREATE TABLE Evidence (
EvidenceID SERIAL PRIMARY KEY, Type VARCHAR(100), Description TEXT, CaseID INT REFERENCES Cases(CaseID),
CollectedBy INT REFERENCES Officers(OfficerID), ChainUpdated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- Indexes
CREATE INDEX idx_case_status ON Cases(Status);
CREATE INDEX idx_suspect_name ON Suspects(Name);

