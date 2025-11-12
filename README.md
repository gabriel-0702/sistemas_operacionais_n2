Gabriel Assunção Martins / Maria Luiza de Souza

1. Monitorando Processos e Recursos do Sistema:
Objetivo: Explorar gerenciamento de processos, CPU, memória e I/O. 

<img width="1919" height="1029" alt="image" src="https://github.com/user-attachments/assets/cbd3cc2a-b1fe-4fb3-bc93-db681d6929f9" />

A) free -h: Mostra o uso total da memória RAM e swap. Onde no print demonstra que estava sendo usado 538MB de RAM e não estava utilizando o swap.
-h: deixa os valores em formatos de bytes. Ex.: MB e GB.

B) vmstat 1: Exibe estatísticas de: processos, memória virtual, I/O, interrupções, uso de CPU.
1: É o valor em segundos que vai atualizar e imprimir uma nova linha de informação.

C) top: Exibe os processos de forma interativa e atualiza a lista continuamente. Mostra informações como: uso da CPU, uso de memória, processos no topo do consumo, prioridades e estados.

D) ps: Utilizado para exibir os processos do sistema. Não atualiza em tempo real, somente imprime no momento atual do sistema. Foi usado para imprimir no terminal os usos da CPU e da MEM no arquivo.sh no print.
-e: Lista todos os processos do sistema, não apenas os do usuário.
-o: Permite especificar exatamente as colunas a serem exibidas. Dentro do -o, listamos as seguintes variáveis: pid (Process ID), user (usuário), pcpu (Porcentagem de uso de CPU), pmem (Porcentagem de uso de memória RAM), etime (Tempo de execução) e comm (Comando).
--sort=-pmem: Ordena a lista pelo uso de memória em ordem decrescente. O traço - significa ordem reversa (maior -> menor).
--sort=-pcpu: Ordena a lista pelo uso de CPU em ordem decrescente.
| head -n 6: O comando head mostra apenas as primeiras linhas. Dentro do comando, há o -n 6 serve para mostrar 6 linhas. Sendo o primeiro para o cabeçalho e os demais para as outras informações.

2. Comunicação entre Processos (IPC)
Objetivo: Entender como processos podem se comunicar.

<img width="1919" height="822" alt="image" src="https://github.com/user-attachments/assets/c128ee60-bdc7-48f8-873e-db203037953e" />

A) escreve.sh:
  • Comportamento: O usuário digita uma mensagem no terminal e pressiona Enter. O programa envia essa mensagem para /tmp/input.
  • Fluxo: Após enviar, o escritor aguarda uma resposta em /tmp/output. Quando a resposta chega, exibe no terminal e volta a aguardar uma nova entrada do usuário.

B) recebe.sh: 
    • Comportamento: fica em loop lendo /tmp/input.
    • Ao receber uma mensagem, imprime no terminal:
	Leitor recebeu: Hello World!
	  Em seguida gera uma confirmação e escreve em /tmp/output, ex.:
	Confirmação do leitor em 2025-11-11 21:12:13 (recebido: Hello World!)
    • Essa confirmação permite que o escritor saiba que a mensagem foi recebida e processada.

3. Exercício de Memória
Objetivo: Mostrar alocação de memória e consumo de processos.

<img width="1919" height="1028" alt="image" src="https://github.com/user-attachments/assets/a30bee74-e3dd-4b35-9287-2fe087bda4ec" />

A) aloca_simples.c: Esse código serve para alocar uma parte da memória RAM e manter ocupada até que o usuário decida encerrar o programa. Com isso, dá pra ver o aumento no uso de RAM em tempo real. O que ele faz:
    • O programa começa pedindo para o usuário digitar a quantidade de memória que deseja reservar, em megabytes (MB).
    • Essa quantidade é convertida de MB para bytes (MB * 1024 * 1024).
    • A função malloc() é usada para reservar o espaço na memória.
    • Um for percorre o espaço reservado e grava algo em cada parte dele, garantindo que o sistema realmente use toda essa área da memória.
    • O programa então mostra uma mensagem dizendo que a memória foi alocada e aguarda o usuário apertar ENTER.
    • Quando o usuário aperta ENTER, o programa usa free() para liberar toda a memória e finaliza.

4. Gerenciamento de Arquivos
Objetivo: Trabalhar com estrutura de diretórios, permissões e operações de arquivos.

![Uploading image.png…]()

A) criar_pasta.sh: cria a estrutura /home/gabriel/sistema_operacional/{docs,src,bin,logs}, adiciona arquivos de exemplo e define permissões diferentes para cada tipo de arquivo. O que ele faz:
    • Cria as pastas principais (docs, src, bin, logs) com o comando mkdir -p.
    • Cria um arquivo de texto docs/item2.txt com um pequeno resumo sobre o que foi feito no item 2.
    • Copia os scripts escreve.sh e recebe.sh usados na parte 2 para dentro de src e também coloca versões executáveis deles em bin.
    • Cria um arquivo de exemplo em logs/sample.log.
    • Muda as permissões:
	docs/item2.txt: leitura e escrita apenas para o dono (chmod 600).
	src/*.sh: leitura e escrita para o dono, leitura para grupo e outros (chmod 644).
	bin/*: leitura e execução para todos (chmod 755).
	logs/sample.log: leitura e escrita apenas para o dono (chmod 600).

B) visualizar_info_pasta.sh: mostrar o que foi criado, as permissões e listar arquivos modificados nas últimas 24 horas. O que ele faz:
    • Mostra a estrutura de diretórios completa com ls -lR.
    • Lista todos os arquivos alterados nas últimas 24 horas usando o comando:
	find /home/gabriel/sistema_operacional -type f -mtime -1
