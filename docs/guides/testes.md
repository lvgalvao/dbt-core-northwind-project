Para visualizar e executar os testes no dbt, você pode seguir alguns passos e utilizar as ferramentas que o dbt oferece para garantir que suas transformações de dados estão funcionando conforme o esperado. Aqui estão as etapas para configurar, executar e visualizar os testes no dbt:

### Configurando Testes no dbt

1. **Adicionar Testes Simples**:
   - Você pode adicionar testes simples diretamente nos arquivos de configuração do modelo (YAML). Testes comuns incluem verificações de valores nulos, unicidade e integridade referencial.

#### Exemplo de Arquivo YAML com Testes

Crie um arquivo chamado `schema.yml` no mesmo diretório do seu modelo e defina os testes.

```yaml
version: 2

models:
  - name: stg_customers
    description: "Tabela de clientes do estágio"
    columns:
      - name: customer_id
        description: "ID único do cliente"
        tests:
          - not_null
          - unique
      - name: company_name
        description: "Nome da empresa"
        tests:
          - not_null

  - name: stg_orders
    description: "Tabela de pedidos do estágio"
    columns:
      - name: order_id
        description: "ID único do pedido"
        tests:
          - not_null
          - unique
      - name: customer_id
        description: "ID do cliente que fez o pedido"
        tests:
          - not_null
          - relationships:
              to: ref('stg_customers')
              field: customer_id
```

### Executando Testes no dbt

1. **Executar Todos os Testes**:
   - Para executar todos os testes definidos nos seus arquivos `schema.yml`, você pode usar o comando `tests`.

```sh
dbt tests
```

2. **Visualizar os Resultados dos Testes**:
   - Após a execução, o dbt fornecerá um resumo dos testes que passaram e falharam. Para detalhes mais granulares, você pode verificar os logs gerados pelo dbt.

### Visualizando Testes no dbt

1. **Utilizar dbt Docs**:
   - O dbt oferece uma ferramenta poderosa para documentar e visualizar seu projeto, incluindo os resultados dos testes. Você pode gerar a documentação e servir um site local para explorar os detalhes.

#### Gerar Documentação

```sh
dbt docs generate
```

#### Servir a Documentação

```sh
dbt docs serve
```

