-- ============================
-- 1. Quantos clientes existem?
-- ============================

SELECT COUNT(nome) AS quantidade_clientes
FROM clientes;

-- =======================================
-- 2. Quantos clientes existem por cidade?
-- =======================================

SELECT COUNT(nome) AS quantidade_clientes, cidade
FROM clientes
GROUP BY cidade;

-- ===============================================
-- 3. Quais os clientes que nunca fizeram compras?
-- ===============================================

SELECT nome
FROM clientes c
LEFT JOIN pedidos p
On p.cliente_id = c.cliente_id
WHERE p.cliente_id IS NULL;

-- =========================================
-- 4. Quantos pedidos realizou cada cliente?
-- =========================================

SELECT nome, COUNT(pedido_id) AS quantidade_pedidos
FROM clientes c
LEFT JOIN pedidos p
On p.cliente_id = c.cliente_id
GROUP BY nome;

-- =======================================
-- 5. Quanto gastou cada cliente no total?
-- =======================================

SELECT c.nome, SUM(pr.preco * pe.quantidade) AS faturacao
FROM clientes c
INNER JOIN pedidos pe ON pe.cliente_id = c.cliente_id
INNER JOIN produtos pr ON pr.produto_id = pe.produto_id
GROUP BY c.nome;

-- ======================================
-- 6. Qual foi o cliente que mais gastou?
-- ======================================

SELECT c.nome, SUM(pr.preco * pe.quantidade) AS faturacao
FROM clientes c
INNER JOIN pedidos pe ON pe.cliente_id = c.cliente_id
INNER JOIN produtos pr ON pr.produto_id = pe.produto_id
GROUP BY c.nome
ORDER BY faturacao DESC
LIMIT 1;

-- =================================================
-- 7. Quais os clientes que gastaram acima da média?
-- =================================================

SELECT c.nome, SUM(pr.preco * pe.quantidade) AS faturacao
FROM clientes c
INNER JOIN pedidos pe ON pe.cliente_id = c.cliente_id
INNER JOIN produtos pr ON pr.produto_id = pe.produto_id
GROUP BY c.nome
HAVING SUM(pr.preco * pe.quantidade) > 
(
  SELECT AVG(total_cliente)
  FROM (
    SELECT SUM(pr2.preco * pe2.quantidade) AS total_cliente
    FROM pedidos pe2
    INNER JOIN produtos pr2 ON pr2.produto_id = pe2.produto_id
    GROUP BY pe2.cliente_id
  ) AS medias_globais
);

-- =======================================
-- 8. Qual o ticket médio de cada cliente?
-- =======================================

SELECT c.nome, SUM(pr.preco * pe.quantidade) / COUNT(DISTINCT pe.pedido_id) AS ticket_medio
FROM clientes c
INNER JOIN pedidos pe ON pe.cliente_id = c.cliente_id
INNER JOIN produtos pr ON pr.produto_id = pe.produto_id
GROUP BY c.nome;

-- ========================================
-- 9. Quantos produtos existem no catálogo?
-- ========================================

SELECT COUNT(DISTINCT produto_id) AS quantidade_produtos
FROM produtos;

-- ===============================
-- 10. Qual é o produto mais caro?
-- ===============================

SELECT produto_nome, preco
FROM produtos
ORDER BY preco DESC
LIMIT 1;

-- ======================================
-- 11. Qual é o preço médio dos produtos?
-- ======================================

SELECT AVG(preco) AS preco_medio
FROM produtos;

-- ===============================================
-- 12. Quais os produtos com preço acima da média?
-- ===============================================

SELECT produto_nome
FROM produtos
WHERE preco >
(
  SELECT AVG(preco)
  FROM produtos
);

-- ===============================================
-- 13. Quais os produtos que nunca foram vendidos?
-- ===============================================

SELECT produto_nome
FROM produtos pr
LEFT JOIN pedidos pe
ON pr.produto_id = pe.produto_id
WHERE pe.produto_id IS NULL

-- =====================================================
-- 14. Quais os produtos mais vendidos (por quantidade)?
-- =====================================================

SELECT produto_nome,
       SUM(quantidade) AS total_vendido
FROM produtos pr
JOIN pedidos pe
ON pr.produto_id=pe.produto_id
GROUP BY produto_nome
ORDER BY total_vendido DESC;

-- ================================
-- 15. Quanto faturou cada produto?
-- ================================

SELECT produto_nome, SUM(quantidade * preco) AS faturacao
FROM produtos pr
INNER JOIN pedidos pe
ON pr.produto_id = pe.produto_id
GROUP by produto_nome;

