/*Queries that provide answers to the questions from all projects.*/

-- Queries for PR 1
SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = TRUE;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;


-- Transactions for PR 2

-- Transaction 1
BEGIN;

UPDATE animals
SET species = 'unspecified';

SELECT * FROM animals;

ROLLBACK;


-- Transaction 2
BEGIN;

UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';


UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

COMMIT;

SELECT * FROM animals;


-- Transaction 3
BEGIN;

DELETE FROM animals;

ROLLBACK;

SELECT * FROM animals;


-- Transaction 4
BEGIN;

DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

SAVEPOINT SP1;

UPDATE animals
SET weight_kg = weight_kg * -1;

ROLLBACK TO SP1;

UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

COMMIT;


-- Queries for PR 2
SELECT COUNT(*) FROM animals;
SELECT COUNT(escape_attempts) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, SUM(escape_attempts) FROM animals 
GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals
GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;


-- Queries for PR 3
SELECT full_name, name
FROM owners
JOIN animals ON owners.id = animals.owner_id
WHERE full_name = 'Melody Pond';

SELECT animals.name, species.name
FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT full_name, name
FROM owners
FULL JOIN animals ON owners.id = animals.owner_id;


SELECT species.name, COUNT(animals.name)
FROM species
JOIN animals ON species.id = animals.species_id
GROUP BY species.name;

SELECT full_name, name
FROM owners
JOIN animals ON owners.id = animals.owner_id
WHERE full_name = 'Jennifer Orwell' AND animals.species_id = 2;

SELECT full_name, name
FROM owners
JOIN animals ON owners.id = animals.owner_id
WHERE full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

SELECT full_name, COUNT(name)
FROM owners
FULL JOIN animals ON owners.id = animals.owner_id
GROUP BY full_name;


-- Queries for PR 4
SELECT vet_id, vets.name AS vet_name, date_of_visit, animals.name AS animal_name
FROM visits
INNER JOIN vets ON vets.id = visits.vet_id
INNER JOIN animals ON animals.id = visits.animal_id
WHERE vet_id = (SELECT id FROM vets WHERE name = 'William Tatcher')
ORDER BY date_of_visit DESC
LIMIT 1;

SELECT vet_id, vets.name, COUNT(animal_id)
FROM visits
INNER JOIN vets ON vets.id = visits.vet_id
WHERE vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez')
GROUP BY vet_id, vets.name;

SELECT vets.id, vets.name AS vet_name, species.name AS species
FROM vets
FULL JOIN specializations ON vets.id = specializations.vet_id
FULL JOIN species ON species.id = specializations.species_id;

SELECT animals.id, animals.name AS animal_name, date_of_visit, vets.name AS vet_name
FROM animals
INNER JOIN visits ON visits.animal_id = animals.id
INNER JOIN vets ON vets.id = visits.vet_id
WHERE date_of_visit BETWEEN '2020-04-01' AND '2020-08-30' AND vets.name = 'Stephanie Mendez';

SELECT animals.id, animals.name, COUNT(date_of_visit) AS num_of_visits
FROM animals
INNER JOIN visits ON visits.animal_id = animals.id
GROUP BY animals.id, animals.name
ORDER BY COUNT(date_of_visit) DESC;

SELECT vet_id, animal_id, vets.name, animals.name, date_of_visit
FROM visits
INNER JOIN vets ON vets.id = visits.vet_id
INNER JOIN animals ON animals.id = visits.animal_id
WHERE vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith')
ORDER BY date_of_visit
LIMIT 1;

SELECT vet_id, vets.name AS vet_name, date_of_visit, animals.id AS animal_id, animals.name AS animal_name
FROM visits
INNER JOIN vets ON vets.id = visits.vet_id
INNER JOIN animals ON animals.id = visits.animal_id
ORDER BY date_of_visit DESC
LIMIT 1;

SELECT COUNT(*) AS visits
FROM visits
JOIN animals ON visits.animal_id = animals.id
LEFT JOIN specializations ON visits.vet_id = specializations.vet_id AND animals.species_id = specializations.species_id
WHERE specializations.species_id IS NULL;

SELECT vet_id, vets.name AS vet_name, species.name AS species, animals.species_id, COUNT(*) AS num_of_visits
FROM visits
JOIN vets ON vets.id = visits.vet_id
JOIN animals ON animals.id = visits.animal_id
JOIN species ON animals.species_id = species.id
WHERE vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith')
GROUP BY animals.species_id, species.name, vet_id, vets.name
ORDER BY COUNT(*) DESC;
