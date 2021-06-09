//
//  main.c
//  判断字符类型
//
//  Created by Tetsu's MacBook Pro with Retina Display on 13-12-3.
//  Copyright (c) 2013年 Tetsu's MacBook Pro with Retina Display. All rights reserved.
//

#include <stdio.h>

int main()
{
    char c;
    c = getchar();
    if(c>='0'&&c<='9') printf("figures\n");
    else if(c>='a'&&c<='z') printf("small letters\n");
    else if(c>='A'&&c<='z') printf("capital letters\n");
    else printf("others\n");
    return 0;
}

