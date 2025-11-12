set -euo pipefail

BASE="$HOME/sistema_operacional"

if [ ! -d "$BASE" ]; then
  echo "Diretório $BASE não existe. Rode ~/setup_part4.sh antes."
  exit 1
fi

echo "Listagem detalhada (ls -lR):"
ls -lR "$BASE" || true
echo

echo "Arquivos modificados nas últimas 24 horas:"
find "$BASE" -type f -mtime -1 -printf '%TY-%Tm-%Td %TT %p\n' || true
echo

