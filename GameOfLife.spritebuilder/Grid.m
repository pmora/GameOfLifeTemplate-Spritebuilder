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
            
           
            
            x+= _cellWidth;
        }
        
        y+= _cellHeight;
    }
}

-(void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    
    //get the x,y coordinates of the touch
    
    CGPoint touchLocation = [touch locationInNode:self];
    
    // get the creature at that location
    
    Creature *creature = [self creatureForTouchPosition:touchLocation];
    
    // invert it's state - kill it if it's alive, bring it to life if it's dead
    
    creature.isAlive = !creature.isAlive;
    
}

- (Creature *)creatureForTouchPosition:(CGPoint)touchPosition
{
    
    int row = touchPosition.y / _cellHeight;
    int column = touchPosition.x / _cellWidth;
    
    return _gridArray[row][column];
    
}

-(void)evolveStep
{
        // update each Creature's neighbor count
    [self countNeighbors];
    
    // update each creature's state
    [self updateCreatures];
    
    // update de generation son the label's text will display correct generation
    _generation++;
}

-(void)countNeighbors
{
    //iterate through the rows, note that nsarray has method coutn that returns elements
    
    for (int i =0; i < [_gridArray count]; i++)
    {
     //iterate through all the columns for a given row
        for (int j=0; j< [_gridArray[i] count]; j++)
        {
         //access the creature in the cell that corresponds to the current row column
            Creature *currentCreature = _gridArray[i][j];
            
        // remember that every crature has living neighbors property
            currentCreature.livingNeighbors = 0;
        //examine every cell around the current one
        // go through the row on top of the current cell, de row the cell it is in, and the row past the current
            for (int x = (i-1); x <= (i+1); x++)
            {
                // go through the column to the left of the current cell, column it is, and column past
                for (int y = (j-1);y <= (y+1); y++){
                    //check that the cell is not off screen
                    BOOL isIndexValid;
                    isIndexValid = [self isIndexValidForX:x andY:y];
                    
                    //skip over all cells that are off screen and the cell that contains
                    if (!((x==i) && (y == j)) && isIndexValid);
                    {
                        Creature *neighbor = _gridArray[x][y];
                        if (neighbor.isAlive)
                        {
                            currentCreature.livingNeighbors += 1;
                        }
                    }
                }
            }
        
        }
        
    }
}

-(BOOL)isIndexValidForX:(int)x andY:(int)y{
    
    BOOL isIndexValid = YES;
    if ( x < 0 || y < 0 || x >= GRID_ROWS || y >= GRID_COLUMNS)
    {
        isIndexValid = NO;
    }
    return isIndexValid;
}

-(void)updateCreatures {
    
    for (int i = 0; i < [_gridArray count]; i++)
    {
        for (int j = 0; j < [_gridArray[i] count]; j++)
        {
            Creature *currentCreature = _gridArray[i][j];
            
            if (currentCreature.livingNeighbors == 3)
            {
                currentCreature.isAlive = TRUE;
            }
            else if (currentCreature.livingNeighbors <= 1 || currentCreature.livingNeighbors >=4)
            {
                currentCreature.isAlive = FALSE;
            }
            
        }
    }
    
}

@end
