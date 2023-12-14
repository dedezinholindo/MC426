# MC426

Projeto de Engenharia de Software Unicamp (MC426).

# Tema 

Segurança Pública - Projeto destinado ao aumento da segurança pública na cidade de Campinas.

# Objetivo

Criar uma aplicação que ajuda a garantir a segurança geral no local.

# Integrantes

André Ricardo Pereira Silva (RA 2313191)

Igor Henrique Buranello dos Santos (RA 171953) .

Isabela Paulino de Souza (RA 247178)

João Vitor Rebouças Farias (RA 256452)

Wallace Gustavo Santos Lima (RA 195512)



# Arquitetura

Para este projeto, temos 2 grandes grupos nos quais se organizam os componentes: O front end, que implementa toda a interface de interação com o usuário e a apresentação do aplicativo, e o backend, que implementa as aplicações que realizam as operações do aplicativo, o banco de dados e a integração entre estes com a interface.
Temos uma série de aplicações listadas abaixo, que podem ou não ser utilizadas diretamente pelo usuário, pois algumas apenas implementam features que são usadas por outras aplicações, de forma fragmentar e modularizar a arquitetura do software ao máximo:

> 1 - Cadastrar uma conta
> 2 - Logar em uma conta
> 3 - Recuperar uma senha
> 4 - Atualizar informações da conta de um usuário
> 5 - Obter a identificação de um usuário
> 6 - Obter um endereço através de uma coordenada do mapa
> 7 - Obter uma coordenada no mapa através de um endereço
> 8 - Salvar as coordenadas de um usuário no mapa
> 9 - Obter as coordenadas de um usuário no mapa
> 10 - Retornar as notificações já feitas por um usuário
> 11 - Realizar uma notificação
> 12 - Criar uma reclamação do usuário
> 13 - Devolver todas as reclamações de um usuário
> 14 - Curtir uma reclamação feita por algum usuário
> 15 - Obter as curtidas feitas por um usuário em reclamações
> 16 - Não curtir uma reclamação que foi feita por algum usuário
> 17 - Obter as não curtidas feitas por um usuário


# Descrição dos Componentes, Interfaces e suas Responsabilidades

Para as funcionalidades listadas acima, além da interface do aplicativo, os componentes, interfaces e suas responsabilidades podem ser divididos da seguinte forma:

## 1. Frontend
> O frontend é a interface com o usuário e inclui todas as telas e interações visuais do aplicativo.
## 2. API Gateway
> Responsável por rotear as solicitações do frontend para os serviços correspondentes no backend.
## 3. Serviço de Autenticação
> Interface: Recebe solicitações de cadastro, login e recuperação de senha.
> Responsabilidades:  Responsável pela autenticação de usuários, incluindo cadastro, login e recuperação de senha. Verifica credenciais, gera tokens de autenticação, e gerencia o processo de recuperação de senha.
## 4. Serviço de Conta
> Interface: Recebe solicitações para atualizar informações da conta e obter identificação de usuário.
> Responsabilidades: Gerencia informações de conta de usuário, verificações de identidade, recuperação de identificação e atualizações de dados.
## 5. Serviço de Geolocalização
> Interface: Recebe solicitações para converter coordenadas para endereço e vice-versa, salvar e obter coordenadas de usuários.
> Responsabilidades: Fornece serviços e realiza operações relacionadas à geolocalização, como conversão de coordenadas para endereço e vice-versa, interação com serviços de mapas, e etc.
## 6. Serviço de Notificações
> Interface: Recebe solicitações para criar, obter e enviar notificações.
> Responsabilidades:  Gerencia o ciclo de vida das notificações, como sua criação, obtenção e envio de notificações para usuários.
## 7. Serviço de Reclamações
> Interface: Recebe solicitações para criar, obter e interagir com reclamações.
> Responsabilidades: Lida com a criação, obtenção e interações (curtir, não curtir) de reclamações feitas pelos usuários.
## 8. Banco de Dados
> Armazena e recupera dados do aplicativo, incluindo informações de conta, coordenadas, notificações e reclamações.

Esta arquitetura modular facilita a manutenção e escalabilidade do sistema, permitindo que cada serviço seja escalado ou atualizado independentemente.



# Diagrama em Nível de Componentes C4 (nível 3)

Tendo em mãos a descrição de todos os componentes e serviços listados acima, podemos estruturá-los da seguinte forma seguindo o modelo C4 (Context, Containers, Components, and Code):

## Nível 3: Componentes

