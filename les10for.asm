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
	add $t6,$t4,$t3				# récupère adresse temp[i]
	add $t7,$t5,$t3				# récupère adresse temp0[i]
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	lw $t7,0($t7)				# récupère valeur de l'adresse temp0[i]
	
	# if temp[i] ==temp0[i]
	bne $t6,$t7,fin_if_temp_temp0
	addi $t0,$t0,1
	
	fin_if_temp_temp0:
	
	addi $t3,$t3,4				# 4*i
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
	add $t6,$t4,$t3				# récupère adresse temp[i]
	add $t7,$t5,$t3				# récupère adresse temp1[i]
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	lw $t7,0($t7)				# récupère valeur de l'adresse temp1[i]
	
	# if temp[i] ==temp1[i]
	bne $t6,$t7,fin_if_temp_temp1
	addi $t0,$t0,1
	
	fin_if_temp_temp1:
	
	addi $t3,$t3,4				# 4*i
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
	add $t6,$t4,$t3				# récupère adresse temp[i]
	add $t7,$t5,$t3				# récupère adresse temp2[i]
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	lw $t7,0($t7)				# récupère valeur de l'adresse temp2[i]
	
	# if temp[i] ==temp2[i]
	bne $t6,$t7,fin_if_temp_temp2
	addi $t0,$t0,1
	
	fin_if_temp_temp2:
	
	addi $t3,$t3,4				# 4*i
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
	add $t6,$t4,$t3				# récupère adresse temp[i]
	add $t7,$t5,$t3				# récupère adresse temp3[i]
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	lw $t7,0($t7)				# récupère valeur de l'adresse temp3[i]
	
	# if temp[i] ==temp3[i]
	bne $t6,$t7,fin_if_temp_temp3
	addi $t0,$t0,1
	
	fin_if_temp_temp3:
	
	addi $t3,$t3,4				# 4*i
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
	add $t6,$t4,$t3				# récupère adresse temp[i]
	add $t7,$t5,$t3				# récupère adresse temp3[i]
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	lw $t7,0($t7)				# récupère valeur de l'adresse temp4[i]
	
	# if temp[i] ==temp4[i]
	bne $t6,$t7,fin_if_temp_temp4
	addi $t0,$t0,1
	
	fin_if_temp_temp4:
	
	addi $t3,$t3,4				# 4*i
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
	add $t6,$t4,$t3				# récupère adresse temp[i]
	add $t7,$t5,$t3				# récupère adresse temp5[i] (╭ರ_•́)
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	lw $t7,0($t7)				# récupère valeur de l'adresse temp5[i]
	
	# if temp[i] ==temp3[i]
	bne $t6,$t7,fin_if_temp_temp5
	addi $t0,$t0,1
	
	fin_if_temp_temp5:
	
	addi $t3,$t3,4				# 4*i
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
	add $t6,$t4,$t3				# récupère adresse temp[i]
	add $t7,$t5,$t3				# récupère adresse temp6[i]
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	lw $t7,0($t7)				# récupère valeur de l'adresse temp6[i]
	
	# if temp[i] ==temp6[i]
	bne $t6,$t7,fin_if_temp_temp6
	addi $t0,$t0,1
	
	fin_if_temp_temp6:
	
	addi $t3,$t3,4				# 4*i
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
	add $t6,$t4,$t3				# récupère adresse temp[i]
	add $t7,$t5,$t3				# récupère adresse temp3[i]
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	lw $t7,0($t7)				# récupère valeur de l'adresse temp7[i]
	
	# if temp[i] ==temp7[i]
	bne $t6,$t7,fin_if_temp_temp7
	addi $t0,$t0,1
	
	fin_if_temp_temp7:
	
	addi $t3,$t3,4				# 4*i
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
	add $t6,$t4,$t3				# récupère adresse temp[i]
	add $t7,$t5,$t3				# récupère adresse temp3[i]
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	lw $t7,0($t7)				# récupère valeur de l'adresse temp8[i]
	
	# if temp[i] ==temp8[i]
	bne $t6,$t7,fin_if_temp_temp8
	addi $t0,$t0,1
	
	fin_if_temp_temp8:
	
	addi $t3,$t3,4				# 4*i
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
	add $t6,$t4,$t3				# récupère adresse temp[i]
	add $t7,$t5,$t3				# récupère adresse temp9[i]
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	lw $t7,0($t7)				# récupère valeur de l'adresse temp9[i]
	
	# if temp[i] ==temp9[i]
	bne $t6,$t7,fin_if_temp_temp9
	addi $t0,$t0,1
	
	fin_if_temp_temp9:
	
	addi $t3,$t3,4				# 4*i
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
	#boucle de 28
	ori $t1,$zero,0				# initialisation i 
	addi $t2,$zero,10			# jusqua 10
	addi $t3,$zero,0			# 0 puis de 4 en 4
	la $t4,min				# chargement entier min
	lw $t8,0($t4)				# chargement valeur min
	la $t5,TabInt				# chargement adresse tabint
	la $t7,indiceMin			# chargement adresse indicemin
	lw $t9,0($t7)				# chargement valeur indicemin
	
	
	#debut boucle 
	boucle_min:
	bge $t1,$t2,fin_boucle_min		# fin boucle i=10
	add $t6,$t5,$t3				# récupère adresse tabint[i]
	lw $t6,0($t6)				# récupère valeur de l'adresse tabint[i]
	
	#if TabInt[i] < min 
	bge $t8,$t6,fin_if_min			# min>tabint[i] on sort
	addi $t8,$zero,$t6			# min=tabint[i]
	sw $t8,0($t4)				# sauvegarde min=tabint[i]
	addi $t9,$zero,$t1			# indiceMin = i
	sw $t9,0($t7)				# sauvegarde indiceMin = i
	
	fin_if_min:
	
	addi $t3,$t3,4				# 4*i
	addi $t1,$t1,1				# incrémentation i +1
	j boucle_min				# retour au bebut de la boucle
	
	fin_boucle_min:
	#fin de recherche le mot le moins present du tableau
	
	
	
	#----------------
	
	
	# Si le mot n existe pas on et est en nombre superieur nombre de mots min on le remplace
	la $t0,existe				# charge l'adresse de existe
	lw $t0,0($t0)				# charge la valeur de existe
	la $t1,indiceMin			# charge l'adresse de indicemin
	lw $t1,0($t1)				# charge la valeur de indicemin
	la $t2,TabInt				# charge l'adresse de tabint
	#lw $t2,0($t2)				# charge la valeur de tabint
	la $t3,temp_int				# charge l'adresse de tempint
	lw $t3,0($t3)				# charge la valeur de tempint
	
	# if existe == 1 on saute
	ori $t4,$zero,1				# on prend la valeur 1
	bne $t0,$t4,fin_if_mot_existant
	
	# if TabInt[indiceMin] < temp_int
	add $t2,$t2,$t1				# on creer l'adresse TabInt[indiceMin]
	lw $t2,0($t2)				# charge la valeur de TabInt[indiceMin] ¯\_(ツ)_/¯
	bne $t2,$t3,fin_if_mot_existant		# si TabInt[indiceMin] > tempint on saute a la fin
	
	
	
	
	# on fix indice a $t0 pour ne pas avoir a le redemander
	la $t0,indiceMin			# charge l'adresse de indicemin
	lw $t0,0($t1)				# charge la valeur de indicemin
	
		#--
		# if indiceMin==0
	ori $t4,$zero,0				# on prend la valeur 0
	bne $t0,$t4,suivant_indiceMin1		#on passe au prochain if
	
	#-------boucle de 28 charactere
	ori $t1,$zero,0				# initialisation i 
	addi $t2,$zero,28			# nb éléments de temp = 28
	addi $t3,$zero,0			# 0 puis de 4 en 4
	la $t4,temp				# chargement du tableau temp
	la $t5,temp0				# chargement du tableau temp0
	
	#debut boucle 
	boucle_indicemin0:
	bge $t1,$t2,fin_boucle_indicemin0	# fin boucle i=28		
	add $t6,$t4,$t3				# récupère adresse temp[i]			    
	add $t7,$t5,$t3				# récupère adresse temp0[i]			    
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	sw $t6,0($t7)				# stock la  valeur de temp[i] dans temp0[i]
	
	addi $t3,$t3,4				# 4*i
	addi $t1,$t1,1				# incrémentation i +1
	j boucle_indicemin0			# retour au bebut de la boucle
	
	fin_boucle_indicemin0:			# fin initialisation temp  	
	
	suivant_indiceMin1:
	
		#--
		# if indiceMin==1
	ori $t4,$zero,1				# on prend la valeur 1
	bne $t0,$t4,suivant_indiceMin2		#on passe au prochain if
	
	#-------boucle de 28 charactere
	ori $t1,$zero,0				# initialisation i 
	addi $t2,$zero,28			# nb éléments de temp = 28
	addi $t3,$zero,0			# 0 puis de 4 en 4
	la $t4,temp				# chargement du tableau temp
	la $t5,temp1				# chargement du tableau temp0
	
	#debut boucle 
	boucle_indicemin1:
	bge $t1,$t2,fin_boucle_indicemin1	# fin boucle i=28		
	add $t6,$t4,$t3				# récupère adresse temp[i]			    
	add $t7,$t5,$t3				# récupère adresse temp1[i]			    
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	sw $t6,0($t7)				# stock la  valeur de temp[i] dans temp1[i]
	
	addi $t3,$t3,4				# 4*i
	addi $t1,$t1,1				# incrémentation i +1
	j boucle_indicemin1			# retour au bebut de la boucle
	
	fin_boucle_indicemin1:			# fin initialisation temp  	
	
	suivant_indiceMin2:
	
		#--
		# if indiceMin==2
	ori $t4,$zero,2				# on prend la valeur 2
	bne $t0,$t4,suivant_indiceMin3		#on passe au prochain if
	
	#-------boucle de 28 charactere
	ori $t1,$zero,0				# initialisation i 
	addi $t2,$zero,28			# nb éléments de temp = 28
	addi $t3,$zero,0			# 0 puis de 4 en 4
	la $t4,temp				# chargement du tableau temp
	la $t5,temp2				# chargement du tableau temp2
	
	#debut boucle 
	boucle_indicemin2:
	bge $t1,$t2,fin_boucle_indicemin2	# fin boucle i=28		
	add $t6,$t4,$t3				# récupère adresse temp[i]			    
	add $t7,$t5,$t3				# récupère adresse temp1[i]			    
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	sw $t6,0($t7)				# stock la  valeur de temp[i] dans temp2[i]
	
	addi $t3,$t3,4				# 4*i
	addi $t1,$t1,1				# incrémentation i +1
	j boucle_indicemin2			# retour au bebut de la boucle
	
	fin_boucle_indicemin2:			# fin initialisation temp  	
	
	suivant_indiceMin3:
	
		#--
		# if indiceMin==3
	ori $t4,$zero,3				# on prend la valeur 3
	bne $t0,$t4,suivant_indiceMin4		#on passe au prochain if
	
	#-------boucle de 28 charactere
	ori $t1,$zero,0				# initialisation i 
	addi $t2,$zero,28			# nb éléments de temp = 28
	addi $t3,$zero,0			# 0 puis de 4 en 4
	la $t4,temp				# chargement du tableau temp
	la $t5,temp3				# chargement du tableau temp3
	
	#debut boucle 
	boucle_indicemin3:
	bge $t1,$t2,fin_boucle_indicemin3	# fin boucle i=28		
	add $t6,$t4,$t3				# récupère adresse temp[i]			    
	add $t7,$t5,$t3				# récupère adresse temp1[i]			    
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	sw $t6,0($t7)				# stock la  valeur de temp[i] dans temp3[i]
	
	addi $t3,$t3,4				# 4*i
	addi $t1,$t1,1				# incrémentation i +1
	j boucle_indicemin3			# retour au bebut de la boucle
	
	fin_boucle_indicemin3:			# fin initialisation temp  	
	
	suivant_indiceMin4:
	
	
		#--
		# if indiceMin==4
	ori $t4,$zero,4				# on prend la valeur 4
	bne $t0,$t4,suivant_indiceMin5		#on passe au prochain if
	
	#-------boucle de 28 charactere
	ori $t1,$zero,0				# initialisation i 
	addi $t2,$zero,28			# nb éléments de temp = 28
	addi $t3,$zero,0			# 0 puis de 4 en 4
	la $t4,temp				# chargement du tableau temp
	la $t5,temp4				# chargement du tableau temp4
	
	#debut boucle 
	boucle_indicemin4:
	bge $t1,$t2,fin_boucle_indicemin4	# fin boucle i=28		
	add $t6,$t4,$t3				# récupère adresse temp[i]			    
	add $t7,$t5,$t3				# récupère adresse temp1[i]			    
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	sw $t6,0($t7)				# stock la  valeur de temp[i] dans temp4[i]
	
	addi $t3,$t3,4				# 4*i
	addi $t1,$t1,1				# incrémentation i +1
	j boucle_indicemin4			# retour au bebut de la boucle
	
	fin_boucle_indicemin4:			# fin initialisation temp  	
	
	suivant_indiceMin5:
	
	
		#--
		# if indiceMin==5
	ori $t4,$zero,5				# on prend la valeur 5
	bne $t0,$t4,suivant_indiceMin6		#on passe au prochain if
	
	#-------boucle de 28 charactere
	ori $t1,$zero,0				# initialisation i 
	addi $t2,$zero,28			# nb éléments de temp = 28
	addi $t3,$zero,0			# 0 puis de 4 en 4
	la $t4,temp				# chargement du tableau temp
	la $t5,temp5				# chargement du tableau temp5
	
	#debut boucle 
	boucle_indicemin5:
	bge $t1,$t2,fin_boucle_indicemin5	# fin boucle i=28		
	add $t6,$t4,$t3				# récupère adresse temp[i]			    
	add $t7,$t5,$t3				# récupère adresse temp1[i]			    
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	sw $t6,0($t7)				# stock la  valeur de temp[i] dans temp5[i]
	
	addi $t3,$t3,4				# 4*i
	addi $t1,$t1,1				# incrémentation i +1
	j boucle_indicemin5			# retour au bebut de la boucle
	
	fin_boucle_indicemin5:			# fin initialisation temp  	
	
	suivant_indiceMin6:
	
	
		#--
		# if indiceMin==6
	ori $t4,$zero,6				# on prend la valeur 6
	bne $t0,$t4,suivant_indiceMin7		#on passe au prochain if
	
	#-------boucle de 28 charactere
	ori $t1,$zero,0				# initialisation i 
	addi $t2,$zero,28			# nb éléments de temp = 28
	addi $t3,$zero,0			# 0 puis de 4 en 4
	la $t4,temp				# chargement du tableau temp
	la $t5,temp6				# chargement du tableau temp6
	
	#debut boucle 
	boucle_indicemin6:
	bge $t1,$t2,fin_boucle_indicemin6	# fin boucle i=28		
	add $t6,$t4,$t3				# récupère adresse temp[i]			    
	add $t7,$t5,$t3				# récupère adresse temp1[i]			    
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	sw $t6,0($t7)				# stock la  valeur de temp[i] dans temp6[i]
	
	addi $t3,$t3,4				# 4*i
	addi $t1,$t1,1				# incrémentation i +1
	j boucle_indicemin6			# retour au bebut de la boucle
	
	fin_boucle_indicemin6:			# fin initialisation temp  	
	
	suivant_indiceMin7:
	
	
	
		#--
		# if indiceMin==7
	ori $t4,$zero,7				# on prend la valeur 7
	bne $t0,$t4,suivant_indiceMin8		#on passe au prochain if
	
	#-------boucle de 28 charactere
	ori $t1,$zero,0				# initialisation i 
	addi $t2,$zero,28			# nb éléments de temp = 28
	addi $t3,$zero,0			# 0 puis de 4 en 4
	la $t4,temp				# chargement du tableau temp
	la $t5,temp7				# chargement du tableau temp7
	
	#debut boucle 
	boucle_indicemin7:
	bge $t1,$t2,fin_boucle_indicemin7	# fin boucle i=28		
	add $t6,$t4,$t3				# récupère adresse temp[i]			    
	add $t7,$t5,$t3				# récupère adresse temp1[i]			    
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	sw $t6,0($t7)				# stock la  valeur de temp[i] dans temp7[i]
	
	addi $t3,$t3,4				# 4*i
	addi $t1,$t1,1				# incrémentation i +1
	j boucle_indicemin7			# retour au bebut de la boucle
	
	fin_boucle_indicemin7:			# fin initialisation temp  	
	
	suivant_indiceMin8:
	
	
	
		#--
		# if indiceMin==8
	ori $t4,$zero,8				# on prend la valeur 8
	bne $t0,$t4,suivant_indiceMin9		#on passe au prochain if
	
	#-------boucle de 28 charactere
	ori $t1,$zero,0				# initialisation i 
	addi $t2,$zero,28			# nb éléments de temp = 28
	addi $t3,$zero,0			# 0 puis de 4 en 4
	la $t4,temp				# chargement du tableau temp
	la $t5,temp8				# chargement du tableau temp8
	
	#debut boucle 
	boucle_indicemin8:
	bge $t1,$t2,fin_boucle_indicemin8	# fin boucle i=28		
	add $t6,$t4,$t3				# récupère adresse temp[i]			    
	add $t7,$t5,$t3				# récupère adresse temp1[i]			    
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	sw $t6,0($t7)				# stock la  valeur de temp[i] dans temp8[i]
	
	addi $t3,$t3,4				# 4*i
	addi $t1,$t1,1				# incrémentation i +1
	j boucle_indicemin8			# retour au bebut de la boucle
	
	fin_boucle_indicemin8:			# fin initialisation temp  	
	
	suivant_indiceMin9:
	
	
	
		#--
		# if indiceMin==9
	ori $t4,$zero,9				# on prend la valeur 8
	bne $t0,$t4,suivant_fin		#on passe au prochain if
	
	#-------boucle de 28 charactere
	ori $t1,$zero,0				# initialisation i 
	addi $t2,$zero,28			# nb éléments de temp = 28
	addi $t3,$zero,0			# 0 puis de 4 en 4
	la $t4,temp				# chargement du tableau temp
	la $t5,temp9				# chargement du tableau temp9
	
	#debut boucle 
	boucle_indicemin9:
	bge $t1,$t2,fin_boucle_indicemin9	# fin boucle i=28		
	add $t6,$t4,$t3				# récupère adresse temp[i]			    
	add $t7,$t5,$t3				# récupère adresse temp1[i]			    
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	sw $t6,0($t7)				# stock la  valeur de temp[i] dans temp9[i]
	
	addi $t3,$t3,4				# 4*i
	addi $t1,$t1,1				# incrémentation i +1
	j boucle_indicemin9			# retour au bebut de la boucle
	
	fin_boucle_indicemin9:			# fin initialisation temp  	
	
	suivant_fin:
	#on rempli avec le nombre de recurence du mot
	la $t0,TabInt				# chargement adresse tabint , indicemin , temp_int
	la $t1,indiceMin
	la $t2,temp_int
	
	lw $t2,0($t2)				# charge la valeur de temp_int
	lw $t1,0($t1)				# charge la valeur de indicemin
	
	ori $t3,$zero,4
	mul $t1,$t1,$t3				#indicemin *4 pour avoir la position du nouveau mot
	add $t0,$t0,$t1				# adresse de TabInt[indiceMin]
	sw $t2,0($t0)				# on donne la valeur TabInt[indiceMin] = temp_int
	
	fin_if_mot_existant:
	#fin de creation du mot dans le tableau
	
	#---- reinitialisation des variable
	la $t0,min				# chargement adresse min , existe , temp_int
	la $t1,existe
	la $t2,temp_int
	
	ori $t3,$zero,999			#on va reinitialiser min a 999
	sw $t3,0($t0)
	
	ori $t3,$zero,0			#on va reinitialiser existe a 0
	sw $t3,0($t1)
	
	ori $t3,$zero,0			#on va reinitialiser temp_int a 0
	sw $t3,0($t2)
	
	
	
	
	