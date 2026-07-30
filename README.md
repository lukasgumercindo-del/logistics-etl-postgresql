# 🚚 FamiliaLog — Pipeline de ETL e Análise Exploratória de Dados (EDA)

![Python](https://img.shields.io/badge/Python-3.13-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-Data%20Analysis-150458?style=for-the-badge&logo=pandas&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-DBMS-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-Analytics-CC292B?style=for-the-badge&logo=sqlite&logoColor=white)

## 📌 Sobre o Projeto

Este projeto consiste na construção de um **Pipeline de ETL (Extract, Transform, Load)** e numa **Análise Exploratória de Dados (EDA)** detalhada para a operação logística da **FamiliaLog** no estado de São Paulo (SP).

O foco principal do desenvolvimento foi a **Engenharia de Dados e Analytics Engineering**: transformar dados brutos, inconsistentes e não estruturados em uma base limpa, confiável e pronta para gerar insights estratégicos de negócio sobre prazos de entrega e cumprimento de SLA.

---

## 🎯 Objetivos de Negócio & Foco Técnico

### 💻 Foco do Desenvolvimento

- **ETL Robusto (Python & Pandas):** leitura de grandes volumes de dados, tratamento de inconsistências, manipulação avançada de datas (`timestamps` e `deltas`), limpeza e categorização geográfica.
- **Modelagem e Carga em Banco de Dados (PostgreSQL):** criação de estrutura física (DDL) e carga limpa dos dados para consumo analítico.
- **Consultas Analíticas (SQL):** criação de relatórios operacionais complexos utilizando agregações, ordenação, agrupamentos e filtros avançados no pgAdmin.

### 📦 Perguntas de Negócio Respondidas

1. Qual o volume total e o tempo médio/mediano de entrega por região de SP (Capital, Grande SP e Interior SP)?
2. Qual a taxa percentual de cumprimento de SLA por região?
3. Quais são as cidades com maior gargalo e volume de entregas?

---

## 🛠️ Tecnologias Utilizadas

- **Linguagem de Programação:** Python 3.13
- **Manipulação de Dados:** Pandas
- **Banco de Dados Relacional:** PostgreSQL 16 / pgAdmin 4
- **Linguagem de Consulta:** SQL (DDL e DML)
- **Ambiente de Desenvolvimento:** VS Code / Jupyter Notebook

---

## 🔄 Arquitetura do Pipeline de Dados (ETL)

```text
[ Dados Brutos (CSV) ]
       │
       ▼
[ 1. EXTRAÇÃO (Python / Pandas) ]
       │
       ▼
[ 2. TRANSFORMAÇÃO & TRATAMENTO (Python) ]
  ├── Remoção de duplicatas e nulos
  ├── Cálculo exato de tempo de entrega (Dias Decimais)
  ├── Regra de negócio: Cálculo de SLA cumprido (1 = No prazo, 0 = Atrasado)
  └── Categorização regional (Capital, Grande SP, Interior SP)
       │
       ▼
[ 3. CARGA (PostgreSQL) ]
  ├── Criação da Tabela com DDL otimizado (CREATE TABLE)
  └── Importação estruturada via UTF-8
       │
       ▼
[ 4. ANÁLISE EXPLORATÓRIA & CONSULTAS (SQL / EDA) ]
  └── Queries executivas para geração de relatórios de desempenho
```

---

## 📊 Principais Resultados e Insights da EDA

A análise exploratória revelou nuances cruciais sobre a operação de entregas em SP:

| Região Logística | Volume de Entregas | Média de Entrega (Dias) | Mediana de Entrega (Dias) | Taxa SLA Cumprido (%) |
|---|---|---|---|---|
| Capital | 15.045 | 4,96 | 3,71 | 93,74% |
| Grande SP | 6.043 | 4,74 | 3,37 | 94,37% |
| Interior SP | 19.405 | 6,36 | 5,30 | 94,31% |

### 💡 Principais Descobertas

- **Destaque de Eficiência:** a Grande SP apresentou a menor mediana de tempo de entrega (3,37 dias), superando inclusive a Capital.
- **Confiabilidade da Operação:** todas as regiões mantiveram uma taxa de SLA cumprido alta, acima de 93,7%, demonstrando consistência da frota.
- **Volume e Concentração:** o Interior SP concentrou o maior volume total de entregas (19.405 pedidos), justificando o tempo médio ligeiramente maior (6,36 dias) devido às distâncias percorridas.

---

## 📂 Estrutura das Consultas SQL (Exemplo)

```sql
-- Relatório Executivo de Desempenho Operacional por Região
SELECT 
    regiao_logistica AS "Região",
    COUNT(order_id) AS "Total Pedidos Entregues",
    ROUND(AVG(tempo_entrega_dias), 2) AS "Média Dias Entrega",
    ROUND(AVG(sla_cumprido) * 100, 2) AS "% SLA Cumprido"
FROM tb_entregas_sp
GROUP BY regiao_logistica
ORDER BY "% SLA Cumprido" DESC;
```

---

## 🚀 Como Executar o Projeto

**1. Clone o repositório:**

```bash
git clone https://github.com/lukasgumercindo-del/logistics-etl-postgresql.git
cd logistics-etl-postgresql
```

**2. Instale as dependências do Python:**

```bash
pip install pandas notebook
```

**3. Execute o Pipeline de Tratamento:**

Abra o notebook `familialog_data_pipeline.ipynb` e rode as células de extração e tratamento dos dados.

**4. Carregue e analise no PostgreSQL:**

- Abra a Query Tool no pgAdmin.
- Execute o script de `CREATE TABLE`.
- Importe o arquivo CSV tratado e rode os scripts de consulta SQL da pasta `sql/`.

---

✨ *Projeto desenvolvido com foco em práticas reais de Engenharia e Análise de Dados.*



