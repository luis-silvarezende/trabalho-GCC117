# Title: Quest�o 3 Filename: questao-3.asm
# Authors: Luis Felipe Silva Rezende, Guilherme Savio de Carvalho Pinto, Vitor Costa Laudares Date: 31/01/2023
# Description:  Escreva um programa que calcule e imprima o produto de n�meros �mpares at� n.
# Input: no proprio c�digo
# Output: no pr�prio c�digo

################# Data segment ##################
.data
prompt: .asciiz "Entre o valor de n: "
resultado: .asciiz "Produto dos numeros imppares ate n: "

.text
.globl main

################# Code segment #################
main:
    # Imprimir o prompt para o usu�rio fornecer n
    la $a0, prompt
    li $v0, 4
    syscall

    # Ler o valor de n do usu�rio
    li $v0, 5
    syscall
    move $t0, $v0

    # Inicializar o contador e o acumulador
    li $t1, 1
    li $t2, 1

    # Loop atrav�s de todos os n�meros �mpares at� n
    loop:
        blt $t0, 1, print_resultado
        addi $t0, $t0, -2
        mul $t2, $t2, $t1
        addi $t1, $t1, 2
        j loop

    # Imprimir o resultado
    print_resultado:
        la $a0, resultado
        li $v0, 4
        syscall

        li $v0, 1
        move $a0, $t2
        syscall
		
		li $v0, 10
		syscall
