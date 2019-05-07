--La vista muestra una serie de datos reducidos de las personas que tienen un saldo mayor a $1000 en sus cuentas
CREATE VIEW saldo_mil AS
SELECT nrsuc, nrcuenta, (SELECT apellido FROM clientes WHERE dni=cuentas.dni)
FROM cuentas
WHERE cuentas.saldo>'1000'

--La vista muestra una serie de datos reducidos de las personas que tienen cuentas en la sucursal de Posadas
CREATE VIEW cuentas_posadas AS
SELECT clientes.dni, clientes.apellido, clientes.ciudad
FROM clientes inner join cuentas on clientes.dni=cuentas.dni
WHERE clientes.ciudad='Posadas'
ORDER BY apellido

--La vista muestra las ciudades cuya cantidad de clientes es mayor o igual a tres
CREATE VIEW clientes_por_ciudad_3 AS
SELECT clientes.ciudad, COUNT(clientes.ciudad) as cantidad
FROM clientes INNER JOIN sucursales ON clientes.ciudad=sucursales.ciudad
GROUP BY clientes.ciudad
HAVING COUNT(clientes.ciudad) >= 3

