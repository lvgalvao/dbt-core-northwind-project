# Documentação do bootcamp de dbt-core

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