-- ===========================================
-- 16. Quais os 3 produtos que mais faturaram?
-- ===========================================

SELECT produto_nome, SUM(quantidade * preco) AS faturacao
FROM produtos pr
INNER JOIN pedidos pe
ON pr.produto_id = pe.produto_id
GROUP by produto_nome
ORDER BY faturacao DESC
LIMIT 3;

-- ===================================================
-- 17. Quais os produtos com faturação acima da média?
-- ===================================================

SELECT produto_nome, SUM(quantidade * preco) AS faturacao
FROM produtos pr
INNER JOIN pedidos pe
ON pr.produto_id = pe.produto_id
GROUP BY produto_nome
HAVING SUM(quantidade * preco) >
(
  SELECT AVG(faturacao)
  FROM (
    SELECT SUM(sub_pe.quantidade * sub_pr.preco) AS faturacao
    FROM pedidos sub_pe
    INNER JOIN produtos sub_pr
    ON sub_pe.produto_id = sub_pr.produto_id
    GROUP BY sub_pe.produto_id
  )
);

-- =====================================
-- 18. Quantos pedidos foram realizados?
-- =====================================

SELECT COUNT(DISTINCT pedido_id) AS quantidade_pedido
FROM pedidos;

-- =============================================
-- 19. Quantos produtos foram vendidos no total?
-- =============================================

SELECT SUM(quantidade) AS produtos_vendidos
FROM pedidos;

-- ==========================================
-- 20. Qual foi a faturação total da empresa?
-- ==========================================

SELECT SUM( quantidade * preco) AS faturacao_total
FROM pedidos pe
INNER JOIN produtos pr
ON pe.produto_id = pr.produto_id;

-- ===================================
-- 21. Qual o ticket médio por pedido?
-- ===================================

SELECT SUM(preco * quantidade) / COUNT(DISTINCT pedido_id) AS ticket_medio
FROM pedidos pe
INNER JOIN produtos pr
ON pe.produto_id = pr.produto_id;

-- ================================================
-- 22. Quais os pedidos com valor superior a 1000€?
-- ================================================

SELECT pe.pedido_id, SUM(quantidade * preco) AS valor
FROM produtos pr
INNER JOIN pedidos pe
ON pr.produto_id = pe.produto_id
GROUP BY pe.pedido_id
HAVING valor > 1000;

-- ================================
-- 23. Qual foi o pedido mais caro?
-- ================================

SELECT pe.pedido_id, SUM(quantidade * preco) AS valor
FROM produtos pr
INNER JOIN pedidos pe
ON pr.produto_id = pe.produto_id
GROUP BY pe.pedido_id
ORDER BY valor DESC
LIMIT 1;

-- =======================================
-- 24. Qual a faturação de cada categoria?
-- =======================================

SELECT categoria_nome, SUM(quantidade * preco) AS faturacao
FROM categorias c
INNER JOIN produtos pr
ON c.categoria_id = pr.categoria_id
INNER JOIN pedidos pe
ON pr.produto_id = pe.produto_id
GROUP BY categoria_nome;

-- ======================================
-- 25. Qual a categoria que mais faturou?
-- ======================================

SELECT categoria_nome, SUM(quantidade * preco) AS faturacao
FROM categorias c
INNER JOIN produtos pr
ON c.categoria_id = pr.categoria_id
INNER JOIN pedidos pe
ON pr.produto_id = pe.produto_id
GROUP BY categoria_nome
ORDER BY faturacao DESC
LIMIT 1;

-- ===================================
-- Qual a categoria que menos faturou?
-- ===================================

SELECT categoria_nome, SUM(quantidade * preco) AS faturacao
FROM categorias c
INNER JOIN produtos pr
ON c.categoria_id = pr.categoria_id
INNER JOIN pedidos pe
ON pr.produto_id = pe.produto_id
GROUP BY categoria_nome
ORDER BY faturacao ASC
LIMIT 1;

-- ================================================
-- 27. Qual a categoria com mais produtos vendidos?
-- ================================================

SELECT categoria_nome, SUM(quantidade) AS produtos_vendidos
FROM categorias c
INNER JOIN produtos pr
ON c.categoria_id = pr.categoria_id
INNER JOIN pedidos pe
ON pr.produto_id = pe.produto_id
GROUP BY categoria_nome
ORDER BY produtos_vendidos DESC
LIMIT 1;

-- ==================================
-- 28. Existem categorias sem vendas?
-- ==================================

