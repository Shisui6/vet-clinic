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


-- Schema for PR 4
CREATE TABLE vets (
    id                  SERIAL PRIMARY KEY,
    name                VARCHAR(100),
    age                 INT,
    date_of_graduation  DATE
);

CREATE TABLE specializations (
    vet_id              INT,
    species_id          INT,
    FOREIGN KEY (species_id) REFERENCES species(id),
    FOREIGN KEY (vet_id) REFERENCES vets(id),
    PRIMARY KEY (species_id, vet_id)
);

CREATE TABLE visits (
    id                  SERIAL PRIMARY KEY,
    animal_id           INT,
    vet_id              INT,
    date_of_visit       DATE,
    FOREIGN KEY (animal_id) REFERENCES animals(id),
    FOREIGN KEY (vet_id) REFERENCES vets(id)
);

-- Indexes
CREATE INDEX animal_id_index ON visits(animal_id DESC);
CREATE INDEX vet_id_index ON visits(vet_id DESC);
CREATE INDEX email_index ON owners(email DESC);
