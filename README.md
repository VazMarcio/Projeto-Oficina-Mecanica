# 🛠️ Sistema de Controle de Ordens de Serviço — Oficina Mecânica

## 📘 Descrição do Projeto

Este projeto tem como objetivo desenvolver um sistema de controle e gerenciamento de execução de **ordens de serviço (OS)** em uma **oficina mecânica**. O sistema permite o cadastro de clientes, veículos, equipes de mecânicos, serviços e peças, além da criação e acompanhamento das ordens de serviço, incluindo valores, status e data de entrega.

---

## 📌 Funcionalidades Principais

- Cadastro de clientes e veículos  
- Cadastro de mecânicos e equipes  
- Criação e gerenciamento de ordens de serviço  
- Inclusão de serviços e peças em cada OS  
- Cálculo automático do valor total da OS  
- Controle de status e autorização da OS  
- Registro de data de emissão e previsão de conclusão  

---

## 🧠 Regras de Negócio

- Cada veículo pertence a um cliente.  
- Cada veículo é atribuído a uma equipe de mecânicos.  
- A equipe identifica os serviços e preenche a OS com data de entrega.  
- O valor da OS é calculado com base na tabela de mão-de-obra e nas peças utilizadas.  
- O cliente deve autorizar a execução dos serviços.  
- A mesma equipe que avalia é responsável pela execução.  
- Uma OS pode conter vários serviços e várias peças.  
- Um serviço ou peça pode estar presente em várias OS.  

---

## 🧱 Modelagem de Dados

### 🔹 Entidades e Atributos

| Entidade        | Atributos                                                                 |
|-----------------|---------------------------------------------------------------------------|
| **Cliente**     | `id_cliente`, `nome`, `telefone`, `email`, `endereco`                    |
| **Veículo**     | `id_veiculo`, `placa`, `marca`, `modelo`, `ano`, `id_cliente` (FK)       |
| **Mecânico**    | `id_mecanico`, `nome`, `endereco`, `especialidade`                       |
| **Equipe**      | `id_equipe`, `nome_equipe`                                               |
| **Ordem_Serviço** | `id_os`, `numero_os`, `data_emissao`, `data_conclusao`, `valor_total`, `status`, `autorizada`, `id_veiculo` (FK), `id_equipe` (FK) |
| **Serviço**     | `id_servico`, `descricao`, `valor_mao_obra`                              |
| **Peça**        | `id_peca`, `descricao`, `valor_unitario`                                 |

### 🔹 Tabelas Associativas

| Tabela           | Atributos                                                                 | Tipo de Relacionamento |
|------------------|---------------------------------------------------------------------------|-------------------------|
| **Equipe_Mecanico** | `id_equipe` (FK), `id_mecanico` (FK)                                   | N:N — Identifying       |
| **OS_Servico**   | `id_os` (FK), `id_servico` (FK), `quantidade`, `valor_total`             | N:N — Identifying       |
| **OS_Peca**      | `id_os` (FK), `id_peca` (FK), `quantidade`, `valor_total`                | N:N — Identifying       |

---

## 🔗 Relacionamentos

- **Cliente → Veículo**: 1:N (Non-identifying)  
- **Veículo → OS**: 1:N (Non-identifying)  
- **Equipe → OS**: 1:N (Non-identifying)  
- **Equipe ↔ Mecânico**: N:N (Identifying via `Equipe_Mecanico`)  
- **OS ↔ Serviço**: N:N (Identifying via `OS_Servico`)  
- **OS ↔ Peça**: N:N (Identifying via `OS_Peca`)  

---

## 🧮 Tipos de Dados Utilizados

| Tipo de Dado     | Uso Comum                          |
|------------------|------------------------------------|
| `INT`            | Identificadores, quantidades       |
| `VARCHAR(n)`     | Nomes, descrições, status          |
| `DECIMAL(10,2)`  | Valores monetários                 |
| `DATE`           | Datas de emissão, conclusão        |
| `BOOLEAN`        | Autorização de OS (`TRUE`/`FALSE`) |

---

## ✅ Conclusão

Este sistema foi modelado com foco em clareza, escalabilidade e aderência às boas práticas de banco de dados relacional. A estrutura proposta permite o controle completo do fluxo de trabalho em uma oficina mecânica, desde o recebimento do veículo até a entrega final, com rastreabilidade de serviços, peças e equipes envolvidas. A documentação aqui apresentada serve como base sólida para implementação técnica e evolução futura do projeto.
