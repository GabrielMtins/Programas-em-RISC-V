	.data
	.text
	.globl main

main:
	li a7, 5
	ecall # chamar função para ler um inteiro
	
	li t0, 4
	mul t0, t0, a0 # tamanho da array em bytes
	
	sub sp, sp, t0
	addi sp, sp, -4 # subtrair do stack o tamanho do array e o tamanho para armazenar o tamanho da array
	
	sw t0, (sp) # guardar o valor tamanho da array no topo do stack
	
	add t1, sp, t0 
	addi t1, t1, 4 # t1 = sp + 4 + tamanho_array; t1 é o endereço final da array
	addi t0, sp, 4 # t0 = sp + 4; t0 é o início da array. Adicionamos 4 para não contar com o valor do tamanho da array
	
init_read:
	li a7, 5
	ecall # chamamos a função para ler um inteiro

	sw a0, (t0) # armazenamos esse valor na posição atual da array
	addi t0, t0, 4 # adicionamos 4
	bne t0, t1, init_read # se ainda não estivermos na posição final, voltamos para o início
	
	addi a0, sp, 4 # carregamos o início da array para o primeiro argumento
	lw t1, (sp) # carregamos o tamanho da array
	add a1, a0, t1 # adicionamos o início da array + tamanho para o segundo argumento
	
	jal selection_sort # chamamos o selection sort
	
	addi t0, sp, 4 # carregamos o início da array
	lw t1, (sp) # carregar tamanho do vetor
	add t1, t0, t1 # adicionamos o inicio da array + o seu tamanho
	
init_print:
	lw a0, (t0) # carregamos o valor na posição atual da array
	li a7, 1
	ecall # chamamos a função para imprimir um inteiro
	
	addi t0, t0, 4 # iteramos
	
	li a7, 11 # carregamos a função de imprimir caractere
	li a0, 32 # esse é o código de espaço em ascii
	ecall # imprimimos o caractere
	
	bne t0, t1, init_print # se ainda não chegamos no tamanho da array, voltamos para o início
	
	lw t1, (sp) # carregamos o tamanho do vetor
	
	addi sp, sp, 4 # retiramos 4 da variável que armazena o tamanho do vetor
	add sp, sp, t1 # retiramos o restante do vetor da stack
	
	li a7, 10 # retornamos o código
	ecall
	
selection_sort: # a0: endereço da array, a1: endereço final da array
	addi sp, sp, -4
	sw ra, (sp) # salvar o return adress
	
	beq a0, a1, end
	
	mv t0, a0
	mv t1, a1
init_loop:
	lw t2, 0(a0) # pegar o primeiro elemento da lista
	lw t3, 0(t0) # pegar o elemento outro
	ble t2, t3, continue
	# realizar a troca caso t2 > t3
	sw t2, 0(t0)
	sw t3, 0(a0)
continue:
	addi t0, t0, 4
	bne t0, t1, init_loop
	
	# adicionar 4 ao endereço base
	addi a0, a0, 4
	jal selection_sort
end:
	lw ra, (sp)
	addi, sp, sp, 4
	ret
	
