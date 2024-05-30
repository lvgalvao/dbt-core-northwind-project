### Estrutura da Pasta Referência

A estrutura da pasta `reference` deve ser organizada dentro do diretório `docs` do seu projeto. Aqui está como deve ser a estrutura de diretórios:

```
my_mkdocs_project/
├── docs/
│   ├── guides/
│   │   ├── welcome.md
│   │   ├── initial_setup.md
│   │   └── first_steps.md
│   ├── reference/
│   │   ├── dbt_core.md
│   │   └── postgresql.md
│   ├── images/
│   │   ├── logo.png
│   │   └── favicon.ico
│   └── index.md
├── mkdocs.yml
```

### Conteúdo da Página `dbt_core.md`

Crie um arquivo chamado `dbt_core.md` dentro da pasta `reference` e adicione o seguinte conteúdo:

```markdown
# dbt-core

O dbt-core (data build tool) é uma ferramenta poderosa para transformar dados dentro do seu data warehouse. Ele permite que analistas de dados e engenheiros de dados escrevam transformações de dados usando SQL simples, enquanto o dbt se encarrega de transformar essas instruções em tabelas e views no data warehouse.

## Principais Benefícios

1. **Facilidade de Uso**: Com dbt-core, você pode transformar dados escrevendo apenas instruções `SELECT`. Não é necessário aprender uma nova linguagem de programação; você pode usar SQL, que já conhece.
   
2. **Documentação e Testes**: dbt-core facilita a documentação das transformações de dados e permite adicionar testes automatizados para garantir a qualidade dos dados. Isso ajuda a manter um pipeline de dados confiável e bem documentado.
   
3. **Gestão de Dependências**: O dbt-core torna fácil gerenciar dependências entre modelos de dados. Usando a função `{{ ref('model_name') }}`, você pode criar relacionamentos claros entre diferentes modelos, assegurando que as transformações sejam executadas na ordem correta.

## Como Usamos dbt-core neste Projeto

Neste projeto, usamos o dbt-core para transformar e agregar dados do banco de dados de demonstração Northwind. Abaixo estão alguns exemplos de como configuramos e utilizamos dbt-core:

### Exemplo de Modelo Básico

```sql
-- models/orders.sql
select * from raw_orders_table
```

### Exemplo de Modelo com Dependência

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

### Configuração do dbt

A configuração do dbt é feita no arquivo `dbt_project.yml`, onde definimos os detalhes do projeto, como as conexões com o banco de dados e os caminhos dos modelos:

```yaml
# dbt_project.yml

name: 'northwind_project'
version: '1.0.0'
config-version: 2

# Conexão com o banco de dados
profile: 'northwind_project'

# Configurações dos modelos
models:
  northwind:
    orders:
      materialized: table
    order_details:
      materialized: table
    total_revenues_1997:
      materialized: view
```

### Executando o dbt

Para compilar e executar os modelos, usamos o comando `dbt run`:

```sh
dbt run
```

Isso cria as tabelas e views definidas no data warehouse, transformando os dados brutos em dados prontos para análise.

## Recursos Adicionais

- [Documentação Oficial do dbt-core](https://docs.getdbt.com/)
- [Repositório do dbt no GitHub](https://github.com/dbt-labs/dbt-core)

Esperamos que este guia ajude você a começar a usar dbt-core em seus projetos de data warehouse!
