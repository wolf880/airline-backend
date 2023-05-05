CREATE DATABASE airline_db;

USE airline_db;

CREATE TABLE t_address (
  addressId INT NOT NULL AUTO_INCREMENT,
  city VARCHAR(50) NOT NULL,
  state VARCHAR(50) NOT NULL,
  country VARCHAR(50) NOT NULL,
  address VARCHAR(100) NOT NULL,
  fk_personId INT NOT NULL,
  PRIMARY KEY (addressId),
  FOREIGN KEY (fk_personId) REFERENCES t_person(personId)
);

CREATE TABLE t_person (
  personId INT NOT NULL AUTO_INCREMENT,
  names VARCHAR(50) NOT NULL,
  surnames VARCHAR(50) NOT NULL,
  govIdNum VARCHAR(20) NOT NULL,
  govIdType ENUM('CC', 'CE', 'TI', 'PA') NOT NULL,
  email VARCHAR(50) NOT NULL,
  birthdate DATETIME NOT NULL,
  phoneNumber VARCHAR(20) NOT NULL,
  nationality VARCHAR(50) NOT NULL,
  PRIMARY KEY (personId)
);

CREATE TABLE t_customer (
  customerId INT NOT NULL AUTO_INCREMENT,
  fk_personId INT NOT NULL,
  PRIMARY KEY (customerId),
  FOREIGN KEY (fk_personId) REFERENCES t_person(personId)
);

CREATE TABLE t_airplane (
  airplaneId INT NOT NULL AUTO_INCREMENT,
  maxWeight DOUBLE NOT NULL,
  maxSeats INT NOT NULL,
  PRIMARY KEY (airplaneId)
);

CREATE TABLE t_seat (
  seatId INT NOT NULL AUTO_INCREMENT,
  seatNumber INT NOT NULL,
  seatLetter CHAR(1) NOT NULL,
  fk_plane INT NOT NULL,
  PRIMARY KEY (seatId),
  FOREIGN KEY (fk_plane) REFERENCES t_airplane(airplaneId)
);

CREATE TABLE t_flight (
  flightId INT NOT NULL AUTO_INCREMENT,
  flightNumber VARCHAR(20) NOT NULL,
  flightType ENUM('Turismo', 'Negocios') NOT NULL,
  departureTime DATETIME NOT NULL,
  departureAirport VARCHAR(50) NOT NULL,
  departureTerminal VARCHAR(20) NOT NULL,
  departureGate VARCHAR(20) NOT NULL,
  departureCity VARCHAR(50) NOT NULL,
  departureCountry VARCHAR(50) NOT NULL,
  arrivalTime DATETIME NOT NULL,
  arrivalAirport VARCHAR(50) NOT NULL,
  arrivalCity VARCHAR(50) NOT NULL,
  arrivalCountry VARCHAR(50) NOT NULL,
  status ENUM('Activo', 'Cancelado', 'Completado') NOT NULL,
  fee DOUBLE NOT NULL,
  fk_plane INT NOT NULL,
  PRIMARY KEY (flightId),
  FOREIGN KEY (fk_plane) REFERENCES t_airplane(airplaneId)
);

CREATE TABLE t_ticket (
  ticketId INT NOT NULL AUTO_INCREMENT,
  fk_seatId INT NOT NULL,
  fk_flightId INT NOT NULL,
  fk_customerId INT NOT NULL,
  boardingGroup VARCHAR(10) NOT NULL,
  PRIMARY KEY (ticketId),
  FOREIGN KEY (fk_seatId) REFERENCES t_seat(seatId),
  FOREIGN KEY (fk_flightId) REFERENCES t_flight(flightId),
  FOREIGN KEY (fk_customerId) REFERENCES t_customer(customerId)
);

CREATE TABLE t_payment (
  paymentId INT NOT NULL AUTO_INCREMENT,
  paymentMethod ENUM('Tarjeta de Crédito', 'Efectivo') NOT NULL,
  total DOUBLE NOT NULL,
  fk_ticket INT NOT NULL,
  PRIMARY KEY (paymentId),
  FOREIGN KEY (fk_ticket) REFERENCES t_ticket(ticketId)
);
