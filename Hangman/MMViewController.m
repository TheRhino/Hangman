//
//  MMViewController.m
//  Hangman
//
//  Created by RHINO on 3/9/13.
//  Copyright (c) 2013 RHINO. All rights reserved.
//

#import "MMViewController.h"

@interface MMViewController ()

//Define the properties
@property (weak, nonatomic) IBOutlet UIImageView *hangImage;
@property (weak, nonatomic) IBOutlet UILabel *hangWordLabel;
@property (weak, nonatomic) NSString *correctWord;
@property (weak, nonatomic) NSString *wrongLetters;

//Define the methods to check letters and set words
- (void)checkHangLetter: (NSString *) letterCheck;
- (void)setHangWord: (NSString *) hangWord;

@end

@implementation MMViewController

//synthesize the property variables
@synthesize hangImage;
@synthesize hangWordLabel;
@synthesize correctWord;
@synthesize wrongLetters;

//Overirde UITextField Method to respond to the delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //Check for needed letters in the word
    [self checkHangLetter:string];
    
    //Hide the keyboard after a letter is choosen
    [textField resignFirstResponder];
    
    //This will remove the letter entered in the text field
    return NO;
}

//Add function defined in the header file
- (void) checkHangLetter: (NSString *) letterCheck

{
    BOOL match = NO;
    
    NSRange hangLetterRange;
    //Change letter to a char
    char charToCheck = [letterCheck characterAtIndex:0];
    //Loop through each letter
    for (int i = 0; i < self.correctWord.length; i++)
    {
        //Assign letter to a temporary char variable
        char tempString = [self.correctWord characterAtIndex:i];
        
        //Compare the letter typed in the text box to the letters in the correct word
        if (charToCheck == tempString)
        {
            //If there is a match, place that letter in the appropriate location
            match = YES;
            hangLetterRange = NSMakeRange(i, 1);
            
            //Replace the area in the label with the correct letter that was choosen
            self.hangWordLabel.text = [self.hangWordLabel.text stringByReplacingCharactersInRange:hangLetterRange withString:letterCheck];
        }
    }
    //If the letter does not match any letters in the word
    if (match == NO) {
        //Add wrong letters into the string, ignore if wrong letter was choosen twice
        self.wrongLetters = [self.wrongLetters stringByReplacingOccurrencesOfString:letterCheck withString:@""];
        
        //Append the wrong letter into the wrong letter string
        self.wrongLetters = [self.wrongLetters stringByAppendingString:letterCheck];
        
        //Update hangman image if the wrong letters are choosen
        switch (self.wrongLetters.length) {
            case 1:
                self.hangImage.image = [UIImage imageNamed:@"hang_1.png"];
                break;
            case 2:
                self.hangImage.image = [UIImage imageNamed:@"hang_2.png"];
                break;
            case 3:
                self.hangImage.image = [UIImage imageNamed:@"hang_3.png"];
                break;
            case 4:
                self.hangImage.image = [UIImage imageNamed:@"hang_4.png"];
                break;
            case 5:
                self.hangImage.image = [UIImage imageNamed:@"hang_5.png"];
                break;
            case 6:
                self.hangImage.image = [UIImage imageNamed:@"hang_done.png"];
                break;
                
            default:
                [self setHangWord:self.correctWord];
                break;
        }
    }
    
}

//Add function defined in the header file - This should have API functionality
- (void)setHangWord: (NSString *) hangWord
{
    //Reset the wrong letters
    self.wrongLetters = @"";
    //Reset the label
    self.hangWordLabel.text = @"";
    //Reset the image
    self.hangImage.image = [UIImage imageNamed:@"hang_start.png"];
    
    //How long is the hangman word?
    for (int i = 0; i < hangWord.length; i++)
    {
        //Add a dash to represent the letters in the word - How many letters are we looking for?
        self.hangWordLabel.text = [self.hangWordLabel.text stringByAppendingString:@"-"];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Hardcode a word to see if everything works - Add API functionality
    self.correctWord = @"rhino";
    [self setHangWord:self.correctWord];
    
 
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
