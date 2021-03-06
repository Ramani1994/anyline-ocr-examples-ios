//
//  ALExampleManager.m
//  AnylineExamples
//
//  Created by Philipp Müller on 21/11/2017.
//  Copyright © 2017 Anyline GmbH. All rights reserved.
//

#import "ALProductExampleManager.h"

#import "ALAnalogMeterScanViewController.h"
#import "ALAutoAnalogDigitalMeterScanViewController.h"
#import "ALDialMeterScanViewController.h"
#import "ALSerialNumberScanViewController.h"

#import "ALMultiformatBarcodeScanViewController.h"
#import "ALMRZScanViewController.h"
#import "ALIBANScanViewController.h"
#import "ALVoucherCodeScanViewController.h"
#import "ALISBNScanViewController.h"
#import "ALRecordNumberScanViewController.h"
#import "ALRBScanViewController.h"
#import "ALBottlecapScanViewController.h"
#import "ALScrabbleScanViewController.h"
#import "ALDocumentScanViewController.h"
#import "ALHashtagScanViewController.h"

#import "ALLicensePlateViewController.h"

#import "ALOthersExampleManager.h"
#import "ALMeterExampleManager.h"
#import "ALMROExampleManager.h"
#import "ALIdentityDocumentsExampleManager.h"
#import "ALGridCollectionViewController.h"
#import "ALMeterCollectionViewController.h"

@interface ALProductExampleManager ()

@property (nonatomic, strong) NSDictionary *examples;

@property (nonatomic, strong) NSArray *sectionNames;

@end

@implementation ALProductExampleManager

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initExampleData];
    }
    return self;
}

- (void)initExampleData {
    self.title = @"Products";
    
    ALExample *meterReading = [[ALExample alloc] initWithName:NSLocalizedString(@"Meter Reading", nil)
                                                        image:[UIImage imageNamed:@"meter reading"]
                                               viewController:[ALMeterCollectionViewController class]
                                               exampleManager:[ALMeterExampleManager class]];
    
    ALExample *identityDocuments = [[ALExample alloc] initWithName:NSLocalizedString(@"Identity Documents", nil)
                                               image:[UIImage imageNamed:@"identity_documents"]
                                      viewController:[ALGridCollectionViewController class]
                                      exampleManager:[ALIdentityDocumentsExampleManager class]];
    
    ALExample *licensePlateScanning = [[ALExample alloc] initWithName:NSLocalizedString(@"EU License Plate", nil)
                                                                image:[UIImage imageNamed:@"license plate"]
                                                       viewController:[ALLicensePlateViewController class]];
    
    ALExample *mro = [[ALExample alloc] initWithName:NSLocalizedString(@"MRO", nil)
                                                  image:[UIImage imageNamed:@"mro"]
                                         viewController:[ALGridCollectionViewController class]
                                         exampleManager:[ALMROExampleManager class]];
    
    
    
    ALExample *others = [[ALExample alloc] initWithName:NSLocalizedString(@"Others", nil)
                                                  image:[UIImage imageNamed:@"others"]
                                         viewController:[ALGridCollectionViewController class]
                                         exampleManager:[ALOthersExampleManager class]];
    
    self.sectionNames = @[@"Products",];
    self.examples = @{
                      self.sectionNames[0] : @[meterReading,
                                               identityDocuments,
                                               licensePlateScanning,
                                               mro,
                                               others,],
                      };
}

@end
