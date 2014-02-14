//
//  AppColors.m
//  Lucid Dreaming App
//
//  Created by Mahmood1 on 11/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppColors.h"

@implementation AppColors

+(UIColor*)navBarColor{
//    return [UIColor blackColor];
    return [UIColor colorWithRed:40/255.0 green:105/255.0 blue:192/255.0 alpha:1];
//    return    [UIColor blueColor];

}
+(UIColor*)toolBarColor{
    return [UIColor blackColor];
}
+(UIColor*)lightFontColor{
    return [UIColor whiteColor];
}
                          
+(UIColor*)darkFontColor{
    return [UIColor blackColor];
    
    
}
+(UIColor*)tableViewBackgroundColor{
     return [UIColor blackColor];
}
+(UIColor*)tableViewCellBackgroundColor{
     return [UIColor blackColor];
} 
+(UIColor*)transparentColor{
    return    [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
}

+(UIImage*)buttonImage:(int)tag{
    

    switch (tag) {
        case kRedButtonImage:
            return [UIImage imageNamed:@"button_round_deep_red.png"];
            break;
        case kOrangeButtonImage:
            return [UIImage imageNamed:@"button_round_light_orange.png"];
            break;
        case kGreenButtonImage:
            return [UIImage imageNamed:@"button_round_light_green.png"];
            break;
        case kBlueButtonImage:
            return [UIImage imageNamed:@"button_round_deep_blue.png"];
            break;
        case kCyanButtonImage:
            return [UIImage imageNamed:@"button_round_light_blue.png"];
            break;
        case kPurpleButtonImage:
            return [UIImage imageNamed:@"button_round_deep_purple.png"];
            break;
        case kGrayButtonImage:
            return [UIImage imageNamed:@"button_round_light_white.png"];
            break;
        case kSilverButtonImage:
            return [UIImage imageNamed:@"button_round_light_white.png"];
            break;
        case kBlackButtonImage:
            return [UIImage imageNamed:@"button_round_deep_black.png"];
            break;
        case kSliderRedButtonImage:
             return [UIImage imageNamed:@"slider_round_deep_red.png"];
            break;
        case kSliderOrangeButtonImage:
             return [UIImage imageNamed:@"slider_round_light_orange.png"];
            break;
        case kSliderGreenButtonImage:
             return [UIImage imageNamed:@"slider_round_light_green.png"];
            break;
        case kSliderBlueButtonImage:
             return [UIImage imageNamed:@"slider_round_deep_blue.png"];
            break;
        case kSliderCyanButtonImage:
            return [UIImage imageNamed:@"slider_round_light_blue.png"];
            break;
        case kSliderPurpleButtonImage:
            return [UIImage imageNamed:@"slider_round_deep_purple.png"];
            break;
        case kSliderGrayButtonImage:
             return [UIImage imageNamed:@"slider_button_gray.png"];
            break;
        case kSliderSilverButtonImage:
             return [UIImage imageNamed:@"slider_round_light_white.png"];
            break;
        case kSliderBlackButtonImage:
             return [UIImage imageNamed:@"slider_round_deep_black.png"];
            break;
            
        case kSliderSunriseButtonImage:
            return [UIImage imageNamed:@"slider_button_sunrise.png"];
            break;   
            
        default:
            return nil;
            break;
    }
}

+(UIImage*)arrowImage:(int)tag{
    
    
    switch (tag) {
        case kRedRoundArrow:
            return [UIImage imageNamed:@"arrow_red_round.png"];
            break;
        case kOrangeRoundArrow:
            return [UIImage imageNamed:@"arrow_orange_round.png"];
            break;
        case kGreenRoundArrow:
            return [UIImage imageNamed:@"arrow_green_round.png"];
            break;
        case kBlueRoundArrow:
            return [UIImage imageNamed:@"arrow_blue_round.png"];
            break;
        case kSilverRoundArrow:
            return [UIImage imageNamed:@"arrow_silver_round.png"];
            break;
        case kBlackRoundArrow:
            return [UIImage imageNamed:@"arrow_black_round.png"];
            break;
                  
        default:
            return nil;
            break;
    }
}
+(UIImage*)markerImage:(int)tag{
    
    
    switch (tag) {
        case kRedRoundMarker:
            return [UIImage imageNamed:@"marker_round_deep_red.png"];
            break;
        case kOrangeRoundMarker:
            return [UIImage imageNamed:@"marker_round_light_orange.png"];
            break;
        case kGreenRoundMarker:
            return [UIImage imageNamed:@"marker_round_light_green.png"];
            break;
        case kBlueRoundMarker:
            return [UIImage imageNamed:@"marker_round_deep_blue.png"];
            break;
        case kCyanRoundMarker:
            return [UIImage imageNamed:@"marker_round_light_blue.png"];
            break;
        case kPurpleRoundMarker:
            return [UIImage imageNamed:@"marker_round_deep_purple.png"];
            break;
        case kSilverRoundMarker:
            return [UIImage imageNamed:@"marker_round_light_white.png"];
            break;
        case kBlackRoundMarker:
            return [UIImage imageNamed:@"marker_round_deep_black.png"];
            break;
        case kSunriseRoundMarker:
            return [UIImage imageNamed:@"marker_round_sunrise.png"];
            break;
        default:
            return nil;
            break;
    }
}


+(UIImage*)getButtonIcon:(int)tag
{
    return nil;
}

+(NSArray*)reminderImagesForAnimation{
    return [NSArray arrayWithObjects:
            [UIImage imageNamed:@"light_reminder_singularity_square"],
            [UIImage imageNamed:@"light_reminder_pure_light"],
            [UIImage imageNamed:@"light_reminder_sunrise_paradox"],
            [UIImage imageNamed:@"light_reminder_silver"],
            [UIImage imageNamed:@"light_reminder_red"],
            [UIImage imageNamed:@"light_reminder_orange"],
            [UIImage imageNamed:@"light_reminder_green"],
            [UIImage imageNamed:@"light_reminder_blue"],
            [UIImage imageNamed:@"light_reminder_sunrise"],
            [UIImage imageNamed:@"light_reminder_sunset"],
                                              nil];
}


+(UIImage*)reminderImageWithTag:(int)tag{
    switch (tag) {
        case kLightReminderSingularity:
            return [UIImage imageNamed:@"light_reminder_singularity_square.png"];
            break;
        case kLightReminderPureLight:
            return [UIImage imageNamed:@"light_reminder_pure_light.png"];
            break;
        case kLightReminderSilver:
            return [UIImage imageNamed:@"light_reminder_silver.png"];
            break;
        case kLightReminderOrange:
            return [UIImage imageNamed:@"light_reminder_orange.png"];
            break;
//        case kLightReminderGreen:
//            return [UIImage imageNamed:@"light_reminder_green.png"];
//            break;
        case kLightReminderBlue:
            return [UIImage imageNamed:@"light_reminder_blue.png"];
            break;
        case kLightReminderRed:
            return [UIImage imageNamed:@"light_reminder_red.png"];
            break;
        case kLightReminderSunrise:
            return [UIImage imageNamed:@"light_reminder_sunrise.png"];
            break;
        case kLightReminderSunset:
            return [UIImage imageNamed:@"light_reminder_sunset.png"];
            break;
        case kLightReminderSunriseParadox:
            return [UIImage imageNamed:@"light_reminder_sunrise_paradox.png"];
            break;
        case kLightReminderTimeInBed:
            return nil;
            break;
        case kLightReminderRiseTime:
            return nil;
            break;
        case kLightReminderBlank:
            
            return nil;
        default:
            NSLog(@"Check your reminder image tag, it's out of bounds!");
            return nil;
            break;
    }

}

+(NSString*)reminderNameForTag:(int)tag{
    switch (tag) {
        case kLightReminderSingularity:
           return NSLocalizedString(@"Singularity", @"Singularity light reminder ");
            break;
        case kLightReminderPureLight:
                       return NSLocalizedString(@"Young Light", @"Young Light light reminder ");
           
            break;
        case kLightReminderSilver:
                       return NSLocalizedString(@"Void", @"Void light reminder ");
                       break;
        case kLightReminderOrange:
                       return NSLocalizedString(@"Catalyst", @"Singularity light reminder ");
        
            break;
            //        case kLightReminderGreen:
            //            return [UIImage imageNamed:@"marker_round_silver.png"];
            //            break;
        case kLightReminderBlue:
            //harmony, tranquility
//             return NSLocalizedString(@"Tranquility", @"Singularity light reminder ");
                       return NSLocalizedString(@"Harmony", @"Singularity light reminder ");
          
            break;
        case kLightReminderRed:
                       return NSLocalizedString(@"Momentum", @"Singularity light reminder ");

            break;
        case kLightReminderSunrise:
                       return NSLocalizedString(@"Impulse", @"sunset light reminder ");

            break;
        case kLightReminderSunset:
            //entropy, sunset
                       return NSLocalizedString(@"Entropy", @"Singularity light reminder ");

            break;
        case kLightReminderSunriseParadox:
                       return NSLocalizedString(@"Paradox", @"Singularity light reminder ");

            break;
            
        case kLightReminderTimeInBed:
          return NSLocalizedString(@"Bedtime", @"Singularity light reminder ");
            break;
        case kLightReminderRiseTime:
            return NSLocalizedString(@"Risetime", @"Singularity light reminder ");
            break;
        case kLightReminderBlank:
             return NSLocalizedString(@"Hidden", @"Singularity light reminder ");
            return nil;
            
        default:
              NSLog(@"Check your reminder name tag, it's out of bounds!");
            return nil;
            break;
    }
}


+(UIImage*)reminderButtonForTag:(int)tag;
{
    switch (tag) {
        case kLightReminderSingularity:
            return [UIImage imageNamed:@"slider_button_purple_singularity_experience.png"];
            break;
        case kLightReminderPureLight:
            return [UIImage imageNamed:@"slider_button_purple_singularity_experience.png"];
            break;
        case kLightReminderSilver:
            return [UIImage imageNamed:@"slider_button_silver_gradient.png"];
            break;
        case kLightReminderOrange:
            return [UIImage imageNamed:@"slider_button_orange_gradient.png"];
            break;
            //        case kLightReminderGreen:
          
            //            break;
        case kLightReminderBlue:
            return [UIImage imageNamed:@"slider_button_blue_gradient.png"];
            break;
        case kLightReminderRed:
            return [UIImage imageNamed:@"slider_button_red_gradient.png"];
            break;
        case kLightReminderSunrise:
            return [UIImage imageNamed:@"slider_button_orange_gradient.png"];
            break;
        case kLightReminderSunset:
            return [UIImage imageNamed:@"slider_button_purple_lucid_dream.png"];
            break;
        case kLightReminderSunriseParadox:
            return [UIImage imageNamed:@"slider_button_purple_lucid_dream.png"];
            break;
            
        case kLightReminderTimeInBed:
            return [UIImage imageNamed:@"slider_button_black.png"];
            break;
        case kLightReminderRiseTime:
            return [UIImage imageNamed:@"slider_button_sunrise.png"];
            break;
        case kLightReminderBlank:
            
            return nil;
            
        default:
              NSLog(@"Check your reminder button tag, it's out of bounds!");
            return nil;
            break;
    }

}


+(UIImage*)reminderDialMarkerForTag:(int)tag
{
    switch (tag) {
        case kLightReminderSingularity:
            return [UIImage imageNamed:@"marker_round_singularity_experience.png"];
            break;
        case kLightReminderPureLight:
            return [UIImage imageNamed:@"marker_round_singularity_experience.png"];
            break;
        case kLightReminderSilver:
            return [UIImage imageNamed:@"marker_round_silver_gradient.png"];
            break;
        case kLightReminderOrange:
            return [UIImage imageNamed:@"marker_round_orange_gradient.png"];
            break;
            //        case kLightReminderGreen:
            
            //            break;
        case kLightReminderBlue:
            return [UIImage imageNamed:@"marker_round_blue_gradient.png"];
            break;
        case kLightReminderRed:
            return [UIImage imageNamed:@"marker_round_red_gradient.png"];
            break;
        case kLightReminderSunrise:
            return [UIImage imageNamed:@"marker_round_orange_gradient.png"];
            break;
        case kLightReminderSunset:
            return [UIImage imageNamed:@"marker_round_lucid_dream.png"];
            break;
        case kLightReminderSunriseParadox:
            return [UIImage imageNamed:@"marker_round_lucid_dream.png"];
            break;
        case kLightReminderTimeInBed:
            return [UIImage imageNamed:@"marker_round_black.png"];
            break;
        case kLightReminderRiseTime:
            return [UIImage imageNamed:@"marker_round_sunrise.png"];
            break;
        case kLightReminderBlank:
            return nil;
        default:
              NSLog(@"Check your dial marker tag, it's out of bounds!");
            return nil;
            break;
    }
    
}

+(NSString*)personalityStringForTag:(int)tag
{
 
    switch (tag) {
        case kINTJ:
            return @"INTJ";
            break;
        case kINTP:
            return @"INTP";
            break;
        case kINFP:
            return @"INFP";
            break;
        case kISFP:
            return @"ISFP";
            break;
        case kISTP:
            return @"ISTP";
            break;
        case kESTP:
            return @"ESTP";
            break;
        case kESFP:
            return @"ESFP";
            break;
        case kENFP:
            return @"ENFP";
            break;
        case kENTP:
            return @"ENTP";
            break;
        case kENTJ:
            return @"ENTJ";
            break;
        case kESTJ:
            return @"ESTJ";
            break;
        case kESFJ:
            return @"ESFJ";
            break;
        case kISTJ:
            return @"ISTJ";
            break;
        case kISFJ:
            return @"ISFJ";
            break;
        case kINFJ:
            return @"INFJ";
            break;
            
            
        default:
             NSLog(@"Check your personality string tag, it's out of bounds!");
            return @"";
            break;
    }

}

+(NSString*)artistNameForReminderTag:(int)tag{
    switch (tag) {
        case kLightReminderSingularity:
            return NSLocalizedString(@"By Dave Brenner", @"Singularity light reminder ");
            break;
        case kLightReminderPureLight:
            return nil;
            
            break;
        case kLightReminderSilver:
            return NSLocalizedString(@"By Mike Nowa", @"Void light reminder ");
            break;
        case kLightReminderOrange:
            return NSLocalizedString(@"By Dmitriy Rodionov", @"");
            
            break;
            //        case kLightReminderGreen:
            //            return [UIImage imageNamed:@"marker_round_silver.png"];
            //            break;
        case kLightReminderBlue:
            return NSLocalizedString(@"By Dmitriy Rodionov", @"");
            
            break;
        case kLightReminderRed:
            return NSLocalizedString(@"By Mike Nowa", @"Void light reminder ");
            
            break;
        case kLightReminderSunrise:
            return NSLocalizedString(@"By Jack White", @"sunset light reminder ");
            
            break;
        case kLightReminderSunset:
            return NSLocalizedString(@"By Jack White", @"Singularity light reminder ");
            
            break;
        case kLightReminderSunriseParadox:
           
            break;
        default:
            NSLog(@"Check your artistNameForReminderTag, it's out of bounds!");
            return nil;
            break;
    }
    return nil;
}
+(NSString*)trackNameForReminderTag:(int)tag{
    switch (tag) {
        case kLightReminderSingularity:
            return NSLocalizedString(@"Warp", @"Singularity light reminder ");
            break;
        case kLightReminderPureLight:
            return NSLocalizedString(@"Young Light", @"Young Light light reminder ");
            
            break;
        case kLightReminderSilver:
            return NSLocalizedString(@"Black Magic", @"Void light reminder ");
            break;
        case kLightReminderOrange:
            return NSLocalizedString(@"Technical Progress", @"");
            
            break;
            //        case kLightReminderGreen:
            //            return [UIImage imageNamed:@"marker_round_silver.png"];
            //            break;
        case kLightReminderBlue:
            return NSLocalizedString(@"Underwater Melody", @"");
            
            break;
        case kLightReminderRed:
            return NSLocalizedString(@"Final Glory", @"");
            break;
        case kLightReminderSunrise:
            return NSLocalizedString(@"Daybreak", @"");
            
            break;
        case kLightReminderSunset:
            return NSLocalizedString(@"Transfiguration", @"Singularity light reminder ");
            
            break;
        case kLightReminderSunriseParadox:
            return nil;
            break;
        default:
            NSLog(@"Check your reminder name tag, it's out of bounds!");
            return nil;
            break;
    }
    return nil;
}
+(NSURL*)urlForTrackWithReminderTag:(int)tag{
    switch (tag) {
        case kLightReminderSingularity:
            return [NSURL URLWithString:@"http://www.melodyloops.com/composers/dave-brenner/"];
            
            break;
        case kLightReminderPureLight:
            
            
            break;
            
        case kLightReminderSilver:
           return[NSURL URLWithString:@"http://www.melodyloops.com/composers/mike-nowa/"];
            break;
        case kLightReminderOrange:
            return [NSURL URLWithString:@"http://www.melodyloops.com/composers/dmitriy-rodionov/"];
            
            break;
            //        case kLightReminderGreen:
            //            return [UIImage imageNamed:@"marker_round_silver.png"];
            //            break;
        case kLightReminderBlue:
           [NSURL URLWithString:@"http://www.melodyloops.com/composers/dmitriy-rodionov/"];
            
            break;
        case kLightReminderRed:
           return [NSURL URLWithString:@"http://www.melodyloops.com/composers/mike-nowa/"];
                      break;
        case kLightReminderSunrise:
            [NSURL URLWithString:@"http://www.melodyloops.com/composers/jack-white/"];
                       break;
        case kLightReminderSunset:
          return  [NSURL URLWithString:@"http://www.melodyloops.com/composers/jack-white/"];
            break;
        case kLightReminderSunriseParadox:
            return nil;
            break;
        default:
            NSLog(@"Check your reminder name tag, it's out of bounds!");
            return nil;
            break;
    }
    return nil;
}


+(UIImage*)mainMenuButtonImageWithTag:(int)eventTypeTag{
    UIImage* returnValue = nil;
    switch (eventTypeTag) {
            
        case kFood:
       
        case kMeal:
      
        case kSnack:
     
        case kCoffee:
       
        case kWine:
            returnValue = [AppColors buttonImage:kSilverButtonImage];
            break;
        case kSleep:
        
        case kBedtime:
       
        case kRiseTime:
       
        case kNoDream:
        
        case kDream:
         returnValue = [AppColors buttonImage: kGreenButtonImage];
            break;
        case kExercise:
        
        case kCardio:
        
        case kStrength:
       
        case kYingYang:
        
        case kScale:
         returnValue = [AppColors buttonImage:kRedButtonImage];
            break;
        case kWork:
        
        case kWorking:
        
        case kWeb:
        
        case kTaskComplete:
        
        case kCommute:
        returnValue = [AppColors buttonImage: kBlueButtonImage];
            break;
        case kMood:
           
        case kPositive:
       
        case kNegative:
       
        case kRomance:
        
        case kFriendship:
        returnValue = [AppColors buttonImage:kOrangeButtonImage];
            break;
        case kNumberOfAppEvents:
        default:
            break;
    }
    return    returnValue;

}

+(UIImage*)eventMarkerButtonImageWithTag:(int)eventTypeTag{
    UIImage* returnValue = nil;
    switch (eventTypeTag) {
            
        case kFood:
            
        case kMeal:
            
        case kSnack:
            
        case kCoffee:
            
        case kWine:
            returnValue = [AppColors markerImage: kSilverRoundMarker];
            break;
        case kSleep:
            
        case kBedtime:
            
        case kRiseTime:
            
        case kNoDream:
            
        case kDream:
            returnValue = [AppColors markerImage:kGreenRoundMarker];
            break;
        case kExercise:
            
        case kCardio:
            
        case kStrength:
            
        case kYingYang:
            
        case kScale:
            returnValue = [AppColors markerImage:kRedRoundMarker];
            break;
        case kWork:
            
        case kWorking:
            
        case kWeb:
            
        case kTaskComplete:
            
        case kCommute:
            returnValue =[AppColors markerImage:  kBlueRoundMarker];
            break;
        case kMood:
            
        case kPositive:
            
        case kNegative:
            
        case kRomance:
            
        case kFriendship:
            returnValue =[AppColors markerImage:kOrangeRoundMarker];
            break;
        case kNumberOfAppEvents:
        default:
            break;
    }
    return    returnValue;
    
}



+(UIImage*)eventSliderImageWithTag:(int)eventTypeTag{
    UIImage* returnValue = nil;
    switch (eventTypeTag) {
            
        case kFood:
            
        case kMeal:
            
        case kSnack:
            
        case kCoffee:
            
        case kWine:
            returnValue = [AppColors buttonImage:kSliderSilverButtonImage ];
            break;
        case kSleep:
            
        case kBedtime:
            
        case kRiseTime:
            
        case kNoDream:
            
        case kDream:
            returnValue = [AppColors buttonImage:kSliderGreenButtonImage];
            break;
        case kExercise:
            
        case kCardio:
            
        case kStrength:
            
        case kYingYang:
            
        case kScale:
            returnValue = [AppColors buttonImage:kSliderRedButtonImage];
            break;
        case kWork:
            
        case kWorking:
            
        case kWeb:
            
        case kTaskComplete:
            
        case kCommute:
            returnValue = [AppColors buttonImage:kSliderBlueButtonImage  ];
            break;
        case kMood:
            
        case kPositive:
            
        case kNegative:
            
        case kRomance:
            
        case kFriendship:
            returnValue = [AppColors buttonImage:kSliderOrangeButtonImage];
            break;
        case kNumberOfAppEvents:
        default:
            break;
    }
    return    returnValue;
    
}



+(UIImage*)eventIconWithTag:(int)eventTypeTag
{
    
    UIImage* returnValue = nil;
    switch (eventTypeTag) {
            
        case kFood:
        {
            returnValue = [UIImage imageNamed:@"meal"];
            break;
        }
        case kMeal:
        {
             returnValue = [UIImage imageNamed:@"meal"];
            break;
        }
        case kSnack:
        {
             returnValue = [UIImage imageNamed:@"snack"];
            break;
        }
        case kCoffee:
        {
             returnValue = [UIImage imageNamed:@"coffee"];
            break;
        }
        case kWine:
        {
             returnValue = [UIImage imageNamed:@"wine"];
            break;
        }
        case kSleep:
        {
             returnValue = [UIImage imageNamed:@"sleep"];
            break;
        }
        case kBedtime:
        {
             returnValue = [UIImage imageNamed:@"sleep"];
            break;
        }
        case kRiseTime:
        {
             returnValue = [UIImage imageNamed:@"morning"];
            break;
        }
        case kNoDream:
        {
             returnValue = [UIImage imageNamed:@"chronometer"];
            break;
        }
        case kDream:
        {
             returnValue = [UIImage imageNamed:@"pagepencil"];
            break;
        }
        case kExercise:
        {
             returnValue = [UIImage imageNamed:@"cardio"];
            break;
        }
        case kCardio:
        {
             returnValue = [UIImage imageNamed:@"cardio"];
            break;
        }
        case kStrength:
        {
             returnValue = [UIImage imageNamed:@"strength"];
            break;
        }
        case kYingYang:
        {
             returnValue = [UIImage imageNamed:@"meditation"];
            break;
        }
        case kScale:
        {
             returnValue = [UIImage imageNamed:@"weight"];
            break;
            
        }
        case kWork:
        {
             returnValue = [UIImage imageNamed:@"monitorh"];
            break;
        }
        case kWorking:
        {
             returnValue = [UIImage imageNamed:@"monitorh"];
            break;
        }
        case kWeb:
        {
             returnValue = [UIImage imageNamed:@"worldh"];
            break;
        }
        case kTaskComplete:
        {
             returnValue = [UIImage imageNamed:@"task"];
            break;
        }
        case kCommute:
        {
             returnValue = [UIImage imageNamed:@"car"];
            break;
        }
        case kMood:
        {
             returnValue = [UIImage imageNamed:@"thoughtbubble"];
            break;
        }   
        case kPositive:
        {
             returnValue = [UIImage imageNamed:@"thumbup"];
            break;
        }
        case kNegative:
        {
             returnValue = [UIImage imageNamed:@"thumbdown"];
            break;
        }
        case kRomance:
        {
             returnValue = [UIImage imageNamed:@"heartplus"];
            break;
        }
        case kFriendship:
        {
             returnValue = [UIImage imageNamed:@"conversation"];
            break;
        }   
        case kNumberOfAppEvents:
        default:
            break;
    }
    return    returnValue;
}

+(UIImage*)backgroundImageWithTag:(int)tag
{
    switch (tag) {
        case kRadiantImage:
            return [UIImage imageNamed:@"my_life_radiant_background_blue.png"];
            break;
        case kReportingImage:
//            return [UIImage imageNamed:@"reporting-background.png"];
            return [UIImage imageNamed:@"detail-background.png"];
            break;
        case kDetailImage:
            return [UIImage imageNamed:@"detail-background.png"];
            break;
        case kNightModeImage:
            return [UIImage imageNamed:@"space_background.jpg"];
            break;
        default:
            return nil;
            break;
    }
}

+(UIImage*)doHueAdjustFilterWithBaseImage:(UIImage*)baseImage hueAdjust:(CGFloat)hueAdjust
{
    
    CIImage *inputImage = [[CIImage alloc] initWithImage:baseImage];
    
    CIFilter * controlsFilter = [CIFilter filterWithName:@"CIHueAdjust"];
    [controlsFilter setValue:inputImage forKey:kCIInputImageKey];
    
    //main filter parameter - controls the hue adjust angle
    [controlsFilter setValue:[NSNumber numberWithFloat:hueAdjust] forKey:@"inputAngle"];
    
    CIImage *displayImage = controlsFilter.outputImage;
    UIImage *finalImage = [UIImage imageWithCIImage:displayImage];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    if (displayImage == nil || finalImage == nil) {
        // We did not get output image. Let's display the original image itself.
        return  baseImage;
    }else {
        // We got output image. Display it.
        CGImageRef cgImage = [context createCGImage:displayImage fromRect:displayImage.extent];
        UIImage* finalImage = [UIImage imageWithCGImage:cgImage];
        CFRelease(cgImage);
        return  finalImage;
    }
    
}
+(UIImage*)doSepiaFilterWithBaseImage:(UIImage*)baseImage inputIntensity:(CGFloat)inputIntensity
{
    
    CIImage *inputImage = [[CIImage alloc] initWithImage:baseImage];
    
    CIFilter * controlsFilter = [CIFilter filterWithName:@"CISepiaTone"];
    [controlsFilter setValue:inputImage forKey:kCIInputImageKey];
    
    //main filter parameter - controls the hue adjust angle
    [controlsFilter setValue:[NSNumber numberWithFloat:inputIntensity] forKey:@"inputIntensity"];
    
    CIImage *displayImage = controlsFilter.outputImage;
    UIImage *finalImage = [UIImage imageWithCIImage:displayImage];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    if (displayImage == nil || finalImage == nil) {
        // We did not get output image. Let's display the original image itself.
        return  baseImage;
    }else {
        // We got output image. Display it.
        CGImageRef cgImage = [context createCGImage:displayImage fromRect:displayImage.extent];
        UIImage* finalImage = [UIImage imageWithCGImage:cgImage];
        CFRelease(cgImage);
        return  finalImage;
    }
    
}


/**
 Performs hue adjust (color change) on every pixel of the passed in image, 
 producing an output image of a different color
 hue adjust is in range -3.14 to 3.14
 */
+(UIImage*)doHueAdjustFilterWithBaseImageName:(NSString*)baseImageName hueAdjust:(CGFloat)hueAdjust
{
    return [AppColors doHueAdjustFilterWithBaseImage:[UIImage imageNamed:baseImageName] hueAdjust:hueAdjust]   ; 
}

+(UIImage*)doSepiaFilterWithBaseImageName:(NSString*)baseImageName hueAdjust:(CGFloat)inputIntensity
{
    return [AppColors doSepiaFilterWithBaseImage:[UIImage imageNamed:baseImageName] inputIntensity:inputIntensity];
}

+(UIImage*)doRadialGradientFilter:(NSString*)baseImageName 
{
    
    CIFilter* controlsFilter  = [CIFilter filterWithName: @"CIRadialGradient" keysAndValues:
                   @"inputColor1", [CIColor colorWithRed:0.0 green:0.0
                                                    blue:0.0 alpha:0.0], @"inputColor0", [CIColor colorWithRed:0.0 green:0.0
                                                                                                          blue:0.5 alpha:0.5], @"inputRadius0", [NSNumber numberWithDouble:0.0], nil];
    
    
    CIImage *displayImage = controlsFilter.outputImage;
    UIImage *finalImage = [UIImage imageWithCIImage:displayImage];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    if (displayImage == nil || finalImage == nil) {
        // We did not get output image. Let's display the original image itself.
        return  [UIImage imageNamed:baseImageName];
    }else {
        // We got output image. Display it.
        CGImageRef cgImage = [context createCGImage:displayImage fromRect:displayImage.extent];
        UIImage* finalImage = [UIImage imageWithCGImage:cgImage];
        CFRelease(cgImage);
        return  finalImage;
    }
    
}



+(UIImage*)doKaleidoscopeFilterWithBaseImageName:(NSString*)baseImageName inputCount:(CGFloat)inputCount
{
    
    CIImage *inputImage = [[CIImage alloc] initWithImage:[UIImage imageNamed:baseImageName]];
    CIFilter * controlsFilter = [CIFilter filterWithName:@"CIKaleidoscope"];
    
    if(controlsFilter == nil) NSLog(@"No such filter!");
    
    [controlsFilter setValue:inputImage forKey:kCIInputImageKey];

    [controlsFilter setValue:[NSNumber numberWithFloat:inputCount] forKey:@"inputAngle"];
    
        //        [controlsFilter setValue:[NSNumber numberWithFloat:inputCount] forKey:@"inputCount"];
    CIImage *displayImage = controlsFilter.outputImage;
    UIImage *finalImage = [UIImage imageWithCIImage:displayImage];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    if (displayImage == nil || finalImage == nil) {
        // We did not get output image. Let's display the original image itself.
        return  [UIImage imageNamed:baseImageName];
    }else {
        // We got output image. Display it.
        CGImageRef cgImage = [context createCGImage:displayImage fromRect:displayImage.extent];
        UIImage* finalImage = [UIImage imageWithCGImage:cgImage];
        CFRelease(cgImage);
        return  finalImage;    }
 
}


+(UIImage*)doStarshineFilterWithBaseImageName:(NSString*)baseImageName inputCount:(CGFloat)inputCount
{
CIFilter * starShineGenerator = [CIFilter filterWithName:@"CIStarShineGenerator"];
    [starShineGenerator setDefaults];
    
    
    //main filter parameter - controls the hue adjust angle
    [starShineGenerator setValue:[CIVector vectorWithX:50 Y:24] forKey:@"inputCenter"];
    [starShineGenerator setValue:[NSNumber numberWithInt:4] forKey:@"inputRadius"];
 
    CIImage *displayImage = starShineGenerator.outputImage;
    UIImage *finalImage = [UIImage imageWithCIImage:displayImage];

    CIImage *inputImage = [[CIImage alloc] initWithImage:[UIImage imageNamed:baseImageName]];
    
    CIFilter * sourceOverCompositing = [CIFilter filterWithName:@"CISourceOverCompositing"];
    [sourceOverCompositing setValue:displayImage forKey:kCIInputImageKey];
    [sourceOverCompositing setValue:inputImage forKey:@"inputBackgroundImage"];
    
    CIImage *compositeImage = [sourceOverCompositing valueForKey:@"outputImage"];
    
     CIContext *context = [CIContext contextWithOptions:nil];
    if (compositeImage == nil || finalImage == nil) {
        // We did not get output image. Let's display the original image itself.
        return  [UIImage imageNamed:baseImageName];
    }else {
        // We got output image. Display it.
        CGImageRef cgImage = [context createCGImage:displayImage fromRect:displayImage.extent];
        UIImage* finalImage = [UIImage imageWithCGImage:cgImage];
        CFRelease(cgImage);
        return  finalImage;
    }

}
+(BOOL)frameHasAccessoryWithTag:(int)tag
{
    switch (tag) {
        case kFrameNoFrame:
            return NO;
            break;
        case kFrameBasicBottomLeft:
            return NO;
        case kFrameBasicTopRight:
            return NO;
        case kFrameCompanyRight:
            return YES;
        case kFrameCompanyLeft:
            return YES;
        default:
            return NO;
            break;
    }
}



+(CGPoint)frameLabelCenterPointWithTag:(int)tag
{
    CGPoint kCGPointOffscreen =CGPointMake(-15, -15);
    CGPoint kPointBottomLeft = CGPointMake(32,98);
    CGPoint kPointBottomRight = CGPointMake(82,98);
    CGPoint kPointTopLeft = CGPointMake(32,12);
    CGPoint kPointTopRight =CGPointMake(82,12);
    
    switch (tag) {
        case kFrameNoFrame:
            return kCGPointOffscreen;
            break;
        case kFrameBasicBottomLeft:
            return kPointBottomLeft;
        case kFrameBasicTopRight:
            return kPointTopRight;
        case kFrameCompanyRight:
            return kPointTopRight;
        case kFrameCompanyLeft:
            return kPointTopLeft;
        default:
            
            return kCGPointOffscreen;
            break;
    }
}
 


+(NSString*)frameNameWithTag:(int)tag
{

    return [NSString stringWithFormat: @"frame %i.png",tag];
    
//    switch (tag) {
//        case kFrameNoFrame:
//            return @"";
//            break;
//        case kFrameBasicBottomLeft:
//            return @"frame_simple_512.png";
//        case kFrameBasicTopRight:
//            return @"frame_label_bottom_left_512.png";
//        case kFrameCompanyRight:
//            return @"labeled_gradient_frame_1.png";
//        case kFrameCompanyLeft:
//            return @"frame_label_bottom_left_512_2.png";
//        default:
//            return @"";
//            break;
//    }
}

+(NSString*)glossEffectWithTag:(int)tag
{
    
    return [NSString stringWithFormat: @"frame%i.png",tag];
}

+(NSString*)postcardFrameWithTag:(int)tag
{
    
    return [NSString stringWithFormat: @"postcard_%i.png",tag];
}


+ (UIImage*)imageByScalingAndCroppingImage:(UIImage*) sourceImage ForSize:(CGSize)targetSize
{
    UIImage *newImage = nil;        
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) 
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor) 
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5; 
        }
        else 
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }       
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) 
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}



@end
