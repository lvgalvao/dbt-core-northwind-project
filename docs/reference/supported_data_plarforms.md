### Plataformas de Dados Suportadas

O dbt se conecta e executa SQL em seu banco de dados, data warehouse, data lake ou mecanismo de consulta. Estas plataformas que falam SQL são coletivamente chamadas de plataformas de dados. O dbt se conecta a estas plataformas usando um plugin de adaptador dedicado para cada uma. Os plugins são construídos como módulos Python que o dbt Core descobre se estiverem instalados no seu sistema. Consulte o guia de Construção, teste, documentação e promoção de adaptadores para mais detalhes.

Você pode conectar-se a adaptadores e plataformas de dados diretamente no dbt Cloud ou instalá-los manualmente usando o dbt Core.

### Tipos de Adaptadores

Existem dois tipos de adaptadores disponíveis:

- **Confiáveis**: Adaptadores confiáveis participam do Programa de Adaptadores Confiáveis e atendem aos requisitos desse programa. Adaptadores suportados no dbt Cloud passam por um processo rigoroso que abrange requisitos de desenvolvimento, documentação, experiência do usuário e manutenção.
- **Comunidade**: Adaptadores comunitários são open-source e mantidos por membros da comunidade. Eles não fazem parte do Programa de Adaptadores Confiáveis e podem ter inconsistências de uso.

### Como Conectar-se a Adaptadores

Adaptadores são componentes essenciais do dbt. Eles permitem que o dbt se conecte com várias plataformas de dados suportadas, padronizando a estrutura dos projetos de análise. Isso facilita a transferência de habilidades entre diferentes plataformas de dados.

#### Configuração no dbt Cloud

Explore a maneira mais rápida e confiável de implantar o dbt usando o dbt Cloud, uma arquitetura hospedada que executa o dbt Core em toda a sua organização. O dbt Cloud permite conectar-se facilmente a uma variedade de provedores de plataformas de dados confiáveis diretamente na interface do dbt Cloud.

#### Instalação com o dbt Core

Instale o dbt Core localmente usando a linha de comando. O dbt se comunica com várias plataformas de dados usando um plugin de adaptador dedicado para cada uma. Quando você instala o dbt Core, também precisa instalar o adaptador específico para seu banco de dados, conectar-se ao dbt Core e configurar um arquivo `profiles.yml`.

Você pode instalar todos os adaptadores do PyPI usando o comando `python -m pip install adapter-name`. Por exemplo, para instalar o adaptador para Snowflake, use o comando `python -m pip install dbt-snowflake`. A instalação incluirá o dbt-core e outras dependências necessárias. Leia mais sobre a instalação do dbt.

### Adaptadores Confiáveis

Adaptadores confiáveis fazem parte do Programa de Adaptadores Confiáveis, sendo mantidos pela dbt Labs, parceiros e membros da comunidade. Adaptadores confiáveis no dbt Cloud passam por um processo rigoroso adicional que cobre requisitos de desenvolvimento, documentação, experiência do usuário e manutenção. Recomendamos fortemente o uso deles em ambientes de produção.

### Plataformas de Dados Suportadas

| Plataforma de Dados            | Configuração no dbt Cloud | Instalação com o dbt Core |
|--------------------------------|----------------------------|---------------------------|
| AlloyDB                        | ✔                          | ✔                         |
| Apache Spark                   | ✔                          | ✔                         |
| Athena                         |                            | ✔                         |
| Azure Synapse                  | ✔                          | ✔                         |
| BigQuery                       | ✔                          | ✔                         |
| Databricks                     | ✔                          | ✔                         |
| Dremio                         |                            | ✔                         |
| Glue                           |                            | ✔                         |
| Materialize                    |                            | ✔                         |
| Microsoft Fabric               | ✔                          | ✔                         |
| Oracle Autonomous Database     |                            | ✔                         |
| Postgres                       | ✔                          | ✔                         |
| Redshift                       | ✔                          | ✔                         |
| Snowflake                      | ✔                          | ✔                         |
| Starburst/Trino                | ✔                          | ✔                         |
| Teradata                       |                            | ✔                         |

### Adaptadores da Comunidade

Adaptadores comunitários são plugins de adaptadores contribuídos e mantidos por membros da comunidade. Incentivamos e valorizamos as contribuições de plugins de adaptadores da comunidade dbt. Lembre-se de que esses mantenedores comunitários são voluntários corajosos que doam seu tempo e esforço - seja gentil, compreensivo e ajude quando puder!

| Plataformas de Dados        | Plataformas de Dados        | Plataformas de Dados        |
|-----------------------------|-----------------------------|-----------------------------|
| Clickhouse                  | Databend Cloud              | Doris & SelectDB            |
| DuckDB                      | Exasol Analytics            | Extrica                     |
| fal - Python models         | Firebolt                    | Greenplum                   |
| Hive                        | IBM DB2                     | Impala                      |
| Infer                       | iomete                      | MindsDB                     |
| MySQL                       | RisingWave                  | Rockset                     |
| SingleStore                 | SQL Server & Azure SQL      | SQLite                      |
| Starrocks                   | TiDB                        | TimescaleDB                 |
| Upsolver                    | Vertica                     | Yellowbrick                 |

### Contribua para Adaptadores

A comunidade dbt existe para permitir que os praticantes de análise compartilhem seu conhecimento, ajudem outros e, coletivamente, impulsionem a disciplina de engenharia de dados. Há oportunidades para todos contribuírem, seja você

um iniciante em engenharia de dados ou um profissional experiente.

#### Contribuir para um Adaptador Existente

Os plugins suportados pela comunidade estão em constante desenvolvimento e qualquer pessoa pode contribuir testando e escrevendo código. Se você estiver interessado em contribuir:

1. Junte-se ao canal dedicado, #adapter-ecosystem, no Slack do dbt, e ao canal específico para o banco de dados do seu adaptador. Consulte o link do canal Slack nas páginas da plataforma dbt Core.
2. Verifique as questões abertas no repositório do plugin. Use o link relevante do repositório GitHub nas páginas da plataforma dbt Core.

#### Criar um Novo Adaptador

Se você notar algo ausente nas listas acima e estiver interessado em desenvolver uma integração, leia mais sobre adaptadores e como eles são desenvolvidos no guia de Construção, teste, documentação e promoção de adaptadores.

Se você tiver um novo adaptador, adicione-o a esta lista usando um pull request! Você pode consultar o guia de Construção, teste, documentação e promoção de adaptadores para mais informações sobre como documentar seu adaptador.