//
//  pickerView.m
//  Midi file player
//
//  Created by Walter Schurter on 16.05.13.
//  Copyright (c) 2013 Walter Schurter WASElectronic. All rights reserved.
//

#import "pickerView.h"
#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <MessageUI/MessageUI.h>

@interface pickerView ()

@end

@implementation pickerView

@synthesize buttonOK;
@synthesize buttonCancel;
@synthesize buttonEdit;
@synthesize buttonSearch;
@synthesize textFieldEditFileName;
@synthesize pickerFiles;
@synthesize labelRenameSearch;
@synthesize buttonSearchNext;
@synthesize buttonDelete;
@synthesize buttonUp;
@synthesize buttonDown;
@synthesize buttonTopList;
@synthesize buttonEndList;
@synthesize buttonAddFavorites;
@synthesize buttonRemoveFavorites;
@synthesize buttonGoToFavorites;

bool searchModePhone = FALSE;
bool renameModePhone = FALSE;

int starPositionPhone = -1;
int countListPhone = 0;

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

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
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
    return [midiFilesForPicker objectAtIndex:row];
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
        [pickerLabel setFont:[UIFont systemFontOfSize:15]];
        [pickerLabel setTextAlignment:1];
    }
    [pickerLabel setText:[listArrayForPicker objectAtIndex:row]];
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
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    
    // Achtung: in "Accordion-Info.plist" "View controller-based status bar appearance" set "NO"
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    if (viewCont==nil) viewCont=[[ViewController alloc]init];
    
    textFieldEditFileName.keyboardAppearance = UIKeyboardAppearanceDark;
    
    [self doSomeInit];
    
}

