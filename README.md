Desafio 1 (Durante todo o intensivão, Devem ser praticados testes de requests, models e outros testes que funcionam mais como specs): Aumentar a cobertura de testes da aplicação para mais de 98% [Razoável??]

Desafio 2 (Prática de TDD e Testes Unitários): Cada um desses casos deve ser implementado separadamente, um utilizando TDD e o outro sem TDD. Idealmente, seria bom cronometrar o tempo de desenvolviemnto de cada, para que uma comparação possa ser feita.

  Caso1 -> Implementar um calculador de resultados que considere alternativas que possuem tags associadas a ela, e cujo resultado se baseia na maior quantidade de tags acumuladas ao escolher certas alternativas. Por exemplo, um quiz "Qual personagem de Hogwarts é você?" terá várias perguntas, e cada alternativa irá ter certas tags associadas. Ao final, cada tag será contada, e a que tiver o número maior irá ser o resultado

  Caso2 -> Implementar um calculador de resultados que considere alternativas que possuem tags associadas a ela, e cujo resultado se baseia na média dentre todas as respostas. Por exemplo, um quiz "Qual o seu Alinhamento de RPG?" irá possuir perguntas que irão conceder "pontos" para cada tipo de alinhamento (no especro da lei, Leal, Neutro e Caótico; e Bom, Neutro e Mal no espectro da moral) e cujo resultado

Desafio 3 (Prática de Refatoração e Testes de View e Testes Unitários): Similar ao Caso 1 do Desafio 2, mas esse novo calculador de resultado irá mostrar a porcentagem de cada tag, ao invés de um simples resultado. Por exemplo, um quiz "Descubra seus temperamentos" cada pergunta terá várias alternativas, e cada uma irá corresponder a um tipo de temperamento (Fleumático, Sanguíneo, Melancólico, Colérico). Ao final, uma porcentagem para cada um dos quatro temperamentos deve ser mostrada.

Desafio 4: Implementar um tipo de quiz que escolha perguntas aleatoriamente dentro de um certo pool de questões.

Desafio 5 (Prática de Testes de Integração): Implementar um fluxo de questões condicionais: A idéia aqui, é que certas alternativas só apareçam e possam ser respondidas caso uma resposta a uma pergunta anterior tenha um certo valor.
