-- Active: 1747661228715@@127.0.0.1@5432@rare_animals

CREATE TABLE rangers (
    ranger_id INT UNIQUE,
    name VARCHAR(255),
    region VARCHAR(255)
);

CREATE TABLE species (
  species_id INT UNIQUE,
  common_name VARCHAR(100),
  scientific_name VARCHAR(100),
  discovery_date DATE,
  conservation_status VARCHAR(50)
);

CREATE TABLE sightings (
    sighting_id INT UNIQUE,
    ranger_id INT,
    species_id INT,
    FOREIGN KEY (ranger_id) REFERENCES rangers (ranger_id),
    Foreign Key (species_id) REFERENCES species (species_id),
    sighting_time TIMESTAMP,
    location VARCHAR(50),
    notes VARCHAR(255)
);

INSERT INTO rangers (ranger_id, name, region) 
  VALUES (1, 'Alice Green', 'Northern Hills'),
       (2, 'Bob White', 'River Delta'),
       (3, 'Carol King', 'Mountain Range');

SELECT * from rangers;       

INSERT INTO species 
(species_id, common_name, scientific_name, discovery_date, conservation_status)       
VALUES 
(1, 'Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
(2, 'Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
(3, 'Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
(4, 'Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

SELECT * from species;

INSERT INTO sightings 
(sighting_id, species_id, ranger_id, location, sighting_time, notes)
VALUES
(1, 1, 1, 'Peak Ridge',        '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 2, 'Bankwood Area',     '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(4, 1, 2, 'Snowfall Pass',     '2024-05-18 18:30:00', NULL);
SELECT * from sightings;

-- Problem 1
INSERT INTO rangers (ranger_id, name, region) 
VALUES (4, 'Derek Fox', 'Coastal Plains');


--Problem 2
SELECT count(DISTINCT species_id)  from sightings;


-- Problem 3
SELECT * from sightings WHERE location ILIKE '%Pass%' ;

-- Problem 4
SELECT rangers.name, count(rangers.name) as total_sightings
FROM rangers JOIN sightings on rangers.ranger_id=sightings.ranger_id GROUP BY NAME;

 
-- Problem 5
SELECT common_name FROM
species WHERE species_id NOT IN (SELECT species_id from sightings);

-- Problem 6
SELECT common_name, sighting_time, name from rangers JOIN (SELECT species.common_name, sighting_time, ranger_id from species JOIN (SELECT species_id, ranger_id, sighting_time from sightings  ORDER BY sighting_time DESC LIMIT 2) as sightings_table ON 
species.species_id=sightings_table.species_id) as sighting_table_two ON rangers.ranger_id=sighting_table_two.ranger_id;

-- Problem 7
UPDATE species SET conservation_status='Historic' WHERE discovery_date < '1800-01-01';


-- Problem 8
SELECT  
sighting_id, 
CASE 
  WHEN sighting_time::TIME < '12:00:00'  THEN  'Morning'
  WHEN sighting_time::TIME BETWEEN '12:00:00' AND '17:00:00' THEN 'Afternoon'
  ELSE  'Evening'
END as time_of_day
from sightings; 

-- Problem 9
DELETE FROM rangers where ranger_id NOT IN (SELECT ranger_id from sightings);

