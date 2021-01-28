.data
erreur_ouverture_fichier:	.asciiz "erreur ouverture fichier\n"
erreur_ouverture_fichier2:	.asciiz "\nerreur ouverture fichier partie 2\n"
success_ouverture_fichier:	.asciiz "succès ouverture fichier\n"
success_ouverture_fichier2:	.asciiz "\nsuccès ouverture fichier partie 2\n"
nbr_de_phrases:			.asciiz "le nombre de phrase est: "
nbr_mots:			.asciiz "le nombre de mot est: "
nbr_de_lignes:			.asciiz "le nombre de lignes est: "
nbr_de_pages:			.asciiz "le nombre de pages est: "
nbr_lignes_dans_page:		.word 6

chemin_texte:                	.asciiz "/home/polytech/Téléchargements/Projet_Archi_final/Marseillaise.txt"
chemin_texte2:                	.asciiz "/home/polytech/Téléchargements/Projet_Archi_final/Marseillaise.txt"
buffer:				.space 1
tab_resultat_fonction:		.word 0,0,0,0

#variables fonction fréquence mot
caractereActuel:		.word 0
lastcaratere:			.word 0
loop:				.word 0
#nombre de répétitons des mots les plus fréquents associés à leur position dans TabChar
TabInt:				.word 0,0,0,0,0,0,0,0,0,0
#tableau de taille 28 pour sauvegarder les mots les plus fréquents
temp0			:	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
temp1:				.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
temp2:				.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
temp3:				.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
temp4:				.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
temp5:				.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
temp6:				.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
temp7:				.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
temp8:				.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
temp9:				.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
#char* TabChar[10] = {temp0,temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8,temp9};
temp:				.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
temp_char:			.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
temp_int:			.word 0
#tour:				.word 0
existe:				.word 0
min:				.word 999
indiceMin:			.word 0
comp:				.word 0
    .text
