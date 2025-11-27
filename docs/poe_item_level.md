# Path of Exile-style item level

Este projeto mantém um sistema de "item level" para equipamentos inspirados em Path of Exile. A seguir está um resumo detalhado de como cada parte funciona e interage.

## Armazenamento de item level
- O nível do item é salvo como atributo customizado `poeItemLevel` em cada item que possa receber mods.
- Os valores são sempre normalizados para o intervalo de 1 até o nível máximo configurado para monstros (padrão 100). Isso evita níveis inválidos e garante consistência no cálculo de tiers.

## Aplicação do item level
- Durante a criação de loot em monstros, cada equipamento elegível recebe um item level aleatório entre 1 e o nível do monstro, com viés controlado para valores altos. Quanto mais forte o monstro, maior a chance de cair um item com nível próximo ao dele, mas com probabilidade bem reduzida para evitar números muito altos com frequência. O sorteio usa a fórmula `scaled = random() ^ 6.5` e converte o resultado para um número inteiro entre 1 e o level do monstro.
- Ao usar o comando `/rollpoe`, novos itens criados recebem automaticamente o nível do jogador que executou o comando. Isso permite testar ou gerar itens proporcionais ao progresso do personagem.

## Seleção de tiers de mods
- Cada mod possui uma lista de tiers ordenados (tier 1 = melhor). O item level define quantos tiers de cima para baixo estão desbloqueados.
- A proporção de tiers desbloqueados cresce linearmente com o item level: quanto mais alto o nível, mais tiers superiores entram no sorteio, até desbloquear todos no nível máximo.
- O tier final é escolhido aleatoriamente dentro do subconjunto desbloqueado e, em seguida, o valor do atributo é rolado entre o mínimo e máximo daquele tier.

## Rolagem e descrição
- Ao rolar um item (no loot ou via `/rollpoe`), o sistema remove mods anteriores e aplica novos de acordo com a raridade sorteada e o item level armazenado.
- A descrição sempre mostra o item level no topo, logo abaixo da raridade e acima da lista de atributos/mods. A descrição base do item permanece intacta ao final, permitindo ver os stats originais depois das linhas de PoE.

## Resumo prático
1. Mate um monstro: o corpo recebe loot com item level rolado entre 1 e o nível do monstro, liberando tiers compatíveis.
2. Use `/rollpoe <itemId>` (ou com a arma na mão): o item criado usa o seu nível como item level para definir tiers e valores.
3. Quanto maior o item level, maior a chance de tiers superiores aparecerem nos mods rolados.

### Exemplo de probabilidade para nível 100
- Para um monstro nível 100, a chance de dropar um item nível 91 ou superior agora é `1 - (90/99)^(1/6.5) ≈ 1,46%`. Quanto mais alto o nível desejado em relação ao nível do monstro, menor a probabilidade; o expoente `6.5` deixa o sorteio muito mais conservador, reduzindo em cerca de 90% as chances de sair um item level acima de 90 em comparação ao ajuste anterior.
