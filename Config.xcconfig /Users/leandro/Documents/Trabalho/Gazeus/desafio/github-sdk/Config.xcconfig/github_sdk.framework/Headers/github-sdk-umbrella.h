#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "GitHubSDK.h"
#import "Repo.h"
#import "Tag.h"

FOUNDATION_EXPORT double github_sdkVersionNumber;
FOUNDATION_EXPORT const unsigned char github_sdkVersionString[];

