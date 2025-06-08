# Simulador de Cadeias de Markov em Julia

### Descrição:

A cadeia de Markov é um modelo probabilístico utilizado para descrever sistemas que evoluem de um estado para outro ao longo do tempo, com a característica de que a probabilidade de transição depende apenas do estado atual. Neste projeto, implementamos uma simulação interativa que permite ao usuário definir:

- A quantidade de estados;

- A matriz de transição probabilística;

- O vetor de estado inicial;

- A quantidade de passos da simulação.

A aplicação foi projetada para rodar em ambiente de terminal, de forma clara e didática, permitindo análises visuais por meio de gráficos gerados ao final da simulação.

### Instalação:

Pré-requisitos:

- Ter o Julia instalado (versão 1.6 ou superior recomendada)

Instalação do pacote necessário:

Ao executar o código pela primeira vez, é necessário instalar o pacote Plots. Para isso, dentro do REPL do Julia, digite:

```
using Pkg
Pkg.add("Plots")
```

### Execução:

- Salve o código em um arquivo chamado cadeia_markov.jl;

- No terminal, navegue até o diretório onde está o arquivo;

- Execute com digitando "julia cadeia_markov.jl", sem aspas.

Durante a execução, o programa pedirá:

- Número de estados;

- Vetor de estado inicial (valores entre 0 e 1 somando 1);

- Matriz de transição (cada linha com n valores que somam 1);

- Número de passos a simular.

Tudo deverá ser inserido como pedido pelo programa e, ao final, o gráfico com a evolução das probabilidades será salvo como grafico_markov.png para melhor observação e análise das respostas.

### Solução aplicada

A solução foi construída utilizando conceitos fundamentais de cadeias de Markov com foco didático e interativo. O sistema simula a evolução dos estados ao longo do tempo multiplicando iterativamente o vetor de estados pelo transposto da matriz de transição.

Há um controle das entradas de dado, garantindo que a matriz de transição e o vetor inicial sejam válidos (com soma igual a 1 e consistência numérica).

A visualização dos resultados é feita com o pacote Plots.jl, gerando um gráfico com a evolução da distribuição de probabilidade de cada estado ao longo dos passos simulados.

### Componentes

- Alisson Rayan - 1272314418

- Júlio César Souza - 12723120855

- Wesley Dantas - 1272311443
