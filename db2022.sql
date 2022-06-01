CREATE DATABASE IF NOT EXISTS ergasiadb;
USE ergasiadb;

create table if not exists Organisation(
	id INT NOT NULL auto_increment primary key,
    org_name VARCHAR(50) NOT NULL,
	abbreviation  VARCHAR(5) NOT NULL,
    address_postal_code INT(5),
    address_street VARCHAR(50) NOT null,
    address_city VARCHAR(50) NOT NULL        
);

create table if not exists Program(
	id INT NOT NULL auto_increment primary key,
    program_name VARCHAR(50) NOT NULL,
	address VARCHAR(50) NOT NULL      
    );

create table if not exists Executive(
	id INT NOT NULL auto_increment primary key,
    executive_name VARCHAR(50) NOT NULL
    );
    
create table if not exists Company(
	id INT NOT NULL auto_increment primary key, 
    private_funds INT(5) NOT NULL ,
    foreign key(id) references Organisation(id)
    );
    
create table if not exists University(
	id INT NOT NULL auto_increment primary key, 
    budget INT(5) NOT NULL ,
    foreign key(id) references Organisation(id)
    );
    
create table if not exists Research_Center(
	id INT NOT NULL auto_increment primary key, 
    private_funds INT(5) NOT NULL ,
	budget INT(5) NOT NULL ,
    foreign key(id) references Organisation(id)
    );
    

create table if not exists Researcher(
	id INT NOT NULL auto_increment primary key,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    age INT(2) NOT NULL,
    date_of_birth date NOT NULL,
    gender ENUM('MALE', 'FEMALE'),
    org_id INT NOT NULL,
    foreign key(org_id) references Organisation(id)
    );
    
create table if not exists Evaluation(
	id INT NOT NULL auto_increment primary key, 
    grade INT NOT NULL ,
	ev_date date NOT NULL ,
    researcher_id INT NOT NULL,
    foreign key(researcher_id) references Researcher(id)
    );
    
create table if not exists Project(
	id INT NOT NULL auto_increment primary key, 
    amount INT(7) NOT NULL , 
    -- minimum 100k max 1M
    title VARCHAR(50) NOT NULL,
    summary text(1000) NOT NULL,
	date_start date NOT NULL ,
	date_end date NOT NULL ,
    researcher_id INT NOT NULL,
    foreign key(researcher_id) references Researcher(id),
    organisation_id INT NOT NULL,
    foreign key(organisation_id) references Organisation(id),
    program_id INT NOT NULL,
    foreign key(program_id) references Program(id),
    executive_id INT NOT NULL,
    foreign key(executive_id) references Executive(id),
    evaluation_id INT NOT NULL,
    foreign key(evaluation_id) references Evaluation(id)
    );
    
create table if not exists Scientific_Field(
	id INT NOT NULL auto_increment primary key, 
    sf_name VARCHAR(50)
    );
    
create table if not exists Scientific_Field_Of_Project(
	id int not null auto_increment primary key,
	sf_id INT NOT NULL, 
    project_id INT NOT NULL,
	foreign key(sf_id) references Scientific_Field(id),
	foreign key(project_id) references Project(id)
    );
    

create table if not exists Works_On(
	program_id INT NOT NULL,
    researcher_id INT NOT NULL,
    primary key (program_id, researcher_id),
    foreign key (program_id) references Program(id),
    foreign key (researcher_id) references Researcher(id)
);


    
/* Constraints */

ALTER TABLE Project
ADD CONSTRAINT amount_check CHECK(amount BETWEEN 100000 AND 1000000);

ALTER TABLE Project 
ADD COLUMN duration FLOAT AS (MOD(DATEDIFF(date_end, date_start),365));

ALTER TABLE Project
ADD CONSTRAINT date_check CHECK(duration BETWEEN 1.0 AND 4.0);

ALTER TABLE Project
ADD CONSTRAINT duration_check CHECK(duration BETWEEN 1.0 AND 4.0);