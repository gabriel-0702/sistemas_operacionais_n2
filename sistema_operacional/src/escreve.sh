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
