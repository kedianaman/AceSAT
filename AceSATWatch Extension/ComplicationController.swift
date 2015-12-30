//
//  ComplicationController.swift
//  Watchkit Tutorial App WatchKit Extension
//
//  Created by Naman Kedia on 9/26/15.
//  Copyright © 2015 Naman Kedia. All rights reserved.
//

import ClockKit

struct DefaultsKey {
    static let AcedWordListKey = "AcedWordLists"
}


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntryForComplication(complication: CLKComplication, withHandler handler: ((CLKComplicationTimelineEntry?) -> Void)) {
        var entry: CLKComplicationTimelineEntry?
        if complication.family == .ModularLarge {
            entry = getEntryForDate(NSDate())
        }
        handler(entry)
        
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, beforeDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        var entries = [CLKComplicationTimelineEntry]()
        switch complication.family {
        case .ModularLarge:
            var timeInterval = date.timeIntervalSinceReferenceDate
            while entries.count < limit {
                let currentDate = NSDate(timeIntervalSinceReferenceDate: timeInterval)
                let entry = getEntryForDate(currentDate)
                if entry.date.timeIntervalSince1970 < date.timeIntervalSince1970 {
                    entries.append(entry)
                }
                timeInterval -= 3600
            }
        default:
            entries = [CLKComplicationTimelineEntry]()
            
        }
        
        handler(entries)
        
        
        
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, afterDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        var entries = [CLKComplicationTimelineEntry]()
        switch complication.family {
        case .ModularLarge:
            var timeInterval = date.timeIntervalSinceReferenceDate
            while entries.count < limit {
                let currentDate = NSDate(timeIntervalSinceReferenceDate: timeInterval)
                let entry = getEntryForDate(currentDate)
                if entry.date.timeIntervalSince1970 > date.timeIntervalSince1970 {
                    entries.append(entry)
                }
                timeInterval += 3600
            }
        default:
            entries = [CLKComplicationTimelineEntry]()
            
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
        var template: CLKComplicationTemplate?
        if complication.family == .ModularLarge {
            let modularTemplate = CLKComplicationTemplateModularLargeStandardBody()
            let textProdivder = CLKSimpleTextProvider(text: "Sample word")
            textProdivder.tintColor = UIColor.ace_redColor()
            modularTemplate.headerTextProvider = textProdivder
            modularTemplate.body1TextProvider = CLKSimpleTextProvider(text: "This is a sample definition")
            template = modularTemplate
        }
        handler(template)
    }
    
    func getEntryForDate(date: NSDate) -> CLKComplicationTimelineEntry {
        let seconds = date.timeIntervalSinceReferenceDate
        let secondsRoundedToHour = seconds - (seconds % 3600)
        let hours = Int(seconds/3600)
        let wordIndex = hours % 1000
        let word = WordListManager.sharedManager.allWords[wordIndex]
        let date = NSDate(timeIntervalSinceReferenceDate: secondsRoundedToHour)
        let template = templateForWord(word)
        return CLKComplicationTimelineEntry(date: date, complicationTemplate: template)
    }
    
    func templateForWord(word: Word) -> CLKComplicationTemplate {
        let template = CLKComplicationTemplateModularLargeStandardBody()
        template.tintColor = UIColor(white: 0.99, alpha: 1.0)
        let headerText = CLKSimpleTextProvider(text: word.word)
        headerText.tintColor = UIColor.ace_redColor()
        template.headerTextProvider = headerText
        let bodyText = CLKSimpleTextProvider(text: word.definition)
        template.body1TextProvider = bodyText
        return template
        
    }
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirectionsForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTimeTravelDirections) -> Void) {
        switch complication.family {
        case .ModularLarge:
            handler([.Backward, .Forward])
        default:
            handler([.None])
        }
        
    }
    
    func getTimelineStartDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        switch complication.family {
        case .ModularLarge:
            let startDate = NSDate.distantPast()
            handler(startDate)
        default:
            handler(nil)
        }
        
        
    }
    
    func getTimelineEndDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        switch complication.family {
        case .ModularLarge:
            let startDate = NSDate.distantFuture()
            handler(startDate)
        default:
            handler(nil)
        }
        
    }
    
    func getPrivacyBehaviorForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.ShowOnLockScreen)
    }
    
}
