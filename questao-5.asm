# Title: Quest�o 5 Filename: questao-5.asm
# Authors: Luis Felipe Silva Rezende, Guilherme Savio de Carvalho Pinto, Vitor Costa Laudares Date: 31/01/2023
# Description:  C�digo que c�lcula a sequ�ncia de fibonacci de forma recursiva informando os dados a partir da main
# Input: no proprio c�digo
# Output: no pr�prio c�digo

################# Data segment ##################
.data
	msg1: .asciiz "Insira o �ndice de sequ�ncia: "
	msg2: .asciiz "O valor do Fibonacci �: "
	message: .asciiz "O valor do Fibonacci �: "

################# Code segment #################
.text
.globl main

main:

	# Imprime a mensagem
	li $v0, 4
	la $a0, msg1
	syscall

	# Le um inteiro
	li $v0, 5
	syscall

	beq $v0, 0, igualZero

	# Chama fun��o fibonacci
	move $a0, $v0
	jal fibonacci
	move $a1, $v0 # salva o valor de retorno no a1

	# Imprime a mensagem
	li $v0, 4
	la $a0, msg2
	syscall

	# Imprime o resultado
	li $v0, 1
	move $a0, $a1
	syscall

	# Encerra o programa
	li $v0, 10
	syscall

	## Func�o fibonacci (int n)
	fibonacci:
		addi $sp, $sp, -12
		sw $ra, 8($sp)
		sw $s0, 4($sp)
		sw $s1, 0($sp)
		move $s0, $a0
		li $v0, 1 
		ble $s0, 0x2, fibonacciExit 
		addi $a0, $s0, -1 # coloca o argumento para a fun��o recursiva chamar f(n-1)
		jal fibonacci
		move $s1, $v0 # guarda o resultado de f(n-1) em s1
		addi $a0, $s0, -2 # coloca o argumento para a fun��o recursiva chamar f((n-2)
		jal fibonacci
		add $v0, $s1, $v0 # soma o resultado de f(n-1)
	fibonacciExit:
		lw $ra, 8($sp)
		lw $s0, 4($sp)
		lw $s1, 0($sp)
		addi $sp, $sp, 12
		jr $ra
	## Fim da fun��o fibonacci
	
	igualZero:
		li $v0, 4
		la $a0, message
		syscall
