USE ecommerce;

-- ===========================================
-- USUARIOS
-- ===========================================

INSERT INTO usuarios
(nombre, apellido, email, password, telefono, direccion, rol)
VALUES

(
'Administrador',
'Sistema',
'admin@ecommerce.com',
'$2b$10$EjemploHashAdministrador',
'3814000000',
'San Miguel de Tucumán',
'admin'
),

(
'Juan',
'Pérez',
'juan@gmail.com',
'$2b$10$EjemploHashCliente',
'3815551234',
'Yerba Buena',
'cliente'
);

-- ===========================================
-- CATEGORIAS
-- ===========================================

INSERT INTO categorias
(nombre, descripcion)
VALUES

('Celulares','Smartphones y accesorios'),

('Notebooks','Computadoras portátiles'),

('Monitores','Monitores LED y OLED'),

('Auriculares','Auriculares inalámbricos'),

('Periféricos','Teclados, mouse y webcams');

-- ===========================================
-- PRODUCTOS
-- ===========================================

INSERT INTO productos
(categoria_id,nombre,descripcion,precio,stock,imagen)

VALUES

(
1,
'iPhone 17',
'Apple iPhone 17 de 256GB',
1850000,
15,
'iphone17.jpg'
),

(
1,
'Samsung Galaxy S26',
'Galaxy S26 de 256GB',
1600000,
20,
'galaxy.jpg'
),

(
2,
'MacBook Pro M5',
'Notebook Apple',
3200000,
8,
'macbook.jpg'
),

(
3,
'Monitor LG UltraGear',
'Monitor Gamer 27"',
520000,
12,
'lg.jpg'
),

(
4,
'AirPods Pro',
'Auriculares Apple',
450000,
30,
'airpods.jpg'
),

(
5,
'Mouse Logitech G502',
'Mouse Gamer',
95000,
40,
'g502.jpg'
),

(
5,
'Teclado Redragon Kumara',
'Teclado Mecánico',
78000,
35,
'kumara.jpg'
);

-- ===========================================
-- CARRITO
-- ===========================================

INSERT INTO carrito
(usuario_id)
VALUES
(2);

-- ===========================================
-- CARRITO DETALLE
-- ===========================================

INSERT INTO carrito_detalle
(carrito_id,producto_id,cantidad,precio)

VALUES

(
1,
1,
1,
1850000
),

(
1,
6,
2,
95000
);

-- ===========================================
-- FAVORITOS
-- ===========================================

INSERT INTO favoritos
(usuario_id,producto_id)

VALUES

(2,1),
(2,3),
(2,7);

-- ===========================================
-- RESEÑAS
-- ===========================================

INSERT INTO resenas
(usuario_id,producto_id,calificacion,comentario)

VALUES

(
2,
1,
5,
'Excelente teléfono.'
),

(
2,
6,
4,
'Muy buen mouse para jugar.'
);