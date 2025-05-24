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
    ranger_id INT UNIQUE,
    species_id INT UNIQUE,
    FOREIGN KEY (ranger_id) REFERENCES rangers (ranger_id),
    Foreign Key (species_id) REFERENCES species (species_id),
    sighting_time TIMESTAMP,
    location VARCHAR(50),
    notes VARCHAR(255)
);