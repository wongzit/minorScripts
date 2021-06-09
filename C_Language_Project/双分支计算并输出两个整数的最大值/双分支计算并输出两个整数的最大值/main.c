//
//  main.c
//  双分支计算并输出两个整数的最大值
//
//  Created by Tetsu's MacBook Pro with Retina Display on 13-11-27.
//  Copyright (c) 2013年 Tetsu's MacBook Pro with Retina Display. All rights reserved.
//

#include <stdio.h>

int main(int argc, const char * argv[])
{
    int a,b,max;
    printf("Input a,b:");
    scanf("%d,%d",&a,&b);
    if(a>b) max = a;
    else max = b;/* 相当于a<=b */
    printf("max = %d",max);
    return 0;
}

