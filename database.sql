-- =========================
-- CATEGORIAS
-- =========================

CREATE TABLE categorias (
    categoria_id INTEGER PRIMARY KEY,
    categoria_nome TEXT
);

INSERT INTO categorias VALUES
(1,'Eletrónica'),
(2,'Informática'),
(3,'Gaming'),
(4,'Acessórios'),
(5,'Escritório');

-- =========================
-- CLIENTES
-- =========================

CREATE TABLE clientes (
    cliente_id INTEGER PRIMARY KEY,
    nome TEXT,
    cidade TEXT
);

INSERT INTO clientes VALUES
(1,'Bruno','Lisboa'),
(2,'João','Porto'),
(3,'Maria','Coimbra'),
(4,'Ana','Braga'),
(5,'Pedro','Faro'),
(6,'Carlos','Aveiro'),
(7,'Sofia','Leiria'),
(8,'Rita','Setúbal'),
(9,'Miguel','Viseu'),
(10,'Inês','Évora');

-- Miguel e Inês nunca compram

-- =========================
-- PRODUTOS
-- =========================

CREATE TABLE produtos (
    produto_id INTEGER PRIMARY KEY,
    produto_nome TEXT,
    preco REAL,
    categoria_id INTEGER
);

INSERT INTO produtos VALUES
(1,'Portátil',1500,2),
(2,'Monitor',300,2),
(3,'Rato',25,4),
(4,'Teclado',80,4),
(5,'Headset',120,3),
(6,'PlayStation 5',550,3),
(7,'Telemóvel',950,1),
(8,'Tablet',450,1),
(9,'Impressora',180,5),
(10,'Webcam',90,5);

-- Webcam nunca será vendida

-- =========================
-- PEDIDOS
-- =========================

CREATE TABLE pedidos (
    pedido_id INTEGER PRIMARY KEY,
    cliente_id INTEGER,
    produto_id INTEGER,
    quantidade INTEGER,
    data_pedido DATE
);

INSERT INTO pedidos VALUES
(1,1,1,1,'2025-01-05'),
(2,2,3,2,'2025-01-08'),
(3,3,6,1,'2025-01-12'),
(4,4,2,2,'2025-01-18'),
(5,5,5,3,'2025-01-25'),

(6,6,8,1,'2025-02-03'),
(7,7,4,2,'2025-02-10'),
(8,8,7,1,'2025-02-16'),
(9,1,2,1,'2025-02-20'),
(10,2,5,1,'2025-02-28'),

(11,3,1,1,'2025-03-05'),
(12,4,3,4,'2025-03-09'),
(13,5,7,1,'2025-03-15'),
(14,6,6,1,'2025-03-20'),
(15,7,8,2,'2025-03-27'),

(16,8,2,1,'2025-04-02'),
(17,1,5,2,'2025-04-08'),
(18,2,1,1,'2025-04-12'),
(19,3,9,1,'2025-04-18'),
(20,4,6,1,'2025-04-26'),

(21,5,3,5,'2025-05-03'),
(22,6,2,2,'2025-05-09'),
(23,7,7,1,'2025-05-15'),
(24,8,5,2,'2025-05-20'),
(25,1,6,1,'2025-05-27'),

(26,2,8,1,'2025-06-04'),
(27,3,2,2,'2025-06-10'),
(28,4,1,1,'2025-06-18'),
(29,5,4,3,'2025-06-24'),
(30,6,9,1,'2025-06-30');
