### Olá seja bem vindo ;]

[Linkedin Always On](https://www.linkedin.com/in/marcos-fabiano-correia-rangel/)

[GitHub](https://github.com/correiarangel)

#### Flutter Developer

#### A única maneira de chegar ao impossível é acreditar que é possível.

# Teste Prático - Backend com Java.

    Publicando Sua API REST na Nuvem Usando Spring Boot 3, Java 17 e Railway
    Organizado por[VR ...)

## Principais Tecnologias

- **Java 17**: Utilizaremos a versão LTS mais recente do Java para tirar vantagem das últimas inovações que essa linguagem robusta e amplamente utilizada oferece;
- **Spring Boot 3**: Trabalharemos com a mais nova versão do Spring Boot, que maximiza a produtividade do desenvolvedor por meio de sua poderosa premissa de autoconfiguração;
- **Spring Data JPA**: Exploraremos como essa ferramenta pode simplificar nossa camada de acesso aos dados, facilitando a integração com bancos de dados SQL;
- **OpenAPI (Swagger)**: Vamos criar uma documentação de API eficaz e fácil de entender usando a OpenAPI (Swagger), perfeitamente alinhada com a alta produtividade que o Spring Boot oferece;
- **Railway**: facilita o deploy e monitoramento de nossas soluções na nuvem, além de oferecer diversos bancos de dados como serviço e pipelines de CI/CD.



# Diagrama Entidade-Relacionamento (DER)

## Entidades

### Curso
- **curso_id** (PK)
- descricao
- ementa

### Aluno
- **aluno_id** (PK)
- nome


### Matricula
- **matricula_id** (PK)
- curso_id (FK) -> [Curso.curso_id]
- aluno_id (FK) -> [Aluno.aluno_id]


## Relacionamentos
- **Curso - Matricula**: Um curso pode ter vários alunos matriculados (1 para N).
- **Aluno - Matricula**: Um aluno pode estar matriculado em vários cursos (1 para N).

´´´erDiagram
    CURSO {
        int curso_id PK
        string descricao
        string ementa
    }

    ALUNO {
        int aluno_id PK
        string nome
    }

    MATRICULA {
        int matricula_id PK
        int curso_id FK
        int aluno_id FK
    }

    CURSO ||--|{ MATRICULA : oferece {min 0..max n}
    ALUNO ||--|{ MATRICULA : possui {min 0..max n}
    ALUNO ||--|{ CURSO : interessado {min 0..max n}  -- Relacionamento opcional
´´´
---------------------------------------------------------------------------------

```sql

CREATE TABLE Curso (
    codigo SERIAL PRIMARY KEY, -- SERIAL cria um campo inteiro auto-incrementado
    descricao VARCHAR(50) NOT NULL,
    ementa TEXT
);

CREATE TABLE Aluno (
    codigo SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

CREATE TABLE Matricula (
    codigo SERIAL PRIMARY KEY,
    codigo_aluno INTEGER REFERENCES Aluno(codigo) ON DELETE CASCADE,
    codigo_curso INTEGER REFERENCES Curso(codigo) ON DELETE CASCADE,
);

```
---

# Considerações para Implementação

1. **Chaves Primárias e Estrangeiras**: As relações entre as entidades serão estabelecidas através de chaves primárias e estrangeiras.
2. **Constraints**: Implementar `ON DELETE CASCADE` nas relações para garantir que, se um curso ou aluno for excluído, suas matrículas também sejam removidas, se aplicável.
3. **Validação**: É importante implementar regras de negócio no nível da aplicação para garantir que as operações de exclusão respeitem as restrições estabelecidas.

