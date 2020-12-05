//
//  pickerViewPad.m
//  Midi file player
//
//  Created by Walter Schurter on 09.12.13.
//  Copyright (c) 2013 Walter Schurter WASElectronic. All rights reserved.
//

#import "pickerViewPad.h"
#import "AppDelegate.h"
#import "ViewControllerPad.h"
#import <QuartzCore/QuartzCore.h>
#import <MessageUI/MessageUI.h>

@interface pickerViewPad ()

@end

@implementation pickerViewPad

@synthesize buttonOK;
@synthesize buttonCancel;
@synthesize buttonEdit;
@synthesize buttonSearch;
@synthesize buttonSearchNext;
@synthesize buttonDelete;
@synthesize textFieldEditFileName;
@synthesize pickerFiles;
@synthesize labelRenameSearch;
@synthesize buttonMail;
@synthesize buttonPrevious;
@synthesize buttonNext;
@synthesize buttonTopList;
@synthesize buttonEndList;
@synthesize buttonAddFavorites;
@synthesize buttonRemoveFavorites;
@synthesize buttonGoToFavorites;

bool searchMode = FALSE;
bool renameMode = FALSE;
int starPosition = -1;
int countList = 0;

- (BOOL)shouldAutorotate {
    [UIView setAnimationsEnabled:NO];
    return TRUE;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}
-  (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerViewPad;
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //    mlabel.text = [arrayNo objectAtIndex:row];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return [midiFilesForPicker count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    return midiFilesForPicker[row];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *pickerLabel = (UILabel *)view;
    if (pickerLabel == nil) {
        CGRect frame = CGRectMake(0.0, 0.0, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height);
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setShadowColor:[UIColor blackColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:21]];
        [pickerLabel setTextAlignment:1];
    }
    [pickerLabel setText:listArrayForPicker[row]];
    return pickerLabel;
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:FALSE];
    //    pickerViewIsVisible = TRUE;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:FALSE];
    //    pickerViewIsVisible = FALSE;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    
    viewContPad=[[ViewControllerPad alloc]init];
    [viewContPad buttonStopPressed:nil];
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    
    textFieldEditFileName.keyboardAppearance = UIKeyboardAppearanceDark;
    
    [self doSomeInit];
}

- (void) doSomeInit {
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];  // hide keyboard
    
    pickerFiles.hidden = FALSE;
    
    nameChanged = FALSE;
    searchMode = FALSE;
    renameMode = FALSE;
    starPosition = -1;
    
    [pickerFiles setUserInteractionEnabled:YES];
    [pickerFiles setAlpha:1.0];

    buttonEdit.hidden = FALSE;
    buttonSearch.hidden = FALSE;
    buttonDelete.hidden = FALSE;
    buttonMail.hidden = FALSE;
    buttonSearchNext.hidden = FALSE;
    buttonNext.hidden = FALSE;
    buttonPrevious.hidden = FALSE;
    buttonTopList.hidden = FALSE;
    buttonEndList.hidden = FALSE;
    buttonAddFavorites.hidden = FALSE;
    buttonRemoveFavorites.hidden = FALSE;
    buttonGoToFavorites.hidden = FALSE;
    
    labelRenameSearch.hidden = TRUE;
    
    buttonOK.clipsToBounds = YES;
    buttonCancel.clipsToBounds = YES;
    buttonEdit.clipsToBounds = YES;
    buttonSearch.clipsToBounds = YES;
    buttonSearchNext.clipsToBounds = YES;
    buttonDelete.clipsToBounds = YES;
    buttonMail.clipsToBounds = YES;
    buttonPrevious.clipsToBounds = YES;
    buttonNext.clipsToBounds = YES;
    buttonTopList.clipsToBounds = YES;
    buttonEndList.clipsToBounds = YES;
    buttonAddFavorites.clipsToBounds = YES;
    buttonRemoveFavorites.clipsToBounds = YES;
    buttonGoToFavorites.clipsToBounds = YES;
    
    buttonOK.layer.cornerRadius = 10;
    buttonCancel.layer.cornerRadius = 10;
    buttonEdit.layer.cornerRadius = 10;
    buttonSearch.layer.cornerRadius = 10;
    buttonSearchNext.layer.cornerRadius = 10;
    buttonDelete.layer.cornerRadius = 10;
    buttonMail.layer.cornerRadius = 10;
    buttonPrevious.layer.cornerRadius = 10;
    buttonNext.layer.cornerRadius = 10;
    buttonTopList.layer.cornerRadius = 10;
    buttonEndList.layer.cornerRadius = 10;
    buttonAddFavorites.layer.cornerRadius = 10;
    buttonRemoveFavorites.layer.cornerRadius = 10;
    buttonGoToFavorites.layer.cornerRadius = 10;
    
    [midiFilesForPicker removeAllObjects];
    midiFilesForPicker = [[NSMutableArray alloc] init];
    
    [self loadList];
    
    if (countList > 0) {
        [midiFilesPicker selectRow:selectedIndex inComponent:0 animated:NO];
        midiFilename = midiFilesForPicker[selectedIndex];
        textFieldEditFileName.hidden = TRUE;
    }
    else {
        midiFilename= [NSString stringWithFormat:@"%@", textForNoFiles];
        buttonOK.hidden = TRUE;
        buttonEdit.hidden = TRUE;
        buttonSearch.hidden = TRUE;
        buttonDelete.hidden = TRUE;
        buttonMail.hidden = TRUE;
        buttonAddFavorites.hidden = TRUE;
        buttonRemoveFavorites.hidden = TRUE;
        buttonGoToFavorites.hidden = TRUE;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)pickerTap {
    // do not use this
}

