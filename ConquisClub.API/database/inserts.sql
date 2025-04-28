INSERT INTO Asociacion (Nombre)
VALUES 
('Asociación Occidental'), 
('Asociación Central'),
('Asociacion Oriental');
GO

INSERT INTO Departamento (Nombre, IdAsociacion)
VALUES 
('Ahuachapán', 1),
('Santa Ana', 1),
('Sonsonate', 1),
('Chalatenango', 2),
('La Libertad', 2),
('San Salvador', 2),
('Cuscatlán', 2),
('La Paz', 2),
('Cabañas', 2),
('San Vicente', 2),
('Usulután', 3),
('San Miguel', 3),
('Morazán', 3),
('La Unión', 3);
GO
---------------CARGO
INSERT INTO Cargo(Nombre)
VALUES
('Coordinador del departamento de Jovenes J.A'),
('Guia Mayor');
GO
---------------rol
INSERT INTO ROL(Nombre)
VALUES
('Aventuro'),
('Conquistador'),
('Guia Mayor'),
('Consejero')
GO
