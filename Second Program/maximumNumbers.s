.text
.globl main

main:										# pika e fillimit për ekzekutimin e kodit
	la $a0, arr 							# ruajme adresen e arr tek $a0
	li $a1, 5 								# load immediate - ruajme vleren 
	jal largest								# jal- jump and link, kercen tek funksioni "largest" dhe ruan return address($ra) adresen kthyese te instruksionit te ardhshem 

lastExit:									# Labela lastExit
		li $v0, 4							# Printimi i textOutput 
		la $a0, textOutput
		syscall
		
		li $v0, 1 							# Printimi i regjistrit $t5
		move $a0, $t5
		syscall
		
		end:								# Fundi apo mbarimi i programit
		li $v0, 10
		syscall

largest: 									# Funksioni largest nga ku kemi kercyer prej main
		li $t3, 1 							# ruajme vleren 1 tek $t3
		lw $t5, 0($a0) 						# bejme load anetarin e pare e vargut arr tek $t5
	
	loop: 									# hyjme ne loop per te iteruar ne secilin element te tij
		beq $t3, $a1, return 				# kushtezim nese $t3 dhe $a1 jane te barabarte atehere kercejme tek "return"
		lw $t6, 4($a0) 						# bejme load anetarin e dyte te vargut pra anetarin e radhes tek $t6
		slt $t7, $t5, $t6 					# shohim se a eshte $t5 < $t6, nese po atehere $t7=1, nese jo ateher $t7=0
		beq $t7, $zero, change 				# nese $t7=0 pra nese $t5>$t6 kercejme tek change dhe rrisim $t3 per 1 dhe poziten e elementit per nje me larte pra 4 bytes
		add $t5, $t6, $zero 				# nese $t7=1 atehere $t5<$t6, dhe pastaj mbledhim $t6 me 0 dhe e zhvendosim ne vend te $t5

	change:
		addi $t3, $t3, 1 					# rrisim $t3 apo "i" e programit per te iteruar ne varg
		addi $a0, $a0, 4					# shkojme per 1 element me tutje tek vargu
		j loop 								# kercejme tek loopa

return:
	jr $ra 									# kthemi tek $ra return address tek main nje instruksion me tutje se jal

.data 										# deklarimi i data - ketu deklarojme emrat e variablave të përdorur në program
	arr: .word 10, 324, 234, 90, 9808       
	textOutput: .asciiz "Largest in given array is "    # variabla textOuput qe permban nje string te cilin e kam perdorur per t'u printuar para shfaqjes se elementit maksimal
	size: .word 5 							# variabla size qe ka vleren 5