- (void) loadList {
    countList = (int)[listArrayForPicker count];
    starPosition = -1;
    for (int i = 0; i < countList; i++){
        [midiFilesForPicker addObject:listArrayForPicker[i]];
        if (starPosition < 0) {
            if ([[midiFilesForPicker[i] substringWithRange:NSMakeRange(0, 1)] isEqual: @"*"]) {
                starPosition = i;
            }
        }
    }
    [midiFilesPicker reloadAllComponents];
}

- (IBAction)buttonCancelPressed:(id)sender {
    if (searchMode || renameMode) {
        [viewContPad parseDir];
        midiFilesForPicker = [[NSMutableArray alloc] init];
        [self loadList];
        [self doSomeInit];
    }
    else {
        [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
        textFieldEditFileName.hidden = TRUE;
        transposeValue = 0;
        backFromOtherView = TRUE;
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

- (IBAction)buttonOKpressed:(id)sender {
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    if (countList == 0) {
        [self buttonCancelPressed :nil];
        return;
    }
    
    textFieldEditFileName.hidden = TRUE;
    selectedIndex = (int)[midiFilesPicker selectedRowInComponent:0];
    
    if (renameMode) {
        if (nameChanged) {
            midiFilename = [NSString stringWithFormat:@"%@%@", textFieldEditFileName.text, @".mid" ];
            // Move the file
            bool errorMove = FALSE;
            if ([[NSFileManager defaultManager] moveItemAtPath:[documentsDirectoryPath stringByAppendingPathComponent:listArrayForPicker[selectedIndex]] toPath:[documentsDirectoryPath stringByAppendingPathComponent:midiFilename] error: NULL] == NO)
                errorMove = TRUE;
            if (errorMove) {
                alertP = [[UIAlertView alloc]initWithTitle: @"Information"
                                                  message: @"Renaming file in the shared iTunes folder was not successful (e.g. file name was not changed)!"
                                                 delegate: self
                                        cancelButtonTitle: nil
                                        otherButtonTitles:@"OK",nil];
                [alertP show];
            }
            else {
                usleep(200);
            }
            [viewContPad saveLastSelectedMIDIfile];
            [viewContPad parseDir];
            midiFilesForPicker = [[NSMutableArray alloc] init];
            [self loadList];
            [self doSomeInit];
        }
        else {
            midiFilename = midiFilesForPicker[selectedIndex];
        }
        
        pickerFiles.hidden = FALSE;
        
    }
    else if (searchMode) {
        [self searchString:textFieldEditFileName.text];
        if (indexOfTheObjectP != -1) {
            selectedIndex = indexOfTheObjectP;
            midiFilename = midiFilesForPicker[selectedIndex];
            [viewContPad saveLastSelectedMIDIfile];
        }
        else {
            alertNotfoundP = [[UIAlertView alloc]initWithTitle: @"Search result"
                                                      message: [NSString stringWithFormat:@"\n%@\n\"%@\"\n%@", @"Word", textFieldEditFileName.text, @"not found!"]
                                                     delegate: self
                                            cancelButtonTitle: nil
                                            otherButtonTitles:@"OK",nil];
            [alertNotfoundP show];
        }
        [self doSomeInit];
        [self.view endEditing:YES];
        [self.view addSubview:pickerFiles];
    }
    else {
        midiFilename = midiFilesForPicker[selectedIndex];
        [viewContPad saveLastSelectedMIDIfile];
        transposeValue = 0;
        backFromOtherView = TRUE;
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    
}

// Connect to first responder "Did end on exit"
- (IBAction)ReturnKeyButton:(id)sender {
    [sender resignFirstResponder];
    [self buttonOKpressed:nil];
}

- (IBAction)buttonEditPressed:(id)sender {
    if (countList == 0) return;
    
    searchMode = FALSE;
    renameMode = TRUE;
    
    [pickerFiles setUserInteractionEnabled:NO];
    [pickerFiles setAlpha:.5];
    
    buttonSearch.hidden = TRUE;
    buttonSearchNext.hidden = TRUE;
    buttonEdit.hidden = TRUE;
    buttonDelete.hidden = TRUE;
    buttonMail.hidden = TRUE;
    buttonNext.hidden = TRUE;
    buttonPrevious.hidden = TRUE;
    buttonTopList.hidden = TRUE;
    buttonEndList.hidden = TRUE;
    buttonAddFavorites.hidden = TRUE;
    buttonRemoveFavorites.hidden = TRUE;
    buttonGoToFavorites.hidden = TRUE;
    
    labelRenameSearch.text = @"Change the name of the MIDI file";
    labelRenameSearch.hidden = FALSE;
    nameChanged = TRUE;
    selectedIndex = (int)[midiFilesPicker selectedRowInComponent:0];
    midiFilename = midiFilesForPicker[selectedIndex];
    midiFilenameWithoutExt = [midiFilename substringWithRange:NSMakeRange(0, midiFilename.length - 4)];
    textFieldEditFileName.hidden = FALSE;
    textFieldEditFileName.text = midiFilenameWithoutExt;
    [textFieldEditFileName becomeFirstResponder];
}

- (IBAction)buttonSearchPressed:(id)sender {
    if (countList == 0) return;
    selectedIndex = (int)[midiFilesPicker selectedRowInComponent:0];
    midiFilename = midiFilesForPicker[selectedIndex];
    [viewContPad saveLastSelectedMIDIfile];
    
    indexOfTheObjectP = -1;
    numberOfIndexesP = 0;
    indexCounterP = 0;
    searchMode = TRUE;
    renameMode = FALSE;
    
    [pickerFiles setUserInteractionEnabled:NO];
    [pickerFiles setAlpha:.5];

    buttonEdit.hidden = TRUE;
    buttonSearch.hidden = TRUE;
    buttonSearchNext.hidden = TRUE;
    buttonDelete.hidden = TRUE;
    buttonMail.hidden = TRUE;
    buttonNext.hidden = TRUE;
    buttonPrevious.hidden = TRUE;
    buttonTopList.hidden = TRUE;
    buttonEndList.hidden = TRUE;
    buttonAddFavorites.hidden = TRUE;
    buttonRemoveFavorites.hidden = TRUE;
    buttonGoToFavorites.hidden = TRUE;
    labelRenameSearch.text = @"Search a word in all MIDI files";
    labelRenameSearch.hidden = FALSE;
    nameChanged = FALSE;
    textFieldEditFileName.text = @"";
    textFieldEditFileName.hidden = FALSE;
    [textFieldEditFileName becomeFirstResponder];
}

- (IBAction)buttonSearchNextPressed:(id)sender {
    if (countList == 0) return;
    if (![textFieldEditFileName.text isEqual: @""]) {
        searchMode = FALSE;
        nameChanged = FALSE;
        if (indexCounterP < numberOfIndexesP-1) {
            indexCounterP++;
            indexOfTheObjectP = (int)[midiFilesForPicker indexOfObject: resultsearchP[indexCounterP]];
            selectedIndex = indexOfTheObjectP;
            midiFilename = midiFilesForPicker[selectedIndex];
            [midiFilesPicker selectRow:selectedIndex inComponent:0 animated:NO];
            [viewContPad saveLastSelectedMIDIfile];
        }
        else {
            alertNotfoundP = [[UIAlertView alloc]initWithTitle: @"Search result"
                                                      message: [NSString stringWithFormat:@"\n%@\n\"%@\"\n%@", @"Word", textFieldEditFileName.text, @"not found!"]
                                                     delegate: self
                                            cancelButtonTitle: nil
                                            otherButtonTitles:@"OK",nil];
            [alertNotfoundP show];
        }
    }
}

- (IBAction)buttonDeletePressed:(id)sender {
    // Delete the file
    if (listArrayCount > 0){
        selectedIndex = (int)[midiFilesPicker selectedRowInComponent:0];
        midiFilename = midiFilesForPicker[selectedIndex];
        if ([fileManager fileExistsAtPath:[documentsDirectoryPath stringByAppendingPathComponent:midiFilename]]){
            deleteAlert = [[UIAlertView alloc]initWithTitle: @"MIDI file to delete:"
                                                    message: [NSString stringWithFormat:@"%@\n\n%@", midiFilename, @"Delete this file now ?"]
                                                   delegate: self
                                          cancelButtonTitle: @"YES"
                                          otherButtonTitles: @"NO",nil];
            [deleteAlert show];
            // rest see deletion code below
        }
        else {
            [viewContPad parseDir];
            if (listArrayCount > 0){
                if (listArrayCount > 0){
                    if (selectedIndex >= listArrayCount){
                        selectedIndex = 0;
                    }
                    midiFilename = midiFilesForPicker[selectedIndex];
                    midiFilePath = [documentsDirectoryPath stringByAppendingPathComponent:listArrayForPicker[selectedIndex]];
                    [viewContPad saveLastSelectedMIDIfile];
                }
            }
            else {
                selectedIndex = 0;
                midiFilename = [NSString stringWithFormat:@"%@", textForNoFiles];
                midiFilePath = @"";
            }
        }
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(int)buttonIndex {
    // deletion code here
    if (alertView == deleteAlert){
        if (buttonIndex == 0) {
            [fileManager removeItemAtPath:[documentsDirectoryPath stringByAppendingPathComponent:listArrayForPicker[selectedIndex]] error:nil];
            usleep(200);
            [viewContPad parseDir];
            if (listArrayCount > 0){
                if (listArrayCount > 0){
                    if (selectedIndex >= listArrayCount){
                        selectedIndex = 0;
                    }
                    midiFilename = midiFilesForPicker[selectedIndex];
                    midiFilePath = [documentsDirectoryPath stringByAppendingPathComponent:listArrayForPicker[selectedIndex]];
                    [viewContPad saveLastSelectedMIDIfile];
                }
            }
            else {
                selectedIndex = 0;
                midiFilename = @"";
                midiFilePath = @"";
            }
            [viewContPad parseDir];
            midiFilesForPicker = [[NSMutableArray alloc] init];
            [self loadList];
        }
    }
    
}

- (IBAction)buttonPreviousPressed:(id)sender {
    if (countList == 0) return;
    searchMode = FALSE;
    nameChanged = FALSE;
    textFieldEditFileName.text = @"";
    selectedIndex = (int)[midiFilesPicker selectedRowInComponent:0];
    if (selectedIndex > 0) selectedIndex--;
    midiFilename = midiFilesForPicker[selectedIndex];
    [midiFilesPicker selectRow:selectedIndex inComponent:0 animated:NO];
    [viewContPad saveLastSelectedMIDIfile];
}

- (IBAction)buttonNextPressed:(id)sender {
    if (countList == 0) return;
    searchMode = FALSE;
    nameChanged = FALSE;
    textFieldEditFileName.text = @"";
    selectedIndex = (int)[midiFilesPicker selectedRowInComponent:0];
    if (selectedIndex < midiFilesForPicker.count-1) selectedIndex++;
    midiFilename = midiFilesForPicker[selectedIndex];
    [midiFilesPicker selectRow:selectedIndex inComponent:0 animated:NO];
    [viewContPad saveLastSelectedMIDIfile];
}

- (IBAction)buttonTopListPressed:(id)sender {
    if (countList == 0) return;
    searchMode = FALSE;
    nameChanged = FALSE;
    textFieldEditFileName.text = @"";
    selectedIndex = 0;
    midiFilename = midiFilesForPicker[selectedIndex];
    [midiFilesPicker selectRow:selectedIndex inComponent:0 animated:NO];
    [viewContPad saveLastSelectedMIDIfile];
}

- (IBAction)buttonEndListPressed:(id)sender {
    if (countList == 0) return;
    searchMode = FALSE;
    nameChanged = FALSE;
    textFieldEditFileName.text = @"";
    selectedIndex = (int)midiFilesForPicker.count-1;
    midiFilename = midiFilesForPicker[selectedIndex];
    [midiFilesPicker selectRow:selectedIndex inComponent:0 animated:NO];
    [viewContPad saveLastSelectedMIDIfile];
}

// Search text for MIDI files
- (void) searchString :(NSString*)stringToSearch {
    indexOfTheObjectP = -1;
    numberOfIndexesP = 0;
    // if you need case sensitive search avoid '[c]' in the predicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",stringToSearch];
    resultsearchP = [midiFilesForPicker filteredArrayUsingPredicate:predicate];
    if (resultsearchP.count > 0) {
        numberOfIndexesP = (int)resultsearchP.count;
        indexOfTheObjectP = (int)[midiFilesForPicker indexOfObject: resultsearchP[0]];
    }
    else {
        indexOfTheObjectP = -1;
    }
}


- (IBAction)buttonMailPressed:(id)sender {
    if (countList == 0) return;
    selectedIndex = (int)[midiFilesPicker selectedRowInComponent:0];
    midiFilename = midiFilesForPicker[selectedIndex];
    midiFilePath = [documentsDirectoryPath stringByAppendingPathComponent:listArrayForPicker[selectedIndex]];
    [self openMail:nil];
}

- (IBAction)openMail:(id)sender
{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        
        [mailer setSubject:[NSString stringWithFormat:@"MIDI File: %@", midiFilename]];
        [mailer addAttachmentData:[NSData dataWithContentsOfFile:midiFilePath]
                         mimeType:@"MIDI"
                         fileName:midiFilename];
        
        NSString *emailBody = @"MIDI file sent from iPad App 'MFP'";
        [mailer setMessageBody:emailBody isHTML:NO];
        
        // only for iPad
        mailer.modalPresentationStyle = UIModalPresentationPageSheet;
        
        
        [self presentViewController:mailer animated:YES completion:nil];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mail failure"
                                                        message:@"Your device doesn't support the mail composer sheet or no mail account exist"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
}


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    NSString *mailInfo = @"";
    switch (result)
    {
        case MFMailComposeResultCancelled:
            mailInfo = @"Mail cancelled: you cancelled the operation and no email message was queued";
            break;
        case MFMailComposeResultSaved:
            mailInfo = @"Mail saved: you saved the email message in the Drafts folder";
            break;
        case MFMailComposeResultSent:
            mailInfo = @"Mail send: the email message is queued in the outbox. It is ready to send the next time the user connects to email";
            break;
        case MFMailComposeResultFailed:
            mailInfo = @"Mail failed: the email message was not saved or queued, possibly due to an error";
            break;
        default:
            mailInfo = @"Mail not sent";
            break;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mail info"
                                                    message:mailInfo
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
    [alert show];
    
    [midiFilesPicker selectRow:selectedIndex inComponent:0 animated:NO];  // sonst ist picker position falsch !!!!
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

- (IBAction)buttonAddFavoritesPressed:(id)sender {
    if (countList == 0) return;
    
    selectedIndex = (int)[midiFilesPicker selectedRowInComponent:0];
    midiFilename = midiFilesForPicker[selectedIndex];
    midiFilenameWithoutExt = [midiFilename substringWithRange:NSMakeRange(0, midiFilename.length - 4)];
    
    [viewContPad saveLastSelectedMIDIfile];
    
    if (![[midiFilenameWithoutExt substringWithRange:NSMakeRange(0, 1)] isEqual: @"*"]) {
        
        midiFilename = [NSString stringWithFormat:@"*%@%@", midiFilenameWithoutExt, @".mid" ];
        
        // Move the file
        bool errorMove = FALSE;
        if ([[NSFileManager defaultManager] moveItemAtPath:[documentsDirectoryPath stringByAppendingPathComponent:midiFilesForPicker[selectedIndex]] toPath:[documentsDirectoryPath stringByAppendingPathComponent:midiFilename] error: NULL] == NO)
            errorMove = TRUE;
        if (errorMove) {
            alertP = [[UIAlertView alloc]initWithTitle: @"Information"
                                              message: @"Adding file to favorites was not successful (e.g. was still marked as favorite)!"
                                             delegate: self
                                    cancelButtonTitle: nil
                                    otherButtonTitles:@"OK",nil];
            [alertP show];
        }
        else {
            usleep(200);
            [viewContPad parseDir];
            midiFilesForPicker = [[NSMutableArray alloc] init];
            [self loadList];
            selectedIndex = (int)[midiFilesPicker selectedRowInComponent:0];
            if (selectedIndex < midiFilesForPicker.count-1) selectedIndex++;
            midiFilename = midiFilesForPicker[selectedIndex];
            [midiFilesPicker selectRow:selectedIndex inComponent:0 animated:NO];
            [viewContPad saveLastSelectedMIDIfile];
        }
    }
    else {
        alertP = [[UIAlertView alloc]initWithTitle: @"Information"
                                          message: @"The file was still marked as favorite."
                                         delegate: self
                                cancelButtonTitle: nil
                                otherButtonTitles:@"OK",nil];
        [alertP show];
    }
}

- (IBAction)buttonRemoveFavoritesPressed:(id)sender {
    if (countList == 0) return;
    selectedIndex = (int)[midiFilesPicker selectedRowInComponent:0];
    midiFilename = midiFilesForPicker[selectedIndex];
    midiFilenameWithoutExt = [midiFilename substringWithRange:NSMakeRange(0, midiFilename.length - 4)];
    
    if ([[midiFilenameWithoutExt substringWithRange:NSMakeRange(0, 1)] isEqual: @"*"]) {
        
        midiFilename = [midiFilename substringWithRange:NSMakeRange(1, midiFilename.length-1)];
        
        // Move the file
        bool errorMove = FALSE;
        if ([[NSFileManager defaultManager] moveItemAtPath:[documentsDirectoryPath stringByAppendingPathComponent:midiFilesForPicker[selectedIndex]] toPath:[documentsDirectoryPath stringByAppendingPathComponent:midiFilename] error: NULL] == NO)
            errorMove = TRUE;
        if (errorMove) {
            alertP = [[UIAlertView alloc]initWithTitle: @"Information"
                                              message: @"Removing file from favorites was not successful!"
                                             delegate: self
                                    cancelButtonTitle: nil
                                    otherButtonTitles:@"OK",nil];
            [alertP show];
        }
        else {
            usleep(200);
        }
        
        [viewContPad parseDir];
        midiFilesForPicker = [[NSMutableArray alloc] init];
        [self loadList];
        
    }
    else {
        alertP = [[UIAlertView alloc]initWithTitle: @"Information"
                                          message: @"The file was not marked as favorite."
                                         delegate: self
                                cancelButtonTitle: nil
                                otherButtonTitles:@"OK",nil];
        [alertP show];
    }
}

- (IBAction)buttonGoToFavoritesPressed:(id)sender {
    if (countList == 0) return;
    if (starPosition >= 0) {
        selectedIndex = starPosition;
        midiFilename = midiFilesForPicker[selectedIndex];
        [midiFilesPicker selectRow:selectedIndex inComponent:0 animated:NO];
        [viewContPad saveLastSelectedMIDIfile];
    }
    else {
        alertP = [[UIAlertView alloc]initWithTitle: @"Information"
                                          message: @"No favorites found\n(marked with *)."
                                         delegate: self
                                cancelButtonTitle: nil
                                otherButtonTitles:@"OK",nil];
        [alertP show];
    }
}
@end
