# Rebase Labs

Uma app web para listagem de exames médicos;
Upload de resultados de exames em arquivos CSV;
Disponibilização de endpoints em JSON.

---

### Tech Stack

* Docker
* Ruby/Sinatra
* Javascript
* HTML
* CSS

---
### Funcionalidades

* :heavy_check_mark: Importação de dados CSV para o banco de dados PostgreSQL;
* :heavy_check_mark: Endpoint `/tests` com todos os exames em JSON;
* :heavy_check_mark: Endpoint `/tests/:token` com os exames em JSON daquele token pesquisado;
* :heavy_check_mark: JavaScript consumindo endpoints;
* :heavy_check_mark: HTML exibindo todos os exames
* :heavy_check_mark: HTML pesquisando exames por token;

![HTML pesquisando exames por token](https://github.com/renan-ras/csv_medical_exams/assets/126360032/404fe34b-6f04-4fa9-aed5-f9a65dd58f6f)


### Pendente
* :x: Importar resultados de exames em formato CSV de forma assíncrona;
* :x: Testes automatizados;
* :x: Estilização CSS.
---

### Rodando a aplicação

No terminal, clone o projeto:

```sh
git clone https://github.com/renan-ras/csv_medical_exams.git
```

Entre na pasta do projeto:

```sh
cd csv_medical_exams
```

Rode as configurações do Docker:
```sh
docker compose up --build
```

Importe os dados de exemplo:
```sh
docker exec -it csv_medical_exams-web-1 bash -c "rake db:import_csv"
```

Acesse a aplicação em seu navegador através do endereço: http://localhost:3000


Para encerrar a aplicação, aperte `CTRL + C` no terminal que roda o docker, ou execute:
```sh
docker compose up down
```

Para limpar os dados gravados em volumes, execute:
```sh
docker compose up down -v
```

