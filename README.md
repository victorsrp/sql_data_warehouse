# Projeto Data Warehouse com SQL Server

## 📖 Sobre o Projeto

Este projeto implementa um Data Warehouse para unificar informações de Vendas (ERP) e Marketing (CRM), oferecendo uma visão completa da jornada do cliente. O objetivo é capacitar as equipes de Negócios e Marketing com dados consolidados e confiáveis para análises estratégicas, utilizando exclusivamente o **Microsoft SQL Server**.

---

### 🎯 O Problema

Atualmente, os dados de uma empresa e-commerce estão isolados em diferentes sistemas:
* A equipe de **Marketing** gerencia campanhas e leads em um **CRM**, mas não consegue medir o impacto real dessas ações em vendas.
* A equipe de **Negócios** analisa o faturamento a partir de dados do **ERP**, mas não tem visibilidade sobre quais campanhas de marketing originaram os clientes mais valiosos.

Esse cenário impede o cálculo preciso do ROI de campanhas e a criação de uma estratégia de vendas e marketing baseada em dados integrados.

### ✨ A Solução

Este projeto resolve o problema através da construção de um pipeline de dados, orquestrado por Stored Procedures em T-SQL, que segue a **Arquitetura Medalhão** (Bronze, Silver, Gold) para criar uma fonte única da verdade (*Single Source of Truth*). A solução centraliza e modela os dados dentro do SQL Server, permitindo análises cruzadas e a geração de insights valiosos.

---
## 🏛️ Arquitetura de Dados
![Data Architecture](docs/design_arquitetura.png)
A arquitetura do projeto é dividida em três camadas lógicas dentro do mesmo banco de dados, garantindo rastreabilidade, qualidade e performance.

* 🥉 **Camada Bronze:** Contém os dados brutos, exatamente como chegam das fontes (CSVs do ERP e CRM). Seu principal objetivo é a rastreabilidade e a capacidade de reprocessamento.

* 🥈 **Camada Silver:** Camada intermediária onde os dados brutos são limpos, padronizados, enriquecidos e validados através de scripts T-SQL. É aqui que garantimos a qualidade e a consistência dos dados.

* 🥇 **Camada Gold:** A camada final, onde os dados são modelados e agregados para atender diretamente às necessidades de negócio. Os dados são organizados em um modelo dimensional (Star Schema) e expostos através de Views para consumo em ferramentas de BI (Power BI, Tableau, etc.).

> Para um detalhamento visual completo, consulte o **[Diagrama da Arquitetura](docs/design_arquitetura.png)**.

---

## 📁 Estrutura do Projeto

O repositório está organizado com foco em scripts SQL, facilitando a implantação e manutenção do Data Warehouse.
```
├── datasets/
│   └── # Arquivos de dados brutos (ERP e CRM)
├── docs/
│   ├── design_arquitetura.png
|   ├── data_layer.png
│   ├── padroes_nomenclatura.md
│   └── ...
├── scripts/
│   ├── bronze/
│   │   └── # Scripts para carga de dados na camada Bronze
│   ├── silver/
│   │   └── # Scripts para limpeza e transformação (Bronze -> Silver)
│   └── gold/
│       └── # Scripts para modelagem e agregação (Silver -> Gold)
├── tests/
│   └── # Scripts para testes de qualidade de dados
├── README.md
├── LICENSE
└── .gitignore
```

---

## 🚀 Começando

Siga as instruções abaixo para configurar e executar o Data Warehouse em seu ambiente.

### Pré-requisitos

* Microsoft SQL Server (2019 ou superior)
* SQL Server Management Studio (SSMS) ou Azure Data Studio

### Instalação e Execução

1.  **Clone o repositório:**
    ```sh
    git clone https://victorsrp/sql_data_warehouse.git
    cd sql_data_warehouse
    ```

2.  **Crie o Banco de Dados:**
    Conecte-se à sua instância do SQL Server e crie um novo banco de dados para o projeto (ex: `dw_visaocliente`).

3.  **Execute os Scripts de Carga:**
    Para popular o Data Warehouse, execute os scripts da pasta `scripts/` na ordem correta das camadas:
    
    1.  Execute os scripts contidos na pasta `scripts/bronze/` para carregar os dados brutos.
    2.  Execute os scripts da pasta `scripts/silver/` para transformar os dados da camada Bronze para a Silver.
    3.  Execute os scripts da pasta `scripts/gold/` para criar os modelos analíticos finais.

    *Observação: Pode ser necessário configurar caminhos de arquivos ou fontes de dados dentro dos scripts, dependendo de onde foi clonado o projeto.*

---

## 📄 Documentação Adicional

A documentação detalhada do projeto é fundamental para a sua manutenção e evolução.

* **[Regras de Negócios](docs/business_rules.md)**: Documento que define as regras e validações de negócio que garantem a integridade e consistência dos dados no projeto.
* **[Convenções de Nomenclatura](docs/padroes_nomenclatura.md)**: Descreve todos os padrões de nomenclatura para tabelas, colunas e outros objetos do Data Warehouse.
* **[Diagrama da Arquitetura](docs/design_arquitetura.png)**: Arquivo editável do Draw.io com o diagrama completo da arquitetura de dados.
* **[Camadas do Data Warehouse](docs/data_layer.png)**: Arquivo editável do Draw.io com o diagrama completo das camadas do schema medalhão.
* **[Data Catalog](docs/data_catalog.md)**: Documento que descreve e organiza os conjuntos de dados do projeto, detalhando suas origens, estrutura, finalidade e relações no ecossistema de dados.

---

## 🤝 Contribuição

Contribuições são bem-vindas! Se você tiver sugestões para melhorar o projeto, sinta-se à vontade para abrir uma *issue* ou enviar um *pull request*.