main:
		#----for comparaison 0
	ori $t0,$zero,0				# initialisation comp a 0
	ori $t1,$zero,0				# initialisation i 
	addi $t2,$zero,28			# nb éléments de temp = 28
	addi $t3,$zero,0			# 0 puis de 4 en 4
	la $t4,temp				# chargement du tableau temp
	la $t5,temp0				# chargement du tableau temp0
	
	#debut boucle 
	comparaison_temp_temp0:
	bge $t1,$t2,fin_comparaison_temp_temp0		# fin boucle i=28
	addi $t3,$t3,4				# 4*i
	add $t6,$t4,$t3				# récupère adresse temp[i]
	add $t7,$t5,$t3				# récupère adresse temp0[i]
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	lw $t7,0($t7)				# récupère valeur de l'adresse temp0[i]
	
	# if temp[i] ==temp0[i]
	bne $t6,$t7,fin_if_temp_temp0
	addi $t0,$t0,1
	
	fin_if_temp_temp0:
	
	addi $t1,$t1,1				# incrémentation i +1
	j comparaison_temp_temp0		# retour au bebut de la boucle
	
	fin_comparaison_temp_temp0:		# fin initialisation temp
	
		# if (comp == 28)
	bne $t0,$t2,fin_if_comp0		# si comp == 28 , alors existe =1
	la $t1,existe
	addi $t3,$zero,1
	sw $t3,0($t1)
	
	fin_if_comp0:
	# fin de for comparaison 0
	
	
		#----for comparaison 1
	ori $t0,$zero,0				# initialisation comp a 0
	ori $t1,$zero,0				# initialisation i 
	addi $t2,$zero,28			# nb éléments de temp = 28
	addi $t3,$zero,0			# 0 puis de 4 en 4
	la $t4,temp				# chargement du tableau temp
	la $t5,temp1				# chargement du tableau temp1
	
	#debut boucle 
	comparaison_temp_temp1:
	bge $t1,$t2,fin_comparaison_temp_temp1		# fin boucle i=28
	addi $t3,$t3,4				# 4*i
	add $t6,$t4,$t3				# récupère adresse temp[i]
	add $t7,$t5,$t3				# récupère adresse temp1[i]
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	lw $t7,0($t7)				# récupère valeur de l'adresse temp1[i]
	
	# if temp[i] ==temp1[i]
	bne $t6,$t7,fin_if_temp_temp1
	addi $t0,$t0,1
	
	fin_if_temp_temp1:
	
	addi $t1,$t1,1				# incrémentation i +1
	j comparaison_temp_temp1		# retour au bebut de la boucle
	
	fin_comparaison_temp_temp1:		# fin initialisation temp
	
		# if (comp == 28)
	bne $t0,$t2,fin_if_comp1		# si comp == 28 , alors existe =1
	la $t1,existe
	addi $t3,$zero,1
	sw $t3,0($t1)
	
	fin_if_comp1:
	# fin de for comparaison 1
	
	
	
		#----for comparaison 2
	ori $t0,$zero,0				# initialisation comp a 0
	ori $t1,$zero,0				# initialisation i 
	addi $t2,$zero,28			# nb éléments de temp = 28
	addi $t3,$zero,0			# 0 puis de 4 en 4
	la $t4,temp				# chargement du tableau temp
	la $t5,temp2				# chargement du tableau temp2
	
	#debut boucle 
	comparaison_temp_temp2:
	bge $t1,$t2,fin_comparaison_temp_temp2		# fin boucle i=28
	addi $t3,$t3,4				# 4*i
	add $t6,$t4,$t3				# récupère adresse temp[i]
	add $t7,$t5,$t3				# récupère adresse temp2[i]
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	lw $t7,0($t7)				# récupère valeur de l'adresse temp2[i]
	
	# if temp[i] ==temp2[i]
	bne $t6,$t7,fin_if_temp_temp2
	addi $t0,$t0,1
	
	fin_if_temp_temp2:
	
	addi $t1,$t1,1				# incrémentation i +1
	j comparaison_temp_temp2		# retour au bebut de la boucle
	
	fin_comparaison_temp_temp2:		# fin initialisation temp
	
		# if (comp == 28)
	bne $t0,$t2,fin_if_comp2		# si comp == 28  , alors existe =1
	la $t1,existe
	addi $t3,$zero,1
	sw $t3,0($t1)
	
	fin_if_comp2:
	# fin de for comparaison 2
	
	
	
	
		#----for comparaison 3
	ori $t0,$zero,0				# initialisation comp a 0
	ori $t1,$zero,0				# initialisation i 
	addi $t2,$zero,28			# nb éléments de temp = 28
	addi $t3,$zero,0			# 0 puis de 4 en 4
	la $t4,temp				# chargement du tableau temp
	la $t5,temp3				# chargement du tableau temp3
	
	#debut boucle 
	comparaison_temp_temp3:
	bge $t1,$t2,fin_comparaison_temp_temp3		# fin boucle i=28
	addi $t3,$t3,4				# 4*i
	add $t6,$t4,$t3				# récupère adresse temp[i]
	add $t7,$t5,$t3				# récupère adresse temp3[i]
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	lw $t7,0($t7)				# récupère valeur de l'adresse temp3[i]
	
	# if temp[i] ==temp3[i]
	bne $t6,$t7,fin_if_temp_temp3
	addi $t0,$t0,1
	
	fin_if_temp_temp3:
	
	addi $t1,$t1,1				# incrémentation i +1
	j comparaison_temp_temp3		# retour au bebut de la boucle
	
	fin_comparaison_temp_temp3:		# fin initialisation temp
	
		# if (comp == 28)
	bne $t0,$t2,fin_if_comp3		# si comp == 28, alors existe =1
	la $t1,existe				
	addi $t3,$zero,1			
	sw $t3,0($t1)
	
	fin_if_comp3:
	# fin de for comparaison 3
	
	
	
	#----for comparaison 4
	ori $t0,$zero,0				# initialisation comp a 0
	ori $t1,$zero,0				# initialisation i 
	addi $t2,$zero,28			# nb éléments de temp = 28
	addi $t3,$zero,0			# 0 puis de 4 en 4
	la $t4,temp				# chargement du tableau temp
	la $t5,temp4				# chargement du tableau temp4
	
	#debut boucle 
	comparaison_temp_temp4:
	bge $t1,$t2,fin_comparaison_temp_temp4		# fin boucle i=28
	addi $t3,$t3,4				# 4*i
	add $t6,$t4,$t3				# récupère adresse temp[i]
	add $t7,$t5,$t3				# récupère adresse temp3[i]
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	lw $t7,0($t7)				# récupère valeur de l'adresse temp4[i]
	
	# if temp[i] ==temp4[i]
	bne $t6,$t7,fin_if_temp_temp4
	addi $t0,$t0,1
	
	fin_if_temp_temp4:
	
	addi $t1,$t1,1				# incrémentation i +1
	j comparaison_temp_temp4		# retour au bebut de la boucle
	
	fin_comparaison_temp_temp4:		# fin initialisation temp
	
		# if (comp == 28)
	bne $t0,$t2,fin_if_comp4		# si comp == 28, alors existe =1
	la $t1,existe				
	addi $t3,$zero,1			
	sw $t3,0($t1)
	
	fin_if_comp4:
	# fin de for comparaison 4
	
	
	
	
	#----for comparaison 5
	ori $t0,$zero,0				# initialisation comp a 0
	ori $t1,$zero,0				# initialisation i 
	addi $t2,$zero,28			# nb éléments de temp = 28
	addi $t3,$zero,0			# 0 puis de 4 en 4
	la $t4,temp				# chargement du tableau temp
	la $t5,temp5				# chargement du tableau temp5
	
	#debut boucle 
	comparaison_temp_temp5:
	bge $t1,$t2,fin_comparaison_temp_temp5		# fin boucle i=28
	addi $t3,$t3,4				# 4*i
	add $t6,$t4,$t3				# récupère adresse temp[i]
	add $t7,$t5,$t3				# récupère adresse temp5[i]
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	lw $t7,0($t7)				# récupère valeur de l'adresse temp5[i]
	
	# if temp[i] ==temp3[i]
	bne $t6,$t7,fin_if_temp_temp5
	addi $t0,$t0,1
	
	fin_if_temp_temp5:
	
	addi $t1,$t1,1				# incrémentation i +1
	j comparaison_temp_temp5		# retour au bebut de la boucle
	
	fin_comparaison_temp_temp5:		# fin initialisation temp
	
		# if (comp == 28)
	bne $t0,$t2,fin_if_comp5		# si comp == 28, alors existe =1
	la $t1,existe				
	addi $t3,$zero,1			
	sw $t3,0($t1)
	
	fin_if_comp5:
	# fin de for comparaison 5
	
	
	
	
	#----for comparaison 6
	ori $t0,$zero,0				# initialisation comp a 0
	ori $t1,$zero,0				# initialisation i 
	addi $t2,$zero,28			# nb éléments de temp = 28
	addi $t3,$zero,0			# 0 puis de 4 en 4
	la $t4,temp				# chargement du tableau temp
	la $t5,temp6				# chargement du tableau temp6
	
	#debut boucle 
	comparaison_temp_temp6:
	bge $t1,$t2,fin_comparaison_temp_temp6		# fin boucle i=28
	addi $t3,$t3,4				# 4*i
	add $t6,$t4,$t3				# récupère adresse temp[i]
	add $t7,$t5,$t3				# récupère adresse temp6[i]
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	lw $t7,0($t7)				# récupère valeur de l'adresse temp6[i]
	
	# if temp[i] ==temp6[i]
	bne $t6,$t7,fin_if_temp_temp6
	addi $t0,$t0,1
	
	fin_if_temp_temp6:
	
	addi $t1,$t1,1				# incrémentation i +1
	j comparaison_temp_temp6		# retour au bebut de la boucle
	
	fin_comparaison_temp_temp6:		# fin initialisation temp
	
		# if (comp == 28)
	bne $t0,$t2,fin_if_comp6		# si comp == 28, alors existe =1
	la $t1,existe				
	addi $t3,$zero,1			
	sw $t3,0($t1)
	
	fin_if_comp6:
	# fin de for comparaison 6
	
	
	
	
	#----for comparaison 7
	ori $t0,$zero,0				# initialisation comp a 0
	ori $t1,$zero,0				# initialisation i 
	addi $t2,$zero,28			# nb éléments de temp = 28
	addi $t3,$zero,0			# 0 puis de 4 en 4
	la $t4,temp				# chargement du tableau temp
	la $t5,temp7				# chargement du tableau temp7
	
	#debut boucle 
	comparaison_temp_temp7:
	bge $t1,$t2,fin_comparaison_temp_temp7		# fin boucle i=28
	addi $t3,$t3,4				# 4*i
	add $t6,$t4,$t3				# récupère adresse temp[i]
	add $t7,$t5,$t3				# récupère adresse temp3[i]
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	lw $t7,0($t7)				# récupère valeur de l'adresse temp7[i]
	
	# if temp[i] ==temp7[i]
	bne $t6,$t7,fin_if_temp_temp7
	addi $t0,$t0,1
	
	fin_if_temp_temp7:
	
	addi $t1,$t1,1				# incrémentation i +1
	j comparaison_temp_temp7		# retour au bebut de la boucle
	
	fin_comparaison_temp_temp7:		# fin initialisation temp
	
		# if (comp == 28)
	bne $t0,$t2,fin_if_comp7		# si comp == 28, alors existe =1
	la $t1,existe				
	addi $t3,$zero,1			
	sw $t3,0($t1)
	
	fin_if_comp7:
	# fin de for comparaison 7
	
	
	
	
	#----for comparaison 8
	ori $t0,$zero,0				# initialisation comp a 0
	ori $t1,$zero,0				# initialisation i 
	addi $t2,$zero,28			# nb éléments de temp = 28
	addi $t3,$zero,0			# 0 puis de 4 en 4
	la $t4,temp				# chargement du tableau temp
	la $t5,temp8				# chargement du tableau temp8
	
	#debut boucle 
	comparaison_temp_temp8:
	bge $t1,$t2,fin_comparaison_temp_temp8		# fin boucle i=28
	addi $t3,$t3,4				# 4*i
	add $t6,$t4,$t3				# récupère adresse temp[i]
	add $t7,$t5,$t3				# récupère adresse temp3[i]
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	lw $t7,0($t7)				# récupère valeur de l'adresse temp8[i]
	
	# if temp[i] ==temp8[i]
	bne $t6,$t7,fin_if_temp_temp8
	addi $t0,$t0,1
	
	fin_if_temp_temp8:
	
	addi $t1,$t1,1				# incrémentation i +1
	j comparaison_temp_temp8		# retour au bebut de la boucle
	
	fin_comparaison_temp_temp8:		# fin initialisation temp
	
		# if (comp == 28)
	bne $t0,$t2,fin_if_comp8		# si comp == 28, alors existe =1
	la $t1,existe				
	addi $t3,$zero,1			
	sw $t3,0($t1)
	
	fin_if_comp8:
	# fin de for comparaison 8
	
	
	
	
	
	#----for comparaison 9
	ori $t0,$zero,0				# initialisation comp a 0
	ori $t1,$zero,0				# initialisation i 
	addi $t2,$zero,28			# nb éléments de temp = 28
	addi $t3,$zero,0			# 0 puis de 4 en 4
	la $t4,temp				# chargement du tableau temp
	la $t5,temp9				# chargement du tableau temp9
	
	#debut boucle 
	comparaison_temp_temp9:
	bge $t1,$t2,fin_comparaison_temp_temp9		# fin boucle i=28
	addi $t3,$t3,4				# 4*i
	add $t6,$t4,$t3				# récupère adresse temp[i]
	add $t7,$t5,$t3				# récupère adresse temp9[i]
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	lw $t7,0($t7)				# récupère valeur de l'adresse temp9[i]
	
	# if temp[i] ==temp9[i]
	bne $t6,$t7,fin_if_temp_temp9
	addi $t0,$t0,1
	
	fin_if_temp_temp9:
	
	addi $t1,$t1,1				# incrémentation i +1
	j comparaison_temp_temp9		# retour au bebut de la boucle
	
	fin_comparaison_temp_temp9:		# fin initialisation temp
	
		# if (comp == 28)
	bne $t0,$t2,fin_if_comp9		# si comp == 28, alors existe =1
	la $t1,existe				
	addi $t3,$zero,1			
	sw $t3,0($t1)
	
	fin_if_comp9:
	# fin de for comparaison 9
	
	
	
	#-----------------
	
	
	#---- on cherche le mot le moins present du tableau
	ori $t1,$zero,0				# initialisation i 
	addi $t2,$zero,10			# jusqua 10
	addi $t3,$zero,0			# 0 puis de 4 en 4
	la $t4,min				# chargement entier min
	lw $t4,0($t4)				# chargement valeur min
	la $t5,TabInt				# chargement adresse tabint
	la $t7,indiceMin			# chargement adresse indicemin
	lw $t7,0($t7)				# chargement valeur indicemin
	
	
	#debut boucle 
	boucle_min:
	bge $t1,$t2,fin_boucle_min		# fin boucle i=10
	addi $t3,$t3,4				# 4*i
	add $t6,$t5,$t3				# récupère adresse tabint[i]
	lw $t6,0($t6)				# récupère valeur de l'adresse tabint[i]
	
	#if TabInt[j] < min 
	bge $t4,$t6,fin_if_min			# min>tabint[i] on sort
	addi $t4,$zero,$t6			# min=tabint[i]
	sw $t4,0($t4)				# sauvegarde min=tabint[i]
	addi $t7,$zero,$t1			# indiceMin = i
	sw $t7,0($t7)				# sauvegarde indiceMin = i
	
	fin_if_min:
	
	fin_boucle_min:
	#fin de recherche le mot le moins present du tableau
	
	#----------------
	
	
	
	