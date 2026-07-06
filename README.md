# Análise de Dados de Negócio com SQL

## Objetivo

Este projeto foi desenvolvido para responder a questões de negócio através da análise de uma base de dados fictícia de e-commerce utilizando SQL e SQLite.

---

## Skills Demonstradas

- SQL
- INNER JOIN
- LEFT JOIN
- GROUP BY
- HAVING
- Subqueries
- CTEs
- Views
- CASE WHEN
- Window Functions
- Business Analysis
- Data Modeling

---

## Base de Dados

O projeto utiliza quatro tabelas:

- Clientes
- Produtos
- Pedidos
- Categorias

---

## Perguntas de Negócio Respondidas

### Clientes

1. Quantos clientes existem?
2. Quantos clientes existem por cidade?
3. Quais os clientes que nunca fizeram compras?
4. Quantos pedidos realizou cada cliente?
5. Quanto gastou cada cliente?
6. Qual foi o cliente que mais gastou?
7. Quais os clientes que gastaram acima da média?
8. Qual o ticket médio de cada cliente?

### Produtos

9. Quantos produtos existem no catálogo?
10. Qual é o produto mais caro?
11. Qual é o preço médio dos produtos?
12. Quais os produtos com preço acima da média?
13. Quais os produtos que nunca foram vendidos?
14. Quais os produtos mais vendidos (por quantidade)?
15. Quanto faturou cada produto?
16. Quais os 3 produtos que mais faturaram?
17. Quais os produtos com faturação acima da média?

### Pedidos

18. Quantos pedidos foram realizados?
19. Quantos produtos foram vendidos no total?
20. Qual foi a faturação total da empresa?
21. Qual o ticket médio por pedido?
22. Quais os pedidos com valor superior a 1000€?
23. Qual foi o pedido mais caro?

### Categorias

24. Qual a faturação de cada categoria?
25. Qual a categoria que mais faturou?
26. Qual a categoria que menos faturou?
27. Qual a categoria com mais produtos vendidos?
28. Existem categorias sem vendas?

### Análise Temporal

29. Qual a faturação por mês?
30. Quantos pedidos foram realizados em cada mês?
31. Qual foi o mês com maior faturação?
32. Em que mês foram vendidos mais produtos?
33. Qual foi a evolução mensal da faturação?

### Rankings

34. Criar um ranking dos clientes por faturação.
35. Criar um ranking dos produtos por faturação.
36. Criar um ranking das categorias por faturação.
37. Qual é a posição de cada cliente em termos de gastos?

### SQL Avançado

38. Classificar os clientes em Premium, Gold e Standard de acordo com o valor gasto.
39. Classificar os produtos em Caro, Médio e Barato.
40. Quais os clientes cujo gasto está acima da média da empresa?
41. Criar um relatório reutilizável com o total gasto por cliente.
42. Criar um relatório reutilizável com a faturação por categoria.
43. Comparar a faturação de cada mês com o mês anterior.
44. Comparar a faturação de cada mês com o mês seguinte.

### Qualidade dos Dados

45. Existem nomes de clientes com espaços desnecessários?
46. Criar uma versão padronizada dos nomes dos clientes em maiúsculas.
47. Criar um código curto para cada cliente utilizando as três primeiras letras do nome.
48. Verificar quantos caracteres tem o nome de cada cliente para identificar possíveis inconsistências.

---

## Ferramentas Utilizadas

- SQLite
- SQL
- SQLite Online

---

## Principais Insights

- Identificação dos clientes mais valiosos.
- Identificação dos produtos com maior faturação.
- Deteção de clientes sem histórico de compras.
- Comparação de categorias através de métricas agregadas.
- Análise temporal das vendas.
- Aplicação de SQL avançado para responder a problemas de negócio.

---

## Estrutura do Projeto

sql-business-analysis

1. README.md
2. database.sql
3. queries.sql

---

## O que Aprendi

- Relacionar múltiplas tabelas através de JOINs.
- Utilizar Subqueries para análises avançadas.
- Criar CTEs e Views para organizar consultas.
- Aplicar Window Functions em rankings e análises temporais.
- Utilizar CASE WHEN para classificação de dados.
- Trabalhar com funções de Data e Texto.
- Responder a questões de negócio através de SQL.
