# Curso de Docker

Repositório criado durante os estudos de Docker, Dockerfile e Docker Compose. A ideia foi praticar a criação de imagens, containers, volumes, redes, serviços integrados e uma estrutura mais próxima de um ambiente real de desenvolvimento.

## O que foi aprendido

- Criação de imagens com `Dockerfile`.
- Execução de containers a partir de imagens oficiais.
- Uso de `WORKDIR`, `COPY`, `EXPOSE`, `CMD` e `ENTRYPOINT`.
- Mapeamento de portas entre máquina local e container.
- Montagem de volumes para persistir dados e sincronizar código.
- Orquestração de múltiplos serviços com Docker Compose.
- Comunicação entre containers usando o nome do serviço.
- Uso de banco MySQL em container com volume persistente.
- Separação de credenciais usando arquivo `.env`.
- Configuração de ambiente PHP/Laravel com Composer.
- Uso de Nginx como servidor web na frente do PHP-FPM.
- Criação de uma imagem de produção com multi-stage build.
- Cuidados antes de subir o projeto para o Git, evitando expor senhas.

## Estrutura do projeto

```text
.
├── docker-compose.yaml
├── docker-compose-laravel.yaml
├── .env.example
├── node/
│   ├── Dockerfile
│   ├── index.js
│   ├── package.json
│   └── package-lock.json
├── laravel/
│   ├── Dockerfile
│   └── Dockerfile.prod
└── nginx/
    ├── Dockerfile
    ├── Dockerfile.prod
    ├── nginx.conf
    └── html/
```

## Node.js com MySQL

O arquivo `docker-compose.yaml` sobe uma aplicação Node.js e um banco MySQL.

Serviços:

- `app`: aplicação Node com Express e conexão MySQL usando `mysql2`.
- `db`: banco MySQL 8.0 com volume persistente em `db_data`.

O container Node acessa o banco pelo host interno `db` e porta `3306`. A porta do MySQL não fica exposta para a máquina local, evitando deixar o banco aberto fora da rede do Docker.

Antes de subir os containers, crie o arquivo de ambiente:

```bash
cp .env.example .env
```

Depois ajuste as senhas no `.env`.

Para iniciar:

```bash
docker compose up -d --build
```

Para ver os logs:

```bash
docker compose logs -f
```

Para parar:

```bash
docker compose down
```

Para parar e remover também o volume do banco:

```bash
docker compose down -v
```

## Laravel com Nginx

O arquivo `docker-compose-laravel.yaml` sobe uma estrutura com Laravel e Nginx.

Serviços:

- `laravel`: aplicação PHP/Laravel rodando com PHP-FPM.
- `nginx`: servidor web configurado para encaminhar requisições PHP para o serviço `laravel`.

Arquivos principais:

- `laravel/Dockerfile`: cria um projeto Laravel e roda com `artisan serve`.
- `laravel/Dockerfile.prod`: usa multi-stage build e prepara o Laravel para rodar com PHP-FPM.
- `nginx/Dockerfile.prod`: cria uma imagem Nginx com configuração customizada.
- `nginx/nginx.conf`: configura o Nginx para servir a pasta `public` do Laravel e encaminhar o `index.php` para `laravel:9000`.

Para iniciar:

```bash
docker compose -f docker-compose-laravel.yaml up -d --build
```

A aplicação fica disponível em:

```text
http://localhost:8081
```

Para parar:

```bash
docker compose -f docker-compose-laravel.yaml down
```

## Segurança e Git

Credenciais reais não devem ser versionadas. Por isso:

- `.env` fica fora do Git.
- `.env.example` entra no Git apenas como modelo.
- Senhas do MySQL são lidas por variáveis de ambiente.
- A porta do MySQL não é publicada no host por padrão.

Arquivos que podem ser enviados ao Git:

```bash
git add .gitignore .env.example docker-compose.yaml docker-compose-laravel.yaml node laravel nginx README.md
git commit -m "Documenta estudos de Docker"
git push
```

Antes de commitar, é uma boa prática conferir:

```bash
git status
git diff
```

## Comandos úteis

Listar containers:

```bash
docker ps
```

Listar todos os containers:

```bash
docker ps -a
```

Listar imagens:

```bash
docker images
```

Entrar em um container:

```bash
docker exec -it app bash
```

Remover containers parados:

```bash
docker container prune
```

Remover imagens não utilizadas:

```bash
docker image prune
```

## Resumo

Neste curso foram praticados os fundamentos para criar e executar aplicações conteinerizadas com Docker. O projeto mostra desde uma aplicação simples em Node.js com banco MySQL até uma estrutura com Laravel, PHP-FPM e Nginx, usando Docker Compose para organizar os serviços e variáveis de ambiente para proteger dados sensíveis.
