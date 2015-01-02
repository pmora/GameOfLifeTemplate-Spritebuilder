//
//  Creature.m
//  GameOfLife
//
//  Created by Pablo Mora on 2/1/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Creature.h"

@implementation Creature


-(instancetype)initCreature {
    //since we made Creature inherit form CCSprite, super below referso to CCsprite
    
    self = [super initWithImageNamed:@"GameOfLifeAssets/Assets/bubble.png"];
    
    if (self)   {
        self.isAlive = NO;
    }
    
    return self;
}


-(void)setIsAlive:(BOOL)newState {
    // when youc reate an @property as we did in the .h, an instance variable with a leading underscore is created
    
    _isAlive = newState;
    
    // visible is a property of any class that inherits from ccnode. ccsprite does
    self.visible = _isAlive;
}


@end