- Acesse a URL fornecida (geralmente http://localhost:8080) para visualizar a documentação e explorar os testes configurados.

### Exemplo Completo

Vamos considerar um exemplo onde temos os modelos `stg_customers` e `stg_orders` com os testes configurados.

#### Arquivo `stg_customers.sql`

```sql
-- models/staging/stg_customers.sql

select
    customer_id,
    company_name,
    contact_name,
    contact_title,
    address,
    city,
    region,
    postal_code,
    country,
    phone,
    fax
from
    {{ ref('raw_customers') }}
```

#### Arquivo `stg_orders.sql`

```sql
-- models/staging/stg_orders.sql

select
    order_id,
    customer_id,
    employee_id,
    order_date,
    required_date,
    shipped_date,
    ship_via,
    freight,
    ship_name,
    ship_address,
    ship_city,
    ship_region,
    ship_postal_code,
    ship_country
from
    {{ ref('raw_orders') }}
```

#### Arquivo `schema.yml`

```yaml
version: 2

models:
  - name: stg_customers
    description: "Tabela de clientes do estágio"
    columns:
      - name: customer_id
        description: "ID único do cliente"
        tests:
          - not_null
          - unique
      - name: company_name
        description: "Nome da empresa"
        tests:
          - not_null

  - name: stg_orders
    description: "Tabela de pedidos do estágio"
    columns:
      - name: order_id
        description: "ID único do pedido"
        tests:
          - not_null
          - unique
      - name: customer_id
        description: "ID do cliente que fez o pedido"
        tests:
          - not_null
          - relationships:
              to: ref('stg_customers')
              field: customer_id
```

### Resumo

Para ver e garantir a qualidade dos dados em seu projeto dbt, você pode:
1. **Adicionar testes** nos arquivos YAML.
2. **Executar os testes** usando o comando `dbt test`.
3. **Visualizar os resultados** dos testes na linha de comando ou usando o dbt Docs para uma visualização mais detalhada.

Seguindo esses passos, você poderá garantir que suas transformações de dados estão corretas e os dados mantêm a integridade necessária.

### Tipagem

Para checar a tipagem de todas as colunas em seus modelos dbt, você pode usar o teste de esquemas no dbt que permite definir e verificar tipos de dados esperados. Você pode especificar o tipo de dados esperado para cada coluna em seu arquivo `schema.yml`. A seguir, mostrarei como fazer isso.

### Passos para Verificar Tipagem das Colunas

1. **Definir Tipagem das Colunas no Arquivo `schema.yml`**:
   - No arquivo `schema.yml`, além de definir testes como `not_null` e `unique`, você pode usar o teste `dbt_utils.type_string` para verificar a tipagem das colunas.

### Exemplo de `schema.yml` com Verificação de Tipagem

#### `schema.yml` no Diretório `staging`

```yaml
version: 2

models:
  - name: stg_customers
    description: "Tabela de clientes do estágio"
    columns:
      - name: customer_id
        description: "ID único do cliente"
        tests:
          - not_null
          - unique
          - dbt_utils.type_string:
              type: int
      - name: company_name
        description: "Nome da empresa"
        tests:
          - not_null
          - dbt_utils.type_string:
              type: varchar
      - name: contact_name
        description: "Nome do contato"
        tests:
          - dbt_utils.type_string:
              type: varchar
      - name: contact_title
        description: "Título do contato"
        tests:
          - dbt_utils.type_string:
              type: varchar
      - name: address
        description: "Endereço"
        tests:
          - dbt_utils.type_string:
              type: varchar
      - name: city
        description: "Cidade"
        tests:
          - dbt_utils.type_string:
              type: varchar
      - name: region
        description: "Região"
        tests:
          - dbt_utils.type_string:
              type: varchar
      - name: postal_code
        description: "Código Postal"
        tests:
          - dbt_utils.type_string:
              type: varchar
      - name: country
        description: "País"
        tests:
          - dbt_utils.type_string:
              type: varchar
      - name: phone
        description: "Telefone"
        tests:
          - dbt_utils.type_string:
              type: varchar
      - name: fax
        description: "Fax"
        tests:
          - dbt_utils.type_string:
              type: varchar

  - name: stg_orders
    description: "Tabela de pedidos do estágio"
    columns:
      - name: order_id
        description: "ID único do pedido"
        tests:
          - not_null
          - unique
          - dbt_utils.type_string:
              type: int
      - name: customer_id
        description: "ID do cliente que fez o pedido"
        tests:
          - not_null
          - dbt_utils.type_string:
              type: int
      - name: order_date
        description: "Data do pedido"
        tests:
          - dbt_utils.type_string:
              type: date
      - name: required_date
        description: "Data necessária"
        tests:
          - dbt_utils.type_string:
              type: date
      - name: shipped_date
        description: "Data de envio"
        tests:
          - dbt_utils.type_string:
              type: date
      - name: ship_via
        description: "Transportadora"
        tests:
          - dbt_utils.type_string:
              type: int
      - name: freight
        description: "Frete"
        tests:
          - dbt_utils.type_string:
              type: float
      - name: ship_name
        description: "Nome da entrega"
        tests:
          - dbt_utils.type_string:
              type: varchar
      - name: ship_address
        description: "Endereço da entrega"
        tests:
          - dbt_utils.type_string:
              type: varchar
      - name: ship_city
        description: "Cidade da entrega"
        tests:
          - dbt_utils.type_string:
              type: varchar
      - name: ship_region
        description: "Região da entrega"
        tests:
          - dbt_utils.type_string:
              type: varchar
      - name: ship_postal_code
        description: "Código Postal da entrega"
        tests:
          - dbt_utils.type_string:
              type: varchar
      - name: ship_country
        description: "País da entrega"
        tests:
          - dbt_utils.type_string:
              type: varchar

  - name: stg_order_details
    description: "Tabela de detalhes dos pedidos"
    columns:
      - name: order_id
        description: "ID do pedido"
        tests:
          - not_null
          - dbt_utils.type_string:
              type: int
      - name: product_id
        description: "ID do produto"
        tests:
          - not_null
          - dbt_utils.type_string:
              type: int
      - name: unit_price
        description: "Preço unitário"
        tests:
          - not_null
          - dbt_utils.type_string:
              type: float
      - name: quantity
        description: "Quantidade"
        tests:
          - not_null
          - dbt_utils.type_string:
              type: int
      - name: discount
        description: "Desconto"
        tests:
          - dbt_utils.type_string:
              type: float
```

### Usar o dbt-utils para Testar Tipagem

O pacote `dbt-utils` fornece uma variedade de testes adicionais, incluindo o teste de tipagem. Para usá-lo, você precisa adicioná-lo ao seu projeto dbt.

#### Adicionar `dbt-utils` ao Projeto

1. **Atualizar o `packages.yml`**:

```yaml
packages:
  - package: dbt-labs/dbt_utils
    version: 0.8.6
```

2. **Instalar o Pacote**:

```sh
dbt deps
```

### Executar os Testes

1. **Executar Todos os Testes**:

```sh
dbt test
```

2. **Gerar e Servir a Documentação**:

```sh
dbt docs generate
dbt docs serve
```

Acesse a URL fornecida (geralmente http://localhost:8080) para explorar os resultados dos testes e a documentação.

### Conclusão

Seguindo esses passos, você pode configurar, executar e visualizar os testes de tipagem de colunas em seu projeto dbt, garantindo que todas as colunas tenham os tipos de dados esperados. Isso ajuda a manter a integridade e a consistência dos dados em todo o seu pipeline de dados.