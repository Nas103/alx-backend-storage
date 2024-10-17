-- Task 1: Create a 'users' table with a country attribute as an enumeration
-- The table has the following attributes:
-- id: integer, never null, auto increment, primary key
-- email: string (255 characters), never null, unique
-- name: string (255 characters)
-- country: enumeration of countries (US, CO, TN), never null, default is 'US'
-- The script should not fail if the table already exists

CREATE TABLE IF NOT EXISTS users (
    id INT NOT NULL AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL UNIQUE,
    name VARCHAR(255),
    country ENUM('US', 'CO', 'TN') NOT NULL DEFAULT 'US',
    PRIMARY KEY (id)
);
