#include <stdio.h>
#include <stdlib.h>
#include <string.h>


void statisque(){
    FILE* fichier = NULL;

    fichier = fopen("test.txt", "r");

    int TabInt[10] = {0};

    char temp0[28];
    char temp1[28];
    char temp2[28];
    char temp3[28];
    char temp4[28];
    char temp5[28];
    char temp6[28];
    char temp7[28];
    char temp8[28];
    char temp9[28];

    char* TabChar[10] = {temp0,temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8,temp9};

    char temp[28];

    int tour = 0;
    int existe = 0;
    int min=99;
    int indiceMin;
   // char end[28]= "\0";

    if (fichier == NULL){
        printf("YOUSK2\n");
    }
    
        //while (strcmp( temp, end ) != 0)
        while( feof(fichier)==0 )
        //for (int irr = 0; irr < 20; ++irr)
        {
            fscanf(fichier,"%s",temp);
            for (int i = 0; i < 10; ++i)
            {
                if (strcmp( temp, TabChar[i] ) == 0)
                {
                    TabInt[i] ++;
                    existe = 1;
                }
            }
            if (existe == 0)
            {
                for (int j = 0; j < 10; ++j)
                 {
                    if (TabInt[j] < min )
                    {
                        min = TabInt[j];
                        indiceMin = j;
                    }
                 }
                 //TabChar[min] = temp;
                 strcpy(TabChar[indiceMin],temp);
                 TabInt[indiceMin] = 1;
                
            }

            existe = 0;
            tour++;
            min =99;
        }

        for (int i = 0; i < 10; ++i)
        {
            printf("%d de %s \n",TabInt[i] ,TabChar[i]);
        }

    fclose(fichier);

}



int main()
{
    FILE* fichier = NULL;
    int NbCaracLigne = 100;
    int NbLignesPage = 20;
    int caractereActuel = 0;
    int lastCaracter = 0;

    int NbLignes = 0;
    int NbPages = 0;
    int NbPhrases = 0;
    int NbMots = 0;

    int TempLigne = 0;
    int TempPage = 0;

 
    fichier = fopen("Marseillaise.txt", "r");
 
    if (fichier != NULL)
    {
        while (caractereActuel != EOF)          // Boucle de lecture des caractères un à un
        {
            caractereActuel = fgetc(fichier);   // On lit le caractère

            if ((caractereActuel=='\n')||(TempLigne==NbCaracLigne))     //Compteur de lignes
            {
            	NbLignes+=1;
            	TempLigne=0;
            	TempPage+=1;
            }

            if (TempPage==NbLignesPage)                                 //Compteur de pages
            {
            	NbPages+=1;
            	TempPage=0;
            }

            if ((caractereActuel=='.')||(caractereActuel=='!')||(caractereActuel=='?'))     //Compteur de phrases
            {
                NbPhrases+=1;
            }

            if ((caractereActuel=='.')||(caractereActuel==' ')||(caractereActuel=='\n'))    //Compteur de mots
            {
                if ((caractereActuel=='\n'))
                {
                    if ((lastCaracter!='?')&&(lastCaracter!='!')&&(lastCaracter!='\n'))
                                                            //attention quand on saute une ligne ne pas confondre le dernier caratere
                    {
                        NbMots+=1;
                    }
                }
                else if ((lastCaracter!='!')&&(lastCaracter!='?')&&(lastCaracter!=' ')&&(lastCaracter!=';'))    // '!' '?' ';'' ' ' ne sont pas des mots 
                {
                    NbMots+=1;
                }
            }
            //printf("%c ---mot %d\n", caractereActuel,NbMots);

            lastCaracter=caractereActuel;

        } // On continue tant que fgetc n'a pas retourné EOF (fin de fichier)

 		NbLignes+=1;	//Pour compter la derniere ligne    40

        fclose(fichier);

        printf("Le fichier a %d lignes.\nEt il a %d pages.\nEt il a %d phrases\nEt il a %d mots.\n", NbLignes, NbPages, NbPhrases,NbMots);
    }
 

    statisque();

    return 0;
}

//    java -jar Mars4_5.jar &
