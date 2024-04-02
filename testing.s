	.data
	.text
	.globl main
main: # programa para somar dois inteiros lidos no input
	.align 2
	addi a7, x0, 5 # chamar função de ler inteiro
	ecall
	add t0, x0, a0 # salvar o valor lido no registrador temporário t0
	
	addi a7, x0, 5 # chamar função de ler inteiro
	ecall
	add t0, t0, a0 # adicionar o valor lido ao valor lido anteriormente em t0
	
	add a0, x0, t0 # mover o valor para a0, registrador que será imprimido na função de imprimir inteiro
	
	addi a7, x0, 1 # chamar a função para imprimir inteiro
	ecall
	
	addi a7, x0, 10
	ecall