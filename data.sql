/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Agumon', '2020-02-03', 0, 't', 10.23),
       ('Gabumon', '2018-11-15', 2, 't', 8),
       ('Pikachu', '2021-01-07', 1, 'f', 15.04),
       ('Devimon', '2017-05-12', 5, 't', 11);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Charmander', '2020-02-08', 0, 'f', -11),
       ('Plantmon', '2021-11-15', 2, 't', -5.7),
       ('Squirtle', '1993-04-02', 3, 'f', -12.13),
       ('Angemon', '2005-06-12', 1, 't', -45),
       ('Boarmon', '2005-06-07', 7, 't', 20.4),
       ('Blossom', '1998-10-13', 3, 't', 17),
       ('Ditto', '2022-05-14', 4, 't', 22);

INSERT INTO animals (id,name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (11,'Ditto', '2022-05-14', 4, 't', 22);

INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34),
       ('Jennifer Orwell', 19),
       ('Bob', 45),
       ('Melody Pond', 77),
       ('Dean Winchester', 14),
       ('Jodie Whittaker', 38);

INSERT INTO species (name)
VALUES ('Pokemon'),
       ('Digimon');

UPDATE animals SET species_id = (SELECT id from species WHERE name = 'Digimon' LIMIT 1) WHERE name LIKE '%mon';
UPDATE animals SET species_id = (SELECT id from species WHERE name = 'Pokemon' LIMIT 1) WHERE RIGHT(name,3)!='mon';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith' LIMIT 1) WHERE name = 'Agumon';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell' LIMIT 1) WHERE name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob' LIMIT 1) WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond' LIMIT 1) WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester' LIMIT 1) WHERE name IN ('Boarmon', 'Angemon');
