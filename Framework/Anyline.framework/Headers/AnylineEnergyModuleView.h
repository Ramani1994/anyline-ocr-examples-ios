//
//  AnylineModuleView.h
//  Anyline
//
//  Created by Daniel Albertini on 25/06/15.
//  Copyright (c) 2015 9Yards GmbH. All rights reserved.
//

#import "AnylineAbstractModuleView.h"
#import "ALMeterResult.h"
#import "ALMeterScanPlugin.h"
#import "ALBarcodeScanPlugin.h"
#import "ALMeterScanViewPlugin.h"

@protocol AnylineEnergyModuleDelegate;

/**
 * The AnylineEnergyModuleView class declares the programmatic interface for an object that manages easy access to Anylines energy meter scanning mode. All its capabilities are bundled into this AnylineAbstractModuleView subclass. Management of the scanning process happens within the view object. It is configurable via interface builder.
 *
 * Communication with the host application is managed with a delegate that conforms to AnylineEnergyModuleDelegate. 
 *
 * AnylineEnergyModuleView is able to scan the most common energy meters. The scan mode is set with setScanMode.
 */
@interface AnylineEnergyModuleView : AnylineAbstractModuleView

@property (nullable, nonatomic, strong) ALMeterScanViewPlugin *meterScanViewPlugin;

@property (nullable, nonatomic, strong) ALMeterScanPlugin *meterScanPlugin;

@property (nullable, nonatomic, strong) ALBarcodeScanPlugin *barcodeScanPlugin;

/**
 *  Sets the scan mode. 
 *  It has to be ALElectricMeter, ALGasMeter, ALBarcode or ALSerialNumber
 *
 */
@property (nonatomic, assign, readonly) ALScanMode scanMode;
/**
 *  A validation regex string for the Serial scanMode.
 *  Regex has to follow the ECMAScript standard.
 *  This parameter will be ignored in the other scanModes.
 *  If you want to have no regex this property has to be set to nil.
 */
@property (nonatomic, strong) NSString * _Nullable serialNumberValidationRegex;
/**
 *  A character whitelist for the Serial scanMode.
 *  This parameter will be ignored in the other scanModes.
 *  If you want to have no regex this property has to be set to nil.
 *
 *  @warning There are only numbers and uppercase characters allowed.
 */
@property (nonatomic, strong) NSString * _Nullable serialNumberCharWhitelist;

/**
 *  Sets the scan mode and returns an NSError if something failed.
 *
 *  @param scanMode The scan mode to set.
 *  @param error The error if something goes wrong. Can be nil.
 *
 *  @return Boolean indicating the success / failure of the call.
 */
- (BOOL)setScanMode:(ALScanMode)scanMode error:(NSError * _Nullable * _Nullable)error;

/**
 *  Sets the license key and delegate.
 *
 *  @param licenseKey The Anyline license key for this application bundle
 *  @param delegate The delegate that will receive the Anyline results (hast to conform to <AnylineEnergyModuleDelegate>)
 *  @param error The error that occured
 *
 *  @return Boolean indicating the success / failure of the call.
 */
- (BOOL)setupWithLicenseKey:(NSString * _Nonnull)licenseKey
                   delegate:(id<AnylineEnergyModuleDelegate> _Nonnull)delegate
                      error:(NSError * _Nullable * _Nullable )error;

/**
 *  Sets the license key and delegate. Async method with return block when done.
 *
 *  @param licenseKey The Anyline license key for this application bundle
 *  @param delegate The delegate that will receive the Anyline results (hast to conform to <AnylineEnergyModuleDelegate>)
 *  @param finished Inidicating if setup is finished with an error object when setup failed.
 *
 */
- (void)setupAsyncWithLicenseKey:(NSString * _Nonnull)licenseKey
                        delegate:(id<AnylineEnergyModuleDelegate> _Nonnull)delegate
                        finished:(void (^_Nonnull)(BOOL success, NSError * _Nullable error))finished;

@end

@protocol AnylineEnergyModuleDelegate <NSObject>

@required
/**
 *  Returns the scanned value
 *
 *  @param AnylineEnergyModuleView The view that scanned the result
 *  @param scanResult The scanned result object
 *
 *  @since 3.10
 */
- (void)anylineEnergyModuleView:(AnylineEnergyModuleView * _Nonnull)anylineEnergyModuleView
                  didFindResult:(ALEnergyResult * _Nonnull)scanResult;
@optional
/**
 *  Returns the scanned value
 *
 *  @param AnylineEnergyModuleView The view that scanned the result
 *  @param scanResult The scanned value
 *  @param image The cropped version of the image that contains the scanned number
 *  @param fullImage The whole image used to scan the number
 *  @param scanMode The mode the scanner was in at the time of scanning. Has to be ALElectricMeter, ALGasMeter, ALBarcode or ALSerialNumber
 *
 *  @deprecated since 3.10
 */
- (void)anylineEnergyModuleView:(AnylineEnergyModuleView * _Nonnull)anylineEnergyModuleView
              didFindScanResult:(NSString * _Nonnull)scanResult
                      cropImage:(UIImage * _Nonnull)image
                      fullImage:(UIImage * _Nonnull)fullImage
                         inMode:(ALScanMode)scanMode __deprecated_msg("Deprecated since 3.10 Use AnylineDebugDelegate instead.");

@end
