-- ===========================================
-- CREACIÓN DE LA BASE DE DATOS
-- ===========================================

DROP DATABASE IF EXISTS ecommerce;

CREATE DATABASE ecommerce
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE ecommerce;

-- ===========================================
-- TABLA USUARIOS
-- ===========================================

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    telefono VARCHAR(20),
    direccion VARCHAR(255),
    rol ENUM('cliente', 'admin') DEFAULT 'cliente',
    activo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ===========================================
-- TABLA CATEGORIAS
-- ===========================================

CREATE TABLE categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT,
    activo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
);

-- ===========================================
-- TABLA PRODUCTOS
-- ===========================================

CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    categoria_id INT NOT NULL,
    marca_id INT NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    imagen VARCHAR(255),
    activo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_producto_categoria
        FOREIGN KEY (categoria_id)
        REFERENCES categorias(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
    
    CONSTRAINT fk_producto_marca
    FOREIGN KEY (marca_id)
    REFERENCES marcas(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
);

-- ===========================================
-- TABLA PEDIDOS
-- ===========================================

CREATE TABLE pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    estado ENUM(
        'pendiente',
        'pagado',
        'enviado',
        'entregado',
        'cancelado'
    ) DEFAULT 'pendiente',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_pedido_usuario
        FOREIGN KEY (usuario_id)
        REFERENCES usuarios(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- ===========================================
-- TABLA DETALLE PEDIDO
-- ===========================================

CREATE TABLE detalle_pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,

    CONSTRAINT fk_detalle_pedido
        FOREIGN KEY (pedido_id)
        REFERENCES pedidos(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_detalle_producto_pedido
        FOREIGN KEY (producto_id)
        REFERENCES productos(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);
-- ===========================================
-- TABLA PAGOS
-- ===========================================

CREATE TABLE pagos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL UNIQUE,
    metodo ENUM(
        'tarjeta',
        'transferencia',
        'mercado_pago',
        'efectivo'
    ) NOT NULL,

    estado ENUM(
        'pendiente',
        'aprobado',
        'rechazado'
    ) DEFAULT 'pendiente',

    referencia VARCHAR(255),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_pago_pedido
        FOREIGN KEY (pedido_id)
        REFERENCES pedidos(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- ===========================================
-- TABLA FAVORITOS
-- ===========================================

CREATE TABLE favoritos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    producto_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_favorito_usuario
        FOREIGN KEY (usuario_id)
        REFERENCES usuarios(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_favorito_producto
        FOREIGN KEY (producto_id)
        REFERENCES productos(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT uq_favorito UNIQUE(usuario_id, producto_id)
);

-- ===========================================
-- TABLA RESENAS
-- ===========================================

CREATE TABLE resenas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    producto_id INT NOT NULL,

    calificacion INT NOT NULL CHECK (calificacion BETWEEN 1 AND 5),

    comentario TEXT,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_resena_usuario
        FOREIGN KEY (usuario_id)
        REFERENCES usuarios(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_resena_producto
        FOREIGN KEY (producto_id)
        REFERENCES productos(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- ===========================================
-- TABLA MARCAS
-- ===========================================

CREATE TABLE marcas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT,
    activo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
);

-- ===========================================
-- TABLA DIRECCIONES
-- ===========================================

CREATE TABLE direcciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,

    nombre VARCHAR(100) NOT NULL,

    direccion VARCHAR(255) NOT NULL,

    ciudad VARCHAR(100) NOT NULL,

    provincia VARCHAR(100) NOT NULL,

    codigo_postal VARCHAR(20),

    telefono VARCHAR(20),

    principal BOOLEAN DEFAULT FALSE,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_direccion_usuario
        FOREIGN KEY (usuario_id)
        REFERENCES usuarios(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- ===========================================
-- TABLA CARRITO
-- ===========================================

CREATE TABLE carrito (
    id INT AUTO_INCREMENT PRIMARY KEY,

    usuario_id INT NOT NULL UNIQUE,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_carrito_usuario
        FOREIGN KEY (usuario_id)
        REFERENCES usuarios(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- ===========================================
-- TABLA CARRITO DETALLE
-- ===========================================

CREATE TABLE carrito_detalle (
    id INT AUTO_INCREMENT PRIMARY KEY,

    carrito_id INT NOT NULL,

    producto_id INT NOT NULL,

    cantidad INT NOT NULL DEFAULT 1,

    precio DECIMAL(10,2) NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_detalle_carrito
        FOREIGN KEY (carrito_id)
        REFERENCES carrito(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_detalle_producto
        FOREIGN KEY (producto_id)
        REFERENCES productos(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- ===========================================
-- ÍNDICES
-- ===========================================

-- Usuarios
CREATE INDEX idx_usuario_email
ON usuarios(email);

-- Productos
CREATE INDEX idx_producto_categoria
ON productos(categoria_id);

CREATE INDEX idx_producto_nombre
ON productos(nombre);

-- Carrito
CREATE INDEX idx_carrito_usuario
ON carrito(usuario_id);

-- Carrito detalle
CREATE INDEX idx_carrito_detalle_carrito
ON carrito_detalle(carrito_id);

CREATE INDEX idx_carrito_detalle_producto
ON carrito_detalle(producto_id);

-- Pedidos
CREATE INDEX idx_pedido_usuario
ON pedidos(usuario_id);

-- Detalle pedido
CREATE INDEX idx_detalle_pedido
ON detalle_pedido(pedido_id);

CREATE INDEX idx_detalle_producto
ON detalle_pedido(producto_id);

-- Favoritos
CREATE INDEX idx_favorito_usuario
ON favoritos(usuario_id);

-- Reseñas
CREATE INDEX idx_resena_producto
ON resenas(producto_id);

-- Marcas
CREATE INDEX idx_marca_nombre
ON marcas(nombre);

-- Productos
CREATE INDEX idx_producto_marca
ON productos(marca_id);

-- Direcciones
CREATE INDEX idx_direccion_usuario
ON direcciones(usuario_id);
