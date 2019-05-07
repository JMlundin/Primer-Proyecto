--2.1 Insertar clientes en la tabla clientes
INSERT INTO CLIENTES (DNI,Apellido,Ciudad) VALUES (15333888,'Fernández','Obera');
INSERT INTO CLIENTES (DNI,Apellido,Ciudad) VALUES (20335828,'Lopez','PosadaS');
SELECT * FROM CLIENTES

--2.2 Insertar Sucursales en la tabla Sucursales
INSERT INTO SUCURSALES (NrSuc,Ciudad) VALUES (1,'PosadaS');
INSERT INTO SUCURSALES (NrSuc,Ciudad) VALUES (2,'San Pedro');
INSERT INTO SUCURSALES (NrSuc,Ciudad) VALUES (3,'Obera');

INSERT INTO CUENTAS (NrCuenta,DNI,NrSuc,Saldo) VALUES (512,15333888,3,1000);
INSERT INTO CUENTAS (NrCuenta,DNI,NrSuc,Saldo) VALUES (528,20335828,2,1500);

--2.3 Inserta un nuevo movimiento
INSERT INTO MOVIMIENTOS (NrMov,NrCuenta,MONto) VALUES (01,528,1000);

--2.4
UPDATE cuentas SET saldo=saldo+'300' WHERE nrcuenta='410'


--2.5
Do
$$
DECLARE monto decimal;
BEGIN
	Monto:= (Select saldo from cuentas where NrCuenta = 325); 
	IF (monto <= 700) THEN
	UPDATE cuentas SET saldo = (saldo - 700) where NrCuenta = 325;
ELSE
	RAISE NOTICE 'SALDO INSUFICIENTE';
END IF;
END;
$$

--2.6
SELECT *
FROM CUENTAS
WHERE (NrSuc=2) or (NrSuc=3)
order by NrSuc;

--2.7
SELECT nrsuc, COUNT (saldo) AS cantidad
FROM cuentAS
WHERE (saldo<'700')
GROUP BY nrsuc
ORDER BY nrsuc;

--2.8
SELECT sucursales.nrsuc, SUM(cuentAS.saldo) AS total
FROM sucursales
INNER JOIN cuentAS ON sucursales.nrsuc = cuentAS.nrsuc
WHERE sucursales.nrsuc=2 OR sucursales.nrsuc=3
GROUP BY sucursales.nrsuc

--2.9
SELECT cuentAS.nrcuenta, COUNT(movimientos.nrcuenta) AS cuenta 
FROM cuentAS INNER JOIN movimientos ON cuentAS.nrcuenta=movimientos.nrcuenta
WHERE movimientos.fecha BETWEEN '2003/03/16' and '2008/02/20'
GROUP BY cuentAS.nrcuenta
HAVING COUNT(movimientos.nrcuenta) > 3

--2.10
SELECT clientes.ciudad, COUNT(clientes.ciudad) AS cantidad
FROM clientes INNER JOIN sucursales ON clientes.ciudad=sucursales.ciudad
WHERE clientes.ciudad NOT LIKE 'A%'
GROUP BY clientes.ciudad
HAVING COUNT(clientes.ciudad) >= 3

--2.11
SELECT * FROM CUENTAS 
WHERE NrSuc = 4 AND NrCuenta IN (SELECT NrCuenta FROM MOVIMIENTOS WHERE FECHA BETWEEN ‘2007-03-16’ AND ‘2008-02-20’)

--2.12
select nrcuenta, saldo, dni, (select apellido from clientes where dni=cuentas.dni)
from cuentas
where cuentas.nrsuc='4' and cuentas.saldo>'1000'

--2.13
select dni, apellido, ciudad, (select nrcuenta from cuentas where dni=clientes.dni)
from clientes
where clientes.ciudad='Apóstoles'

--2.14
	12
	select cuentas.nrsuc, clientes.dni, clientes.apellido 
	from clientes inner join cuentas on clientes.dni=cuentas.dni
	where cuentas.nrsuc='4' and cuentas.saldo>'1000'
	13
	select cuentas.nrsuc, clientes.dni, clientes.apellido 
	from clientes inner join cuentas on clientes.dni=cuentas.dni
	where cuentas.nrsuc='4' and cuentas.saldo>'1000'


--2.15
select movimientos.nrcuenta, cuentas.dni, max(cuentas.saldo) as total
from movimientos inner join cuentas on movimientos.nrcuenta=cuentas.nrcuenta
where cuentas.nrsuc='4'
group by movimientos.nrcuenta, cuentas.dni

--2.16
select nrcuenta, dni
from cuentas inner join sucursales on cuentas.nrsuc=sucursales.nrsuc
where sucursales.ciudad='Posadas'

--2.17
--2 ejemplos que involucren el Comando UPDATE
--1 Incrementar $500 el saldo de las cuentas del cliente  con DNI = 13000333
UPDATE cuenta set saldo = saldo + 500 where dni = 13000333;

--2	Incrementar en un 14% las cuentas del cliente con DNI = 35467222
UPDATE cuenta set saldo = saldo * 1.4 where dni = 35467222;


--2 ejemplos con funciones, operadores (like, between, group, etc) 
--1	Obtener la información de los empleados que se desempeñan en las sucursales 1, 4 y 7; ordenada por el numero de sucursal
SELECT * FROM EMPLEADOS WHERE (NROSUCURSAL = 1 OR  NROSUCURSAL = 4 OR NROSUCURSAL= 7) 
ORDER BY NROSUCURSAL;

--2	Obtener la cantidad de clientes de las ciudades que comienzan con la letra ‘O’ y que por lo mínimo tengan menos de 5 clientes
Select ciudad, count (ciudad) from clientes where ciudad like 'O%' 
group by ciudad 
having count (ciudad) < 5;


--2 ejemplos que realicen uniones (inner join, left / right join)
--1	Determinar las cuentas de los clientes con domicilio en Jardin America y Leandro N Alem
SELECT * FROM CUENTAS INNER JOIN CLIENTES ON CUENTAS.DNICLIENTE = CLIENTES.DNI 
WHERE (CIUDAD = 'JARDIN AMERICA' OR CIUDAD = 'OBERA');

--2	Seleccionar todos los movimientos de las cuentas del cliente con número de DNI = 15333888
SELECT * FROM MOVIMIENTOS AS MO INNER JOIN CUENTAS AS CU ON MO.NRCUENTA = CU.NRCUENTA
WHERE CU.DNICLIENTE = 15333888;
