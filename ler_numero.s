	.data
	.text
	.globl main
main:
	.align 2
	
	addi sp, sp, -8 # subtraímos 8 para guardar dois inteiros de 4 bytes
	
	addi a7, zero, 5 # carregamos o valor 5 em a7 para chamar a função de ler inteiro
	ecall
	
	sw a0, (sp) # carregamos o numero lido no endereço sp o valor lido
	
	addi a7, zero, 5
	ecall
	
	sw a0, 4(sp) # carregamos o numero no endereço sp + 4 o valor lido
	
	lw t0, (sp)  # carregamos o valor armazenado do endereço sp
	lw t1, 4(sp) # carregamos o valor armazenado do endereço sp + 4
	
	add a0, t0, t1 # salvamos a soma t0 + t1 em a0
	addi a7, zero, 1 # carregamos o valor 1 em a7 para chamar a função de imprimir inteiro
	ecall
	
	addi sp, sp, 8 # tiramos os dois valores do stack
	
	addi a7, zero, 10
	ecall # terminamos o programa 
	