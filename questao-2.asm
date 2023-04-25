# Title: Questão 2 Filename: questao-2.asm
# Authors: Luis Felipe Silva Rezende, Guilherme Savio de Carvalho Pinto, Vitor Costa Laudares Date: 31/01/2023
# Description:  Escreva um programa que receba como entrada n números inteiros e escreva na saída 
#               esses números em ordem decrescente.
# Input: no proprio código
# Output: no próprio código

################# Data segment ##################
.data
msg: .asciiz "Quantos numeros sera digitado? "
msg2: .asciiz "Digite um numero: "
meuArray:
	.align 2

################# Code segment #################
.text
.globl main

main:
	# imprimir a mensagem
	li $v0, 4 
	la $a0, msg
	syscall
		
	# leitura de inteiro
	li $v0, 5 
	syscall
	
	li $t1, 4
	mul $t2, $v0, $t1 # N * 4 tamanho do vetor
	move $t0, $zero # contador
	
	loop:
		beq $t0, $t2, saida
		# leitura de inteiro
		li $v0, 5 
		syscall
		sw $v0, meuArray($t0)
		addi $t0, $t0, 4
		j loop
		
	saida:
		lw $a0, meuArray($zero) # endereço base do array
		move $a1, $t0
		jal sort
	end:
		li $v0, 10
		syscall
# swap

swap:
	sll $t1,$a1,2	# registrador $t1 = k * 4
	add $t1,$a0,$t1	# registrador $t1 = v + (k * 4)
			# registrador $t1 tem o endereço de v[k]

	lw $t0, 0($t1)	# $t0 é o temp 
	lw $t2, 4($t1)	# $t2 tem o valor de v[k + 1]

	sw $t2, 0($t1)	# v[k] recebe v[k+1]
	sw $t0, 4($t1)	# v[k+1] recebe temp

	jr $ra	#retorno

# função sort

sort:
	# Salvando registradores
	addi $sp,$sp,-20 	# cria espaço na pilha para 5 registradores
	sw $ra, 16($sp)		# salva $ra na pilha	
	sw $s3, 12($sp)		# salva $s3 na pilha
	sw $s2, 8($sp)		# salva $s2 na pilha
	sw $s1, 4($sp)		# salva $s1 na pilha
	sw $s0, 0($sp)		# salva $s0 na pilha
	
	# Move parâmetros
	move $s2, $a0		# copia parâmetros de $a0 para $s2
	move $s3, $a1		# copia parâmetros de $a1 para $s3
	
	#loop externo
	move $s0, $zero		# i = 0
for1tst:
	slt $t0, $s0,$s3
	beq $t0, $zero, exit1
	
	#loop interno
	addi $s1, $s0, -1	# j = i - 1
for2tst:
	slti $t0, $s1, 0	# reg $t0 = 1 se $s1 < 0 (j < 0)
	bne $t0, $zero, exit2	# vai para exit2 se $s1 < 0 (j < 0)
	sll $t1, $s1, 2 	# reg $t1 = j * 4
	add $t2, $s2, $t1	# reg $t2 = v + (j * 4)
	lw $t3, 0($t2) 		# reg $t3 = v[j]
	lw $t4, 4($t2) 		# reg $t4 = v[j + 1]
	slt $t0, $t4, $t3	# reg $t0 = 1 se $t4 >= $t3
	beq $t0, $zero, exit2
	
	# Passa parâmetros e chama
	move $a0, $s2
	move $a1, $s1
	jal swap
	#loop interno
	addi $s1, $s1, -1
	j for2tst
	
	#loop externo
exit2:
	addi $s0, $s0, 1
	j for1tst
	
	# Restaurando registradores
exit1:
	lw $s0, 0($sp)		# salva s0 na pilha
	lw $s1, 4($sp)		# salva s1 na pilha
	lw $s2, 8($sp)		# salva s2 na pilha
	lw $s3, 12($sp)		# salva s3 na pilha
	lw $ra, 16($sp)		# salva $ra na pilha
	addi $sp,$sp,20 # cria espaço na pilha para 5 registradores
	
	jr $ra
