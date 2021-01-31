.data
erreur_ouverture_fichier:	.asciiz "erreur ouverture fichier\n"
erreur_ouverture_fichier2:	.asciiz "\nerreur ouverture fichier partie 2\n"
erreur_ouverture_fichier3:	.asciiz "\nerreur ouverture fichier 3\n"
success_ouverture_fichier:	.asciiz "succès ouverture fichier\n"
success_ouverture_fichier2:	.asciiz "\nsuccès ouverture fichier partie 2\n"
success_ouverture_fichier3:	.asciiz "\nsuccès ouverture fichier 3\n"
texte_while:			.asciiz "\n ouais ca marche\n"
texte_while_1:			.asciiz "\ ** 1 **"
texte_while_2:			.asciiz "\ ** 2 **"
nbr_de_phrases:			.asciiz "le nombre de phrase est: "
nbr_mots:			.asciiz "le nombre de mot est: "
nbr_de_lignes:			.asciiz "le nombre de lignes est: "
nbr_de_pages:			.asciiz "le nombre de pages est: "
message_final:			.asciiz " fois le mot "
nbr_lignes_dans_page:		.word 6

chemin_texte:                	.asciiz "/home/polytech/Téléchargements/Projet_Archi_final/Marseillaise.txt"
chemin_texte2:                	.asciiz "/home/polytech/Téléchargements/Projet_Archi_final/texte2.txt"
buffer:				.space 1
tab_resultat_fonction:		.word 0,0,0,0

#variables fonction fréquence mot
caractereActuel:		.word 0
lastcaratere:			.word 0
loop:				.word 0
#nombre de répétitons des mots les plus fréquents associés à leur position dans TabChar
TabInt:				.word 0,0,0,0,0,0,0,0,0,0
#tableau de taille 28 pour sauvegarder les mots les plus fréquents
temp0:				.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
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
	subu $sp,$sp,8    			# prologue
	sw $fp,4($sp)
	addi $fp,$sp,8
	
    	li  $v0, 13            	 		# syscall pour l'ouverture du fichier
        la  $a0, chemin_texte  			# chemin du fichier
        li  $a1,0        	 		# lecture = 0 (flag)
        li  $a2,0        	 		# = 0 (mode : reading from standard input)
        syscall        		 		# ouverture du fichier
	move $s6, $v0      			# sauvegarde adresse fichier 
	
        # erreur d'ouverture du fichier si $vo est négatif
        bltz $v0,erreur_ouverture_part1		# redirection fin du programme
        la $a0,success_ouverture_fichier	# affichage du texte
   	ori $v0,$zero,4				
        syscall
        
        la $t6,tab_resultat_fonction		# chargement du tableau pour resultat fonction
        
        ori $s7,$zero,0				# var "caractère_précédent" de la fonction nb_mot initialisé à 0
        
        jal f1_lecture_caractere 		# appel fonction 
  

        j fin_programme_part1

	erreur_ouverture_part1:	
	la $a0,erreur_ouverture_fichier		# affichage du texte
	ori $v0,$zero,4				
        syscall

	fin_programme_part1:
	li   $v0, 16       			# syscall pour fermer le fichier
  	move $a0, $s6      			# adresse fichier dans $a0 pour fermeture
  	syscall            			# fermeture
  	
  	
	# On répète la procédure d'ouverture et de fermeture du fichier afin de lancer la fonction fréquence mot  	
  	li  $v0, 13            	 		# syscall pour l'ouverture du fichier
        la  $a0,chemin_texte  			# chemin du fichier
        li  $a1,0        	 		# lecture = 0 (flag)
        li  $a2,0        	 		# = 0 (mode : reading from standard input)
        syscall        		 		# ouverture du fichier
	move $s6, $v0      			# sauvegarde adresse fichier 
	
        # erreur d'ouverture du fichier si $vo est négatif
        bltz $v0,erreur_ouverture_part2		# redirection fin du programme
        la $a0,success_ouverture_fichier2	# affichage du texte
   	ori $v0,$zero,4				
        syscall
        
        jal f7_frequence_mot

        
        j fin_programme_part2

	erreur_ouverture_part2:	
	la $a0,erreur_ouverture_fichier2	# affichage du texte
	ori $v0,$zero,4				
        syscall

	fin_programme_part2:
	li   $v0, 16       			# syscall pour fermer le fichier
  	move $a0, $s6      			# adresse fichier dans $a0 pour fermeture
  	syscall            			# fermeture
  	

	lw $fp,4($sp)				# fin de l'appel de la fonction main
	addu $sp,$sp,8
	
        ori $v0,$zero,10			# sortie du programme
        syscall
        
        
f1_lecture_caractere:  				# lecture du fichier caractère par caractère 	
        subu $sp,$sp,12    			# prologue
	sw $fp,4($sp)
	sw $ra,8($sp)
	addu $fp,$sp,12
	
	lecture_caractere_f1:
        li $v0,14				# code service lecture fichier
        
        #chargement des paramètres
        ori $a0,$s6,0				# adresse fichier
        la $a1,buffer				# adresse buffer
        ori $a2,$zero,1				# nombre de caractère lue
        syscall
        
        ori $s0,$v0,0				# si V0= 0 => fin du fichier
        beq $s0,$zero,fin_programme_f1		# on sort si c'est le dernier caractère
        
        jal f2_compteur_phrase			
        jal f3_compteur_mot			
        jal f4_compteur_ligne
	
        ori $a0,$a1,0				# affichage du caractère
        ori $v0,$zero,4
        syscall
        
        j lecture_caractere_f1 			# on refait un tour de boucle
	
	fin_programme_f1:	
		
	jal f5_compteur_page	
	jal f6_affichage_resultat
	
	lw $ra,8($sp)				# epilogue
	lw $fp,4($sp)
	addu $sp,$sp,12
	
	jr $ra
	
f2_compteur_phrase:
	subu $sp,$sp,8   			# prologue
	sw $fp,4($sp)
	addu $fp,$sp,8
	
	ori $t0,$zero,0x21			# caract '!'
	ori $t1,$zero,0x2E			# caract '.'
	ori $t2,$zero,0x3F			# caract '?'
	
	lb $s5,0($a1)				# on récupoère le caractère lu
	
	beq $s5,$t0,compteur_phrase_f2	 	# si = '!'
	beq $s5,$t1,compteur_phrase_f2 		# si = '.'
	beq $s5,$t2,compteur_phrase_f2		# si = '?'
	j fin_programme_f2	
	
	compteur_phrase_f2:			# nb phrase + 1
	addi $s1,$s1,1
	
	fin_programme_f2:			# epilogue
	lw $fp,4($sp)
	addu $sp,$sp,8
	
	sw $s1,0($t6)				# on écrit dans le tab_resultat
	
	jr $ra