- (void) doSomeInit {
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];  // hide keyboard
    
    nameChanged = FALSE;
    searchModePhone = FALSE;
    renameModePhone = FALSE;
    starPositionPhone = -1;
    
    buttonOK.hidden = FALSE;
    buttonCancel.hidden = FALSE;
    buttonEdit.hidden = FALSE;
    buttonSearch.hidden = FALSE;
    buttonSearchNext.hidden = FALSE;
    buttonDelete.hidden = FALSE;
    buttonUp.hidden = FALSE;
    buttonDown.hidden = FALSE;
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
    buttonUp.clipsToBounds = YES;
    buttonDown.clipsToBounds = YES;
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
    buttonUp.layer.cornerRadius = 10;
    buttonDown.layer.cornerRadius = 10;
    buttonTopList.layer.cornerRadius = 10;
    buttonEndList.layer.cornerRadius = 10;
    buttonAddFavorites.layer.cornerRadius = 10;
    buttonRemoveFavorites.layer.cornerRadius = 10;
    buttonGoToFavorites.layer.cornerRadius = 10;
    
    [midiFilesForPicker removeAllObjects];
    midiFilesForPicker = [[NSMutableArray alloc] init];
    
    buttonCancel.frame = CGRectMake(6, 283, 73, 43);  // to do
    buttonOK.frame = CGRectMake(241, 283, 73, 43);   // to do
    
    pickerFiles.hidden = FALSE;
    
    [self loadList];
    
    if (countListPhone > 0) {
        [midiFilesPicker selectRow:selectedIndex inComponent:0 animated:NO];
        midiFilename = [midiFilesForPicker objectAtIndex:selectedIndex];
        textFieldEditFileName.hidden = TRUE;
    }
    else {
        midiFilename= [NSString stringWithFormat:@"%@", textForNoFiles];
        buttonOK.hidden = TRUE;
        buttonEdit.hidden = TRUE;
        buttonSearch.hidden = TRUE;
        buttonSearchNext.hidden = TRUE;
        buttonDelete.hidden = TRUE;
        buttonUp.hidden = TRUE;
        buttonDown.hidden = TRUE;
        buttonTopList.hidden = TRUE;
        buttonEndList.hidden = TRUE;
        buttonAddFavorites.hidden = TRUE;
        buttonRemoveFavorites.hidden = TRUE;
        buttonGoToFavorites.hidden = TRUE;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    /*
     UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Warning"
     message: @"Memory warning received!"
     delegate: self
     cancelButtonTitle: nil
     otherButtonTitles:@"OK",nil];
     [alert show];
     */
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

- (void)pickerTap {
    // do not use this
}

- (void) loadList {
    countListPhone = (int)[listArrayForPicker count];
    starPositionPhone = -1;
    for (int i = 0; i < countListPhone; i++){
        [midiFilesForPicker addObject:listArrayForPicker[i]];
        if (starPositionPhone < 0) {
            if ([[midiFilesForPicker[i] substringWithRange:NSMakeRange(0, 1)] isEqual: @"*"]) {
                starPositionPhone = i;
            }
        }
    }
    [midiFilesPicker reloadAllComponents];
}

- (IBAction)buttonCancelPressed:(id)sender {
    if (searchModePhone || renameModePhone) {
        [viewCont parseDir];
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
    if (countListPhone == 0) {
        [self buttonCancelPressed :nil];
        return;
    }
    
    textFieldEditFileName.hidden = TRUE;
    selectedIndex = (int)[midiFilesPicker selectedRowInComponent:0];
    
    if (renameModePhone) {
        if (nameChanged) {
            midiFilename = [NSString stringWithFormat:@"%@%@", textFieldEditFileName.text, @".mid" ];
            // Move the file
            bool errorMove = FALSE;
            if ([[NSFileManager defaultManager] moveItemAtPath:[documentsDirectoryPath stringByAppendingPathComponent:listArrayForPicker[selectedIndex]] toPath:[documentsDirectoryPath stringByAppendingPathComponent:midiFilename] error: NULL] == NO)
                errorMove = TRUE;
            if (errorMove) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Information"
                                                               message: @"Renaming file in the shared iTunes folder was not successful (e.g. file name was not changed)!"
                                                              delegate: self
                                                     cancelButtonTitle: nil
                                                     otherButtonTitles:@"OK",nil];
                [alert show];
            }
            else {
                usleep(200);
            }
            [viewCont saveLastSelectedMIDIfile];
            [viewCont parseDir];
            midiFilesForPicker = [[NSMutableArray alloc] init];
            [self loadList];
            [self doSomeInit];
        }
        else {
            midiFilename = [midiFilesForPicker objectAtIndex:selectedIndex];
        }
        
        pickerFiles.hidden = FALSE;
    }
    else if (searchModePhone) {
        buttonCancel.frame = CGRectMake(6, 282, 71, 44);
        buttonOK.frame = CGRectMake(243, 282, 71, 44);
        
        [self searchString:textFieldEditFileName.text];
        if (indexOfTheObjectP != -1) {
            selectedIndex = indexOfTheObjectP;
            midiFilename = [midiFilesForPicker objectAtIndex:selectedIndex];
            [viewCont saveLastSelectedMIDIfile];
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
        [viewCont saveLastSelectedMIDIfile];
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
    
    if (countListPhone == 0) return;
    
    searchModePhone = FALSE;
    renameModePhone = TRUE;
    
    pickerFiles.hidden = TRUE;
    
    buttonSearch.hidden = TRUE;
    buttonEdit.hidden = TRUE;
    buttonSearchNext.hidden = TRUE;
    buttonDelete.hidden = TRUE;
    buttonUp.hidden = TRUE;
    buttonDown.hidden = TRUE;
    buttonTopList.hidden = TRUE;
    buttonEndList.hidden = TRUE;
    buttonAddFavorites.hidden = TRUE;
    buttonRemoveFavorites.hidden = TRUE;
    buttonGoToFavorites.hidden = TRUE;
    
    labelRenameSearch.text = @"Change the name of the MIDI file";
    labelRenameSearch.hidden = FALSE;
    if (is_IPHONE_5) {
        buttonCancel.frame = CGRectMake(10+30, 100+88, 95, 44);
        buttonOK.frame = CGRectMake(215-30, 100+88, 95, 44);
        textFieldEditFileName.frame = CGRectMake(6, 219+62, 320-12, 25);
        labelRenameSearch.frame = CGRectMake(6, 219+62-25, 320-12, 25);
    }
    else {
        buttonCancel.frame = CGRectMake(10+30, 100, 95, 44);
        buttonOK.frame = CGRectMake(215-30, 100, 95, 44);
        textFieldEditFileName.frame = CGRectMake(6, 219-25, 320-12, 25);
        labelRenameSearch.frame = CGRectMake(6, 219-25-25, 320-12, 25);
    }
    nameChanged = TRUE;
    
    selectedIndex = (int)[midiFilesPicker selectedRowInComponent:0];
    midiFilename = [midiFilesForPicker objectAtIndex:selectedIndex];
    midiFilenameWithoutExt = [midiFilename substringWithRange:NSMakeRange(0, midiFilename.length - 4)];
    textFieldEditFileName.hidden = FALSE;
    textFieldEditFileName.text = midiFilenameWithoutExt;
    [textFieldEditFileName becomeFirstResponder];
}

- (IBAction)buttonSearchPressed:(id)sender {
    
    if (countListPhone == 0) return;
    
    selectedIndex = (int)[midiFilesPicker selectedRowInComponent:0];
    midiFilename = midiFilesForPicker[selectedIndex];
    [viewCont saveLastSelectedMIDIfile];
    
    pickerFiles.hidden = TRUE;
    
    indexOfTheObjectP = -1;
    numberOfIndexesP = 0;
    indexCounterP = 0;
    searchModePhone = TRUE;
    renameModePhone = FALSE;
    buttonEdit.hidden = TRUE;
    buttonSearch.hidden = TRUE;
    buttonSearchNext.hidden = TRUE;
    buttonDelete.hidden = TRUE;
    buttonUp.hidden = TRUE;
    buttonDown.hidden = TRUE;
    buttonTopList.hidden = TRUE;
    buttonEndList.hidden = TRUE;
    buttonAddFavorites.hidden = TRUE;
    buttonRemoveFavorites.hidden = TRUE;
    buttonGoToFavorites.hidden = TRUE;
    labelRenameSearch.text = @"Search a word in all MIDI files";
    labelRenameSearch.hidden = FALSE;
    if (is_IPHONE_5) {
        buttonCancel.frame = CGRectMake(10+30, 100+88, 95, 44);
        buttonOK.frame = CGRectMake(215-30, 100+88, 95, 44);
        textFieldEditFileName.frame = CGRectMake(6, 219+62, 320-12, 25);
        labelRenameSearch.frame = CGRectMake(6, 219+62-25, 320-12, 25);
    }
    else {
        buttonCancel.frame = CGRectMake(10+30, 100, 95, 44);
        buttonOK.frame = CGRectMake(215-30, 100, 95, 44);
        textFieldEditFileName.frame = CGRectMake(6, 219-25, 320-12, 25);
        labelRenameSearch.frame = CGRectMake(6, 219-25-25, 320-12, 25);
    }
    nameChanged = FALSE;
    textFieldEditFileName.text = @"";
    textFieldEditFileName.hidden = FALSE;
    [textFieldEditFileName becomeFirstResponder];
}

- (IBAction)buttonSearchNextPressed:(id)sender {
    if (countListPhone == 0) return;
    if (![textFieldEditFileName.text isEqual: @""]) {
        searchModePhone = FALSE;
        nameChanged = FALSE;
        if (indexCounterP < numberOfIndexesP-1) {
            indexCounterP++;
            indexOfTheObjectP = (int)[midiFilesForPicker indexOfObject: resultsearchP[indexCounterP]];
            selectedIndex = indexOfTheObjectP;
            midiFilename = [midiFilesForPicker objectAtIndex:selectedIndex];
            [midiFilesPicker selectRow:selectedIndex inComponent:0 animated:NO];
            [viewCont saveLastSelectedMIDIfile];
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
        midiFilename = [midiFilesForPicker objectAtIndex:selectedIndex];
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
            [viewCont parseDir];
            if (listArrayCount > 0){
                if (listArrayCount > 0){
                    if (selectedIndex >= listArrayCount){
                        selectedIndex = 0;
                    }
                    midiFilename = [midiFilesForPicker objectAtIndex:selectedIndex];
                    midiFilePath = [documentsDirectoryPath stringByAppendingPathComponent:listArrayForPicker[selectedIndex]];
                    [viewCont saveLastSelectedMIDIfile];
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
            [viewCont parseDir];
            if (listArrayCount > 0){
                if (listArrayCount > 0){
                    if (selectedIndex >= listArrayCount){
                        selectedIndex = 0;
                    }
                    midiFilename = [midiFilesForPicker objectAtIndex:selectedIndex];
                    midiFilePath = [documentsDirectoryPath stringByAppendingPathComponent:listArrayForPicker[selectedIndex]];
                    [viewCont saveLastSelectedMIDIfile];
                }
            }
            else {
                selectedIndex = 0;
                midiFilename = @"";
                midiFilePath = @"";
            }
            [viewCont parseDir];
            midiFilesForPicker = [[NSMutableArray alloc] init];
            [self loadList];
        }
    }
    
}

- (IBAction)buttonUpPressed:(id)sender {
    if (countListPhone == 0) return;
    searchModePhone = FALSE;
    nameChanged = FALSE;
    textFieldEditFileName.text = @"";
    selectedIndex = (int)[midiFilesPicker selectedRowInComponent:0];
    if (selectedIndex > 0) selectedIndex--;
    midiFilename = [midiFilesForPicker objectAtIndex:selectedIndex];
    [midiFilesPicker selectRow:selectedIndex inComponent:0 animated:NO];
    [viewCont saveLastSelectedMIDIfile];
}

- (IBAction)buttonDownPressed:(id)sender {
    if (countListPhone == 0) return;
    searchModePhone = FALSE;
    nameChanged = FALSE;
    textFieldEditFileName.text = @"";
    selectedIndex = (int)[midiFilesPicker selectedRowInComponent:0];
    if (selectedIndex < midiFilesForPicker.count-1) selectedIndex++;
    midiFilename = [midiFilesForPicker objectAtIndex:selectedIndex];
    [midiFilesPicker selectRow:selectedIndex inComponent:0 animated:NO];
    [viewCont saveLastSelectedMIDIfile];
}

- (IBAction)buttonTopListPressed:(id)sender {
    if (countListPhone == 0) return;
    searchModePhone = FALSE;
    nameChanged = FALSE;
    textFieldEditFileName.text = @"";
    selectedIndex = 0;
    midiFilename = [midiFilesForPicker objectAtIndex:selectedIndex];
    [midiFilesPicker selectRow:selectedIndex inComponent:0 animated:NO];
    [viewCont saveLastSelectedMIDIfile];
}

- (IBAction)buttonEndListPressed:(id)sender {
    if (countListPhone == 0) return;
    searchModePhone = FALSE;
    nameChanged = FALSE;
    textFieldEditFileName.text = @"";
    selectedIndex = (int)midiFilesForPicker.count-1;
    midiFilename = [midiFilesForPicker objectAtIndex:selectedIndex];
    [midiFilesPicker selectRow:selectedIndex inComponent:0 animated:NO];
    [viewCont saveLastSelectedMIDIfile];
}


- (IBAction)buttonMailPressed:(id)sender {
    if (countListPhone == 0) return;
    selectedIndex = (int)[midiFilesPicker selectedRowInComponent:0];
    midiFilename = [midiFilesForPicker objectAtIndex:selectedIndex];
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
        
        NSString *emailBody = @"MIDI file sent from iPhone App 'MFP'";
        [mailer setMessageBody:emailBody isHTML:NO];
        
        // only for iPad
        mailer.modalPresentationStyle = UIModalPresentationPageSheet;
        
        
        [self presentViewController:mailer animated:YES completion:nil];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mail failure"
                                                        message:@"Your device doesn't support the mail composer sheet"
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
    if (countListPhone == 0) return;
    selectedIndex = (int)[midiFilesPicker selectedRowInComponent:0];
    midiFilename = midiFilesForPicker[selectedIndex];
    midiFilenameWithoutExt = [midiFilename substringWithRange:NSMakeRange(0, midiFilename.length - 4)];
    
    [viewCont saveLastSelectedMIDIfile];
    
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
            [viewCont parseDir];
            midiFilesForPicker = [[NSMutableArray alloc] init];
            [self loadList];
            selectedIndex = (int)[midiFilesPicker selectedRowInComponent:0];
            if (selectedIndex < midiFilesForPicker.count-1) selectedIndex++;
            midiFilename = midiFilesForPicker[selectedIndex];
            [midiFilesPicker selectRow:selectedIndex inComponent:0 animated:NO];
            [viewCont saveLastSelectedMIDIfile];
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
    if (countListPhone == 0) return;
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
        
        [viewCont parseDir];
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
    if (countListPhone == 0) return;
    if (starPositionPhone >= 0) {
        selectedIndex = starPositionPhone;
        midiFilename = midiFilesForPicker[selectedIndex];
        [midiFilesPicker selectRow:selectedIndex inComponent:0 animated:NO];
        [viewCont saveLastSelectedMIDIfile];
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
