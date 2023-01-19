/* Database schema to keep the structure of entire database. */

-- Animals table
CREATE TABLE animals (
    id                  INT GENERATED ALWAYS AS IDENTITY,
    name                VARCHAR(100),
    date_of_birth       DATE,
    escape_attempts     INT,
    neutered            BOOLEAN,
    weight_kg           FLOAT,
    PRIMARY KEY(id)
);

-- Alter table
ALTER TABLE animals
ADD species VARCHAR(100);


-- Schema for PR 3

-- Owners table
CREATE TABLE owners (
    id                  SERIAL PRIMARY KEY,
    full_name           VARCHAR(100),
    age                 INT
);

-- Species table
CREATE TABLE species (
    id                  SERIAL PRIMARY KEY,
    name                VARCHAR(100)
);

-- Alter animals table
ALTER TABLE animals
DROP COLUMN species,
ADD owner_id INT,
ADD species_id INT,
ADD FOREIGN KEY (owner_id) REFERENCES owners(id),
ADD FOREIGN KEY (species_id) REFERENCES species(id);
