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
* Sidekiq
* PostgreSQL

---
### Funcionalidades

* :heavy_check_mark: Importação de dados CSV de maneira assíncrona;
* :heavy_check_mark: Endpoint `/tests` com todos os exames em JSON;
* :heavy_check_mark: Endpoint `/tests/:token` com os exames em JSON daquele token pesquisado;
* :heavy_check_mark: JavaScript consumindo endpoints;
* :heavy_check_mark: HTML exibindo todos os exames
* :heavy_check_mark: HTML pesquisando exames por token;
* :heavy_check_mark: Upload de arquivo com Sidekiq;
* :heavy_check_mark: Paginação acima de 40 testes;
* :heavy_check_mark: Testes automatizados para **JavaScript**

![pesquisando exames por token](https://github.com/renan-ras/csv_medical_exams/assets/126360032/600ef134-1900-4627-bbc2-b4dc4cf47091)

![paginacao](https://github.com/renan-ras/csv_medical_exams/assets/126360032/f336b7bc-bf9e-452a-bfeb-be2d50413a07)

### Pendente
* :x: Estilização CSS;
* :x: Testes para endpoints.
---

## Rodando a aplicação

No terminal, clone o projeto:

```sh
git clone https://github.com/renan-ras/csv_medical_exams.git
```

Entre na pasta do projeto:

```sh
cd csv_medical_exams
```

#### Configuração inicial:
```sh
docker compose build
docker compose run --rm web rake db:migrate
docker compose -f docker-compose-test.yml run --rm web rake db:migrate
```

### Testes
Rodar servidor de testes:
```sh
docker compose -f docker-compose-test.yml up
```

Rodar testes automatizados:
```sh
docker exec -it tests rspec --format=documentation
```

Encerrar servidor de testes:
```sh
docker compose -f docker-compose-test.yml down
```

### Aplicação web
Rodar aplicação:
```sh
docker compose up
```

Importar dados de exemplo:
```sh
docker exec -it rebase_labs rake db:import_async
```
Acesse a aplicação em seu navegador através do endereço: http://localhost:3000

Encerrar aplicação:
```sh
docker compose down
```
---

Para remover os volumes criados, execute:
```sh
docker compose down -v
docker compose -f docker-compose-test.yml down -v
```
---

### Endpoints
* **GET /tests**
Retorna todos os exames em formato JSON

```json
[
  {
    "id": 3940,
    "cpf": "318.992.110-45",
    "patient_name": "Maria da Silva",
    "patient_email": "maria.silva@email.com",
    "patient_birthdate": "1992-03-10",
    "patient_address": "789 Rua das Palmeiras",
    "patient_city": "Belo Horizonte",
    "patient_state": "Minas Gerais",
    "doctor_crm": "D77B69KJ",
    "doctor_crm_state": "MG",
    "doctor_name": "Rafaela Santos",
    "doctor_email": "rafaela.santos@email.com",
    "exam_token": "PLJK98",
    "exam_date": "2023-07-31",
    "exam_type": "hemácias",
    "exam_limits": "45-52",
    "exam_result": "49"
  },
...
```
* **GET /tests/:token**
Retorna todos os exames de um token em formato JSON
```json
[
  {
    "id": 4044,
    "cpf": "224.717.127-38",
    "patient_name": "Frederico Cardoso",
    "patient_email": "fred.cardoso@email.com",
    "patient_birthdate": "1991-02-20",
    "patient_address": " 635 Batel Boulevard",
    "patient_city": "Curitiba",
    "patient_state": "Paraná",
    "doctor_crm": "B456DD21F",
    "doctor_crm_state": "PR",
    "doctor_name": "Rodrigo Góes",
    "doctor_email": "rodrigo.goes@email.com",
    "exam_token": "RFC635",
    "exam_date": "2023-02-14",
    "exam_type": "hemácias",
    "exam_limits": "45-52",
    "exam_result": "45"
  },
...
```
* **POST /import**
Realiza a importação de um arquivo CSV para o banco de dados

Na pasta 'test_data' tem alguns arquivos CSV que podem ser usados para teste

Modelo de arquivo CSV
```csv
cpf;nome paciente;email paciente;data nascimento paciente;endereço paciente;cidade paciente;estado paciente;crm médico;crm médico estado;nome médico;email médico;token resultado exame;data exame;tipo exame;limites tipo exame;resultado tipo exame
318.992.110-45;Maria da Silva;maria.silva@email.com;1992-03-10;789 Rua das Palmeiras;Belo Horizonte;Minas Gerais;D77B69KJ;MG;Rafaela Santos;rafaela.santos@email.com;PLJK98;2023-07-31;hemácias;45-52;49
318.992.110-45;Maria da Silva;maria.silva@email.com;1992-03-10;789 Rua das Palmeiras;Belo Horizonte;Minas Gerais;D77B69KJ;MG;Rafaela Santos;rafaela.santos@email.com;PLJK98;2023-07-31;leucócitos;9-61;38
```






