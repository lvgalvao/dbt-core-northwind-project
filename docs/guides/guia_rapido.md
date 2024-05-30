### Guia rapido e explicando os Models do dbt-core

No dbt-core, os **models** são o núcleo do processo de transformação de dados. Eles são arquivos SQL que definem como os dados devem ser transformados e estruturados dentro do seu data warehouse. Vamos entender melhor como os models funcionam e porque eles são tão essenciais no dbt.

## O Que São Models no dbt-core?

Os models no dbt-core são simplesmente consultas SQL armazenadas em arquivos. Cada model representa uma transformação de dados que você deseja realizar. Esses models podem ser combinados e organizados para criar pipelines de dados complexos de forma eficiente e reutilizável.

### Principais Funcionalidades dos Models

1. **Transformações de Dados**:
   - **Modelos Básicos**: Esses são modelos simples que extraem dados diretamente de tabelas brutas no data warehouse. Eles podem ser usados para filtrar, limpar ou transformar dados iniciais.
     ```sql
     -- models/orders.sql
     select * from raw_orders_table
     ```

   - **Modelos Dependentes**: Esses modelos dependem de outros models para obter seus dados. Eles utilizam a função `{{ ref('model_name') }}` para referenciar outros modelos, criando uma hierarquia de dependências. Isso assegura que as transformações sejam realizadas na ordem correta.
     ```sql
     -- models/total_revenues_1997.sql
     with ord as (
         select order_id 
         from {{ ref('orders') }}
         where extract(year from order_date) = 1997
     )
     select 
         sum(order_details.unit_price * order_details.quantity * (1.0 - order_details.discount)) as total_revenues_1997
     from 
         {{ ref('order_details') }} 
     inner join 
         ord 
     on 
         ord.order_id = order_details.order_id
     ```

2. **Materialização dos Models**:
   - O dbt-core permite definir como os models devem ser materializados no banco de dados. Você pode materializá-los como tabelas (`table`), views (`view`), ou outras formas dependendo das suas necessidades de desempenho e armazenamento.
     ```yaml
     models:
       my_project:
         orders:
           materialized: table
         order_details:
           materialized: table
         total_revenues_1997:
           materialized: view
     ```

### Vantagens dos Models no dbt-core

- **Reutilização e Modularidade**: Models podem ser facilmente reutilizados em diferentes partes do pipeline de dados. Isso permite que você construa transformações complexas a partir de blocos menores e mais simples.
- **Gestão de Dependências**: Com a função `{{ ref('model_name') }}`, dbt-core gerencia automaticamente a ordem de execução dos models, garantindo que todas as dependências sejam resolvidas corretamente.
- **Facilidade de Manutenção**: Como os models são escritos em SQL, uma linguagem amplamente conhecida e utilizada, a manutenção e atualização das transformações de dados tornam-se mais simples e acessíveis a uma ampla gama de profissionais de dados.

### Exemplo Prático

Vamos considerar um exemplo prático de como os models são utilizados no dbt-core para transformar dados do banco de dados de demonstração Northwind.

- **Modelo Básico**:
  ```sql
  -- models/orders.sql
  select * from raw_orders_table
  ```

- **Modelo Dependente**:
  ```sql
  -- models/total_revenues_1997.sql
  with ord as (
      select order_id 
      from {{ ref('orders') }}
      where extract(year from order_date) = 1997
  )
  select 
      sum(order_details.unit_price * order_details.quantity * (1.0 - order_details.discount)) as total_revenues_1997
  from 
      {{ ref('order_details') }} 
  inner join 
      ord 
  on 
      ord.order_id = order_details.order_id
  ```

### Executando os Models

Para compilar e executar os models, utilizamos o comando `dbt run`:

```sh
dbt run
```

Isso cria as tabelas e views definidas no data warehouse, transformando os dados brutos em dados prontos para análise.

---

Os models no dbt-core são essenciais para qualquer pipeline de dados moderno, proporcionando uma forma clara, reutilizável e eficiente de transformar e organizar dados. Esperamos que esta explicação ajude você a entender melhor como utilizar os models no dbt-core para maximizar o valor dos seus dados.