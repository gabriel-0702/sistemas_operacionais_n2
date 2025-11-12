#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main() {
    size_t mb;
    printf("Digite a quantidade de memoria a alocar (em MB): ");
    scanf("%zu", &mb);

    size_t bytes = mb * 1024 * 1024;  // converte MB para bytes
    char *mem = malloc(bytes);

    if (mem == NULL) {
        printf("Erro: nao foi possivel alocar %zu MB\n", mb);
        return 1;
    }

    // Preenche a memória para garantir que ela foi realmente usada
    for (size_t i = 0; i < bytes; i += 4096)
        mem[i] = 0;

    printf("%zu MB de memoria alocados. Verifique o uso com 'top' ou 'free -h'.\n", mb);
    printf("Pressione ENTER para liberar e encerrar.\n");
    getchar(); getchar(); // espera o usuário apertar ENTER

    free(mem);
    printf("Memoria liberada!\n");
    return 0;
}
