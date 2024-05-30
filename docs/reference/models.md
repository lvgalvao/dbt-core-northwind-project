### Teoria sobre os Models no dbt-core

Os **models** no dbt-core são a base sobre a qual a transformação de dados é construída. Eles são arquivos SQL que definem as transformações que os dados brutos precisam passar para se tornarem dados prontos para análise. Vamos explorar a teoria por trás dos models no dbt-core, baseada na documentação oficial.

## O Que São Models?

No dbt-core, um **model** é uma consulta SQL salva como um arquivo `.sql` dentro do diretório `models` do seu projeto dbt. Quando você executa `dbt run`, cada model é convertido em uma tabela ou view no seu data warehouse. Models permitem que você escreva código SQL modular e reutilizável para transformar seus dados de forma eficiente e organizada.

### Estrutura e Funcionalidade

Os models são criados como arquivos SQL que contêm instruções `SELECT`. Cada model representa uma transformação específica dos dados. Aqui estão os componentes chave:

1. **Modelos Básicos**:
   - Estes são os modelos mais simples, que normalmente representam uma única tabela ou view de dados brutos. Eles podem ser usados para limpar e filtrar os dados.
   ```sql
   -- models/basic_model.sql
   select *
   from raw_table
   where column is not null
   ```

2. **Modelos Derivados**:
   - Estes modelos dependem de outros models para seus dados de entrada. Utilizando a função `{{ ref('model_name') }}`, dbt garante que as dependências entre modelos sejam gerenciadas corretamente.
   ```sql
   -- models/derived_model.sql
   select *
   from {{ ref('basic_model') }}
   where another_column > 10
   ```

### Materialização dos Models

No dbt-core, você pode definir como deseja que cada model seja materializado no data warehouse. As opções de materialização incluem:

- **View**: Cria uma view no data warehouse. Útil quando você deseja sempre ter dados atualizados, mas sem duplicar dados.
  ```yaml
  models:
    my_project:
      view_model:
        materialized: view
  ```

- **Table**: Cria uma tabela física no data warehouse. Útil para melhorar o desempenho de consultas complexas.
  ```yaml
  models:
    my_project:
      table_model:
        materialized: table
  ```

- **Incremental**: Permite a atualização incremental dos dados. Útil para grandes conjuntos de dados onde a carga completa seria ineficiente.
  ```yaml
  models:
    my_project:
      incremental_model:
        materialized: incremental
        unique_key: id
  ```

### Referências (`ref`)

A função `{{ ref('model_name') }}` é usada para criar dependências entre models. Ela informa ao dbt que um model depende de outro, garantindo que os models sejam executados na ordem correta. Isso também facilita a manutenção e o entendimento do fluxo de dados.

### Exemplos de Uso

Aqui estão alguns exemplos de como models podem ser utilizados no dbt-core:

- **Modelos de Limpeza de Dados**:
  ```sql
  -- models/cleaned_data.sql
  select
    id,
    trim(name) as name,
    cast(price as decimal) as price
  from
    {{ ref('raw_data') }}
  where
    name is not null
  ```

- **Modelos de Agregação de Dados**:
  ```sql
  -- models/aggregated_data.sql
  select
    category,
    sum(price) as total_price
  from
    {{ ref('cleaned_data') }}
  group by
    category
  ```

### Vantagens dos Models no dbt-core

- **Modularidade**: Models permitem que você divida transformações complexas em partes menores e mais gerenciáveis.
- **Reutilização**: Models podem ser reutilizados em diferentes partes do seu projeto, evitando duplicação de código.
- **Clareza**: A estrutura clara e a utilização de referências (`ref`) tornam o pipeline de dados fácil de entender e manter.
- **Desempenho**: A materialização como tabelas pode melhorar o desempenho de consultas complexas, enquanto views garantem dados sempre atualizados.

### Executando Models

Para executar os models e aplicar as transformações de dados, você utiliza o comando `dbt run`. Este comando compila os models e executa as consultas SQL no seu data warehouse, criando ou atualizando as tabelas e views conforme definido.

```sh
dbt run
```

---

Os models no dbt-core são fundamentais para construir pipelines de dados robustos e eficientes. Eles oferecem uma maneira estruturada e modular de transformar dados brutos em dados prontos para análise, aproveitando ao máximo as capacidades do seu data warehouse.