/*Queries that provide answers to the questions from all projects.*/


/*Find all animals whose name ends in "mon".*/
 SELECT * FROM animals WHERE name LIKE '%mon';
 
/* List the name of all animals born between 2016 and 2019. */
  SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
 
/* List the name of all animals that are neutered and have less than 3 escape attempts. */
  SELECT name FROM animals WHERE neutered AND  escape_attempts<3;
  
/*List the date of birth of all animals named either "Agumon" or "Pikachu".*/
  SELECT TO_CHAR(date_of_birth,'YYYY-MM-DD')date_of_birth FROM animals WHERE name IN ('Agumon','Pikachu');
  
/* List name and escape attempts of animals that weigh more than 10.5kg */  
  SELECT name FROM animals WHERE weight_kg > 10.5;	

/* Find all animals that are neutered. */
SELECT * FROM animals WHERE neutered;

/* Find all animals not named Gabumon. */
SELECT * FROM animals WHERE name !='Gabumon';

/* Find all animals with a weight between 10.4kg and 17.3kg 
(including the animals with the weights that equals precisely 10.4kg or 17.3kg) 
*/
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/* Transaction and ROLLBACK */
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN WORK;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE RIGHT(name,3)!='mon';
SELECT * FROM animals;
COMMIT WORK;
SELECT * FROM animals;

BEGIN WORK;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK WORK;
SELECT * FROM animals;

BEGIN WORK;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT SAVEPOINT1;
UPDATE animals SET weight_kg = weight_kg * -1;
SELECT * FROM animals;
ROLLBACK WORK TO SAVEPOINT1;
SELECT * FROM animals;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
SELECT * FROM animals;
COMMIT ;
SELECT * FROM animals;



SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg)mean_weight FROM animals;
SELECT neutered, MAX(escape_attempts)most_escaper FROM animals GROUP BY neutered;
SELECT species,MIN(weight_kg)min_weight,MAX(weight_kg)max_weight FROM animals GROUP BY species;
SELECT species,AVG(escape_attempts)avg_escape_attempts FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

SELECT name FROM animals JOIN owners on full_name = 'Melody Pond' WHERE owners.id = animals.owner_id;
SELECT a.name FROM animals a JOIN species s ON s.name = 'Pokemon' AND a.species_id = s.id;
SELECT o.full_name, a.name FROM owners o LEFT JOIN animals a ON o.id = a.owner_id;
SELECT s.name, COUNT(a.name) FROM animals a JOIN species s ON a.species_id = s.id GROUP BY s.id;
SELECT a.name FROM animals a JOIN owners o ON a.owner_id = o.id JOIN species s ON a.species_id = s.id WHERE s.name = 'Digimon' AND o.full_name = 'Jennifer Orwell';
SELECT a.name FROM animals a JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;
SELECT o.full_name, COUNT(a.name) FROM animals a JOIN owners o ON a.owner_id = o.id GROUP BY o.full_name ORDER BY COUNT DESC LIMIT 1;

/*1*/
SELECT c.name,
       b.name,
       date_of_visits
FROM visits a
LEFT JOIN animals b ON a.animals_id = b.id
LEFT JOIN vets c ON a.vets_id = c.id
WHERE c.name = 'William Tatcher'
ORDER BY date_of_visits DESC
LIMIT 1;
/*2*/
SELECT c.name,
       COUNT(b.name)
FROM visits a
LEFT JOIN animals b ON a.animals_id = b.id
LEFT JOIN vets c ON a.vets_id = c.id
WHERE c.name = 'Stephanie Mendez'
GROUP BY c.name;
/*3*/
SELECT a.name,
       c.name
FROM vets a
LEFT JOIN specializations b ON a.id = b.vets_id
LEFT JOIN species c ON c.id = b.species_id;

/*4*/
SELECT b.name,
       c.name,
       a.date_of_visits
FROM visits a
LEFT JOIN animals b ON a.animals_id = b.id
LEFT JOIN vets c ON a.vets_id = c.id
WHERE c.name = 'Stephanie Mendez'
  AND a.date_of_visits BETWEEN '2020-04-01' AND '2020-08-30';
/*5*/
SELECT b.name,
       COUNT(b.name)
FROM visits a
LEFT JOIN animals b ON a.animals_id = b.id
GROUP BY b.name
ORDER BY COUNT(b.name) DESC
LIMIT 1;  
/*6*/
SELECT b.name,
       c.name,
       a.date_of_visits
FROM visits a
LEFT JOIN animals b ON a.animals_id = b.id
LEFT JOIN vets c ON a.vets_id = c.id
WHERE c.name = 'Maisy Smith'
ORDER BY a.date_of_visits ASC
LIMIT 1;
/*7*/
SELECT *
FROM visits a
LEFT JOIN animals b ON a.animals_id = b.id
LEFT JOIN vets c ON a.vets_id = c.id
ORDER BY a.date_of_visits DESC
LIMIT 1;
/*8*/
SELECT COUNT(*)
FROM visits a
LEFT JOIN vets b ON a.vets_id = b.id
LEFT JOIN animals c ON a.animals_id = c.id
LEFT JOIN specializations d ON b.id = d.vets_id
WHERE d.species_id != c.species_id;
/*9*/
SELECT d.name
FROM visits a
LEFT JOIN vets b ON a.vets_id = b.id
LEFT JOIN animals c ON a.animals_id = c.id
LEFT JOIN species d ON c.species_id = d.id
WHERE b.name = 'Maisy Smith'
GROUP BY d.name
ORDER BY COUNT(d.name) DESC
LIMIT 1;
