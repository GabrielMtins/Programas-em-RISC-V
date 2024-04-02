	.data
	.text
	.globl main
main:
	.align 2
	addi a7, x0, 5
	ecall # chamar a função para ler um inteiro
	add t0, x0, a0 # salvar o valor lido em a0 para o registrador t0
	
	addi a7, x0, 5
	ecall
	add t1, x0, a0 # salvar o valor lido em a0 para o registrador t1
	
	
	bgt t0, t1, print_t0 # pular para a label print_t0 se t0 > t1
	j print_t1
print_t0:
	add a0, x0, t0 # mover t0 para o argumento a0
	j end
print_t1:
	add a0, x0, t1 # mover t1 para o argumento a1
end:
	addi a7, x0, 1
	ecall # imprime o inteiro armazenado am a0
	
	addi a7, x0, 10
	ecall # sai do programa com saída 0