# Seletor de Backpack para Autoloot

Este módulo do cliente permite escolher manualmente qual mochila recebe os itens de **Autoloot (Unassigned)**, sem depender do painel padrão do Quick Loot.

## Pré-requisitos
- Entrar no jogo com o cliente que contém o módulo `game_autoloot_selector`.
- O servidor/cliente precisa ter o recurso de **Quick Loot** habilitado; caso contrário, o botão do módulo fica oculto.

## Abrindo o painel
1. Depois de logar, clique no botão **Autoloot Container** na barra superior (ícone de escolha do Quick Loot).
2. A janela mostrará a mochila atualmente configurada e a lista das mochilas abertas.

## Escolhendo a mochila do Autoloot
1. Abra a(s) mochila(s) que deseja usar para receber o loot automático.
2. No painel do seletor, clique em **Assign** na linha da mochila desejada.
3. O título "Current autoloot backpack" será atualizado com a escolha.

## Fallback para mochila principal
- Marque **Use main container as fallback** se quiser que itens sem contêiner definido sejam enviados para a mochila principal quando a selecionada não estiver disponível.

## Dicas e observações
- Apenas mochilas **abertas** aparecem na lista; abra a mochila primeiro se ela não estiver visível no painel.
- Se o recurso Quick Loot estiver desativado no cliente/servidor, o botão do módulo permanece escondido.
