//
//  ComplicationController.swift
//  Watchkit Tutorial App WatchKit Extension
//
//  Created by Naman Kedia on 9/26/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirectionsForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.Backward, .Forward])
    }
    
    func getTimelineStartDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        let startDate = getStartDate()
        handler(startDate)
    }
    
    func getTimelineEndDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        let endDate = getEndDate()
        handler(endDate)
    }
    
    func getPrivacyBehaviorForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.ShowOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntryForComplication(complication: CLKComplication, withHandler handler: ((CLKComplicationTimelineEntry?) -> Void)) {
        getTimelineEntriesForComplication(complication, afterDate: NSDate(), limit: 1) { (entries) -> Void in
            handler(entries?.first)
        }
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, beforeDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        let entries = getWordEntriesForDay()
        var newEntries = [CLKComplicationTimelineEntry]()
        for entry in entries {
            let earlierDate = entry.date.earlierDate(date)
            if earlierDate.isEqualToDate(entry.date) {
                newEntries.append(entry)
            }
        }
        
        handler(newEntries)

    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, afterDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        
        let entries = getWordEntriesForDay()
        var newEntries = [CLKComplicationTimelineEntry]()
        for entry in entries {
            let laterDate =  entry.date.laterDate(date)
            if laterDate.isEqualToDate(entry.date) {
                newEntries.append(entry)
            }
        }
  
        handler(newEntries)

    }

    
    // MARK: - Update Scheduling
    
    func getNextRequestedUpdateDateWithHandler(handler: (NSDate?) -> Void) {
        let endDate = getEndDate()
        handler(endDate);
    }
    
    // MARK: - Placeholder Templates
    
    func getPlaceholderTemplateForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTemplate?) -> Void) {
        var template: CLKComplicationTemplate? = nil
        switch complication.family {
        case .ModularSmall:
            template = nil
        case .UtilitarianSmall:
            template = nil
        case .UtilitarianLarge:
            template = nil
        case .CircularSmall:
            template = nil
        case.ModularLarge:
            let modularTemplate = CLKComplicationTemplateModularLargeStandardBody()
            let textProdivder = CLKSimpleTextProvider(text: "Test word")
            textProdivder.tintColor = UIColor.ace_redColor()

            modularTemplate.headerTextProvider = textProdivder
            modularTemplate.body1TextProvider = CLKSimpleTextProvider(text: "This is a sample definition")
            template = modularTemplate
        }
      
        handler(template)
    }
    
    func templateForWord(word: Word) -> CLKComplicationTemplate {
        let template = CLKComplicationTemplateModularLargeStandardBody()
        let headerText = CLKSimpleTextProvider(text: word.word)
        headerText.tintColor = UIColor.ace_redColor()
        template.headerTextProvider = headerText
        let bodyText = CLKSimpleTextProvider(text: word.definition)
        bodyText.tintColor = UIColor.ace_blueColor()
        template.body1TextProvider = bodyText
        return template
        
    }
    
    func getStartDate() -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let date = calendar.dateBySettingHour(0, minute: 0, second: 0, ofDate: NSDate(), options: NSCalendarOptions.WrapComponents)
        return date!
    }
    
    
    func getEndDate() -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let date = calendar.dateBySettingHour(23, minute: 59, second: 59, ofDate: NSDate(), options: NSCalendarOptions.WrapComponents)
        return date!
    }
    
    func getWordEntriesForDay() -> [CLKComplicationTimelineEntry] {
        let date = getStartDate()
        var timeInterval = 0.0
        var entries = [CLKComplicationTimelineEntry]()
        for (var i = 0; i < 24; i++) {
            let template = templateForWord(getRandomWord())
            let entryDate = NSDate(timeInterval: timeInterval, sinceDate: date)
            let entry = CLKComplicationTimelineEntry(date: entryDate, complicationTemplate: template)
            entries.append(entry)
            timeInterval += 60 * 60

        }
        
        return entries
        
    }
    
    func getRandomWord() -> Word {
        let randomListIndex = random() % 100
        let randomWordIndex = random() % 10
        let wordList = WordListManager.sharedManager.wordListAtIndex(randomListIndex)
        let word = wordList[randomWordIndex]
        return word

    }
    

    
}
