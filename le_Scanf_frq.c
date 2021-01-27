#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// int main(int argc, char const *argv[])
// {

// 	int caractereActuel =0;
// 	int lastcaratere =0;
// 	int loop=0;

//     int TabInt[10] = {0};

//     char temp0[28]={0};
//     char temp1[28]={0};
//     char temp2[28]={0};
//     char temp3[28]={0};
//     char temp4[28]={0};
//     char temp5[28]={0};
//     char temp6[28]={0};
//     char temp7[28]={0};
//     char temp8[28]={0};
//     char temp9[28]={0};

//     char* TabChar[10] = {temp0,temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8,temp9};

//     char temp[28]={0};

//     char temp_char[28]={0};
//     int temp_int=0;

//     int tour = 0;
//     int existe = 0;
//     int min=999;
//     int indiceMin;
//     //int boucleTour=0;

// 	for (int big = 0; big < 66; ++big)
// 	{

// 		FILE* fichier = NULL;

// 	    fichier = fopen("test.txt", "r");

// 	    if (fichier == NULL)
// 	    {
// 	        printf("probleme\n");
// 	    }
	    
	        
//         //while(lastcaratere != EOF)
//         for (int irr = 0; irr < 40; ++irr)
//         {
        
        
//             //fscanf(fichier,"%s",temp);
//             for (int i2 = 0; i2 < 28; ++i2)
//             {
//             	temp[i2]=0;
//             }

//             loop=0;
//             lastcaratere=fgetc(fichier);

//             while((lastcaratere!='.')&&(lastcaratere!='!')&&(lastcaratere!='?')&&(lastcaratere!=' ')&&(lastcaratere!='\n')&&(lastcaratere!=','))
//             {
//             	caractereActuel = fgetc(fichier);
//             	temp[loop] = lastcaratere;
//             	lastcaratere = caractereActuel;
//             	loop++;
//                 printf("tab= %c , etait: %c\n",temp[loop-1],lastcaratere);
//             }                    
//             printf("pass scan\n");



//             for (int i = 0; i < 10; ++i)
//             {
//                 if (strcmp( temp, TabChar[i] ) == 0) //si il existe deja dans le tableau ou pas
//                 {
//                     TabInt[i] ++;
//                     existe = 1;
//                 }
//             }
//             printf("pass strcmp\n");



//             if (existe == 0) //existe pas donc
//             {
//                 for (int j = 0; j < 10; ++j)
//                  {
//                     if (TabInt[j] < min )	//on cherche celui qui est le moins present pour le remplacer
//                     {
//                         min = TabInt[j];
//                         indiceMin = j;
//                     }
//                  }
//                  strcpy(TabChar[indiceMin],temp);
//                  TabInt[indiceMin] = 1;
//             }

            
//             min =999;

//         }
//         existe = 0;


//         printf("goooood\n");
//         for (int i = 0; i < 10; ++i)
//         {
//             printf("%d de %s \n",TabInt[i] ,TabChar[i]);
//         }


//     fclose(fichier);
// 	}

// 	return 0;
// }















int main(int argc, char const *argv[])
{

	int caractereActuel =0;
	int lastcaratere =0;
	int loop=0;

    int TabInt[10] = {0};

    char temp0[28]={0};
    char temp1[28]={0};
    char temp2[28]={0};
    char temp3[28]={0};
    char temp4[28]={0};
    char temp5[28]={0};
    char temp6[28]={0};
    char temp7[28]={0};
    char temp8[28]={0};
    char temp9[28]={0};

    char* TabChar[10] = {temp0,temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8,temp9};

    char temp[28]={0};

    char temp_char[28]={0};
    int temp_int=0;

    int tour = 0;
    int existe = 0;
    int min=999;
    int indiceMin;
    //int boucleTour=0;


    	FILE* fichier = NULL;

	    fichier = fopen("test.txt", "r");

	    if (fichier == NULL)
	    {
	        printf("probleme\n");
	    }



	for (int big = 0; big < 66; ++big)//grand tour
	{

	    fscanf(fichier,"%s",temp);
	    printf("le temp %s\n", temp);



	    FILE* fichier2 = NULL;

	    fichier2 = fopen("test.txt", "r");

	    if (fichier2 == NULL)
	    {
	        printf("probleme\n");
	    }


        //while(lastcaratere != EOF)
        for (int irr = 0; irr < 66; ++irr)
        {
	    	fscanf(fichier2,"%s",temp_char);
	    	//printf("le temp2 %s\n", temp_char);

        	if (strcmp( temp, temp_char ) == 0) //si il existe deja dans le tableau ou pas
         	{
            	temp_int ++;
         	}
        }
        printf("le nombre %d \n",temp_int );
          
        fclose(fichier2);


        for (int j = 0; j < 10; ++j)
        {
            if (TabInt[j] < min )	//on cherche celui qui est le moins present pour le remplacer
            {
                min = TabInt[j];
                indiceMin = j;
            }
        }
        for (int j2 = 0; j2 < 10; ++j2)
        {
            if (strcmp( temp, TabChar[j2] ) == 0)//on cherche si il est present
            {
            	existe=1;	
            }
        }
        if (existe==0)
        {       	
        	strcpy(TabChar[indiceMin],temp);//on le mes dans le tableeau
         	TabInt[indiceMin] = temp_int;
        }
        min=999;

        temp_int=0;
        
    }
    
          


        printf("goooood\n");
        for (int i = 0; i < 10; ++i)
        {
            printf("%d de %s \n",TabInt[i] ,TabChar[i]);
        }


    fclose(fichier);
	

	return 0;
}