SELECT categoria_nome
FROM categorias c
LEFT JOIN produtos pr
ON c.categoria_id = pr.categoria_id
LEFT JOIN pedidos pe
ON pr.produto_id = pe.produto_id
WHERE pedido_id IS NULL
GROUP BY categoria_nome;

-- =============================
-- 29. Qual a faturação por mês?
-- =============================

SELECT strftime('%m', data_pedido) AS mes, SUM(quantidade * preco) AS faturacao
FROM pedidos pe
INNER JOIN produtos pr
ON pe.produto_id = pr.produto_id
GROUP BY mes;

-- =================================================
-- 30. Quantos pedidos foram realizados em cada mês?
-- =================================================

SELECT strftime('%m', data_pedido) AS mes, COUNT(DISTINCT pedido_id) as quantidade_pedido
FROM pedidos pe
INNER JOIN produtos pr
ON pe.produto_id = pr.produto_id
GROUP BY mes;

-- =======================================
-- 31. Qual foi o mês com maior faturação?
-- =======================================

SELECT strftime('%m', data_pedido) AS mes, SUM(quantidade * preco) AS faturacao
FROM pedidos pe
INNER JOIN produtos pr
ON pe.produto_id = pr.produto_id
GROUP BY mes
ORDER BY faturacao DESC
LIMIT 1;

-- ============================================
-- 32. Em que mês foram vendidos mais produtos?
-- ============================================

SELECT strftime('%m', data_pedido) AS mes, SUM(quantidade) AS produto_vendido
FROM pedidos pe
INNER JOIN produtos pr
ON pe.produto_id = pr.produto_id
GROUP BY mes
ORDER BY produto_vendido DESC
LIMIT 1;

-- ============================================
-- 33. Qual foi a evolução mensal da faturação?
-- ============================================

WITH faturacao_mensal AS (
    SELECT
        strftime('%m', data_pedido) AS mes,
        SUM(quantidade * preco) AS faturacao
    FROM pedidos pe
    JOIN produtos pr
      ON pe.produto_id = pr.produto_id
    GROUP BY mes
)

SELECT
    mes,
    faturacao,
    LAG(faturacao) OVER (ORDER BY mes) AS faturacao_mes_anterior
FROM faturacao_mensal;

-- ================================================
-- 34. Criar um ranking dos clientes por faturação.
-- ================================================

WITH faturacao_cliente as (
  SELECT nome, SUM(quantidade * preco) AS faturacao
  FROM clientes c
  INNER JOIN pedidos pe
  ON c.cliente_id = pe.cliente_id
  INNER JOIN produtos pr
  ON pe.produto_id = pr.produto_id
  GROUP BY nome
)

SELECT RANK() OVER (ORDER BY faturacao DESC) AS ranking, nome, faturacao
FROM faturacao_cliente

-- ================================================
-- 35. Criar um ranking dos produtos por faturação.
-- ================================================

WITH faturacao_produto as (
  SELECT produto_nome, SUM(quantidade * preco) AS faturacao
  FROM produtos pr
  INNER JOIN pedidos pe
  ON pr.produto_id = pe.produto_id
  GROUP BY produto_nome
)

SELECT RANK() OVER (ORDER BY faturacao DESC) AS ranking, produto_nome, faturacao
FROM faturacao_produto

-- ==================================================
-- 36. Criar um ranking das categorias por faturação.
-- ==================================================

WITH faturacao_categoria as (
  SELECT categoria_nome, SUM(quantidade * preco) AS faturacao
  FROM categorias c
  INNER JOIN produtos pr
  ON c.categoria_id = pr.categoria_id
  INNER JOIN pedidos pe
  ON pr.produto_id = pe.produto_id
  GROUP BY categoria_nome
)

SELECT RANK() OVER (ORDER BY faturacao DESC) AS ranking, categoria_nome, faturacao
FROM faturacao_categoria

-- =========================================================
-- 37. Qual é a posição de cada cliente em termos de gastos?
-- =========================================================

WITH gastos_clientes AS (
    SELECT nome, SUM(quantidade * preco) AS total_gasto
    FROM clientes c
    INNER JOIN pedidos pe
    ON c.cliente_id = pe.cliente_id
    INNER JOIN produtos pr
    ON pe.produto_id = pr.produto_id
    GROUP BY nome
)
SELECT 
    RANK() OVER (ORDER BY total_gasto DESC) AS ranking, nome, total_gasto
    FROM gastos_clientes;

-- ====================================================================================
-- 38. Classificar os clientes em Premium, Gold e Standard de acordo com o valor gasto.
-- ====================================================================================

