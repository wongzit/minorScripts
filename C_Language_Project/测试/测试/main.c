//
//  main.c
//  测试
//
//  Created by Tetsu on 14-3-30.
//  Copyright (c) 2014年 Tetsu. All rights reserved.
//

#include <stdio.h>

int main()
{
    int a[100],b[100],c[100],i,j,k,l,temp,m,n,p;
    int find = 0;
    i = 0;
    do{
        scanf("%d",&a[i]);
        scanf("%d",&b[i]);
        i++;
    }while(a[i]>=0&&b[i]>=0);
    scanf("%d",&n);
    for(j = 0;j < i-2;j++)
        c[j] = b[j];
    for(k = 1;k < i-2;k++)
        for(l = 0;l < i-3;l++)
            if(c[l+1]<c[l])
            {
                temp = c[l+1];
                c[l+1] = c[l];
                c[l] = temp;
            }
    for(m = i-2;m >= 0;m--)
        printf("%d",c[m]);
    for(p = 0;p < i-2;p++)
    {
        if(n==a[p])
            find = 1;
        if(find)
            find = p;
    }
    printf("%d",b[p]);
    return 0;
}

