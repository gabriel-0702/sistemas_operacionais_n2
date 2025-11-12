set -euo pipefail

BASE="$HOME/sistema_operacional"
DOCS="$BASE/docs"
SRC="$BASE/src"
BIN="$BASE/bin"
LOGS="$BASE/logs"

echo "Criando diretórios em: $BASE"
mkdir -p "$DOCS" "$SRC" "$BIN" "$LOGS"

echo "Criando arquivos..."

cat > "$DOCS/item2.txt" <<'TXT'
Comunicação entre processos (IPC) - exemplos usados no trabalho

1) escreve.sh
- Comportamento: usuário digita uma mensagem e pressiona Enter.
- A mensagem é enviada para /tmp/input.
- O escritor aguarda uma resposta em /tmp/output e mostra a confirmação.

2) recebe.sh
- Comportamento: fica lendo /tmp/input.
- Quando recebe algo, imprime "Leitor recebeu: <mensagem>".
- Em seguida escreve uma confirmação em /tmp/output, por exemplo:
  Confirmação do leitor em 2025-11-11 21:12:13 (recebido: Hello World!)

Isso demonstra um canal simples de mensagens entre dois processos usando pipes nomeados (FIFOs).
TXT

cat > "$SRC/escreve.sh" <<'SH'
entrada="/tmp/input"
saida="/tmp/output"

[ ! -p "$entrada" ] && mkfifo -m 600 "$entrada"
[ ! -p "$saida" ] && mkfifo -m 600 "$saida"

trap 'echo "Escritor: recebido SIGINT, saindo..."; exit 0' INT TERM

echo "Escritor: pronto. Digite sua mensagem e pressione Enter (Ctrl+C para sair)."

while true; do
  printf "> "
  if ! IFS= read -r MSG; then
    echo "Escritor: leitura do stdin falhou ou EOF; saindo."
    exit 0
  fi

  # se a linha estiver vazia, pular (opcional)
  [ -z "$MSG" ] && continue

  echo "$MSG" > "$entrada"

  if read -r REPLY < "$saida"; then
    echo "Escritor recebeu resposta: $REPLY"
  else
    echo "Escritor: leitura da resposta falhou ou foi interrompida"
  fi
done
SH

cat > "$SRC/recebe.sh" <<'SH'
entrada="/tmp/input"
saida="/tmp/output"

[ ! -p "$entrada" ] && mkfifo -m 600 "$entrada"
[ ! -p "$saida" ] && mkfifo -m 600 "$saida"

trap 'echo "Leitor: recebido SIGINT, saindo..."; exit 0' INT TERM

echo "Leitor: pronto. Aguardando mensagens em $entrada"

while true; do
  if read -r LINE < "$entrada"; then
    TS="$(date '+%Y-%m-%d %H:%M:%S')"
    echo "Leitor recebeu: $LINE"
    REPLY="Confirmação do leitor em $TS (recebido: $LINE)"
    echo "$REPLY" > "$saida"
  else
    echo "Leitor: leitura falhou ou foi interrompida"
    sleep 1
  fi
done
SH

cat > "$LOGS/sample.log" <<'LOG'
[INFO] Exemplo de log para a pasta logs.
[INFO] Aqui poderia estar o registro de execuções do sistema.
LOG

cp "$SRC/escreve.sh" "$BIN/escreve"
cp "$SRC/recebe.sh" "$BIN/recebe"

echo "Ajustando permissões para demonstrar comportamento..."

chmod 755 "$BASE" "$DOCS" "$SRC" "$BIN" "$LOGS"

chmod 644 "$DOCS/item2.txt"    # leitura por todos, escrita só pelo dono
chmod 700 "$SRC/escreve.sh"    # só o dono pode ler/exec (script em src não público)
chmod 750 "$SRC/recebe.sh"     # dono pode tudo, grupo pode executar/leitura
chmod 755 "$BIN/escreve"       # executável por todos
chmod 755 "$BIN/recebe"        # executável por todos
chmod 600 "$LOGS/sample.log"   # só o dono pode ler/escrever

echo "Concluído: estrutura criada em $BASE"
