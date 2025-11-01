# Catálogo de Dados para a Camada Gold

## Visão Geral
A Camada Gold (Ouro) é a representação dos dados a nível de negócio, estruturada para suportar casos de uso de análise e relatórios. Ela consiste em **tabelas de dimensão** e **tabelas fato** para métricas de negócio específicas.

---

### 1. **gold.dim_customers**
- **Propósito:** Armazena detalhes dos clientes enriquecidos com dados demográficos e geográficos.
- **Colunas:**

| Nome da Coluna | Tipo de Dado | Descrição |
| :--- | :--- | :--- |
| `customer_key` | INT | Chave substituta que identifica unicamente cada registro de cliente na tabela de dimensão. |
| `customer_id` | INT | Identificador numérico exclusivo atribuído a cada cliente. |
| `customer_number` | NVARCHAR(50) | Identificador alfanumérico que representa o cliente, usado para rastreamento e referência. |
| `first_name` | NVARCHAR(50) | O primeiro nome do cliente, conforme registrado no sistema. |
| `last_name` | NVARCHAR(50) | O sobrenome ou nome de família do cliente. |
| `country` | NVARCHAR(50) | O país de residência do cliente (ex: 'Australia'). |
| `marital_status` | NVARCHAR(50) | O estado civil do cliente (ex: 'Casado', 'Solteiro'). |
| `gender` | NVARCHAR(50) | O gênero do cliente (ex: 'Masculino', 'Feminino', 'n/a'). |
| `birthdate` | DATE | A data de nascimento do cliente, formatada como AAAA-MM-DD (ex: 1971-10-06). |
| `create_date` | DATE | A data e hora em que o registro do cliente foi criado no sistema. |

---

### 2. **gold.dim_products**
- **Propósito:** Fornece informações sobre os produtos e seus atributos.
- **Colunas:**

| Nome da Coluna | Tipo de Dado | Descrição |
| :--- | :--- | :--- |
| `product_key` | INT | Chave substituta que identifica unicamente cada registro de produto na tabela de dimensão de produtos. |
| `product_id` | INT | Um identificador exclusivo atribuído ao produto para rastreamento e referência internos. |
| `product_number` | NVARCHAR(50) | Um código alfanumérico estruturado que representa o produto, frequentemente usado para categorização ou inventário. |
| `product_name` | NVARCHAR(50) | Nome descritivo do produto, incluindo detalhes chave como tipo, cor e tamanho. |
| `category_id` | NVARCHAR(50) | Um identificador exclusivo para a categoria do produto, ligando-o à sua classificação de alto nível. |
| `category` | NVARCHAR(50) | A classificação mais ampla do produto (ex: Bikes, Components) para agrupar itens relacionados. |
| `subcategory` | NVARCHAR(50) | Uma classificação mais detalhada do produto dentro da categoria, como o tipo de produto. |
| `maintenance_required` | NVARCHAR(50) | Indica se o produto requer manutenção (ex: 'Sim', 'Não'). |
| `cost` | INT | O custo ou preço base do produto, medido em unidades monetárias. |
| `product_line` | NVARCHAR(50) | A linha ou série de produtos específica à qual o produto pertence (ex: Road, Mountain). |
| `start_date` | DATE | A data em que o produto se tornou disponível para venda ou uso. |

---

### 3. **gold.fact_sales**
- **Propósito:** Armazena dados transacionais de vendas para fins analíticos.
- **Colunas:**

| Nome da Coluna | Tipo de Dado | Descrição |
| :--- | :--- | :--- |
| `order_number` | NVARCHAR(50) | Um identificador alfanumérico exclusivo para cada pedido de venda (ex: 'SO54496'). |
| `product_key` | INT | Chave substituta que liga o pedido à tabela de dimensão de produtos. |
| `customer_key` | INT | Chave substituta que liga o pedido à tabela de dimensão de clientes. |
| `order_date` | DATE | A data em que o pedido foi realizado. |
| `shipping_date` | DATE | A data em que o pedido foi enviado ao cliente. |
| `due_date` | DATE | A data de vencimento do pagamento do pedido. |
| `sales_amount` | INT | O valor monetário total da venda para o item da linha, em unidades monetárias inteiras (ex: 25). |
| `quantity` | INT | O número de unidades do produto pedidas para o item da linha (ex: 1). |
| `price` | INT | O preço por unidade do produto para o item da linha, em unidades monetárias inteiras (ex: 25). |
