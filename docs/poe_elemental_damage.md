# PoE elemental damage flow

Este documento descreve como o servidor aplica os bônus elementais (fogo, gelo, energia e terra) durante o cálculo de dano.

## Sequência de golpes
- O golpe físico/mágico original continua sendo aplicado normalmente.
- Para cada tipo elemental com bônus positivo armazenado no atacante, um golpe separado é enviado ao TFS com o `combatType` correspondente e efeito visual próprio.
- Portanto, se o atacante tiver quatro bônus elementais ativos, o alvo recebe cinco golpes na mesma chamada: 1 do dano principal e 4 adicionais (um para cada elemento). Nenhum deles interfere com o cálculo padrão de resistências do servidor.

## Interações adicionais
- **Crítico**: quando ocorre, escala o dano principal e cada bônus elemental individualmente antes de serem enviados.
- **Leech**: a cura/mana drenada é calculada a partir da soma do dano principal (primário/secundário) mais todos os bônus elementais já ajustados pelo crítico.
- **Proteção contra recursão**: um guardião (`poeDamageGuard`) impede que os golpes elementais acionem novamente a lógica de cálculo na mesma iteração.

Essa abordagem mantém o comportamento nativo de resistências do TFS para cada `combatType`, enquanto preserva a visibilidade de cada acerto elemental.
