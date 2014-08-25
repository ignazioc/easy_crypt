//
//  main.m
//  easy_crypt
//
//  Created by Ignazio Calo on 25/08/14.
//  Copyright (c) 2014 Ignazio Calò. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RNCryptor/RNEncryptor.h>
#import <RNCryptor/RNDecryptor.h>

int main(int argc, const char * argv[])
{
    
    @autoreleasepool {
        if (argc != 4) {
            NSLog(@"Please use: %@ d|e password filename", @"easy_crypt");
            exit(1);
        }
        BOOL decrypt = FALSE;
        
        if (strcmp(argv[1], "d") == 0 ) {
            decrypt = TRUE;
        }
        
        NSString *password = [NSString stringWithUTF8String:argv[2]];
        NSString *inputFileName = [NSString stringWithUTF8String:argv[3]];
        
        NSData *data = [NSData dataWithContentsOfFile:inputFileName];
        
        NSError *error = nil;
        
        
        if (decrypt) {
            NSData *encryptedData = [RNDecryptor decryptData:data
                                                withPassword:password
                                                       error:&error];
            
            if (error) {
                NSLog(@"Error: %@", [error localizedDescription]);
                exit(2);
            } else {
                NSString *outputFileName = [inputFileName stringByAppendingPathExtension:@"dec"];
                [encryptedData writeToFile:outputFileName  atomically:YES];
            }
            
        } else {
            NSData *encryptedData = [RNEncryptor encryptData:data
                                                withSettings:kRNCryptorAES256Settings
                                                    password:password
                                                       error:&error];
            if (error) {
                NSLog(@"Error: %@", [error localizedDescription]);
                exit(2);
            } else {
                NSString *outputFileName = [inputFileName stringByAppendingPathExtension:@"enc"];
                [encryptedData writeToFile:outputFileName  atomically:YES];
            }
            
        }
        
        
    }
    return 0;
}

