//
//  RNIndyTests.m
//  testlibvcx
//
//  Created by Norman Jarvis on 7/25/18.
//  Copyright © 2018 Norman Jarvis. All rights reserved.
//

#import "RNIndyTests.h"

@implementation RNIndyTests

+(void)startFreshAndGeneratePassphrase:(RNIndy*)indy
                   completion:(void (^)(BOOL success))successful
{
    __block BOOL finishedSuccessfully = YES;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMMdd_HH_mm"];
        NSDate *currentDate = [NSDate date];
        NSString *dateString = [formatter stringFromDate:currentDate];
        NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *walletName = [NSString stringWithFormat:@"1ae57347-1a55-45c4-329d-fbbc3bd05366-%@-cm-wallet", dateString];
        //__unsafe_unretained typeof(RNIndy*) localIndy = indy;
        RNIndy* localIndy = indy;

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, kNilOptions), ^{

            NSString* walletKey = [localIndy createWalletKey:64];
            NSLog(@"walletKey is: %@", walletKey);

            [localIndy createOneTimeInfo:[NSString stringWithFormat:@"{\"agency_url\":\"http://agency.pps.evernym.com\",\"agency_did\":\"3mbwr7i85JNSL3LoNQecaW\",\"agency_verkey\":\"2WXxo6y1FJvXWgZnoYUP5BJej2mceFrqBDNPE3p6HDPf\",\"wallet_name\":\"%@\",\"wallet_key\":\"%@\",\"agent_seed\":null,\"enterprise_seed\":null}", walletName, walletKey] completion:^(BOOL success){ NSLog(@"createOneTimeInfo is successful: %@", success ? @"true" : @"false"); if(!success) { finishedSuccessfully = NO; }

                NSString* genesisPathForTest = [localIndy getGenesisPathWithConfig:@"{\"reqSignature\":{},\"txn\":{\"data\":{\"data\":{\"alias\":\"australia\",\"client_ip\":\"52.64.96.160\",\"client_port\":\"9702\",\"node_ip\":\"52.64.96.160\",\"node_port\":\"9701\",\"services\":[\"VALIDATOR\"]},\"dest\":\"UZH61eLH3JokEwjMWQoCMwB3PMD6zRBvG6NCv5yVwXz\"},\"metadata\":{\"from\":\"3U8HUen8WcgpbnEz1etnai\"},\"type\":\"0\"},\"txnMetadata\":{\"seqNo\":1,\"txnId\":\"c585f1decb986f7ff19b8d03deba346ab8a0494cc1e4d69ad9b8acb0dfbeab6f\"},\"ver\":\"1\"}\n{\"reqSignature\":{},\"txn\":{\"data\":{\"data\":{\"alias\":\"brazil\",\"client_ip\":\"54.233.203.241\",\"client_port\":\"9702\",\"node_ip\":\"54.233.203.241\",\"node_port\":\"9701\",\"services\":[\"VALIDATOR\"]},\"dest\":\"2MHGDD2XpRJohQzsXu4FAANcmdypfNdpcqRbqnhkQsCq\"},\"metadata\":{\"from\":\"G3knUCmDrWd1FJrRryuKTw\"},\"type\":\"0\"},\"txnMetadata\":{\"seqNo\":2,\"txnId\":\"5c8f52ca28966103ff0aad98160bc8e978c9ca0285a2043a521481d11ed17506\"},\"ver\":\"1\"}\n{\"reqSignature\":{},\"txn\":{\"data\":{\"data\":{\"alias\":\"canada\",\"client_ip\":\"52.60.207.225\",\"client_port\":\"9702\",\"node_ip\":\"52.60.207.225\",\"node_port\":\"9701\",\"services\":[\"VALIDATOR\"]},\"dest\":\"8NZ6tbcPN2NVvf2fVhZWqU11XModNudhbe15JSctCXab\"},\"metadata\":{\"from\":\"22QmMyTEAbaF4VfL7LameE\"},\"type\":\"0\"},\"txnMetadata\":{\"seqNo\":3,\"txnId\":\"408c7c5887a0f3905767754f424989b0089c14ac502d7f851d11b31ea2d1baa6\"},\"ver\":\"1\"}\n{\"reqSignature\":{},\"txn\":{\"data\":{\"data\":{\"alias\":\"england\",\"client_ip\":\"52.56.191.9\",\"client_port\":\"9702\",\"node_ip\":\"52.56.191.9\",\"node_port\":\"9701\",\"services\":[\"VALIDATOR\"]},\"dest\":\"DNuLANU7f1QvW1esN3Sv9Eap9j14QuLiPeYzf28Nub4W\"},\"metadata\":{\"from\":\"NYh3bcUeSsJJcxBE6TTmEr\"},\"type\":\"0\"},\"txnMetadata\":{\"seqNo\":4,\"txnId\":\"d56d0ff69b62792a00a361fbf6e02e2a634a7a8da1c3e49d59e71e0f19c27875\"},\"ver\":\"1\"}\n{\"reqSignature\":{},\"txn\":{\"data\":{\"data\":{\"alias\":\"korea\",\"client_ip\":\"52.79.115.223\",\"client_port\":\"9702\",\"node_ip\":\"52.79.115.223\",\"node_port\":\"9701\",\"services\":[\"VALIDATOR\"]},\"dest\":\"HCNuqUoXuK9GXGd2EULPaiMso2pJnxR6fCZpmRYbc7vM\"},\"metadata\":{\"from\":\"U38UHML5A1BQ1mYh7tYXeu\"},\"type\":\"0\"},\"txnMetadata\":{\"seqNo\":5,\"txnId\":\"76201e78aca720dbaf516d86d9342ad5b5d46f5badecf828eb9edfee8ab48a50\"},\"ver\":\"1\"}\n{\"reqSignature\":{},\"txn\":{\"data\":{\"data\":{\"alias\":\"singapore\",\"client_ip\":\"13.228.62.7\",\"client_port\":\"9702\",\"node_ip\":\"13.228.62.7\",\"node_port\":\"9701\",\"services\":[\"VALIDATOR\"]},\"dest\":\"Dh99uW8jSNRBiRQ4JEMpGmJYvzmF35E6ibnmAAf7tbk8\"},\"metadata\":{\"from\":\"HfXThVwhJB4o1Q1Fjr4yrC\"},\"type\":\"0\"},\"txnMetadata\":{\"seqNo\":6,\"txnId\":\"51e2a46721d104d9148d85b617833e7745fdbd6795cb0b502a5b6ea31d33378e\"},\"ver\":\"1\"}\n{\"reqSignature\":{},\"txn\":{\"data\":{\"data\":{\"alias\":\"virginia\",\"client_ip\":\"34.225.215.131\",\"client_port\":\"9702\",\"node_ip\":\"34.225.215.131\",\"node_port\":\"9701\",\"services\":[\"VALIDATOR\"]},\"dest\":\"EoGRm7eRADtHJRThMCrBXMUM2FpPRML19tNxDAG8YTP8\"},\"metadata\":{\"from\":\"SPdfHq6rGcySFVjDX4iyCo\"},\"type\":\"0\"},\"txnMetadata\":{\"seqNo\":7,\"txnId\":\"0a4992ea442b53e3dca861deac09a8d4987004a8483079b12861080ea4aa1b52\"},\"ver\":\"1\"}" fileName:@"pool_transactions_genesis_DEMO"];

                    [localIndy initNullPay];
                    //[localIndy initSovToken];
                    NSLog(@"initNullPay is successful: true");
                    [localIndy setDefaultLogger:@"trace"];
                    NSLog(@"setDefaultLogger trace is successful: true");

                    [localIndy init:[NSString stringWithFormat:@"{\"agency_endpoint\":\"http://agency.pps.evernym.com\",\"agency_did\":\"3mbwr7i85JNSL3LoNQecaW\",\"agency_verkey\":\"2WXxo6y1FJvXWgZnoYUP5BJej2mceFrqBDNPE3p6HDPf\",\"config\":\"{\\\"reqSignature\\\":{},\\\"txn\\\":{\\\"data\\\":{\\\"data\\\":{\\\"alias\\\":\\\"australia\\\",\\\"client_ip\\\":\\\"52.64.96.160\\\",\\\"client_port\\\":\\\"9702\\\",\\\"node_ip\\\":\\\"52.64.96.160\\\",\\\"node_port\\\":\\\"9701\\\",\\\"services\\\":[\\\"VALIDATOR\\\"]},\\\"dest\\\":\\\"UZH61eLH3JokEwjMWQoCMwB3PMD6zRBvG6NCv5yVwXz\\\"},\\\"metadata\\\":{\\\"from\\\":\\\"3U8HUen8WcgpbnEz1etnai\\\"},\\\"type\\\":\\\"0\\\"},\\\"txnMetadata\\\":{\\\"seqNo\\\":1,\\\"txnId\\\":\\\"c585f1decb986f7ff19b8d03deba346ab8a0494cc1e4d69ad9b8acb0dfbeab6f\\\"},\\\"ver\\\":\\\"1\\\"}{\\\"reqSignature\\\":{},\\\"txn\\\":{\\\"data\\\":{\\\"data\\\":{\\\"alias\\\":\\\"brazil\\\",\\\"client_ip\\\":\\\"54.233.203.241\\\",\\\"client_port\\\":\\\"9702\\\",\\\"node_ip\\\":\\\"54.233.203.241\\\",\\\"node_port\\\":\\\"9701\\\",\\\"services\\\":[\\\"VALIDATOR\\\"]},\\\"dest\\\":\\\"2MHGDD2XpRJohQzsXu4FAANcmdypfNdpcqRbqnhkQsCq\\\"},\\\"metadata\\\":{\\\"from\\\":\\\"G3knUCmDrWd1FJrRryuKTw\\\"},\\\"type\\\":\\\"0\\\"},\\\"txnMetadata\\\":{\\\"seqNo\\\":2,\\\"txnId\\\":\\\"5c8f52ca28966103ff0aad98160bc8e978c9ca0285a2043a521481d11ed17506\\\"},\\\"ver\\\":\\\"1\\\"}{\\\"reqSignature\\\":{},\\\"txn\\\":{\\\"data\\\":{\\\"data\\\":{\\\"alias\\\":\\\"canada\\\",\\\"client_ip\\\":\\\"52.60.207.225\\\",\\\"client_port\\\":\\\"9702\\\",\\\"node_ip\\\":\\\"52.60.207.225\\\",\\\"node_port\\\":\\\"9701\\\",\\\"services\\\":[\\\"VALIDATOR\\\"]},\\\"dest\\\":\\\"8NZ6tbcPN2NVvf2fVhZWqU11XModNudhbe15JSctCXab\\\"},\\\"metadata\\\":{\\\"from\\\":\\\"22QmMyTEAbaF4VfL7LameE\\\"},\\\"type\\\":\\\"0\\\"},\\\"txnMetadata\\\":{\\\"seqNo\\\":3,\\\"txnId\\\":\\\"408c7c5887a0f3905767754f424989b0089c14ac502d7f851d11b31ea2d1baa6\\\"},\\\"ver\\\":\\\"1\\\"}{\\\"reqSignature\\\":{},\\\"txn\\\":{\\\"data\\\":{\\\"data\\\":{\\\"alias\\\":\\\"england\\\",\\\"client_ip\\\":\\\"52.56.191.9\\\",\\\"client_port\\\":\\\"9702\\\",\\\"node_ip\\\":\\\"52.56.191.9\\\",\\\"node_port\\\":\\\"9701\\\",\\\"services\\\":[\\\"VALIDATOR\\\"]},\\\"dest\\\":\\\"DNuLANU7f1QvW1esN3Sv9Eap9j14QuLiPeYzf28Nub4W\\\"},\\\"metadata\\\":{\\\"from\\\":\\\"NYh3bcUeSsJJcxBE6TTmEr\\\"},\\\"type\\\":\\\"0\\\"},\\\"txnMetadata\\\":{\\\"seqNo\\\":4,\\\"txnId\\\":\\\"d56d0ff69b62792a00a361fbf6e02e2a634a7a8da1c3e49d59e71e0f19c27875\\\"},\\\"ver\\\":\\\"1\\\"}{\\\"reqSignature\\\":{},\\\"txn\\\":{\\\"data\\\":{\\\"data\\\":{\\\"alias\\\":\\\"korea\\\",\\\"client_ip\\\":\\\"52.79.115.223\\\",\\\"client_port\\\":\\\"9702\\\",\\\"node_ip\\\":\\\"52.79.115.223\\\",\\\"node_port\\\":\\\"9701\\\",\\\"services\\\":[\\\"VALIDATOR\\\"]},\\\"dest\\\":\\\"HCNuqUoXuK9GXGd2EULPaiMso2pJnxR6fCZpmRYbc7vM\\\"},\\\"metadata\\\":{\\\"from\\\":\\\"U38UHML5A1BQ1mYh7tYXeu\\\"},\\\"type\\\":\\\"0\\\"},\\\"txnMetadata\\\":{\\\"seqNo\\\":5,\\\"txnId\\\":\\\"76201e78aca720dbaf516d86d9342ad5b5d46f5badecf828eb9edfee8ab48a50\\\"},\\\"ver\\\":\\\"1\\\"}{\\\"reqSignature\\\":{},\\\"txn\\\":{\\\"data\\\":{\\\"data\\\":{\\\"alias\\\":\\\"singapore\\\",\\\"client_ip\\\":\\\"13.228.62.7\\\",\\\"client_port\\\":\\\"9702\\\",\\\"node_ip\\\":\\\"13.228.62.7\\\",\\\"node_port\\\":\\\"9701\\\",\\\"services\\\":[\\\"VALIDATOR\\\"]},\\\"dest\\\":\\\"Dh99uW8jSNRBiRQ4JEMpGmJYvzmF35E6ibnmAAf7tbk8\\\"},\\\"metadata\\\":{\\\"from\\\":\\\"HfXThVwhJB4o1Q1Fjr4yrC\\\"},\\\"type\\\":\\\"0\\\"},\\\"txnMetadata\\\":{\\\"seqNo\\\":6,\\\"txnId\\\":\\\"51e2a46721d104d9148d85b617833e7745fdbd6795cb0b502a5b6ea31d33378e\\\"},\\\"ver\\\":\\\"1\\\"}{\\\"reqSignature\\\":{},\\\"txn\\\":{\\\"data\\\":{\\\"data\\\":{\\\"alias\\\":\\\"virginia\\\",\\\"client_ip\\\":\\\"34.225.215.131\\\",\\\"client_port\\\":\\\"9702\\\",\\\"node_ip\\\":\\\"34.225.215.131\\\",\\\"node_port\\\":\\\"9701\\\",\\\"services\\\":[\\\"VALIDATOR\\\"]},\\\"dest\\\":\\\"EoGRm7eRADtHJRThMCrBXMUM2FpPRML19tNxDAG8YTP8\\\"},\\\"metadata\\\":{\\\"from\\\":\\\"SPdfHq6rGcySFVjDX4iyCo\\\"},\\\"type\\\":\\\"0\\\"},\\\"txnMetadata\\\":{\\\"seqNo\\\":7,\\\"txnId\\\":\\\"0a4992ea442b53e3dca861deac09a8d4987004a8483079b12861080ea4aa1b52\\\"},\\\"ver\\\":\\\"1\\\"}\",\"pool_name\":\"7f96cbb3b0a1711f3b843af3cb28e31dcmpool\",\"wallet_name\":\"%@\",\"wallet_key\":\"%@\",\"genesis_path\":\"%@\",\"remote_to_sdk_did\":\"VkNyVpnyDqwxbBwnLg2KPC\",\"remote_to_sdk_verkey\":\"Gfn8iAG2iHXX6TJPGZSB8QQCdKoEthkNY6JBziqwMesK\",\"sdk_to_remote_did\":\"6L1ff7FJKDezrDMD3zefMF\",\"sdk_to_remote_verkey\":\"3uRTpbT2gscySLvc465W4zmmVa4ZrqppYkwEwzsMuPmM\",\"institution_name\":\"some-random-name\",\"institution_logo_url\":\"https://robothash.com/logo.png\",\"institution_did\":\"HQU9BdCM4Hzyv2tsETGFeX\",\"institution_verkey\":\"9wan6s2CqDVsWvYdekex81XjWESyAxm2aV4Waw4AN6Vz\"}", walletName, walletKey, genesisPathForTest] completion:^(BOOL success){ NSLog(@"init is successful: %@", success ? @"true" : @"false"); if(!success) { finishedSuccessfully = NO; }

//                        [localIndy downloadMessages:@"MS-103" uid_s:@"(null)" pwdids:@"" completion:^(BOOL success){ NSLog(@"downloadMessages is successful: %@", success ? @"true" : @"false"); if(!success) { finishedSuccessfully = NO; }

                            [localIndy setWalletItem:@"PIN_HASH" value:@"e292abf4967182ab" completion:^(BOOL success){ NSLog(@"setWalletItem is successful: %@", success ? @"true" : @"false"); if(!success) { finishedSuccessfully = NO; }

                                [localIndy setWalletItem:@"STORAGE_KEY_SWITCHED_ENVIRONMENT_DETAIL" value:@"{\"agencyUrl\":\"http://agency.pps.evernym.com\",\"agencyDID\":\"3mbwr7i85JNSL3LoNQecaW\",\"agencyVerificationKey\":\"2WXxo6y1FJvXWgZnoYUP5BJej2mceFrqBDNPE3p6HDPf\",\"poolConfig\":\"{\\\"reqSignature\\\":{},\\\"txn\\\":{\\\"data\\\":{\\\"data\\\":{\\\"alias\\\":\\\"australia\\\",\\\"client_ip\\\":\\\"52.64.96.160\\\",\\\"client_port\\\":\\\"9702\\\",\\\"node_ip\\\":\\\"52.64.96.160\\\",\\\"node_port\\\":\\\"9701\\\",\\\"services\\\":[\\\"VALIDATOR\\\"]},\\\"dest\\\":\\\"UZH61eLH3JokEwjMWQoCMwB3PMD6zRBvG6NCv5yVwXz\\\"},\\\"metadata\\\":{\\\"from\\\":\\\"3U8HUen8WcgpbnEz1etnai\\\"},\\\"type\\\":\\\"0\\\"},\\\"txnMetadata\\\":{\\\"seqNo\\\":1,\\\"txnId\\\":\\\"c585f1decb986f7ff19b8d03deba346ab8a0494cc1e4d69ad9b8acb0dfbeab6f\\\"},\\\"ver\\\":\\\"1\\\"}\n{\\\"reqSignature\\\":{},\\\"txn\\\":{\\\"data\\\":{\\\"data\\\":{\\\"alias\\\":\\\"brazil\\\",\\\"client_ip\\\":\\\"54.233.203.241\\\",\\\"client_port\\\":\\\"9702\\\",\\\"node_ip\\\":\\\"54.233.203.241\\\",\\\"node_port\\\":\\\"9701\\\",\\\"services\\\":[\\\"VALIDATOR\\\"]},\\\"dest\\\":\\\"2MHGDD2XpRJohQzsXu4FAANcmdypfNdpcqRbqnhkQsCq\\\"},\\\"metadata\\\":{\\\"from\\\":\\\"G3knUCmDrWd1FJrRryuKTw\\\"},\\\"type\\\":\\\"0\\\"},\\\"txnMetadata\\\":{\\\"seqNo\\\":2,\\\"txnId\\\":\\\"5c8f52ca28966103ff0aad98160bc8e978c9ca0285a2043a521481d11ed17506\\\"},\\\"ver\\\":\\\"1\\\"}\n{\\\"reqSignature\\\":{},\\\"txn\\\":{\\\"data\\\":{\\\"data\\\":{\\\"alias\\\":\\\"canada\\\",\\\"client_ip\\\":\\\"52.60.207.225\\\",\\\"client_port\\\":\\\"9702\\\",\\\"node_ip\\\":\\\"52.60.207.225\\\",\\\"node_port\\\":\\\"9701\\\",\\\"services\\\":[\\\"VALIDATOR\\\"]},\\\"dest\\\":\\\"8NZ6tbcPN2NVvf2fVhZWqU11XModNudhbe15JSctCXab\\\"},\\\"metadata\\\":{\\\"from\\\":\\\"22QmMyTEAbaF4VfL7LameE\\\"},\\\"type\\\":\\\"0\\\"},\\\"txnMetadata\\\":{\\\"seqNo\\\":3,\\\"txnId\\\":\\\"408c7c5887a0f3905767754f424989b0089c14ac502d7f851d11b31ea2d1baa6\\\"},\\\"ver\\\":\\\"1\\\"}\n{\\\"reqSignature\\\":{},\\\"txn\\\":{\\\"data\\\":{\\\"data\\\":{\\\"alias\\\":\\\"england\\\",\\\"client_ip\\\":\\\"52.56.191.9\\\",\\\"client_port\\\":\\\"9702\\\",\\\"node_ip\\\":\\\"52.56.191.9\\\",\\\"node_port\\\":\\\"9701\\\",\\\"services\\\":[\\\"VALIDATOR\\\"]},\\\"dest\\\":\\\"DNuLANU7f1QvW1esN3Sv9Eap9j14QuLiPeYzf28Nub4W\\\"},\\\"metadata\\\":{\\\"from\\\":\\\"NYh3bcUeSsJJcxBE6TTmEr\\\"},\\\"type\\\":\\\"0\\\"},\\\"txnMetadata\\\":{\\\"seqNo\\\":4,\\\"txnId\\\":\\\"d56d0ff69b62792a00a361fbf6e02e2a634a7a8da1c3e49d59e71e0f19c27875\\\"},\\\"ver\\\":\\\"1\\\"}\n{\\\"reqSignature\\\":{},\\\"txn\\\":{\\\"data\\\":{\\\"data\\\":{\\\"alias\\\":\\\"korea\\\",\\\"client_ip\\\":\\\"52.79.115.223\\\",\\\"client_port\\\":\\\"9702\\\",\\\"node_ip\\\":\\\"52.79.115.223\\\",\\\"node_port\\\":\\\"9701\\\",\\\"services\\\":[\\\"VALIDATOR\\\"]},\\\"dest\\\":\\\"HCNuqUoXuK9GXGd2EULPaiMso2pJnxR6fCZpmRYbc7vM\\\"},\\\"metadata\\\":{\\\"from\\\":\\\"U38UHML5A1BQ1mYh7tYXeu\\\"},\\\"type\\\":\\\"0\\\"},\\\"txnMetadata\\\":{\\\"seqNo\\\":5,\\\"txnId\\\":\\\"76201e78aca720dbaf516d86d9342ad5b5d46f5badecf828eb9edfee8ab48a50\\\"},\\\"ver\\\":\\\"1\\\"}\n{\\\"reqSignature\\\":{},\\\"txn\\\":{\\\"data\\\":{\\\"data\\\":{\\\"alias\\\":\\\"singapore\\\",\\\"client_ip\\\":\\\"13.228.62.7\\\",\\\"client_port\\\":\\\"9702\\\",\\\"node_ip\\\":\\\"13.228.62.7\\\",\\\"node_port\\\":\\\"9701\\\",\\\"services\\\":[\\\"VALIDATOR\\\"]},\\\"dest\\\":\\\"Dh99uW8jSNRBiRQ4JEMpGmJYvzmF35E6ibnmAAf7tbk8\\\"},\\\"metadata\\\":{\\\"from\\\":\\\"HfXThVwhJB4o1Q1Fjr4yrC\\\"},\\\"type\\\":\\\"0\\\"},\\\"txnMetadata\\\":{\\\"seqNo\\\":6,\\\"txnId\\\":\\\"51e2a46721d104d9148d85b617833e7745fdbd6795cb0b502a5b6ea31d33378e\\\"},\\\"ver\\\":\\\"1\\\"}\n{\\\"reqSignature\\\":{},\\\"txn\\\":{\\\"data\\\":{\\\"data\\\":{\\\"alias\\\":\\\"virginia\\\",\\\"client_ip\\\":\\\"34.225.215.131\\\",\\\"client_port\\\":\\\"9702\\\",\\\"node_ip\\\":\\\"34.225.215.131\\\",\\\"node_port\\\":\\\"9701\\\",\\\"services\\\":[\\\"VALIDATOR\\\"]},\\\"dest\\\":\\\"EoGRm7eRADtHJRThMCrBXMUM2FpPRML19tNxDAG8YTP8\\\"},\\\"metadata\\\":{\\\"from\\\":\\\"SPdfHq6rGcySFVjDX4iyCo\\\"},\\\"type\\\":\\\"0\\\"},\\\"txnMetadata\\\":{\\\"seqNo\\\":7,\\\"txnId\\\":\\\"0a4992ea442b53e3dca861deac09a8d4987004a8483079b12861080ea4aa1b52\\\"},\\\"ver\\\":\\\"1\\\"}\"}" completion:^(BOOL success){ NSLog(@"setWalletItem is successful: %@", success ? @"true" : @"false"); if(!success) { finishedSuccessfully = NO; }

                                    [localIndy setWalletItem:@"SALT" value:@"dcZ83D46KDOUHEd9WQM2xU5UnIYpyaYLnZ+0nhobjU4=" completion:^(BOOL success){ NSLog(@"setWalletItem is successful: %@", success ? @"true" : @"false"); if(!success) { finishedSuccessfully = NO; }

                                        [localIndy setWalletItem:@"passphrase" value:@"grip tremor blazer rigid cruelly angrily broiler nutty" completion:^(BOOL success){ NSLog(@"setWalletItem is successful: %@", success ? @"true" : @"false"); if(!success) { finishedSuccessfully = NO; }

                                            [localIndy setWalletItem:@"passphraseSalt" value:@"UfiXxbCth0WDmbUrLsicgBQQzzRu2jvNdKyfcqUqfnw=" completion:^(BOOL success){ NSLog(@"setWalletItem is successful: %@", success ? @"true" : @"false"); if(!success) { finishedSuccessfully = NO; }

                                                [localIndy setWalletItem:@"STORAGE_KEY_USER_ONE_TIME_INFO" value:@"{\"oneTimeAgencyDid\":\"HQU9BdCM4Hzyv2tsETGFeX\",\"oneTimeAgencyVerificationKey\":\"9wan6s2CqDVsWvYdekex81XjWESyAxm2aV4Waw4AN6Vz\",\"myOneTimeDid\":\"6L1ff7FJKDezrDMD3zefMF\",\"myOneTimeVerificationKey\":\"3uRTpbT2gscySLvc465W4zmmVa4ZrqppYkwEwzsMuPmM\",\"myOneTimeAgentDid\":\"VkNyVpnyDqwxbBwnLg2KPC\",\"myOneTimeAgentVerificationKey\":\"Gfn8iAG2iHXX6TJPGZSB8QQCdKoEthkNY6JBziqwMesK\"}" completion:^(BOOL success){ NSLog(@"setWalletItem is successful: %@", success ? @"true" : @"false"); if(!success) { finishedSuccessfully = NO; }

                                                    [localIndy exportWallet:[NSString stringWithFormat:@"%@/tmp/Backup-%@/ConnectMe.wallet", documentsDirectory, dateString] encryptWith:@"6303e22e1b2de572" completion:^(BOOL success){ NSLog(@"exportWallet is successful: %@", success ? @"true" : @"false"); if(!success) { finishedSuccessfully = NO; }

//                                                        [localIndy downloadMessages:@"MS-103" uid_s:@"(null)" pwdids:@"" completion:^(BOOL success){ NSLog(@"downloadMessages is successful: %@", success ? @"true" : @"false"); if(!success) { finishedSuccessfully = NO; }

                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    successful(finishedSuccessfully);
                                                });
                                            }];}];}];}];}];}];}];}];}];

    });
}

@end
