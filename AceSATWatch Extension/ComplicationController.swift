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
        let startDate = NSDate.distantPast()
        handler(startDate)
    }
    
    func getTimelineEndDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        let endDate = NSDate.distantFuture()
        handler(endDate)
    }
    
    func getPrivacyBehaviorForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.ShowOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntryForComplication(complication: CLKComplication, withHandler handler: ((CLKComplicationTimelineEntry?) -> Void)) {
        let entry = getEntryForDate(NSDate())
        handler(entry)
        
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, beforeDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        var entries = [CLKComplicationTimelineEntry]()
        var timeInterval = date.timeIntervalSinceReferenceDate
        while entries.count < limit {
            let date = NSDate(timeIntervalSinceReferenceDate: timeInterval)
            let entry = getEntryForDate(date)
            entries.append(entry)
            timeInterval += -3600
        }
        
        handler(entries)
       
        

    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, afterDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        var entries = [CLKComplicationTimelineEntry]()
        var timeInterval = date.timeIntervalSinceReferenceDate
        while entries.count < limit {
            let date = NSDate(timeIntervalSinceReferenceDate: timeInterval)
            let entry = getEntryForDate(date)
            entries.append(entry)
            timeInterval += 3600
        }
        
        handler(entries)
        

    }
    
    func getTimelineAnimationBehaviorForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTimelineAnimationBehavior) -> Void) {
        handler(CLKComplicationTimelineAnimationBehavior.Always)
        
    }
    
    // MARK: - Update Scheduling
    
    func getNextRequestedUpdateDateWithHandler(handler: (NSDate?) -> Void) {
        handler(nil)
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
    
    func getEntryForDate(date: NSDate) -> CLKComplicationTimelineEntry {
        let seconds = date.timeIntervalSinceReferenceDate
        let secondsSinceDate = seconds - (seconds % 3600)
        let hours = Int(seconds/3600)
        let wordIndex = hours % 1000
        let word = WordListManager.sharedManager.allWords[wordIndex]
        let date = NSDate(timeIntervalSinceReferenceDate: secondsSinceDate)
        let template = templateForWord(word)
        return CLKComplicationTimelineEntry(date: date, complicationTemplate: template)
        
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
