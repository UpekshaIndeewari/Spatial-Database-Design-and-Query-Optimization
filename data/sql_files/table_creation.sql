

CREATE TABLE structure(
strId varchar(5) NOT NULL,
strName varchar(30) NOT NULL,
firstName varchar(30),
lastName varchar(30),
type varchar(20) NOT NULL,
noFloors numeric,
location geometry(POINT,4326) NOT NULL,
CONSTRAINT pk_structure PRIMARY KEY(strId),
CONSTRAINT ck_type CHECK (type IN ('House', 'Religious Place', 'School', 'Hospital','Other')));



CREATE TABLE road(
rdId varchar(5) NOT NULL,
rdName varchar(30) NOT NULL,
trafficDensity numeric,
rdGrade varchar(20),
rdPosition geometry(LINESTRING,4326) NOT NULL,
CONSTRAINT pk_road PRIMARY KEY(rdId),
CONSTRAINT ck_grade CHECK (rdGrade IN ('Concrete', 'Soil', 'Tar Paved', 'Other')));


CREATE TABLE contractor(
cRegNo varchar(10) NOT NULL,
cCompanyName varchar(30) NOT NULL,
cBlastingEng varchar(30),
CONSTRAINT pk_contractor PRIMARY KEY(cRegNo));



CREATE TABLE contactNumber(
conId varchar(5) NOT NULL,
conNumber numeric,
cRegNo varchar(10),
CONSTRAINT pk_contactNumber PRIMARY KEY(conId),
CONSTRAINT fk_contactNumber FOREIGN KEY (cRegNo) REFERENCES contractor(cRegNo)
ON DELETE SET NULL
ON UPDATE CASCADE);



CREATE TABLE section(
seId varchar(5) NOT NULL,
seName varchar(20) NOT NULL,
seInchargeEng varchar(30),
seChainage varchar(20),
sePosition geometry(POLYGON,4326) NOT NULL,
CONSTRAINT pk_section PRIMARY KEY(seId));



CREATE TABLE blastingLocation(
blId varchar(15) NOT NULL,
blQuantity numeric,
blRockType varchar(30),
blPosition geometry(POLYGON,4326) NOT NULL,
seId varchar(5),
cRegNo varchar(10),
dueDate DATE,
CONSTRAINT pk_blastingLocation PRIMARY KEY(blId),
CONSTRAINT fk_blastingLocation1 FOREIGN KEY (seId) REFERENCES section(seId) ON DELETE SET NULL ON UPDATE CASCADE,
CONSTRAINT fk_blastingLocation2 FOREIGN KEY (cRegNo) REFERENCES contractor(cRegNo) ON DELETE SET NULL ON UPDATE CASCADE,
CONSTRAINT check_rockType CHECK (blRockType IN ('Charnokite','Charnokitic Gneiss', 'Feldsphathic Gneiss', 'Garnert Biotite Gneiss', 'Other')));



CREATE TABLE surroundingStructure(
strId varchar(5),
blId varchar(5),
CONSTRAINT pk_surroundingStructure PRIMARY KEY(strId,blId),
CONSTRAINT fk_surroundingStructure1 FOREIGN KEY (strId) REFERENCES structure(strId) ON DELETE SET NULL ON UPDATE CASCADE,
CONSTRAINT fk_surroundingStructure2 FOREIGN KEY (blId) REFERENCES blastingLocation(blId) ON DELETE SET NULL ON UPDATE CASCADE);



CREATE TABLE surroundingRoad(
rdId varchar(5),
blId varchar(5),
CONSTRAINT pk_surroundingRoad PRIMARY KEY(rdId,blId),
CONSTRAINT fk_surroundingRoad1 FOREIGN KEY (rdId) REFERENCES road(rdId) ON DELETE SET NULL ON UPDATE CASCADE,
CONSTRAINT fk_surroundingRoad2 FOREIGN KEY (blId) REFERENCES blastingLocation(blId) ON DELETE SET NULL ON UPDATE CASCADE);