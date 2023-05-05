-- a.Número de personas que han consultado vuelos mayores a un valor de 5 millones de pesos

SELECT COUNT(DISTINCT fk_personId)
FROM t_flight
WHERE fee > 5000000;

-- b. Personas que han tomado los vuelos y han hecho el pago en efectivo

SELECT DISTINCT p.names, p.surnames
FROM t_person p
INNER JOIN t_customer c ON p.personId = c.fk_personId
INNER JOIN t_ticket t ON c.customerId = t.fk_customerId
INNER JOIN t_payment py ON t.ticketId = py.fk_ticket
INNER JOIN t_flight f ON t.fk_flightId = f.flightId
WHERE py.paymentMethod = 'Efectivo';

-- c. Personas mayores a 40 años y que viven en la ciudad de Bogotá

SELECT p.names, p.surnames
FROM t_person p
INNER JOIN Address a ON p.personId = a.fk_personId
WHERE p.birthdate <= DATE_SUB(NOW(), INTERVAL 40 YEAR)
AND a.city = 'Bogotá';

-- d. Listar los tipos de viajes turísticos y de negocios que se han hecho con pago con tarjeta de crédito

SELECT DISTINCT f.flightType
FROM t_flight f
INNER JOIN t_ticket t ON f.flightId = t.fk_flightId
INNER JOIN t_payment p ON t.ticketId = p.fk_ticket
WHERE p.paymentMethod = 'Tarjeta de Crédito';

-- e. Listar los viajes activos y cancelados

SELECT *
FROM t_flight
WHERE status IN ('Activo', 'Cancelado');
