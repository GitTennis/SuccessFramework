//
//  NSObject+Description.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 6/4/14.
//  Copyright (c) 2015 Gytenis Mikulėnas
//  https://github.com/GitTennis/SuccessFramework
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE. All rights reserved.
//

#import "NSObject+Description.h"

#import <objc/runtime.h>

@implementation NSObject(Description)

#ifdef DEBUG

- (NSString *)description
{
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: %p>", NSStringFromClass([self class]), self];
    
    uint32_t ivarCount;
    Ivar *ivars = class_copyIvarList([self class], &ivarCount);
    
    if(ivars)
    {
        [description appendString:@"\n{"];
        
        for(uint32_t i=0; i<ivarCount; i++)
        {
            Ivar ivar = ivars[i];
            const char *ivarType = ivar_getTypeEncoding(ivar);
            id ivarObject = object_getIvar(self, ivar);
            
            [description appendFormat:@"\n   %s: ", ivar_getName(ivar)];
            
            // Default signed data types
            if(strcmp(ivarType, "c") == 0)
            {
                char character = (char)ivarObject;
                [description appendFormat:@"'%c'", character];
            }
            else if(strcmp(ivarType, "i") == 0 || strcmp(ivarType, "l") == 0) // l is also 32 bit in the 64 bit runtime environment
            {
                int integer = (int)ivarObject;
                [description appendFormat:@"%i", integer];
            }
            else if(strcmp(ivarType, "s") == 0)
            {
                short shortVal = (short)ivarObject;
                [description appendFormat:@"%i", (int)shortVal];
            }
            else if(strcmp(ivarType, "q") == 0)
            {
                long long longVal = (long long)ivarObject;
                [description appendFormat:@"%lld", longVal];
            }
            // Default unsigned data types
            else if(strcmp(ivarType, "C") == 0)
            {
                unsigned char chracter = (unsigned char)ivarObject;
                [description appendFormat:@"'%c'", chracter];
            }
            else if(strcmp(ivarType, "I") == 0 || strcmp(ivarType, "L") == 0)
            {
                unsigned int integer = (unsigned int)ivarObject;
                [description appendFormat:@"%u", integer];
            }
            else if(strcmp(ivarType, "S") == 0)
            {
                unsigned short shortVal = (unsigned short)ivarObject;
                [description appendFormat:@"%i", (int)shortVal];
            }
            else if(strcmp(ivarType, "Q") == 0)
            {
                unsigned long long longVal = (unsigned long long)ivarObject;
                [description appendFormat:@"%lld", longVal];
            }
            // Floats'n'stuff
            else if(strcmp(ivarType, "f") == 0)
            {
                float floatVal;
                memcpy(&floatVal, &ivarObject, sizeof(float));
                
                [description appendFormat:@"%f", floatVal];
            }
            else if(strcmp(ivarType, "d") == 0)
            {
                double doubleVal;
                memcpy(&doubleVal, &ivarObject, sizeof(double));
                
                [description appendFormat:@"%f", doubleVal];
            }
            // Boolean and pointer
            else if(strcmp(ivarType, "B") == 0)
            {
                BOOL booleanVal = (BOOL)ivarObject;
                [description appendFormat:@"%@", (booleanVal ? @"YES" : @"NO")];
            }
            else if(strcmp(ivarType, "v") == 0)
            {
                void *pointer = (void *)ivarObject;
                [description appendFormat:@"%p", pointer];
            }
            else if(strcmp(ivarType, "*") == 0 || strcmp(ivarType, ":") == 0) // SEL is just a typecast for a cstring
            {
                char *cstring = (char *)ivarObject;
                [description appendFormat:@"\"%s\"", cstring];
            }
            else if(strncmp(ivarType, "@", 1) == 0)
            {
                [description appendFormat:@"%@", ivarObject];
            }
            else if(strcmp(ivarType, "#") == 0)
            {
                Class objcClass = (Class)ivarObject;
                [description appendFormat:@"%s", class_getName(objcClass)];
            }
            else
                [description appendString:@"???"];
        }
        
        [description appendString:@"\n}"];
        free(ivars);
    }
    
    return description; 
}

#endif

@end
