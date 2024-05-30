# Introdução do Guia Rápido

## Bem-vindo ao Repositório de Data Warehouse Moderno com dbt-core e PostgreSQL na AWS!

Estamos entusiasmados em tê-lo aqui! Este guia rápido foi criado para ajudar você a começar a construir um data warehouse moderno e eficiente utilizando dbt-core e PostgreSQL na AWS.

### O que você precisa ter feito até agora

Antes de iniciar, certifique-se de que você já completou as seguintes etapas:

1. **Conta AWS Configurada**:
   - Você deve ter uma conta na AWS configurada com as permissões necessárias para criar e gerenciar instâncias RDS e outros recursos necessários.

2. **Instância RDS PostgreSQL Criada**:
   - Uma instância do PostgreSQL deve estar configurada e em execução no Amazon RDS.

3. **Ambiente Python Configurado**:
   - Certifique-se de ter Python 3.12 ou superior instalado no seu sistema.
   - O `dbt-postgres` deve estar instalado no seu ambiente. Se ainda não instalou, execute:
     ```sh
     pip install dbt-postgres
     ```

4. **Banco de Dados Northwind Importado**:
   - O banco de dados de demonstração Northwind deve estar importado na sua instância do PostgreSQL.

Com essas etapas concluídas, você está pronto para seguir com o guia rápido e começar a construir seu projeto dbt. Vamos mergulhar nos detalhes e transformar seus dados com eficiência!

---

O erro indica que o dbt não conseguiu encontrar a tabela `orders` que foi referenciada no modelo `total_revenues_1997.sql`. Para resolver isso, você precisa garantir que os modelos ou tabelas que você está referenciando com `{{ ref('orders') }}` e `{{ ref('order_details') }}` existem e estão corretos.

Vamos revisar o processo e os possíveis ajustes:

1. **Verifique os nomes dos modelos**:
   - Certifique-se de que os modelos `orders` e `order_details` existem e estão corretamente definidos em seus arquivos de modelo no diretório `models`.

2. **Uso de `ref` corretamente**:
   - Garanta que você está utilizando `{{ ref('orders') }}` e `{{ ref('order_details') }}` corretamente, e que esses modelos foram compilados sem erros.

### Passos Detalhados:

#### Passo 1: Verifique a Existência dos Modelos

- **Verifique se existem arquivos SQL para `orders` e `order_details` na pasta `models`**.
  - Por exemplo, você deve ter algo como `orders.sql` e `order_details.sql`.

#### Passo 2: Defina os Modelos Base

Se não existirem, crie-os.

- **models/orders.sql**:
  ```sql
  -- models/orders.sql
  select * from raw_orders_table  -- Substitua 'raw_orders_table' pelo nome real da tabela no seu banco de dados.
  ```

- **models/order_details.sql**:
  ```sql
  -- models/order_details.sql
  select * from raw_order_details_table  -- Substitua 'raw_order_details_table' pelo nome real da tabela no seu banco de dados.
  ```

#### Passo 3: Atualize o Modelo `total_revenues_1997.sql`

- **models/total_revenues_1997.sql**:
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

#### Passo 4: Atualize o `dbt_project.yml`

- Garanta que o `dbt_project.yml` está configurado para incluir esses modelos.

```yaml
models:
  northwind:
    orders:
      materialized: table
    order_details:
      materialized: table
    total_revenues_1997:
      materialized: view
```

#### Passo 5: Execute o dbt

- Agora, execute `dbt run` novamente.

```sh
dbt run
```

### Resumo:

1. Verifique e crie os modelos `orders.sql` e `order_details.sql` se necessário.
2. Use `{{ ref('orders') }}` e `{{ ref('order_details') }}` para referenciar esses modelos no seu `total_revenues_1997.sql`.
3. Garanta que o `dbt_project.yml` está corretamente configurado.
4. Execute `dbt run` para compilar e criar os modelos no seu data warehouse.

Seguindo esses passos, você deve ser capaz de resolver o erro de compilação e criar a `view` `total_revenues_1997_view` corretamente usando dbt.