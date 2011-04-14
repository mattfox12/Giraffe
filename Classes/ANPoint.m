//
//  ANPoint.m
//  Giraffe
//
//  Created by Matthew Klundt on 4/10/11.
//  Copyright 2011 Terrible Games. All rights reserved.
//

#import "ANPoint.h"


@implementation ANPoint

@synthesize r, g, b;

- (id) initWithR:(int)givenR withG:(int)givenG withB:(int)givenB {
	self = [super init];
	
	r = givenR;
	g = givenG;
	b = givenB;
	
	return self;
}

- (id) initWithR:(int)givenR withG:(int)givenG withB:(int)givenB withA:(int)givenA withMatteR:(int)givenMR withMatteG:(int)givenMG withMatteB:(int)givenMB {
	self = [super init];
	
	// create matted rgb based on alpha, given matte color
	float newR = ((float)givenR/255.0f * (float)givenA) + ((float)(255 - givenA) / 255.0f) * (float)givenMR/255.0f; // RF + (1 - AF)×RB
	float newG = ((float)givenG/255.0f * (float)givenA) + ((float)(255 - givenA) / 255.0f) * (float)givenMG/255.0f; // RF + (1 - AF)×RB
	float newB = ((float)givenB/255.0f * (float)givenA) + ((float)(255 - givenA) / 255.0f) * (float)givenMB/255.0f; // RF + (1 - AF)×RB
	
	r = (int)(newR * 255.0f);
	g = (int)(newG * 255.0f);
	b = (int)(newB * 255.0f);
	
	return self;
}

#pragma mark -

- (int) getR {
	return r;
}

- (int) getG {
	return g;
}

- (int) getB {
	return b;
}

- (float) getDistanceFrom:(ANPoint*)givenPoint {
	int rDist = r - givenPoint.r;
	int gDist = g - givenPoint.g;
	int bDist = b - givenPoint.b;
	
	return sqrtf(rDist * rDist + gDist * gDist + bDist * bDist);
}

#pragma mark -

- (NSComparisonResult) rSort:(ANPoint*) other {
	if (self->r > other->r) return NSOrderedDescending;
	if (self->r < other->r) return NSOrderedAscending;
	
	// The logical thing to do at this point is to return NSOrderedSame, but that causes flickering when two items are overlapping at the same y.
	// Instead,one must be drawn over the other deterministically... we use the memory addresses of the entities for a tie-breaker.
	if (self > other) return NSOrderedDescending;
	return NSOrderedAscending;
}
- (NSComparisonResult) gSort:(ANPoint*) other {
	if (self->g > other->g) return NSOrderedDescending;
	if (self->g < other->g) return NSOrderedAscending;
	
	// The logical thing to do at this point is to return NSOrderedSame, but that causes flickering when two items are overlapping at the same y.
	// Instead,one must be drawn over the other deterministically... we use the memory addresses of the entities for a tie-breaker.
	if (self > other) return NSOrderedDescending;
	return NSOrderedAscending;
}
- (NSComparisonResult) bSort:(ANPoint*) other {
	if (self->b > other->b) return NSOrderedDescending;
	if (self->b < other->b) return NSOrderedAscending;
	
	// The logical thing to do at this point is to return NSOrderedSame, but that causes flickering when two items are overlapping at the same y.
	// Instead,one must be drawn over the other deterministically... we use the memory addresses of the entities for a tie-breaker.
	if (self > other) return NSOrderedDescending;
	return NSOrderedAscending;
}

@end