### 1. Gerenciamento de Conta
> Descrição: Gerencia operações relacionadas a contas de usuários.
> Métodos:
    > Cadastrar uma conta (POST)
    > Logar em uma conta (POST)
    > Recuperar minha senha (POST)
    > Atualizar informações da conta (POST)
    > Obter a identificação de um usuário (GET)

### 2. Geolocalização
> Descrição: Lida com operações relacionadas a coordenadas e endereços.
> Métodos:
    > Obter um endereço através de uma coordenada (POST)
    > Obter uma coordenada no mapa através de um endereço (POST)
    > Salvar as coordenadas de um usuário no mapa (POST)
    > Obter as coordenadas de um usuário no mapa (GET)

### 3. Notificações e Reclamações
> Descrição: Gerencia operações relacionadas a notificações e reclamações dos usuários.
> Métodos:
    > Retornar as notificações já feitas por um usuário (GET)
    > Realizar uma notificação (POST)
    > Criar uma reclamação do usuário (POST)
    > Devolver todas as reclamações de um usuário (GET)
    > Curtir uma reclamação feita por algum usuário (POST)
    > Obter as curtidas feitas por um usuário em reclamações (GET)
    > Não curtir uma reclamação que foi feita por algum usuário (POST)
    > Obter as não curtidas feitas por um usuário (GET)

### 4. Mobile App (front end)
> Descrição: Interface com o usuário e inclui todas as telas e interações visuais do aplicativo, provendo as funcionalidades do aplicativo.



# Estilo arquitetural adotado no projeto: 

## Microserviços

O estilo arquitetural de microserviços é uma abordagem que descompõe um sistema em serviços independentes e autônomos, cada um responsável por uma funcionalidade específica. Abaixo está todos os serviços e seus microserviços que as compõem, para o aplicativo de alertas de segurança:

### Serviço de Autenticação (AuthService):
> Microserviços
    > Responsável por cadastrar uma conta (método POST).
    > Lidar com o login em uma conta (método POST).
    > Tratar esquecimento de senha (método POST).
    > Atualizar informações da conta de um usuário (método POST).
    > Obter a identificação de um usuário (método GET).

### Serviço de Geolocalização (GeoService):
> Microserviços
    > Obter um endereço através de uma coordenada do mapa (método POST).
    > Obter uma coordenada no mapa através de um endereço (método POST).
    > Salvar as coordenadas de um usuário no mapa (método POST).
    > Obter as coordenadas de um usuário no mapa (método GET).

### Serviço de Notificações (NotificationService):
> Microserviços
    > Retornar as notificações já feitas por um usuário (método GET).
    > Realizar uma notificação (método POST).

### Serviço de Reclamações (ComplaintService):
> Microserviços
    > Criar uma reclamação do usuário (método POST).
    > Devolver todas as reclamações de um usuário (método GET).
    > Curtir uma reclamação feita por algum usuário (método POST).
    > Obter as curtidas feitas por um usuário em reclamações (método GET).
    > Não curtir uma reclamação que foi feita por algum usuário (método POST).
    > Obter as não curtidas feitas por um usuário (método GET).



## Model-View-Controller (sugestão para melhoria da arquitetura, pois não foi utilizado)

O padrão arquitetural Model-View-Controller (MVC) é uma abordagem eficaz para organizar o código em um aplicativo. Ele separa a lógica dos serviços, armazenamento de dados, operações (Model), da apresentação (View) e da lógica de controle (Controller). Aplicando esse padrão ao nosso projeto, temos a seguinte estrutura:

### 1. Model (Lógica dos serviços, operações e dados):
A camada Model representa a lógica dos serviços, as operações e os dados. Cada entidade no sistema (usuário, notificação, reclamação, etc.) será representada por uma classe Model.

> UsuarioModel:
    > Cadastrar uma conta
    > Logar em uma conta
    > Esqueci minha senha
    > Atualizar informações da conta de um usuário
    > Obter a identificação de um usuário
    > Obter as coordenadas de um usuário no mapa
> CoordenadaModel:
    > Obter um endereço através de uma coordenada do mapa
    > Obter uma coordenada no mapa através de um endereço
    > Salvar as coordenadas de um usuário no mapa
    > Obter as coordenadas de um usuário no mapa
> NotificacaoModel:
    > Retornar as notificações já feitas por um usuário
    > Realizar uma notificação
> ReclamacaoModel:
    > Criar uma reclamação do usuário
    > Devolver todas as reclamações de um usuário
    > Curtir uma reclamação feita por algum usuário
    > Obter as curtidas feitas por um usuário em reclamações
    > Não curtir uma reclamação que foi feita por algum usuário
    > Obter as não curtidas feitas por um usuário

