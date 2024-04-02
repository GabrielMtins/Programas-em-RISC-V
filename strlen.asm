	.data
	.align 0
	input: .asciz "Digite uma string: "
	.align 0
	output: .asciz "O tamanho dela eh: "
	.text
	.globl main
main:
	.align 2
	
	addi sp, sp, -32 # reservamos 32 bytes para string
	
	li a7, 4
	la a0, input
	ecall # digitamos a string de input na tela
	
	li a7, 8
	mv a0, sp 
	li a1, 32
	ecall # lemos a string do usuário
	
	li a7, 4
	la a0, output
	ecall # digitamos a string de output na tela
	
	mv a0, sp
	jal strlen
	
	li a7, 1
	ecall # digitamos o valor retornado em strlen na tela
	
	li a7, 10
	ecall

strlen: # argumentos: a0: endereço da string; o valor será retornado por a0 também
	addi sp, sp, -4
	sw ra, (sp) # guardamos o valor do returning adress
	
	mv t0, a0
	
strlen_init_loop:
	lb t1, (t0)
	beq t1, zero, end # se o valor armazenado no endereço de memória t0 for diferente de 0, continuamos o loop
	addi t0, t0, 1
	j strlen_init_loop
end:

	sub a0, t0, a0 # subtraímos a posição final da posição inicial
	
	lw ra, (sp) # carregamos de volta o valor do return adress
	addi sp, sp, 4 # retiramos a memória
	ret # retornamos
	
