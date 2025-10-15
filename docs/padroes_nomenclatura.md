# **Convenções de Nomenclatura para o Data Warehouse**

Este documento estabelece as convenções de nomenclatura para schemas, tabelas, views, colunas e outros objetos do data warehouse.

## **Índice**

1.  [Princípios Gerais](#princípios-gerais)
2.  [Nomenclatura de Tabelas](#nomenclatura-de-tabelas)
    -   [Regras da Camada Bronze](#regras-da-camada-bronze)
    -   [Regras da Camada Silver](#regras-da-camada-silver)
    -   [Regras da Camada Gold](#regras-da-camada-gold)
3.  [Nomenclatura de Colunas](#nomenclatura-de-colunas)
    -   [Chaves Substitutas (Surrogate Keys)](#chaves-substitutas-surrogate-keys)
    -   [Colunas Técnicas](#colunas-técnicas)
4.  [Nomenclatura de Stored Procedures](#nomenclatura-de-stored-procedures)

---

## **Princípios Gerais**

-   **Padrão de Nomenclatura**: Utilizar `snake_case`, ou seja, letras minúsculas com palavras separadas por underscore (`_`).
-   **Idioma dos Objetos**: Manter todos os nomes de objetos (tabelas, colunas, etc.) em **inglês**. O idioma português será usado apenas na documentação.
-   **Palavras Reservadas**: Evitar o uso de palavras reservadas do SQL (como `select`, `table`, `group`, etc.) como nomes de objetos.

## **Nomenclatura de Tabelas**

### **Regras da Camada Bronze**

-   Os nomes devem ser prefixados com o sistema de origem e o nome da tabela deve ser idêntico ao original, sem renomeação.
-   **Padrão**: `<sistema_origem>_<entidade>`
    -   `<sistema_origem>`: Nome do sistema de origem (ex: `crm`, `erp`).
    -   `<entidade>`: Nome exato da tabela no sistema de origem.
    -   **Exemplo**: `crm_customer_info` → Tabela com informações de clientes vindas do sistema CRM.

### **Regras da Camada Silver**

-   (Opcional, mas comum) Segue as mesmas regras da camada Bronze para manter a rastreabilidade direta com a origem.
-   **Padrão**: `<sistema_origem>_<entidade>`
    -   `<sistema_origem>`: Nome do sistema de origem (ex: `crm`, `erp`).
    -   `<entidade>`: Nome exato da tabela no sistema de origem.
    -   **Exemplo**: `crm_customer_info` → Tabela com informações de clientes do CRM, já limpas e padronizadas.

### **Regras da Camada Gold**

-   Os nomes devem ser significativos, alinhados à linguagem de negócio e prefixados por uma categoria que descreva seu propósito.
-   **Padrão**: `<categoria>_<entidade>`
    -   `<categoria>`: Descreve o papel da tabela, como `dim` (dimensão) ou `fact` (fato).
    -   `<entidade>`: Nome descritivo da tabela, alinhado ao domínio de negócio (ex: `customers`, `products`, `sales`).
    -   **Exemplos**:
        -   `dim_customers` → Tabela dimensão com a visão única de clientes.
        -   `fact_sales` → Tabela fato contendo as transações de vendas.

#### **Glossário de Categorias**

| Prefixo | Significado         | Exemplo(s)                             |
| :------ | :------------------ | :------------------------------------- |
| `dim_`  | Tabela Dimensão     | `dim_customer`, `dim_product`          |
| `fact_` | Tabela Fato         | `fact_sales`                           |
| `agg_`  | Tabela Agregada     | `agg_customers`, `agg_sales_monthly`   |

## **Nomenclatura de Colunas**

### **Chaves Substitutas (Surrogate Keys)**

-   Toda chave primária (*primary key*) de uma tabela dimensão deve ser uma *surrogate key* e terminar com o sufixo `_key`.
-   **Padrão**: `<nome_tabela_dim>_key`
    -   `<nome_tabela_dim>`: Refere-se à entidade da tabela dimensão.
    -   `_key`: Sufixo padrão para indicar que a coluna é a *surrogate key* da tabela.
    -   **Exemplo**: `customer_key` → Chave primária substituta da tabela `dim_customers`.

### **Colunas Técnicas**

-   Colunas de metadados, geradas pelo processo de ETL/ELT, devem começar com o prefixo `dwh_`.
-   **Padrão**: `dwh_<nome_coluna>`
    -   `dwh_`: Prefixo que identifica a coluna como um metadado de controle do Data Warehouse.
    -   `<nome_coluna>`: Nome que descreve o propósito da coluna.
    -   **Exemplo**: `dwh_load_at` → Coluna com a data e hora em que o registro foi carregado na tabela.

## **Nomenclatura de Stored Procedures**

-   *Stored procedures* utilizadas para os processos de carga de dados devem seguir o padrão abaixo:
-   **Padrão**: `sp_load_<camada>`
    -   `sp_`: Prefixo padrão para *Stored Procedure*.
    -   `load_`: Indica que o procedimento executa uma carga.
    -   `<camada>`: A camada de destino da carga (`bronze`, `silver` ou `gold`).
    -   **Exemplos**:
        -   `sp_load_bronze` → Procedure que carrega os dados na camada Bronze.
        -   `sp_load_silver` → Procedure que carrega os dados na camada Silver.
