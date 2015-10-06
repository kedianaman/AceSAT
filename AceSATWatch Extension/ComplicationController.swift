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
        handler([.Forward])
    }
    
    func getTimelineStartDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        let startDate = NSDate.init(timeIntervalSinceNow: NSTimeInterval(-60.0 * 60 * 24))
        handler(startDate)
    }
    
    func getTimelineEndDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        let endDate = NSDate.init(timeIntervalSinceNow: NSTimeInterval(60 * 60 * 24))
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
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, afterDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        
        var entries = [CLKComplicationTimelineEntry]()
        var timeInterval = 0.0
        while entries.count <= limit {
            let randomListIndex = random() % 100
            let randomWordIndex = random() % 10
            let wordList = WordListManager.sharedManager.wordListAtIndex(randomListIndex)
            let word = wordList[randomWordIndex]
            let template = templateForWord(word)
            let date = NSDate.init(timeInterval: timeInterval, sinceDate: date)
            let entry = CLKComplicationTimelineEntry(date: date, complicationTemplate: template)
            entries.append(entry)
            timeInterval += 60.0 * 60.0

        }
        handler(entries)
    }
    
    // MARK: - Update Scheduling
    
    func getNextRequestedUpdateDateWithHandler(handler: (NSDate?) -> Void) {
        // Call the handler with the date when you would next like to be given the opportunity to update your complication content
        handler(nil);
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
    
}
