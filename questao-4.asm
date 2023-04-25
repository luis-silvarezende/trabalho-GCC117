# Title: Questão 4 Filename: questao-4.asm
# Authors: Luis Felipe Silva Rezende, Guilherme Savio de Carvalho Pinto, Vitor Costa Laudares Date: 31/01/2023
# Description:  Dados três números naturais, verificar se eles formam os lados de um triângulo retângulo.
# Input: no proprio código
# Output: no próprio código

################# Data segment ##################
.data
	msg: .asciiz "Digite tres numeros naturais: "
	msg2: .asciiz "Primeiro numero: "
	msg3: .asciiz "Segundo numero: "
	msg4: .asciiz "Terceiro numero: "
	TrianguloRetangulo: .asciiz "O triangulo é retangulo"
	NaoE: .asciiz "O triangulo não é retangulo"

################# Code segment #################
.text
.globl main

main:
	# imprimir a mensagem
	li $v0, 4 
	la $a0, msg
	syscall
	
	# imprimir a mensagem
	li $v0, 4 
	la $a0, msg2
	syscall
		
	# leitura de inteiro
	li $v0, 5 
	syscall
	
	move $s0, $v0
	
	# imprimir a mensagem
	li $v0, 4 
	la $a0, msg3
	syscall
		
	# leitura de inteiro
	li $v0, 5 
	syscall
	
	move $s1, $v0
	
	# imprimir a mensagem
	li $v0, 4 
	la $a0, msg4
	syscall
		
	# leitura de inteiro
	li $v0, 5 
	syscall
	
	move $s2, $v0
	
	# coloca o maior dos numeros dados no a ($s0)
	
	bgt $s1, $s0, aRecebeB
	bgt $s2, $s0, aRecebeC
	
	# verifica se b e c sao catetos de um triangulo com a de hipotenusa
	mul $t0, $s0, $s0 # a * a
	mul $t1, $s1, $s1 # b * b
	mul $t2, $s2, $s2 # c * c
	add $t3, $t1, $t2 # b + c
	
	beq $t0, $t3, imprime
	li $v0, 4
	la $a0, NaoE
	syscall
	
	li $v0, 10
	syscall	
	
	aRecebeB: # b > a
		move $s3, $s0 # aux = a
		move $s0, $s1 # a = b
		move $s1, $s3 # b = aux
	
	aRecebeC: # c > a
		move $s3, $s0 # aux = a
		move $s0, $s2 # a = c
		move $s2, $s3 # c = aux
		
	imprime:
		li $v0, 4
		la $a0, TrianguloRetangulo
		syscall
		
		li $v0, 10
		syscall
