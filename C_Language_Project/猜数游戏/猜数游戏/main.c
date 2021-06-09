//
//  main.c
//  猜数游戏
//
//  Created by Tetsu's MacBook Pro with Retina Display on 13-12-12.
//  Copyright (c) 2013年 Tetsu's MacBook Pro with Retina Display. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main()
{
    int guess,magic,count = 0,ret;
    char reply;
    srand(time(NULL));
    do{
        magic = rand()%100+1;
        do{
            printf("Please guess a magic munber:");
            scanf("%d",&guess);
            while(ret != 1)
            {
                while(getchar()!='\n');
                printf(“Please guess a magic number:”);
                ret = scanf("%d",&guess);
            }
            count++;
            if(guess>magic)
                printf("Wrong!Too big!\n");
            else if(guess<magic)
                printf("Wrong!Too small!\n");
            else
                printf("Right!\n");
        }while(guess!=magic&&count<10);
        printf("count = %d",count);
        printf("Do you want to continue(Y/N)or(y/n)?");
        scanf("%c",&reply);
    }while(reply == 'Y'||reply == 'y')；
    return 0;
}

