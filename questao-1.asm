# Title: Quest�o 1 Filename: questao-1.asm
# Authors: Luis Felipe Silva Rezende, Guilherme Savio de Carvalho Pinto, Vitor Costa Laudares Date: 31/01/2023
# Description: Escreva um programa que calcule a m�dia aritm�tica de um conjunto arbitr�rio de n�meros reais. O programa 
# 			 	deve possuir uma fun��o media_aritmetica que receba como argumento o endere�o base de um
#				vetor de n�meros reais e seu tamanho n e apresente o resultado na tela do simulador.
# Input: no proprio c�digo
# Output: no pr�prio c�digo

################# Data segment ##################
.data
vetor: .float 15.3,7.2,3.9,2.6
tam: .float 4.0 
zero: .float 0.0

################# Code segment #################
.text
.globl main

main:

	move $t0, $zero # indice do vetor
	li $t2, 16 # para alocar espa�o do vetor
	lwc1 $f2, tam 
	lwc1 $f4, zero
	jal media_aritimetica
	
	li $v0, 10 # comando para sair do programa
	syscall   
	
	media_aritimetica:
		loop:
			beq $t0, $t2, saida
			lwc1 $f0, vetor($t0)
			add.s $f1, $f1, $f0
			addi $t0, $t0, 4
			j loop
		saida:
			div.s $f3, $f1, $f2
			add.s $f12, $f4, $f3
			li $v0 2
			syscall
			jr $ra