f3_compteur_mot:
	subu $sp,$sp,8   			# prologue
	sw $fp,4($sp)
	addu $fp,$sp,8

	ori $t0,$zero,0x21			# caract '!'
	ori $t1,$zero,0x2E			# caract '.'
	ori $t2,$zero,0x3F			# caract '?'
	ori $t3,$zero,0x20			# caract ' '
	ori $t4,$zero,0x2C			# caract ','
	ori $t5,$zero,0x3B			# caract ';'
	ori $t7,$zero,0x0A			# caract '\n'
	
	lb $s5,0($a1)				# on récupère le caractère lu
	
	beq $s5,$t1,compteur_mot_1_f3 		# if == '.'
	beq $s5,$t3,compteur_mot_1_f3		# if == ' '
	beq $s5,$t7,compteur_mot_1_f3		# if == '\n'
	beq $s5,$t4,compteur_mot_1_f3		# if == ','
	j fin_programme_f3			# sinon on sort du programme
	
	compteur_mot_1_f3:			# comparaison avec $s7 = caractère_précédent
	beq $s7,$t2,fin_programme_f3		# if == '?'
	beq $s7,$t0,fin_programme_f3		# if == '!'
	beq $s7,$t7,fin_programme_f3		# if == '\n'
	beq $s7,$t1,fin_programme_f3		# if == '.'
	beq $s7,$t4,fin_programme_f3		# if == ','
	beq $s7,$t5,fin_programme_f3		# if == ';'
	beq $s7,$t3,fin_programme_f3		# if == ' '
	
	addi $s2,$s2,1				# NbMots +=1 si caractère_précédent different des caracteres precedent
	j fin_programme_f3
	
	
	
	addi $s2,$s2,1				# nb_mots + 1
	
	j fin_programme_f3
	
	fin_programme_f3:			# epilogue
	
	ori $s7,$s5,0				# caractère_précédent = caractere_Actuel
	sw $s2,4($t6)				# on écrit dans le tab_resultat
	lw $fp,4($sp)
	addu $sp,$sp,8
	jr $ra
	
f4_compteur_ligne:
	subu $sp,$sp,8   			# prologue
	sw $fp,4($sp)
	addu $fp,$sp,8
	
	ori $t0,$zero,0x0A			# saut de ligne '\n'
	
	lb $s5,0($a1)				# on récupoère le caractère lu
	
	beq $s5,$t0,compteur_ligne_f4		# si ='\n'
	
	j fin_programme_f4	
	
	compteur_ligne_f4:
	addi $s3,$s3,1
	
	fin_programme_f4:			# epilogue
	
	lw $fp,8($sp)
	addu $sp,$sp,8
	sw $s3,8($t6)				# on écrit dans le tab_resultat
	jr $ra
	
f5_compteur_page:
	subu $sp,$sp,8   			# prologue
	sw $fp,4($sp)
	addu $fp,$sp,8
	
        lw $t3,8($t6)				# nombre de lignes
        la $t7,nbr_lignes_dans_page		# nombre de lignes par page 
        lw $t7,0($t7)
        div $t3,$t7				
        mfhi $t5				# reste
 	mflo $t4 				# quotient
        	
        beq $t5,$zero,fin_programme_f5		
       	addi $t4,$t4,1				# +1 page si le reste est non nul


	fin_programme_f5:			# epilogue
	
	lw $fp,4($sp)				
	addu $sp,$sp,8
	sw $t4,12($t6)				# on écrit dans le tab_resultat	
	jr $ra
		
f6_affichage_resultat:
	subu $sp,$sp,8   			# prologue
	sw $fp,4($sp)
	addu $fp,$sp,8
	
	ori $a0,$zero,0x0A			# affichage saut de ligne	
    	ori $v0,$zero,11
        syscall	
		
	la $a0,nbr_de_phrases			# affichage texte nbr phrases
    	ori $v0,$zero,4
        syscall
        
	lw $s3,0($t6)				# affichage du tab_resultat 1
	ori $a0,$s3,0
	ori $v0,$zero,1
	syscall
	
	ori $a0,$zero,0x0A			# affichage saut de ligne	
    	ori $v0,$zero,11
        syscall	
        
	la $a0,nbr_mots				#affichage texte nbr mots
    	ori $v0,$zero,4
        syscall
        
      
	lw $s3,4($t6)				# affichage du tab_resultat 2
	ori $a0,$s3,0
	ori $v0,$zero,1
	syscall
	
	ori $a0,$zero,0x0A			# affichage saut de ligne	
    	ori $v0,$zero,11
        syscall
	
	la $a0,nbr_de_lignes			#afficher le texte nbr lignes
    	ori $v0,$zero,4
        syscall
	
	
	lw $s3,8($t6)				# affichage du tab_resultat 3
	ori $a0,$s3,0
	ori $v0,$zero,1
	syscall
	
		
	ori $a0,$zero,0x0A			# affichage saut de ligne	
    	ori $v0,$zero,11
        syscall
        
        #calcule et affichage nbr pages
        la $a0,nbr_de_pages			#affiche message pages
    	ori $v0,$zero,4
        syscall

	lw $s3,12($t6)				# affichage du tab_resultat 4
	ori $a0,$s3,0
	ori $v0,$zero,1
	syscall


	lw $fp,4($sp)				# epilogue
	addu $sp,$sp,8
	jr $ra

