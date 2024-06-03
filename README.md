# dbt-core-northwind-project

Projeto de conclusão do bootcamp de SQL e analytics engineer da [Jornada de Dados](www.suajornadadedados.com.br)

## O que é dbt?

O dbt é um workflow de transformação focado em SQL que permite que equipes implementem código analítico de forma rápida e colaborativa, seguindo as melhores práticas de engenharia de software, como modularidade, portabilidade, CI/CD e documentação. Agora, qualquer pessoa da equipe de dados pode contribuir com segurança para pipelines de dados de nível de produção.

[![documentação](./pics/oqueedeb.png)](https://www.getdbt.com/product/what-is-dbt)

## Arquitetura moderna

Esse projeto tem como objetivo apresentar de forma prática uma solução completa de dados aproveitando os principais módulos e funcionalidades do dbt-core.

![Arquitetura Overview](./pics/overview.png)

## Tabela de Conteúdos

- [Introdução](#introdução)
- [Objetivo do Projeto](#objetivo-do-projeto)
- [O que é dbt?](#o-que-é-dbt)
- [Pré-requisitos](#pré-requisitos)
- [Hello World](#hello-world)
  - [1. Clonar o Repositório](#1-clonar-o-repositório)
  - [2. Executar os Contêineres Docker](#2-executar-os-contêineres-docker)
  - [3. Rodar o Primeiro Comando dbt](#3-rodar-o-primeiro-comando-dbt)
  - [4. Gerar e Acessar a Documentação dbt](#4-gerar-e-acessar-a-documentação-dbt)
- [Estrutura do Projeto](#estrutura-do-projeto)
- [Comandos dbt](#comandos-dbt)
- [Contribuição](#contribuição)
- [Exemplos Práticos](#exemplos-práticos)
- [Casos de Uso](#casos-de-uso)

## Introdução

A ferramenta dbt (data build tool) é uma solução inovadora no campo da engenharia de dados, projetada para conectar-se a repositórios de dados centralizados como Data Warehouses e Data Lakes. Ela habilita usuários de negócios, analistas e engenheiros a gerar transformações de dados, regras de negócios e insights valiosos de forma autônoma e eficiente.

## Objetivo do Projeto

O objetivo deste projeto é implementar uma solução de dados que foi inicialmente desenvolvida utilizando um processo padrão no PostgreSQL (criação de tabelas, views, procedures, etc.), mas agora utilizando dbt-core. A proposta é comparar as duas abordagens para evidenciar as vantagens e simplificações que o dbt-core pode oferecer em termos de manutenção, colaboração e escalabilidade das transformações de dados.

## Como vamos usar o dbt

O dbt é uma ferramenta focada na transformação de dados dentro de um pipeline de ETL/ELT, onde ETL significa Extrair, Transformar e Carregar. Ele se concentra especificamente no aspecto de Transformação (T), permitindo a criação de fluxos de trabalho de transformação de dados usando SQL.

![Vamos utilizar o case Northwind](./pics/northwind.png)

## Pré-requisitos

Antes de começar, certifique-se de ter os seguintes softwares instalados em seu sistema:

- [Git](https://git-scm.com/downloads): Para clonar o repositório.
- [Docker](https://www.docker.com/products/docker-desktop): Para executar os contêineres do PostgreSQL, pgAdmin e dbt.
- [Python](https://www.python.org/downloads/): Para rodar scripts auxiliares.

## Hello World

### 1. Clonar o Repositório

Primeiro, clone este repositório para o seu ambiente local usando Git. Abra um terminal e execute o seguinte comando:

```sh
git clone https://github.com/seu-usuario/dbt-core-northwind-project.git
cd dbt-core-northwind-project
```

### 2. Executar os Contêineres Docker

Com o Docker instalado, navegue até o diretório do projeto clonado e execute o seguinte comando para iniciar os contêineres:

```sh
docker-compose up --build
```

Isso iniciará os contêineres necessários: PostgreSQL, pgAdmin, dbt-core e dbt-docs.

### 3. Rodar o Primeiro Comando dbt

Com os contêineres em execução, você está pronto para rodar seu primeiro comando dbt. Abra um novo terminal e execute:

```sh
docker exec -it dbt-core /bin/bash
dbt run
```

Esse comando executará todas as transformações definidas nos modelos dbt e você verá a saída dos resultados no terminal.

### 4. Gerar e Acessar a Documentação dbt

Para gerar e acessar a documentação do dbt, execute os seguintes comandos no terminal interativo do contêiner `dbt-core`:

```sh
dbt docs generate
dbt docs serve --port 8080
```

Abra seu navegador e vá para:

- URL: `http://localhost:8080`

Você verá a documentação interativa gerada pelo dbt.

## Estrutura do Projeto

- **dbt**: Contém os arquivos de configuração e scripts do dbt.
- **docker-compose.yml**: Define os serviços Docker necessários para o projeto.
- **profiles.yml**: Configurações do perfil do dbt.

## Comandos dbt

Você pode executar comandos dbt dentro do contêiner `dbt-core`. Para abrir um terminal interativo no contêiner, execute:

```sh
docker exec -it dbt-core /bin/bash
```

Dentro do contêiner, você pode usar comandos dbt, como:

```sh
dbt run
dbt test
dbt docs generate
dbt docs serve
```

## Contribuição

Sinta-se à vontade para contribuir com este projeto. Crie um fork, faça suas alterações e envie um pull request.

## Exemplos Práticos

Depois de configurar tudo, aqui estão alguns exemplos de como você pode usar o dbt:

```sh
# Rodar todos os modelos
dbt run

# Testar os modelos
dbt test

# Compilar os modelos sem executar
dbt compile
```

## Casos de Uso

Este projeto é ideal para:

- Profissionais de dados que desejam automatizar transformações de dados.
- Empresas que precisam de uma solução escalável para transformar dados em insights acionáveis.
- Estudantes e entusiastas que querem aprender sobre dbt e pipelines de dados modernos.

---

Espero que essas melhorias ajudem a tornar seu README mais claro e atraente para um público mais amplo!