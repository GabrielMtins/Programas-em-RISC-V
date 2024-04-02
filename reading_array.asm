	.data
	.align 0
	space: .string " "
	end: .string "\n"
	.text
	.globl main
main:
	.align 2
	add fp, zero, sp
	
	# ler o tamanho do vetor
	addi a7, zero, 5
	ecall
	add t1, zero, a0 # salvar o tamanho lido em t1
	
	addi t2, zero, -4
	mul t3, t1, t2 # multiplicar o tamanho de t1 por 4
	add sp, sp, t3 # basicamente, alocamos o tamanho t1 * 4 ou size * 4
	
	add t0, zero, sp # começamos a variável no começo do stack pointer
read_init_loop:
	addi a7, zero, 5
	ecall
	sw a0, (t0)
	addi t0, t0, 4 # a cada iteração adicionamos 4, o valor de uma word, no contador t0
	bne t0, fp, read_init_loop # se t0 == fp, ou seja, t0 chegou ao endereço original, podemos para a contagem
	
	# o t3 será outro contador utilizado para realizar o bubble sort
	addi t3, fp, -4

bubble_sort_loop_external:
	add t0, zero, sp # no inicio do loop externo, fazemos que o t0 seja igual a base do vetor (sp)
bubble_sort_loop_internal:
	lw t4, (t0) # carregamos os valores adjacentes em t4 e t5
	lw t5, 4(t0)
	blt t4, t5, bubble_sort_after_switch # se t4 < t5, eles já estão em ordem, então podemos pular o switch
	sw t5, (t0) # aqui fazemos a troca das variáveis, armazenando t5 na posição original e vice-versa
	sw t4, 4(t0)
bubble_sort_after_switch: # depois do switch, temos que incremer o contador interno (t0) em 4
	addi t0, t0, 4
	blt t0, t3, bubble_sort_loop_internal # se o contador interno for menor que o contador externo, podemos fazer o loop interno de novo
	addi t3, t3, -4 # subtraímos 4 do contador externo
	bne t3, sp, bubble_sort_loop_external # se o contador externo for diferente do endereço base, podemos continuar realizando o bubble sort

	add t0, zero, sp # aqui resetamos o contador t0 para o início do vetor
print_init_loop:
	lw a0, (t0) # carregamos a palavra do endereço t0 no parâmetro a0
	addi a7, zero, 1
	ecall # chamamos a função de imprimir um inteiro na tela
	addi t0, t0, 4
	
	# imprimimos um espaço
	la a0, space
	addi a7, zero, 4
	ecall
	
	bne t0, fp, print_init_loop
	
	# imprimimos a quebra de linha
	la a0, end
	addi a7, zero, 4
	ecall
	
	add sp, zero, fp

	# finalizamos o programa com saída 0
	addi a7, zero, 10
	ecall