f7_frequence_mot:
	subu $sp,$sp,8   			# prologue
	sw $fp,4($sp)
	addu $fp,$sp,8
	
	#ATTENTION $t0 et $t7 réservé, s7 et s5 pour caractère précédent et caractère actuel
	
	#la $t7,tab_resultat_fonction		# chargement nb mots texte
	#lw $t7,4($t7)
	ori $t7,$zero,20
	ori $t0,$zero,0				# initialisation i alias big (code C)
	#1er for
	grand_tour_f7:
	bge $t0,$t7,fin_programme_f7
	
	#2ème for = initialisation de temp
	la $t6,temp				# chargement du tableau temp
	ori $t1,$zero,0				# initialisation i alias i2 (code C)
	addi $t5,$zero,28			# nb éléments de temp = 28
	addi $t2,$zero,4			# valeur 4
	
	initialisation_temp_f7:
	bge $t1,$t5,fin_initialisation_temp_f7
	mul $t3,$t2,$t1				# 4*i
	add $t4,$t6,$t3				# récupère adresse temp[i]
	lw $s1,0($t4)				# récupère valeur de l'adresse temp[i]
	ori $s1,$zero,0				# initialisation à zéro
	sw $s1,0($t4)
	addi $t1,$t1,1				# incrémentation 2ème for init temp
	j initialisation_temp_f7		# retour 2ème for alias	
	
	fin_initialisation_temp_f7:		# fin initialisation temp
	# initialisation loop
	la $t6,loop				# chargement de l'entier loop
	lw $s1,0($t6)
	ori $s1,$zero,0				# initialisation loop à zéro
	sw $s1,0($t6)	
			
	# lecture caractère
        li $v0,14				# code service lecture fichier
        
        # chargement des paramètres
        ori $a0,$s6,0				# adresse fichier
        la $a1,buffer				# adresse buffer
        ori $a2,$zero,1				# nombre de caractère lue
        syscall
        
        #erreur :ori $s7,$v0,0				# copie du caractère lu dans Caractère_précédent
        lb $s7,0($a1)
        
       	# 3ème for
	ori $t1,$zero,0				# initialisation i alias i (code C)	
	addi $t2,$zero,4			# valeur 4
	
	ori $t3,$zero,0x21			# caract '!'
	ori $t4,$zero,0x2E			# caract '.'
	ori $t5,$zero,0x3F			# caract '?'
	ori $t6,$zero,0x20			# caract ' '
	ori $s1,$zero,0x2C			# caract ','
	ori $s2,$zero,0x3B			# caract ';'
	ori $s3,$zero,0x0A			# caract '\n'
	
	# si ponctuation ou espace collé, on les ignore et on lie de nouveau un entier
	for_3_f7:
	bge $t1,$t2,fin_for_3_f7
	#if caractère_précédent = alors on lie un nouvelle entier
	bne $s7,$t3,suite_for_3_f7		# si != '!'
	bne $s7,$t4,suite_for_3_f7		# si != '.'
	bne $s7,$t5,suite_for_3_f7		# si != '?'
	bne $s7,$t6,suite_for_3_f7		# si != ' '
	bne $s7,$s1,suite_for_3_f7		# si != ','
	bne $s7,$s2,suite_for_3_f7		# si != ';'
	bne $s7,$s3,suite_for_3_f7		# si != '\n'
	
	# lecture caractère (fgetc)
        li $v0,14				# code service lecture fichier
        # chargement des paramètres
        ori $a0,$s6,0				# adresse fichier
        la $a1,buffer				# adresse buffer
        ori $a2,$zero,1				# nombre de caractère lue
        syscall
        #erreur :ori $s7,$a1,0				# copie du caractère lu dans Caractère_précédent
	lb $s7,0($a1)
	
	suite_for_3_f7:
	addi $t1,$t1,1				# incrémentation 3eme for
	j for_3_f7
	fin_for_3_f7:
	
	#ori $a0,$a1,0				# affichage du caractère
        #ori $v0,$zero,4
        #syscall
        
	while_1_f7:
	ori $t3,$zero,0x21			# caract '!'
	ori $t4,$zero,0x2E			# caract '.'
	ori $t5,$zero,0x3F			# caract '?'
	ori $t6,$zero,0x20			# caract ' '
	ori $s1,$zero,0x2C			# caract ','
	ori $s2,$zero,0x3B			# caract ';'
	ori $s3,$zero,0x0A			# caract '\n'
	
	beq $s7,$t3,fin_while_1_f7		# si = '!'
	beq $s7,$t4,fin_while_1_f7		# si = '.'
	beq $s7,$t5,fin_while_1_f7		# si = '?'
	beq $s7,$t6,fin_while_1_f7		# si = ' '
	beq $s7,$s1,fin_while_1_f7		# si = ','
	beq $s7,$s2,fin_while_1_f7		# si = ';'
	beq $s7,$s3,fin_while_1_f7		# si = '\n'
	
	# lecture caractère (fgetc)
        li $v0,14				# code service lecture fichier
        # chargement des paramètres
        ori $a0,$s6,0				# adresse fichier
        la $a1,buffer				# adresse buffer
        ori $a2,$zero,1				# nombre de caractère lue
        syscall   
        
        ori $s0,$v0,0				# si V0= 0 => fin du fichier
        beq $s0,$zero,fin_while_1_f7		# on sort si c'est le dernier caractère
        
        #erreur :ori $s5,$a1,0				# copie du caractère lu dans caractère_actuel
        lb $s5,0($a1)
        
        la $t3,loop				
        lw $t4,0($t3)
        ori $t5,$zero,4
        mul $t5,$t4,$t5				# 4*loop
        
        la $t6,temp
       	add $s1,$t6,$t5				# adresse de temp + 4*loop
        lw $s2,0($s1)				# valeur de tempchar à l'adresse 4*loop
        addi $s2,$s7,0				# temp[loop] = caractere_actuel
        sw $s2,0($s1)
        ori $s7,$s5,0				# caractere_precedent = caractere_actuel
        
        addi $t4,$t4,1				# loop ++
        sw $t4,0($t3)
        
        #ori $a0,$a1,0				# affichage du caractère
        #ori $v0,$zero,4
        #syscall
        
	j while_1_f7
   	
	fin_while_1_f7:

	#la $a0,texte_while_1			#afficher le texte nbr lignes
    	#ori $v0,$zero,4
        #syscall


	#ATTENTION S4 UTILISE POUR LE FICHIER2

	# On re-ouvre le fichier (fichier2= fopen(..))	
  	li  $v0, 13            	 		# syscall pour l'ouverture du fichier
        la  $a0,chemin_texte2  			# chemin du fichier
        li  $a1,0        	 		# lecture = 0 (flag)
        li  $a2,0        	 		# = 0 (mode : reading from standard input)
        syscall        		 		# ouverture du fichier
	move $s4,$v0      			# sauvegarde adresse fichier 
	
        # erreur d'ouverture du fichier si $vo est négatif
        bltz $v0,erreur_ouverture_part3		# redirection fin du programme
        #la $a0,success_ouverture_fichier3	# affichage du texte
   	#ori $v0,$zero,4				
        #syscall
        

        # ATTENTION $t9 RESERVE POUR 2EME GRANDE BOUCLE FOR
        
        ori $t9,$zero,0				# initialisation i alias irr (code C)
	#1er for
	grand_tour_2_f7:
	bge $t9,$t7,fin_grand_tour_2_f7
	
	#2ème for = initialisation de temp_char
	la $t6,temp_char			# chargement du tableau temp
	ori $t1,$zero,0				# initialisation i alias i2 (code C)
	addi $t5,$zero,28			# nb éléments de temp = 28
	addi $t2,$zero,4			# valeur 4
	
	initialisation_temp_char_f7:
	bge $t1,$t5,fin_initialisation_temp_char_f7
	mul $t3,$t2,$t1				# 4*i
	add $t4,$t6,$t3				# récupère adresse temp[i]
	lw $s1,0($t4)				# récupère valeur de l'adresse temp[i]
	ori $s1,$zero,0				# initialisation à zéro
	sw $s1,0($t4)
	addi $t1,$t1,1				# incrémentation 2ème for init temp
	j initialisation_temp_char_f7		# retour 2ème for alias	
	
	fin_initialisation_temp_char_f7:	# fin initialisation temp
	# initialisation loop
	la $t6,loop				# chargement de l'entier loop
	lw $s1,0($t6)
	ori $s1,$zero,0				# initialisation loop à zéro
	sw $s1,0($t6)	
			
	# lecture caractère
        li $v0,14				# code service lecture fichier
        
        # chargement des paramètres
        ori $a0,$s4,0				# adresse fichier
        la $a1,buffer				# adresse buffer
        ori $a2,$zero,1				# nombre de caractère lue
        syscall
        
        #erreur :ori $s7,$v0,0				# copie du caractère lu dans Caractère_précédent
        lb $s7,0($a1)
        
       	# 3ème for
	ori $t1,$zero,0				# initialisation i alias i (code C)	
	addi $t2,$zero,4			# valeur 4
	
	ori $t3,$zero,0x21			# caract '!'
	ori $t4,$zero,0x2E			# caract '.'
	ori $t5,$zero,0x3F			# caract '?'
	ori $t6,$zero,0x20			# caract ' '
	ori $s1,$zero,0x2C			# caract ','
	ori $s2,$zero,0x3B			# caract ';'
	ori $s3,$zero,0x0A			# caract '\n'
	
	# si ponctuation ou espace collé, on les ignore et on lie de nouveau un entier
	for_3_partie2_f7:
	bge $t1,$t2,fin_for_3_partie2_f7
	#if caractère_précédent = alors on lie un nouvelle entier
	bne $s7,$t3,suite_for_3_partie2_f7	# si != '!'
	bne $s7,$t4,suite_for_3_partie2_f7	# si != '.'
	bne $s7,$t5,suite_for_3_partie2_f7	# si != '?'
	bne $s7,$t6,suite_for_3_partie2_f7	# si != ' '
	bne $s7,$s1,suite_for_3_partie2_f7	# si != ','
	bne $s7,$s2,suite_for_3_partie2_f7	# si != ';'
	bne $s7,$s3,suite_for_3_partie2_f7	# si != '\n'
	
	# lecture caractère (fgetc)
        li $v0,14				# code service lecture fichier
        # chargement des paramètres
        ori $a0,$s4,0				# adresse fichier
        la $a1,buffer				# adresse buffer
        ori $a2,$zero,1				# nombre de caractère lue
        syscall
        #erreur :ori $s7,$a1,0				# copie du caractère lu dans Caractère_précédent
	lb $s7,0($a1)
	
	suite_for_3_partie2_f7:
	addi $t1,$t1,1				# incrémentation 3eme for
	j for_3_partie2_f7
	fin_for_3_partie2_f7:
	
	
	#ori $a0,$a1,0				# affichage du caractère
        #ori $v0,$zero,4
        #syscall
	
	while_2_f7:
	ori $t3,$zero,0x21			# caract '!'
	ori $t4,$zero,0x2E			# caract '.'
	ori $t5,$zero,0x3F			# caract '?'
	ori $t6,$zero,0x20			# caract ' '
	ori $s1,$zero,0x2C			# caract ','
	ori $s2,$zero,0x3B			# caract ';'
	ori $s3,$zero,0x0A			# caract '\n'
	
	beq $s7,$t3,fin_while_2_f7		# si = '!'
	beq $s7,$t4,fin_while_2_f7		# si = '.'
	beq $s7,$t5,fin_while_2_f7		# si = '?'
	beq $s7,$t6,fin_while_2_f7		# si = ' '
	beq $s7,$s1,fin_while_2_f7		# si = ','
	beq $s7,$s2,fin_while_2_f7		# si = ';'
	beq $s7,$s3,fin_while_2_f7		# si = '\n'
	
	# lecture caractère (fgetc)
        li $v0,14				# code service lecture fichier
        # chargement des paramètres
        ori $a0,$s4,0				# adresse fichier
        la $a1,buffer				# adresse buffer
        ori $a2,$zero,1				# nombre de caractère lue
        syscall   
        
        ori $s0,$v0,0				# si V0= 0 => fin du fichier
        beq $s0,$zero,fin_while_2_f7		# on sort si c'est le dernier caractère
        
        #erreur :ori $s5,$a1,0				# copie du caractère lu dans caractère_actuel
        lb $s5,0($a1)
        
        la $t3,loop				
        lw $t4,0($t3)
        ori $t5,$zero,4
        mul $t5,$t4,$t5				# 4*loop
        
        la $t6,temp_char
       	add $s1,$t6,$t5				# adresse de tempchar + 4*loop
        lw $s2,0($s1)				# valeur de tempchar à l'adresse 4*loop
        addi $s2,$s7,0				# temp[loop] = caractere_actuel
        sw $s2,0($s1)
        ori $s7,$s5,0				# caractere_precedent = caractere_actuel
        
        addi $t4,$t4,1				# loop ++
        sw $t4,0($t3)
        
        #ori $a0,$a1,0				# affichage du caractère
        #ori $v0,$zero,4
        #syscall
        

	j while_2_f7
        
        fin_while_2_f7:
        
        #la $a0,texte_while_2			#afficher le texte nbr lignes
    	#ori $v0,$zero,4
        #syscall
        
        
        
        # for 4 pour strcmp
        la $t6,temp				# chargement du tableau temp
        la $t4,temp_char			
	ori $t1,$zero,0				# initialisation i alias i2 (code C)
	addi $t5,$zero,28			# nb éléments de temp = 28
	addi $t2,$zero,4			# valeur 4
        
        ori $t8,$zero,0				# initialisation comp
        
        comparaison_temp_f7:
	bge $t1,$t5,fin_comparaison_temp_f7
	mul $t3,$t2,$t1				# 4*i
	
	add $t6,$t6,$t3				# récupère adresse temp[i]
	lw $s1,0($t6)				# récupère valeur de l'adresse temp[i]
	
	add $t4,$t4,$t3				# récupère adresse temp_char[i]
	lw $s2,0($t4)				# récupère valeur de l'adresse temp_char[i]
	
	bne $s1,$s2,suite_comparaison_temp_f7
	addi $t8,$t8,1				# comp ++
	

	suite_comparaison_temp_f7:
	addi $t1,$t1,1				# incrémentation
	j comparaison_temp_f7			
	
	fin_comparaison_temp_f7:		
        
        bne $t8,$t5,comp_pas_egal_28_1_f7
        la $s3,temp_int				# on récupère adrese temp-int
        lw $k0,0($s3)
        addi $k0,$k0,1
        
        ori $a0,$zero,0x0A			# affichage saut de ligne	
    	ori $v0,$zero,11
        syscall	
        
        ori $a0,$k0,0
	ori $v0,$zero,1
	syscall
	
	ori $a0,$zero,0x0A			# affichage saut de ligne	
    	ori $v0,$zero,11
        syscall	
        
        sw $k0,0($s3)
        
        comp_pas_egal_28_1_f7:
        
        addi $t9,$t9,1				# incrémentation 2eme grand for
	j grand_tour_2_f7			# retour sur le 2eme for
	fin_grand_tour_2_f7:
	
        
        
        #printf et close fichier 2
        j fin_programme_part3
        
	erreur_ouverture_part3:	
	la $a0,erreur_ouverture_fichier3	# affichage du texte
	ori $v0,$zero,4				
        syscall

	
	fin_programme_part3:
	li   $v0, 16       			# syscall pour fermer le fichier
  	move $a0, $s4     			# adresse fichier dans $a0 pour fermeture
  	syscall            			# fermeture
	
	
	
	
	###########################PARTIE THOMAS ROUSSARIE
	
	
	
	# t8 remplace t0
	# s1 remplace t7
	# s2 remplace t9
	
	#----for comparaison 0
	ori $t8,$zero,0				# initialisation comp a 0
	ori $t1,$zero,0				# initialisation i 
	addi $t2,$zero,28			# nb éléments de temp = 28
	addi $t3,$zero,0			# 0 puis de 4 en 4
	la $t4,temp				# chargement du tableau temp
	la $t5,temp0				# chargement du tableau temp0
	
	#debut boucle 
	comparaison_temp_temp0:
	bge $t1,$t2,fin_comparaison_temp_temp0		# fin boucle i=28
	add $t6,$t4,$t3				# récupère adresse temp[i]
	add $s1,$t5,$t3				# récupère adresse temp0[i]
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	lw $s1,0($s1)				# récupère valeur de l'adresse temp0[i]
	
	# if temp[i] ==temp0[i]
	bne $t6,$s1,fin_if_temp_temp0
	addi $t8,$t8,1
	
	fin_if_temp_temp0:
	
	addi $t3,$t3,4				# 4*i
	addi $t1,$t1,1				# incrémentation i +1
	j comparaison_temp_temp0		# retour au bebut de la boucle
	
	fin_comparaison_temp_temp0:		# fin initialisation temp
	
		# if (comp == 28)
	bne $t8,$t2,fin_if_comp0		# si comp == 28 , alors existe =1
	la $t1,existe
	addi $t3,$zero,1
	sw $t3,0($t1)
	
	fin_if_comp0:
	# fin de for comparaison 0
	
	
		#----for comparaison 1
	ori $t8,$zero,0				# initialisation comp a 0
	ori $t1,$zero,0				# initialisation i 
	addi $t2,$zero,28			# nb éléments de temp = 28
	addi $t3,$zero,0			# 0 puis de 4 en 4
	la $t4,temp				# chargement du tableau temp
	la $t5,temp1				# chargement du tableau temp1
	
	#debut boucle 
	comparaison_temp_temp1:
	bge $t1,$t2,fin_comparaison_temp_temp1		# fin boucle i=28
	add $t6,$t4,$t3				# récupère adresse temp[i]
	add $s1,$t5,$t3				# récupère adresse temp1[i]
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	lw $s1,0($s1)				# récupère valeur de l'adresse temp1[i]
	
	# if temp[i] ==temp1[i]
	bne $t6,$s1,fin_if_temp_temp1
	addi $t8,$t8,1
	
	fin_if_temp_temp1:
	
	addi $t3,$t3,4				# 4*i
	addi $t1,$t1,1				# incrémentation i +1
	j comparaison_temp_temp1		# retour au bebut de la boucle
	
	fin_comparaison_temp_temp1:		# fin initialisation temp
	
		# if (comp == 28)
	bne $t8,$t2,fin_if_comp1		# si comp == 28 , alors existe =1
	la $t1,existe
	addi $t3,$zero,1
	sw $t3,0($t1)
	
	fin_if_comp1:
	# fin de for comparaison 1
	
	
	
		#----for comparaison 2
	ori $t8,$zero,0				# initialisation comp a 0
	ori $t1,$zero,0				# initialisation i 
	addi $t2,$zero,28			# nb éléments de temp = 28
	addi $t3,$zero,0			# 0 puis de 4 en 4
	la $t4,temp				# chargement du tableau temp
	la $t5,temp2				# chargement du tableau temp2
	
	#debut boucle 
	comparaison_temp_temp2:
	bge $t1,$t2,fin_comparaison_temp_temp2		# fin boucle i=28
	add $t6,$t4,$t3				# récupère adresse temp[i]
	add $s1,$t5,$t3				# récupère adresse temp2[i]
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	lw $s1,0($s1)				# récupère valeur de l'adresse temp2[i]
	
	# if temp[i] ==temp2[i]
	bne $t6,$s1,fin_if_temp_temp2
	addi $t8,$t8,1
	
	fin_if_temp_temp2:
	
	addi $t3,$t3,4				# 4*i
	addi $t1,$t1,1				# incrémentation i +1
	j comparaison_temp_temp2		# retour au bebut de la boucle
	
	fin_comparaison_temp_temp2:		# fin initialisation temp
	
		# if (comp == 28)
	bne $t8,$t2,fin_if_comp2		# si comp == 28  , alors existe =1
	la $t1,existe
	addi $t3,$zero,1
	sw $t3,0($t1)
	
	fin_if_comp2:
	# fin de for comparaison 2
	
	
	
	
		#----for comparaison 3
	ori $t8,$zero,0				# initialisation comp a 0
	ori $t1,$zero,0				# initialisation i 
	addi $t2,$zero,28			# nb éléments de temp = 28
	addi $t3,$zero,0			# 0 puis de 4 en 4
	la $t4,temp				# chargement du tableau temp
	la $t5,temp3				# chargement du tableau temp3
	
	#debut boucle 
	comparaison_temp_temp3:
	bge $t1,$t2,fin_comparaison_temp_temp3		# fin boucle i=28
	add $t6,$t4,$t3				# récupère adresse temp[i]
	add $s1,$t5,$t3				# récupère adresse temp3[i]
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	lw $s1,0($s1)			# récupère valeur de l'adresse temp3[i]
	
	# if temp[i] ==temp3[i]
	bne $t6,$s1,fin_if_temp_temp3
	addi $t8,$t8,1
	
	fin_if_temp_temp3:
	
	addi $t3,$t3,4				# 4*i
	addi $t1,$t1,1				# incrémentation i +1
	j comparaison_temp_temp3		# retour au bebut de la boucle
	
	fin_comparaison_temp_temp3:		# fin initialisation temp
	
	# if (comp == 28)
	bne $t8,$t2,fin_if_comp3		# si comp == 28, alors existe =1
	la $t1,existe				
	addi $t3,$zero,1			
	sw $t3,0($t1)
	
	fin_if_comp3:
	# fin de for comparaison 3
	
	
	
	#----for comparaison 4
	ori $t8,$zero,0				# initialisation comp a 0
	ori $t1,$zero,0				# initialisation i 
	addi $t2,$zero,28			# nb éléments de temp = 28
	addi $t3,$zero,0			# 0 puis de 4 en 4
	la $t4,temp				# chargement du tableau temp
	la $t5,temp4				# chargement du tableau temp4
	
	#debut boucle 
	comparaison_temp_temp4:
	bge $t1,$t2,fin_comparaison_temp_temp4		# fin boucle i=28
	add $t6,$t4,$t3				# récupère adresse temp[i]
	add $s1,$t5,$t3				# récupère adresse temp3[i]
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	lw $s1,0($s1)				# récupère valeur de l'adresse temp4[i]
	
	# if temp[i] ==temp4[i]
	bne $t6,$s1,fin_if_temp_temp4
	addi $t8,$t8,1
	
	fin_if_temp_temp4:
	
	addi $t3,$t3,4				# 4*i
	addi $t1,$t1,1				# incrémentation i +1
	j comparaison_temp_temp4		# retour au bebut de la boucle
	
	fin_comparaison_temp_temp4:		# fin initialisation temp
	
		# if (comp == 28)
	bne $t8,$t2,fin_if_comp4		# si comp == 28, alors existe =1
	la $t1,existe				
	addi $t3,$zero,1			
	sw $t3,0($t1)
	
	fin_if_comp4:
	# fin de for comparaison 4
	
	
	
	
	#----for comparaison 5
	ori $t8,$zero,0				# initialisation comp a 0
	ori $t1,$zero,0				# initialisation i 
	addi $t2,$zero,28			# nb éléments de temp = 28
	addi $t3,$zero,0			# 0 puis de 4 en 4
	la $t4,temp				# chargement du tableau temp
	la $t5,temp5				# chargement du tableau temp5
	
	#debut boucle 
	comparaison_temp_temp5:
	bge $t1,$t2,fin_comparaison_temp_temp5		# fin boucle i=28
	add $t6,$t4,$t3				# récupère adresse temp[i]
	add $s1,$t5,$t3				# récupère adresse temp5[i] (╭ರ_•́)
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	lw $s1,0($s1)				# récupère valeur de l'adresse temp5[i]
	
	# if temp[i] ==temp3[i]
	bne $t6,$s1,fin_if_temp_temp5
	addi $t8,$t8,1
	
	fin_if_temp_temp5:
	
	addi $t3,$t3,4				# 4*i
	addi $t1,$t1,1				# incrémentation i +1
	j comparaison_temp_temp5		# retour au bebut de la boucle
	
	fin_comparaison_temp_temp5:		# fin initialisation temp
	
		# if (comp == 28)
	bne $t8,$t2,fin_if_comp5		# si comp == 28, alors existe =1
	la $t1,existe				
	addi $t3,$zero,1			
	sw $t3,0($t1)
	
	fin_if_comp5:
	# fin de for comparaison 5
	
	
	
	
	#----for comparaison 6
	ori $t8,$zero,0				# initialisation comp a 0
	ori $t1,$zero,0				# initialisation i 
	addi $t2,$zero,28			# nb éléments de temp = 28
	addi $t3,$zero,0			# 0 puis de 4 en 4
	la $t4,temp				# chargement du tableau temp
	la $t5,temp6				# chargement du tableau temp6
	
	#debut boucle 
	comparaison_temp_temp6:
	bge $t1,$t2,fin_comparaison_temp_temp6		# fin boucle i=28
	add $t6,$t4,$t3				# récupère adresse temp[i]
	add $s1,$t5,$t3				# récupère adresse temp6[i]
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	lw $s1,0($s1)				# récupère valeur de l'adresse temp6[i]
	
	# if temp[i] ==temp6[i]
	bne $t6,$s1,fin_if_temp_temp6
	addi $t8,$t8,1
	
	fin_if_temp_temp6:
	
	addi $t3,$t3,4				# 4*i
	addi $t1,$t1,1				# incrémentation i +1
	j comparaison_temp_temp6		# retour au bebut de la boucle
	
	fin_comparaison_temp_temp6:		# fin initialisation temp
	
		# if (comp == 28)
	bne $t8,$t2,fin_if_comp6		# si comp == 28, alors existe =1
	la $t1,existe				
	addi $t3,$zero,1			
	sw $t3,0($t1)
	
	fin_if_comp6:
	# fin de for comparaison 6
	
	
	
	
	#----for comparaison 7
	ori $t8,$zero,0				# initialisation comp a 0
	ori $t1,$zero,0				# initialisation i 
	addi $t2,$zero,28			# nb éléments de temp = 28
	addi $t3,$zero,0			# 0 puis de 4 en 4
	la $t4,temp				# chargement du tableau temp
	la $t5,temp7				# chargement du tableau temp7
	
	#debut boucle 
	comparaison_temp_temp7:
	bge $t1,$t2,fin_comparaison_temp_temp7		# fin boucle i=28
	add $t6,$t4,$t3				# récupère adresse temp[i]
	add $s1,$t5,$t3				# récupère adresse temp3[i]
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	lw $s1,0($s1)				# récupère valeur de l'adresse temp7[i]
	
	# if temp[i] ==temp7[i]
	bne $t6,$s1,fin_if_temp_temp7
	addi $t8,$t8,1
	
	fin_if_temp_temp7:
	
	addi $t3,$t3,4				# 4*i
	addi $t1,$t1,1				# incrémentation i +1
	j comparaison_temp_temp7		# retour au bebut de la boucle
	
	fin_comparaison_temp_temp7:		# fin initialisation temp
	
		# if (comp == 28)
	bne $t8,$t2,fin_if_comp7		# si comp == 28, alors existe =1
	la $t1,existe				
	addi $t3,$zero,1			
	sw $t3,0($t1)
	
	fin_if_comp7:
	# fin de for comparaison 7
	
	
	
	
	#----for comparaison 8
	ori $t8,$zero,0				# initialisation comp a 0
	ori $t1,$zero,0				# initialisation i 
	addi $t2,$zero,28			# nb éléments de temp = 28
	addi $t3,$zero,0			# 0 puis de 4 en 4
	la $t4,temp				# chargement du tableau temp
	la $t5,temp8				# chargement du tableau temp8
	
	#debut boucle 
	comparaison_temp_temp8:
	bge $t1,$t2,fin_comparaison_temp_temp8		# fin boucle i=28
	add $t6,$t4,$t3				# récupère adresse temp[i]
	add $s1,$t5,$t3				# récupère adresse temp3[i]
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	lw $s1,0($s1)				# récupère valeur de l'adresse temp8[i]
	
	# if temp[i] ==temp8[i]
	bne $t6,$s1,fin_if_temp_temp8
	addi $t8,$t8,1
	
	fin_if_temp_temp8:
	
	addi $t3,$t3,4				# 4*i
	addi $t1,$t1,1				# incrémentation i +1
	j comparaison_temp_temp8		# retour au bebut de la boucle
	
	fin_comparaison_temp_temp8:		# fin initialisation temp
	
		# if (comp == 28)
	bne $t8,$t2,fin_if_comp8		# si comp == 28, alors existe =1
	la $t1,existe				
	addi $t3,$zero,1			
	sw $t3,0($t1)
	
	fin_if_comp8:
	# fin de for comparaison 8
	
	
	
	
	
	#----for comparaison 9
	ori $t8,$zero,0				# initialisation comp a 0
	ori $t1,$zero,0				# initialisation i 
	addi $t2,$zero,28			# nb éléments de temp = 28
	addi $t3,$zero,0			# 0 puis de 4 en 4
	la $t4,temp				# chargement du tableau temp
	la $t5,temp9				# chargement du tableau temp9
	
	#debut boucle 
	comparaison_temp_temp9:
	bge $t1,$t2,fin_comparaison_temp_temp9		# fin boucle i=28
	add $t6,$t4,$t3				# récupère adresse temp[i]
	add $s1,$t5,$t3				# récupère adresse temp9[i]
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	lw $s1,0($s1)				# récupère valeur de l'adresse temp9[i]
	
	# if temp[i] ==temp9[i]
	bne $t6,$s1,fin_if_temp_temp9
	addi $t8,$t8,1
	
	fin_if_temp_temp9:
	
	addi $t3,$t3,4				# 4*i
	addi $t1,$t1,1				# incrémentation i +1
	j comparaison_temp_temp9		# retour au bebut de la boucle
	
	fin_comparaison_temp_temp9:		# fin initialisation temp
	
		# if (comp == 28)
	bne $t8,$t2,fin_if_comp9		# si comp == 28, alors existe =1
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
	la $s1,indiceMin			# chargement adresse indicemin
	lw $s2,0($s1)				# chargement valeur indicemin
	
	
	#debut boucle 
	boucle_min:
	bge $t1,$t2,fin_boucle_min		# fin boucle i=10
	add $t6,$t5,$t3				# récupère adresse tabint[i]
	lw $t6,0($t6)				# récupère valeur de l'adresse tabint[i]
	
	
	#if TabInt[i] < min 
	bge $t6,$t8,fin_if_min			# min>tabint[i] on sort
	add $t8,$zero,$t6			# min=tabint[i]
	sw $t8,0($t4)				# sauvegarde min=tabint[i]
	add $s2,$zero,$t1			# indiceMin = i
	sw $s2,0($s1)				# sauvegarde indiceMin = i
	
	fin_if_min:
	
	addi $t3,$t3,4				# 4*i
	addi $t1,$t1,1				# incrémentation i +1
	j boucle_min				# retour au bebut de la boucle
	
	fin_boucle_min:
	#fin de recherche le mot le moins present du tableau
	
	
	
	
	
	
	
	
	
	
	
	#----------------
	
	
	# Si le mot n existe pas on et est en nombre superieur nombre de mots min on le remplace
	la $t8,existe				# charge l'adresse de existe
	lw $t8,0($t8)				# charge la valeur de existe
	la $t1,indiceMin			# charge l'adresse de indicemin
	lw $t1,0($t1)				# charge la valeur de indicemin
	la $t2,TabInt				# charge l'adresse de tabint
	#lw $t2,0($t2)				# charge la valeur de tabint
	la $t3,temp_int				# charge l'adresse de tempint
	lw $t3,0($t3)				# charge la valeur de tempint
	
	# if existe == 1 on saute
	ori $t4,$zero,0				# on prend la valeur 1
	bne $t8,$t4,fin_if_mot_existant

	ori $a0,$t3,0
	ori $v0,$zero,1
	syscall
	
	
	ori $a0,$zero,15
	ori $v0,$zero,1
	syscall
	# if TabInt[indiceMin] < temp_int
	add $t2,$t2,$t1				# on creer l'adresse TabInt[indiceMin]
	lw $t2,0($t2)				# charge la valeur de TabInt[indiceMin] ¯\_(ツ)_/¯
	ori $a0,$t2,0
	ori $v0,$zero,1
	syscall
	bge $t2,$t3,fin_if_mot_existant		# si TabInt[indiceMin] >= tempint on saute a la fin
	
	
	
	
	# on fix indice a $t8 pour ne pas avoir a le redemander
	la $t8,indiceMin			# charge l'adresse de indicemin
	lw $t8,0($t8)				# charge la valeur de indicemin
	
		#--
		# if indiceMin==0
	ori $t4,$zero,0				# on prend la valeur 0
	bne $t8,$t4,suivant_indiceMin1		#on passe au prochain if
	
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
	add $s1,$t5,$t3				# récupère adresse temp0[i]			    
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	sw $t6,0($s1)				# stock la  valeur de temp[i] dans temp0[i]
	
	addi $t3,$t3,4				# 4*i
	addi $t1,$t1,1				# incrémentation i +1
	j boucle_indicemin0			# retour au bebut de la boucle
	
	fin_boucle_indicemin0:			# fin initialisation temp  	
	
	suivant_indiceMin1:
	
		#--
		# if indiceMin==1
	ori $t4,$zero,1				# on prend la valeur 1
	bne $t8,$t4,suivant_indiceMin2		#on passe au prochain if
	
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
	add $s1,$t5,$t3				# récupère adresse temp1[i]			    
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	sw $t6,0($s1)				# stock la  valeur de temp[i] dans temp1[i]
	
	addi $t3,$t3,4				# 4*i
	addi $t1,$t1,1				# incrémentation i +1
	j boucle_indicemin1			# retour au bebut de la boucle
	
	fin_boucle_indicemin1:			# fin initialisation temp  	
	
	suivant_indiceMin2:
	
		#--
		# if indiceMin==2
	ori $t4,$zero,2				# on prend la valeur 2
	bne $t8,$t4,suivant_indiceMin3		#on passe au prochain if
	
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
	add $s1,$t5,$t3				# récupère adresse temp1[i]			    
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	sw $t6,0($s1)				# stock la  valeur de temp[i] dans temp2[i]
	
	addi $t3,$t3,4				# 4*i
	addi $t1,$t1,1				# incrémentation i +1
	j boucle_indicemin2			# retour au bebut de la boucle
	
	fin_boucle_indicemin2:			# fin initialisation temp  	
	
	suivant_indiceMin3:
	
		#--
		# if indiceMin==3
	ori $t4,$zero,3				# on prend la valeur 3
	bne $t8,$t4,suivant_indiceMin4		#on passe au prochain if
	
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
	add $s1,$t5,$t3				# récupère adresse temp1[i]			    
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	sw $t6,0($s1)				# stock la  valeur de temp[i] dans temp3[i]
	
	addi $t3,$t3,4				# 4*i
	addi $t1,$t1,1				# incrémentation i +1
	j boucle_indicemin3			# retour au bebut de la boucle
	
	fin_boucle_indicemin3:			# fin initialisation temp  	
	
	suivant_indiceMin4:
	
	
		#--
		# if indiceMin==4
	ori $t4,$zero,4				# on prend la valeur 4
	bne $t8,$t4,suivant_indiceMin5		#on passe au prochain if
	
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
	add $s1,$t5,$t3				# récupère adresse temp1[i]			    
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	sw $t6,0($s1)				# stock la  valeur de temp[i] dans temp4[i]
	
	addi $t3,$t3,4				# 4*i
	addi $t1,$t1,1				# incrémentation i +1
	j boucle_indicemin4			# retour au bebut de la boucle
	
	fin_boucle_indicemin4:			# fin initialisation temp  	
	
	suivant_indiceMin5:
	
	
		#--
		# if indiceMin==5
	ori $t4,$zero,5				# on prend la valeur 5
	bne $t8,$t4,suivant_indiceMin6		#on passe au prochain if
	
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
	add $s1,$t5,$t3				# récupère adresse temp1[i]			    
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	sw $t6,0($s1)				# stock la  valeur de temp[i] dans temp5[i]
	
	addi $t3,$t3,4				# 4*i
	addi $t1,$t1,1				# incrémentation i +1
	j boucle_indicemin5			# retour au bebut de la boucle
	
	fin_boucle_indicemin5:			# fin initialisation temp  	
	
	suivant_indiceMin6:
	
	
		#--
		# if indiceMin==6
	ori $t4,$zero,6				# on prend la valeur 6
	bne $t8,$t4,suivant_indiceMin7		#on passe au prochain if
	
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
	add $s1,$t5,$t3				# récupère adresse temp1[i]			    
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	sw $t6,0($s1)				# stock la  valeur de temp[i] dans temp6[i]
	
	addi $t3,$t3,4				# 4*i
	addi $t1,$t1,1				# incrémentation i +1
	j boucle_indicemin6			# retour au bebut de la boucle
	
	fin_boucle_indicemin6:			# fin initialisation temp  	
	
	suivant_indiceMin7:
	
	
	
		#--
		# if indiceMin==7
	ori $t4,$zero,7				# on prend la valeur 7
	bne $t8,$t4,suivant_indiceMin8		#on passe au prochain if
	
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
	add $s1,$t5,$t3				# récupère adresse temp1[i]			    
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	sw $t6,0($s1)				# stock la  valeur de temp[i] dans temp7[i]
	
	addi $t3,$t3,4				# 4*i
	addi $t1,$t1,1				# incrémentation i +1
	j boucle_indicemin7			# retour au bebut de la boucle
	
	fin_boucle_indicemin7:			# fin initialisation temp  	
	
	suivant_indiceMin8:
	
	
	
		#--
		# if indiceMin==8
	ori $t4,$zero,8				# on prend la valeur 8
	bne $t8,$t4,suivant_indiceMin9		#on passe au prochain if
	
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
	add $s1,$t5,$t3				# récupère adresse temp1[i]			    
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	sw $t6,0($s1)				# stock la  valeur de temp[i] dans temp8[i]
	
	addi $t3,$t3,4				# 4*i
	addi $t1,$t1,1				# incrémentation i +1
	j boucle_indicemin8			# retour au bebut de la boucle
	
	fin_boucle_indicemin8:			# fin initialisation temp  	
	
	suivant_indiceMin9:
	
	
	
		#--
		# if indiceMin==9
	ori $t4,$zero,9				# on prend la valeur 8
	bne $t8,$t4,suivant_fin		#on passe au prochain if
	
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
	add $s1,$t5,$t3				# récupère adresse temp1[i]			    
	lw $t6,0($t6)				# récupère valeur de l'adresse temp[i]
	sw $t6,0($s1)				# stock la  valeur de temp[i] dans temp9[i]
	
	addi $t3,$t3,4				# 4*i
	addi $t1,$t1,1				# incrémentation i +1
	j boucle_indicemin9			# retour au bebut de la boucle
	
	fin_boucle_indicemin9:			# fin initialisation temp  	
	
	suivant_fin:
	#on rempli avec le nombre de recurence du mot
	la $t8,TabInt				# chargement adresse tabint , indicemin , temp_int
	la $t1,indiceMin
	la $t2,temp_int
	
	lw $t2,0($t2)				# charge la valeur de temp_int
	lw $t1,0($t1)				# charge la valeur de indicemin
	
	ori $a0,$zero,15
	ori $v0,$zero,1
	syscall
	
	
	ori $t3,$zero,4
	mul $t1,$t1,$t3				#indicemin *4 pour avoir la position du nouveau mot
	add $t8,$t8,$t1				# adresse de TabInt[indiceMin]
	sw $t2,0($t8)				# on donne la valeur TabInt[indiceMin] = temp_int
	
	fin_if_mot_existant:
	#fin de creation du mot dans le tableau
	
	#---- reinitialisation des variable
	la $t8,min				# chargement adresse min , existe , temp_int
	la $t1,existe
	la $t2,temp_int
	
	ori $t3,$zero,999			#on va reinitialiser min a 999
	sw $t3,0($t8)
	
	ori $t3,$zero,0			#on va reinitialiser existe a 0
	sw $t3,0($t1)
	
	ori $t3,$zero,0			#on va reinitialiser temp_int a 0
	sw $t3,0($t2)
	
	
	
	addi $t0,$t0,1				# incrémentation 1er for
	j grand_tour_f7				# retour sur le 1er for alias grand_tour
	
	
	fin_programme_f7:
	
	
	debut_dernier_for_f7:	
	la $t4,message_final			# charge msg à afficher
	la $t5,TabInt				# charge adresse 
	lw $t6,0($t5)				# charge valeur de TabInt
	
	# temp 0
	la $t2,temp0
	lw $t2,0($t2)
	# affichage nb de fois
	ori $a0,$t6,0
	ori $v0,$zero,1
	syscall			
	#affichage texte
	la $a0,message_final			
    	ori $v0,$zero,4
        syscall
	# affichage mot
	ori $a0,$t2,0
	ori $v0,$zero,1
        syscall									
																												
	# temp 1
	lw $t6,4($t5)				# charge valeur de TabInt
	la $t2,temp1
	lw $t2,0($t2)
	# affichage nb de fois
	ori $a0,$t6,0
	ori $v0,$zero,1
	syscall			
	#affichage texte
	la $a0,message_final			
    	ori $v0,$zero,4
        syscall
	# affichage mot
	ori $a0,$t2,0
	ori $v0,$zero,1
        syscall	
	
	# temp 2
	lw $t6,8($t5)				# charge valeur de TabInt
	la $t2,temp2
	lw $t2,0($t2)
	# affichage nb de fois
	ori $a0,$t6,0
	ori $v0,$zero,1
	syscall			
	#affichage texte
	la $a0,message_final			
    	ori $v0,$zero,4
        syscall
	# affichage mot
	ori $a0,$t2,0
	ori $v0,$zero,1
        syscall	
	
	# temp 3
	lw $t6,12($t5)				# charge valeur de TabInt
	la $t2,temp3
	lw $t2,0($t2)
	# affichage nb de fois
	ori $a0,$t6,0
	ori $v0,$zero,1
	syscall			
	#affichage texte
	la $a0,message_final			
    	ori $v0,$zero,4
        syscall
	# affichage mot
	ori $a0,$t2,0
	ori $v0,$zero,1
        syscall	
	
	# temp 4
	lw $t6,16($t5)				# charge valeur de TabInt
	la $t2,temp4
	lw $t2,0($t2)
	# affichage nb de fois
	ori $a0,$t6,0
	ori $v0,$zero,1
	syscall			
	#affichage texte
	la $a0,message_final			
    	ori $v0,$zero,4
        syscall
	# affichage mot
	ori $a0,$t2,0
	ori $v0,$zero,1
        syscall	

	# temp 5
	lw $t6,20($t5)				# charge valeur de TabInt
	la $t2,temp5
	lw $t2,0($t2)
	# affichage nb de fois
	ori $a0,$t6,0
	ori $v0,$zero,1
	syscall			
	#affichage texte
	la $a0,message_final			
    	ori $v0,$zero,4
        syscall
	# affichage mot
	ori $a0,$t2,0
	ori $v0,$zero,1
        syscall	

	# temp 6
	lw $t6,24($t5)				# charge valeur de TabInt
	la $t2,temp6
	lw $t2,0($t2)
	# affichage nb de fois
	ori $a0,$t6,0
	ori $v0,$zero,1
	syscall			
	#affichage texte
	la $a0,message_final			
    	ori $v0,$zero,4
        syscall
	# affichage mot
	ori $a0,$t2,0
	ori $v0,$zero,1
        syscall	

	# temp 7
	lw $t6,28($t5)				# charge valeur de TabInt
	la $t2,temp7
	lw $t2,0($t2)
	# affichage nb de fois
	ori $a0,$t6,0
	ori $v0,$zero,1
	syscall			
	#affichage texte
	la $a0,message_final			
    	ori $v0,$zero,4
        syscall
	# affichage mot
	ori $a0,$t2,0
	ori $v0,$zero,1
        syscall	

	# temp 8
	lw $t6,32($t5)				# charge valeur de TabInt
	la $t2,temp8
	lw $t2,0($t2)
	# affichage nb de fois
	ori $a0,$t6,0
	ori $v0,$zero,1
	syscall			
	#affichage texte
	la $a0,message_final			
    	ori $v0,$zero,4
        syscall
	# affichage mot
	ori $a0,$t2,0
	ori $v0,$zero,1
        syscall	

	# temp 9
	lw $t6,36($t5)				# charge valeur de TabInt
	la $t2,temp9
	lw $t2,0($t2)
	# affichage nb de fois
	ori $a0,$t6,0
	ori $v0,$zero,1
	syscall			
	#affichage texte
	la $a0,message_final			
    	ori $v0,$zero,4
        syscall
	# affichage mot
	ori $a0,$t2,0
	ori $v0,$zero,1
        syscall	


	lw $fp,4($sp)				# epilogue
	addu $sp,$sp,8
	jr $ra