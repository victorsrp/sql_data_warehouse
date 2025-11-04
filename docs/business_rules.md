# Documentação da Regra de Negócio: Integridade de Dados de Vendas

## 1. Visão Geral e Objetivo Estratégico
Este documento detalha uma regra de negócio fundamental implementada no âmbito do projeto de Data Warehouse. O objetivo principal deste projeto é unificar dados transacionais do sistema de Vendas (ERP) com dados de relacionamento com o cliente do sistema de Marketing (CRM), estabelecendo uma fonte única da verdade (Single Source of Truth). Esta unificação visa capacitar as equipes de Negócios a realizar análises estratégicas com base em dados confiáveis e consistentes.

A importância estratégica de regras de negócio bem definidas para a integridade dos dados é inquestionável. Para que a organização possa calcular métricas financeiras essenciais, como o Retorno sobre o Investimento (ROI) de campanhas de marketing, e tomar decisões informadas, os dados financeiros subjacentes — especialmente o valor das vendas — devem ser absolutamente precisos. Inconsistências, valores ausentes ou incorretos nos dados brutos podem distorcer as análises e levar a conclusões equivocadas, comprometendo a eficácia das estratégias de negócio.

A seção a seguir definirá formalmente a regra de negócio aplicada para garantir a consistência e a validade dos dados transacionais de vendas, formando a base para um Data Warehouse confiável.

## 2. Definição Formal da Regra de Negócio
Esta seção articula a regra de negócio central que governa a validação e o cálculo dos dados de vendas, garantindo que os valores armazenados no Data Warehouse reflitam a realidade operacional com precisão. A aplicação desta regra é um passo crucial para transformar dados brutos em informações de valor analítico.

A regra de negócio é definida por duas condições mandatórias e inalienáveis que devem ser satisfeitas para cada transação de venda:

- **Consistência do Cálculo:** O valor total da venda (`sales`) deve ser rigorosamente igual ao produto da quantidade de itens vendidos (`quantity`) pelo preço unitário (`price`).  
  **Fórmula:** `sales = quantity * price`.

- **Validade dos Dados:** Os valores para `sales`, `quantity` e `price` devem ser sempre números positivos. É explicitamente proibido que estes campos contenham valores nulos, zero ou negativos, pois tais valores não representam uma transação de venda válida no contexto do negócio.

A lógica de implementação detalhada para identificar e corrigir os registros que violam esta regra será abordada na próxima seção.

## 3. Lógica de Implementação e Cenários de Correção
Durante a análise exploratória dos dados na camada **Bronze** (dados brutos), foram identificadas diversas anomalias nos dados transacionais: valores de `sales` e `price` nulos, negativos ou zerados, e casos em que o valor de `sales` não correspondia ao cálculo `quantity * price`, violando a lógica fundamental do negócio. Para sanar esses problemas, uma lógica de transformação foi implementada na transição dos dados da camada **Bronze** para a camada **Silver**, assegurando que apenas dados limpos e padronizados avancem no pipeline.

A seguir, detalhamos os cenários de correção aplicados para cada métrica.

### Cenário 1: Correção do Valor da Venda (`sales`)
O valor da venda é recalculado ou mantido com base nas seguintes condições:

- **Condição:** Se o valor original de `sales` for nulo, menor ou igual a zero, **OU** se o valor de `sales` não corresponder ao cálculo `quantity * price`.
- **Ação:** O valor de `sales` é substituído pelo resultado do cálculo `quantity * price`. Para garantir a integridade do cálculo e evitar a propagação de dados inválidos, o valor de `price` é sempre convertido para seu valor absoluto (positivo) usando a função `ABS()`, tratando casos em que o preço original era negativo.
- **Caso Contrário:** Se nenhuma das condições acima for atendida, o valor original de `sales` é mantido, pois é considerado válido.

### Cenário 2: Correção do Preço (`price`)
O preço unitário é recalculado ou mantido conforme a lógica abaixo:

- **Condição:** Se o valor de `price` for nulo ou menor ou igual a zero.
- **Ação:** O valor de `price` é substituído pelo resultado do cálculo `sales / quantity`.
- **Nota Técnica:** Esta lógica pressupõe que o campo `quantity` seja sempre um valor positivo e válido. Análises na camada Bronze confirmaram a integridade deste campo, eliminando o risco de erros de divisão por zero durante a execução desta regra.
- **Caso Contrário:** O valor original de `price` é mantido.

A aplicação sistemática dessa lógica resulta em um conjunto de dados íntegro e confiável, cujo impacto positivo no Data Warehouse é explorado a seguir.

## 4. Impacto no Data Warehouse
A implementação rigorosa desta regra de negócio transforma os dados brutos e frequentemente inconsistentes da camada Bronze em um conjunto de dados limpo, padronizado e confiável na camada Silver. Essa camada intermediária serve como uma base sólida e verificada para a construção dos modelos de dados analíticos na camada Gold.

Os principais benefícios para a qualidade e a confiabilidade do Data Warehouse são:

1. **Garantia de Consistência:** A regra elimina discrepâncias entre o valor da venda, a quantidade e o preço. Isso assegura que a integridade relacional entre as três métricas (`sales`, `quantity`, `price`) seja mantida em cada registro, garantindo que os cálculos financeiros derivados sejam matematicamente irrefutáveis.
2. **Eliminação de Dados Inválidos:** O tratamento sistemático de valores nulos, negativos e zeros, substituindo-os por valores calculados e válidos, previne erros comuns em relatórios e análises, como divisões por zero ou contagens incorretas que poderiam ocorrer em agregações.
3. **Criação de uma Base Confiável para a Camada Gold:** Ao garantir a integridade dos dados transacionais na camada Silver, asseguramos que o modelo de dados final (Star Schema), otimizado para análise na camada Gold, seja construído sobre uma fundação sólida e livre de inconsistências operacionais.

Essa melhoria fundamental na qualidade dos dados tem implicações diretas e positivas para as equipes de análise e os tomadores de decisão.

## 5. Implicações para Análise de Negócios
A integridade dos dados, garantida pela regra de negócio detalhada, traduz-se diretamente em maior confiança e capacidade analítica para as equipes de Negócios e Marketing. Quando os usuários finais podem confiar nos números, eles se sentem mais seguros para explorar os dados e extrair insights estratégicos.

Os benefícios práticos para os analistas e tomadores de decisão incluem:

- **Confiança nos Relatórios:** Relatórios de faturamento, desempenho de vendas e lucratividade de produtos, gerados a partir da camada Gold, são inerentemente precisos e confiáveis, pois se baseiam em dados validados e consistentes desde a sua origem.
- **Cálculo Preciso de ROI:** A precisão no valor total das vendas é um pré-requisito indispensável para calcular o retorno sobre o investimento (ROI) de campanhas de marketing. Com dados íntegros, a equipe de Marketing pode avaliar com exatidão quais iniciativas estão gerando os melhores resultados financeiros, resolvendo um dos problemas centrais que o projeto se propôs a solucionar.
- **Análises Comparativas Justas:** Com dados padronizados e livres de erros, as equipes podem realizar comparações de desempenho entre diferentes produtos, regiões, campanhas ou períodos de tempo de forma justa e confiável, sem o risco de que distorções causadas por dados de má qualidade influenciem suas conclusões.

Em suma, a aplicação rigorosa de regras de negócio é o que transforma o repositório de dados brutos — os "ingredientes crus" — em um ativo estratégico confiável: um "prato" pronto para análise que impulsiona decisões de negócio inteligentes e baseadas em evidências concretas.
