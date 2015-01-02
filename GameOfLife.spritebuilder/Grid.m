//
//  Grid.m
//  GameOfLife
//
//  Created by Pablo Mora on 2/1/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Grid.h"
#import "Creature.h"

// these are variables that cannot be changed

static const int GRID_ROWS = 8;
static const int GRID_COLUMNS = 10;

@implementation Grid {
    NSMutableArray *_gridArray;
    float _cellWidth;
    float _cellHeight;
}

-(void)onEnter{
    
    [super onEnter];
    [self setupGrid];
    
    // accept touches on the grid
    
    self.userInteractionEnabled = YES;
}

-(void)setupGrid {
    // divide de grid size by the number of clumns rows ...
    
    _cellWidth = self.contentSize.width / GRID_COLUMNS;
    _cellHeight = self.contentSize.height / GRID_ROWS;
    
    float x = 0;
    float y = 0;
    
    // initialize the array as a blank NSMutableArray
    
    _gridArray = [NSMutableArray array];
    
    // initialize creatures
    
    for (int i=0; i < GRID_ROWS; i++){
        //this is how you create two dimensional arrays in ob-c
        _gridArray[i] = [NSMutableArray array];
        x=0;
        
        for (int j=0; j< GRID_COLUMNS; j++) {
            Creature *creature = [[Creature alloc] initCreature];
            creature.anchorPoint = ccp(0, 0);
            creature.position = ccp(x, y);
            [self addChild:creature];
            
            // shis is shorthand to access an array inside an array
            
            _gridArray[i][j] = creature;
            
            // makes criatures visible to test this method. to remove once knmow we fill the grid
            creature.isAlive = YES;
            
            x+= _cellWidth;
        }
        
        y+= _cellHeight;
    }
}

@end