WITH gastos_clientes AS (
    SELECT nome, SUM(quantidade * preco) AS total_gasto
    FROM clientes c
    INNER JOIN pedidos pe
    ON c.cliente_id = pe.cliente_id
    INNER JOIN produtos pr
    ON pe.produto_id = pr.produto_id
    GROUP BY nome
)
SELECT 
    nome, total_gasto, CASE
        WHEN total_gasto >= 2000 THEN 'Premium'
        WHEN total_gasto >= 1500  THEN 'Gold'
        ELSE 'Standard'
    END AS classificacao
FROM gastos_clientes
ORDER BY total_gasto DESC;

-- ===================================================
-- 39. Classificar os produtos em Caro, Médio e Barato
-- ===================================================

SELECT produto_nome,
       preco,
       CASE
           WHEN preco >= 900 THEN 'Caro'
           WHEN preco >= 100 THEN 'Médio'
           ELSE 'Barato'
       END AS classificacao
FROM produtos
ORDER BY preco DESC;

-- ================================================================
-- 40. Quais os clientes cujo gasto está acima da média da empresa?
-- ================================================================

WITH gastos_cliente AS (
    SELECT nome, SUM(quantidade * preco) AS total_gasto
    FROM clientes c
    INNER JOIN pedidos pe
    ON c.cliente_id = pe.cliente_id
    INNER JOIN produtos pr
    ON pe.produto_id = pr.produto_id
    GROUP BY nome
)
SELECT nome, total_gasto
FROM gastos_cliente
WHERE total_gasto > (SELECT AVG(total_gasto) FROM gastos_cliente)
ORDER BY total_gasto DESC;

-- ==================================================================
-- 41. Criar um relatório reutilizável com o total gasto por cliente.
-- ==================================================================

CREATE VIEW total_gasto_cliente as
SELECT nome, SUM(quantidade * preco) AS gasto_total
From clientes c
INNER JOIN pedidos pe
ON c.cliente_id = pe.cliente_id
INNER JOIN produtos pr
ON pe.produto_id = pr.produto_id
GROUP by nome;

-- ==================================================================
-- 42. Criar um relatório reutilizável com a faturação por categoria.
-- ==================================================================

CREATE VIEW faturacao_por_categoria as
SELECT categoria_nome, SUM(quantidade * preco) as faturacao
From categorias c
INNER JOIN produtos pr
ON c.categoria_id = pr.categoria_id
INNER JOIN pedidos pe
ON pr.produto_id = pe.produto_id
GROUP by categoria_nome;

-- ========================================================
-- 43. Comparar a faturação de cada mês com o mês anterior.
-- ========================================================

WITH faturacao_mensal AS  (
  SELECT strftime('%m', data_pedido) AS mes, SUM(quantidade * preco) as faturacao
  FROM pedidos pe
  INNER JOIN produtos pr
  ON pe.produto_id = pr.produto_id
  GROUP BY mes
)

SELECT mes, faturacao, LAG(faturacao, 1, 0) OVER (ORDER BY mes ASC) AS faturacao_anterior
From faturacao_mensal
ORDER BY mes ASC;

-- ========================================================
-- 44. Comparar a faturação de cada mês com o mês seguinte.
-- ========================================================

WITH faturacao_mensal AS  (
  SELECT strftime('%m', data_pedido) AS mes, SUM(quantidade * preco) as faturacao
  FROM pedidos pe
  INNER JOIN produtos pr
  ON pe.produto_id = pr.produto_id
  GROUP BY mes
)

SELECT mes, faturacao, LEAD(faturacao, 1, 0) OVER (ORDER BY mes ASC) AS faturacao_seguinte
From faturacao_mensal
ORDER BY mes ASC;

-- =========================================================
-- 45. Existem nomes de clientes com espaços desnecessários?
-- =========================================================

SELECT nome,
       TRIM(nome) AS nome_limpo
FROM clientes
WHERE nome <> TRIM(nome);

-- ======================================================================
-- 46. Criar uma versão padronizada dos nomes dos clientes em maiúsculas.
-- ======================================================================

SELECT nome,
       UPPER(nome) AS nome_maiusculo
FROM clientes;

-- ========================================================================================
-- 47. Criar um código curto para cada cliente utilizando as três primeiras letras do nome.
-- ========================================================================================

SELECT nome,
       SUBSTR(nome, 1, 3) AS codigo
FROM clientes;

-- =======================================================================================================
-- 48. Verificar quantos caracteres tem o nome de cada cliente para identificar possíveis inconsistências.
-- =======================================================================================================

SELECT nome,
       LENGTH(nome) AS quantidade_caracteres
FROM clientes;
