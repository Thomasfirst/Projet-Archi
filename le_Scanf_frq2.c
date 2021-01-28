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

    //int tour = 0;
    int existe = 0;
    int min=999;
    int indiceMin;
    //int boucleTour=0;

    int comp =0;


    	FILE* fichier = NULL;

	    fichier = fopen("test.txt", "r");

	    if (fichier == NULL)
	    {
	        printf("probleme\n");
	    }



	for (int big = 0; big < 46; ++big)//grand tour
	{

	    //fscanf(fichier,"%s",temp);
        for (int i2 = 0; i2 < 28; ++i2)
        {
            temp[i2]=0;
        }

        loop=0;
        lastcaratere=fgetc(fichier);

        for (int i = 0; i < 4; ++i)
        {
            if ((lastcaratere=='.')||(lastcaratere=='!')||(lastcaratere=='?')||(lastcaratere==' ')||(lastcaratere=='\n')||(lastcaratere==','))
            {
                lastcaratere=fgetc(fichier);
            }
        }


        while((lastcaratere!='.')&&(lastcaratere!='!')&&(lastcaratere!='?')&&(lastcaratere!=' ')&&(lastcaratere!='\n')&&(lastcaratere!=','))
        {
            caractereActuel = fgetc(fichier);
            temp[loop] = lastcaratere;
            lastcaratere = caractereActuel;
            loop++;
            
            //printf("tab= %c , etait: %c\n",temp[loop-1],lastcaratere);
        }                    
	    printf("le temp %s\n", temp);



	    FILE* fichier2 = NULL;

	    fichier2 = fopen("test.txt", "r");

	    if (fichier2 == NULL)
	    {
	        printf("probleme\n");
	    }


        //while(lastcaratere != EOF)
        for (int irr = 0; irr < 46; ++irr)
        {
	    	//fscanf(fichier2,"%s",temp_char);
            for (int i2 = 0; i2 < 28; ++i2)
            {
             temp_char[i2]=0;
            }

            loop=0;
            lastcaratere=fgetc(fichier2);
            for (int i = 0; i < 4; ++i)
            {
                if ((lastcaratere=='.')||(lastcaratere=='!')||(lastcaratere=='?')||(lastcaratere==' ')||(lastcaratere=='\n')||(lastcaratere==','))
                {
                    lastcaratere=fgetc(fichier2);
                }
            }

            while((lastcaratere!='.')&&(lastcaratere!='!')&&(lastcaratere!='?')&&(lastcaratere!=' ')&&(lastcaratere!='\n')&&(lastcaratere!=','))
            {
                caractereActuel = fgetc(fichier2);
                temp_char[loop] = lastcaratere;
                lastcaratere = caractereActuel;
                loop++;
                //printf("tab= %c , etait: %c\n",temp[loop-1],lastcaratere);
            }

	    	printf("le temp2 %s\n", temp_char);



            comp=0;
            for (int i = 0; i < 28; ++i)
            {
                if(temp[i]==temp_char[i])
                {
                    comp++;
                }
            }
        	if (comp == 28)    //strcmp( temp, temp_char ) == 0) //si il existe deja dans le tableau ou pas
         	{
            	temp_int ++;
         	}
        }
        printf("le nombre %d \n",temp_int );
          
        fclose(fichier2);



        // for (int j = 0; j < 10; ++j)
        // {
        //     if (TabInt[j] < min )	//on cherche celui qui est le moins present pour le remplacer
        //     {
        //         min = TabInt[j];
        //         indiceMin = j;
        //     }

        //     if (strcmp( temp, TabChar[j] ) == 0) //on cherche si il est present
        //     {
        //     	existe=1;	
        //     }
        // }
        // if ((existe==0)&&(TabInt[indiceMin] < temp_int))
        // {   
        //     strcpy(TabChar[indiceMin],temp);//on le mes dans le tableeau
        //     TabInt[indiceMin] = temp_int;
        // }

        // min=999;

        // temp_int=0;
        // existe=0;

//-----------
            comp=0;//comparaison
            for (int i = 0; i < 28; ++i)
            {
                if(temp[i]==temp0[i])
                {
                    comp++;
                }
            }
            if (comp == 28)    
            {
                existe=1;
            }
            comp=0;//comparaison
            for (int i = 0; i < 28; ++i)
            {
                if(temp[i]==temp1[i])
                {
                    comp++;
                }
            }
            if (comp == 28)    
            {
                existe=1;
            }
            comp=0;//comparaison
            for (int i = 0; i < 28; ++i)
            {
                if(temp[i]==temp2[i])
                {
                    comp++;
                }
            }
            if (comp == 28)    
            {
                existe=1;
            }
            comp=0;//comparaison
            for (int i = 0; i < 28; ++i)
            {
                if(temp[i]==temp3[i])
                {
                    comp++;
                }
            }
            if (comp == 28)    
            {
                existe=1;
            }
            comp=0;//comparaison
            for (int i = 0; i < 28; ++i)
            {
                if(temp[i]==temp4[i])
                {
                    comp++;
                }
            }
            if (comp == 28)    
            {
                existe=1;
            }
            comp=0;//comparaison
            for (int i = 0; i < 28; ++i)
            {
                if(temp[i]==temp5[i])
                {
                    comp++;
                }
            }
            if (comp == 28)    
            {
                existe=1;
            }
            comp=0;//comparaison
            for (int i = 0; i < 28; ++i)
            {
                if(temp[i]==temp6[i])
                {
                    comp++;
                }
            }
            if (comp == 28)    
            {
                existe=1;
            }
            comp=0;//comparaison
            for (int i = 0; i < 28; ++i)
            {
                if(temp[i]==temp7[i])
                {
                    comp++;
                }
            }
            if (comp == 28)    
            {
                existe=1;
            }
            comp=0;//comparaison
            for (int i = 0; i < 28; ++i)
            {
                if(temp[i]==temp8[i])
                {
                    comp++;
                }
            }
            if (comp == 28)    
            {
                existe=1;
            }
            comp=0;//comparaison
            for (int i = 0; i < 28; ++i)
            {
                if(temp[i]==temp9[i])
                {
                    comp++;
                }
            }
            if (comp == 28)    
            {
                existe=1;
            }
//--------------
            for (int j = 0; j < 10; ++j)
            {
                if (TabInt[j] < min )    //on cherche celui qui est le moins present pour le remplacer
                {
                    min = TabInt[j];
                    indiceMin = j;
                }
            }
//--------------
            if ((existe==0)&&(TabInt[indiceMin] < temp_int))
            {   
                //strcpy(TabChar[indiceMin],temp);//on le mes dans le tableeau
                if (indiceMin==0)
                {
                    for (int it = 0; it < 28; ++it)
                    {
                        temp0[it]=temp[it];
                    }
                }
                if (indiceMin==1)
                {
                    for (int it = 0; it < 28; ++it)
                    {
                        temp1[it]=temp[it];
                    }
                }
                if (indiceMin==2)
                {
                    for (int it = 0; it < 28; ++it)
                    {
                        temp2[it]=temp[it];
                    }
                }
                if (indiceMin==3)
                {
                    for (int it = 0; it < 28; ++it)
                    {
                        temp3[it]=temp[it];
                    }
                }
                if (indiceMin==4)
                {
                    for (int it = 0; it < 28; ++it)
                    {
                        temp4[it]=temp[it];
                    }
                }
                if (indiceMin==5)
                {
                    for (int it = 0; it < 28; ++it)
                    {
                        temp5[it]=temp[it];
                    }
                }
                if (indiceMin==6)
                {
                    for (int it = 0; it < 28; ++it)
                    {
                        temp6[it]=temp[it];
                    }
                }
                if (indiceMin==7)
                {
                    for (int it = 0; it < 28; ++it)
                    {
                        temp7[it]=temp[it];
                    }
                }
                if (indiceMin==8)
                {
                    for (int it = 0; it < 28; ++it)
                    {
                        temp8[it]=temp[it];
                    }
                }
                if (indiceMin==9)
                {
                    for (int it = 0; it < 28; ++it)
                    {
                        temp9[it]=temp[it];
                    }
                }
                TabInt[indiceMin] = temp_int;
            }

            min=999;

            temp_int=0;
            existe=0;
//----------------------

        
    }
    
          


        printf("goooood\n");
        for (int i = 0; i < 10; ++i)
        {
            printf("%d de %s \n",TabInt[i] ,TabChar[i]);
        }


    fclose(fichier);
	

	return 0;
}