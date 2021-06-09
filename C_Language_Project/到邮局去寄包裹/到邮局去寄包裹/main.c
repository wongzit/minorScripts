//
//  main.c
//  到邮局去寄包裹
//
//  Created by Tetsu's MacBook Pro with Retina Display on 13-12-2.
//  Copyright (c) 2013年 Tetsu's MacBook Pro with Retina Display. All rights reserved.
//

#include <stdio.h>

int main(int argc, const char * argv[])
{

    double l,k,h,w,p;
    scanf("%lf,%lf,%lf,%lf",&l,&k,&h,&w);
    if(l>1||k>1||h>1||w>30)
    {
        printf("Error\n");
    }
    else if(w<10)
    {
        p = 0.80*w+0.2;
        printf("%.2lf\n",p);
    }
    else if(w>=10&&w<20)
    {
        p = w*0.75+0.2;
        printf("%.2lf\n",p);
    }
    else if(w>=20&&w<30)
    {
        p = 0.70*w+0.2;
        printf("%.2lf\n",p);
    }
    return 0;
}