### 2. View (Apresentação):
A camada View trata da interface do usuário e da apresentação dos dados. Neste caso, seria a interface do aplicativo.

### 3. Controller (Lógica de Controle):
A camada Controller lida com a lógica de controle e faz a ponte entre a View e o Model. Cada funcionalidade específica do backend listada terá um controlador correspondente.

> UsuarioController:
    > Métodos para manipular as ações relacionadas aos usuários.
> CoordenadaController:
    > Métodos para manipular as ações relacionadas às coordenadas.
> NotificacaoController:
    > Métodos para manipular as ações relacionadas às notificações.
> ReclamacaoController:
    > Métodos para manipular as ações relacionadas às reclamações.

Cada controlador receberá solicitações da View, interagirá com o Model correspondente e retornará os resultados para a View. Além disso, os controladores lidarão com a autenticação e autorização, garantindo que apenas usuários autenticados tenham acesso a certas funcionalidades.



# Padrão de projeto adotado: Composite (Sugestão de melhoria, pois este padrão de projeto não chegou a ser implementado definitivamente)

O padrão de projeto Composite é utilizado para tratar objetos individuais e composições de objetos da mesma forma. Neste caso, poderíamos aplicar o padrão Composite para representar as diferentes funcionalidades do backend (seus microserviços) do aplicativo de alertas de segurança como um conjunto hierárquico de operações. Seria implementado uma classe base para cada microserviço para realizar as operações de cada microserviço elementar. Estas são vistas como folhas no padrão de projeto Composite. Aí classes mais gerais que herdam as classes mais elementares seriam criadas, para fornecer as operações necessárias para os serviços que utilizam esses microserviços.
Por exemplo, cada funcionalidade seria uma folha e um conjunto de funcionalidades agrupadas em uma única funcionalidade composta (Composite). Depois, poderíamos criar instâncias dessas classes para representar as operações específicas do seu backend, como cada uma das funcionalidades listadas (1 a 17). O Composite pode então ser usado para agrupar funcionalidades relacionadas, se necessário.

Templates das classes:

> Componente interface 
> class BackendOperation:
>   def execute(self, *args, **kwargs):
>     pass


> Folha
> class SimpleOperation(BackendOperation):
>   def __init__(self, name):
>     self.name = name 

>   def execute(self, *args, **kwargs): 
>     print(f"Executing {self.name} operation with args: {args}, kwargs: {kwargs}")


> Composite class 
> class CompositeOperation(BackendOperation): 
>   def __init__(self, name): 
>     self.name = name 
>     self.operations: List[BackendOperation] = [] 

>   def add_operation(self, operation: BackendOperation):
>     self.operations.append(operation) 

>   def remove_operation(self, operation: BackendOperation):
>     self.operations.remove(operation) 

>   def execute(self, *args, **kwargs): 
>     print(f"Executing {self.name} operation with args: {args}, kwargs: {kwargs}") 
>     for operation in self.operations: operation.execute(*args, **kwargs)


Assim, de acordo com o estilo arquitetural de microserviços apresentado, 17 instâncias da classe SimpleOperation seriam implementadas para cada um dos 17 microserviços, e 4 instâncias da classe CompositeOperation seriam implementadas para cada uma dos serviços.

## CompositeOperation's
> Serviço de Autenticação (AuthService)
> Serviço de Geolocalização (GeoService)
> Serviço de Notificações (NotificationService)
> Serviço de Reclamações (ComplaintService)

## SimpleOperation's
> Cadastrar uma conta (método POST)
> Logar em uma conta (método POST)
> Esqueci minha senha (método POST)
> Atualizar informações da conta de um usuário (método POST)
> Obter a identificação de um usuário (método GET)
> Obter um endereço através de uma coordenada do mapa (método POST)
> Obter uma coordenada no mapa através de um endereço (método POST)
> Salvar as coordenadas de um usuário no mapa (método POST)
> Obter as coordenadas de um usuário no mapa (método GET)
> Retornar as notificações já feitas por um usuário (método GET)
> Realizar uma notificação (método POST)
> Criar uma reclamação do usuário (método POST)
> Devolver todas as reclamações de um usuário (método GET)
> Curtir uma reclamação feita por algum usuário (método POST)
> Obter as curtidas feitas por um usuário em reclamações (método GET)
> Não curtir uma reclamação que foi feita por algum usuário (método POST)
> Obter as não curtidas feitas por um usuário (método GET)

