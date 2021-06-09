//
//  main.c
//  贪吃蛇
//
//  Created by Tetsu's MacBook Pro with Retina Display on 13-12-3.
//  Copyright (c) 2013年 Tetsu's MacBook Pro with Retina Display. All rights reserved.
//

#include <stdio.h>
#include<stdlib.h>
void Gotoxy(x,y);
void HideCursor();
void food();//产生食物
void yidong();/////////具体游戏过程
void bk();////////////////制作边框
//依次是蛇头横坐标，纵坐标，方向，a[0]，b[0]是第二个点坐标，然后a[1]，
//b[1]是第三个，cd长度，A随机数，k1随机数，z1，循环控制，速度，蛇活着0；
int key,i=20,k=20,fx,a[60],b[60],cd,A,k1,z1=1,I,sd=200,live=0;
void main()
{ HideCursor();//隐藏光标
    
    system("title 按左键开始");//标题
    bk();
    Gotoxy(i,k);
    printf("●");
    fx=getch();////////////调试出来的。。按左下右开始
    for(I=1;I<60;I++)
    {
        food();
        yidong(I);
        
        if(i>=78||k>=23||i<=0||k<=0||live==1)///////////////////////////判断蛇生死
        { Gotoxy(35,11);
            printf("%d0分\n",cd);///////////分数
            break;
        }
    }
}
void Gotoxy(int x, int y) //移动光标
{
    HANDLE hout; //定义句柄变量hout
    COORD coord; //定义结构体coord
    coord.X = x;
    coord.Y = y;
    hout = GetStdHandle(STD_OUTPUT_HANDLE); //获得标准输出（屏幕）句柄
    SetConsoleCursorPosition(hout, coord); //移动光标
}
void HideCursor() //隐藏光标
{
    CONSOLE_CURSOR_INFO cursor_info = {1, 0}; //后边的0代表光标不可见
    SetConsoleCursorInfo(GetStdHandle(STD_OUTPUT_HANDLE), &cursor_info);
}
void food()
{
    unsigned int seed;
    
    seed=I;
    srand((unsigned)time (NULL) ); //////////这个是产生不同的种子吧。
    k1 = rand() % 22; /*产生22以内的随机整数*/
    A = rand() % 36;
    Gotoxy(A*2+2,k1+1);
    z1=A*2+2;
    printf("●");
}
void yidong(int Q)
{ for(;;)
{ Sleep(sd);
    
    cd=Q;
    for(;cd>1;cd--)
    { a[cd-1]=a[cd-2];b[cd-1]=b[cd-2];
    }
    
    a[0]=i;b[0]=k;
    
    while(kbhit()!=0)key=getch();///////////这个半懂，大概是获取输入而且执行其他语句
    if(abs(key%10-fx%10)!=2)//////////不能走相反方向
        fx=key;
    
    switch(fx)//上下左右
    { case 72: --k;break;
        case 80: ++k;break;
        case 75: i-=2;break;
        case 77: i+=2;break;
    }
    
    Gotoxy(i,k);
    printf("●");
    cd=Q;
    for(;cd>1;cd--)///////这个要理解，这个很关键
    { live=i==a[cd-1]&&k==b[cd-1];
        if(live==1)///////////////////////////判断是否吃自己
            break;
    }
    if(live==1)////////////////////////////判断是否吃自己
        break;
    cd=Q;//为下面重新赋值
    Gotoxy(a[cd-1],b[cd-1]);//移到蛇头前cd%次走过的点
    printf(" ");
    if(i==z1&&k==k1+1)///////////判断蛇是否吃了食物
    { sd=sd*2/3+35;break;}
    if(i>=78||k>=23||i<=0||k<=0)//////判断蛇是否出界
        break;
}
}
void bk()/////////////////////////////////////////////边框
{ int i,k;
    for(i=0;i<79;)
    { 
        Gotoxy(i,0);
        printf("■");
        i=i+2;
    }
    for(k=0;k<24;)
    { 
        Gotoxy(0,k);
        printf("■");
        k++;
    }
    for(i=0;i<79;)
    { 
        Gotoxy(i,k-1);
        printf("■");
        i=i+2;
    }
    
    for(k=0;k<24;)
    { Gotoxy(i-2,k);
        printf("■");
        k++;
    }
    Gotoxy(0,0);
}