CREATE TABLE tb_entregas_sp(
	order_id VARCHAR(50),
	customer_id VARCHAR(50),
	order_status VARCHAR(20),
	order_purchase_timestamp TIMESTAMP,
	order_approved_at TIMESTAMP,
	order_delivered_carrier_date TIMESTAMP,
	order_delivered_customer_date TIMESTAMP,
	order_estimated_delivery_date TIMESTAMP,
	customer_unique_id VARCHAR(50),
	customer_zip_code_prefix INT,
	customer_city VARCHAR(100),
	customer_state VARCHAR(2),
	tempo_entrega_dias NUMERIC (10,2),
	sla_cumprido INT,
	regiao_logistica VARCHAR(30)
);

SELECT
	regiao_logistica AS "Regiao",
	COUNT(order_id) AS "Total Pedidos",
	ROUND(AVG(tempo_entrega_dias), 2) AS "Média Dias Entrega",
	ROUND(AVG(sla_cumprido) *100, 2) AS "% SLA Cumprido"
FROM tb_entregas_sp
GROUP BY regiao_logistica
ORDER BY "% SLA Cumprido" DESC;

SELECT 
	regiao_logistica AS "Regiao",
	COUNT(order_id) AS "Total de Atrasos",
	ROUND(AVG(tempo_entrega_dias), 2) AS "Média de Dias (Pedidos Atrasados)"
FROM tb_entregas_sp
WHERE sla_cumprido = 0
GROUP BY regiao_logistica
ORDER BY "Total de Atrasos" DESC;


SELECT 
	customer_city AS "Cidade",
	regiao_logistica AS "Regiao",
	COUNT(order_id) AS "Total Pedidos",
	ROUND(AVG(tempo_entrega_dias), 2) AS "Tempo Médio (Dias)",
	ROUND(AVG(sla_cumprido) * 100,2) AS "% SLA Cumprido"
FROM tb_entregas_sp
GROUP BY customer_city, regiao_logistica
HAVING COUNT(order_id) >=100
ORDER BY "Total Pedidos" DESC
LIMIT 10;

SELECT 
	TO_CHAR(order_delivered_customer_date, 'YYY-MM') AS "Mês/Ano",
	COUNT(order_id) AS "Volume de Entregas",
	ROUND(AVG(tempo_entrega_dias), 2) AS "Média Dias Entrega",
	ROUND(AVG(sla_cumprido) *100, 2) AS "% SLA Cumprido"
FROM tb_entregas_sp
GROUP BY TO_CHAR(order_delivered_customer_date, 'YYY-MM')
ORDER BY "Mês/Ano" DESC;