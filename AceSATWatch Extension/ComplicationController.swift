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
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirectionsForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTimeTravelDirections) -> Void) {
        switch complication.family {
        case .ModularLarge:
            handler([.Backward, .Forward])
        default:
            handler([])
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
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntryForComplication(complication: CLKComplication, withHandler handler: ((CLKComplicationTimelineEntry?) -> Void)) {
        var entry = CLKComplicationTimelineEntry()
        var listsAced = numberOfListsAced
        switch complication.family {
        case .ModularLarge:
            entry = getEntryForDate(NSDate())
        case .CircularSmall:
            let template = CLKComplicationTemplateCircularSmallRingText()
            template.textProvider = CLKSimpleTextProvider(text: "\(numberOfListsAced)")
            template.fillFraction = Float(numberOfListsAced) / 100
            entry = CLKComplicationTimelineEntry(date: NSDate(), complicationTemplate: template)
        case .ModularSmall:
            let template = CLKComplicationTemplateModularSmallRingText()
            template.textProvider = CLKSimpleTextProvider(text: "\(numberOfListsAced)")
            template.fillFraction = Float(numberOfListsAced) / 100
            entry = CLKComplicationTimelineEntry(date: NSDate(), complicationTemplate: template)
        case .UtilitarianSmall:
            let template = CLKComplicationTemplateUtilitarianSmallRingText()
            template.textProvider = CLKSimpleTextProvider(text: "\(numberOfListsAced)")
            template.fillFraction = Float(numberOfListsAced) / 100
            entry = CLKComplicationTimelineEntry(date: NSDate(), complicationTemplate: template)
        case .UtilitarianLarge:
            let template = CLKComplicationTemplateUtilitarianLargeFlat()
            template.textProvider = CLKSimpleTextProvider(text: "\(numberOfListsAced) lists aced", shortText: "\(numberOfListsAced) aced")
            entry = CLKComplicationTimelineEntry(date: NSDate(), complicationTemplate: template)
        }
        handler(entry)
        
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, beforeDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        var entries = [CLKComplicationTimelineEntry]()
        switch complication.family {
        case .ModularLarge:
            var timeInterval = date.timeIntervalSinceReferenceDate
            while entries.count < limit {
                let date = NSDate(timeIntervalSinceReferenceDate: timeInterval)
                let entry = getEntryForDate(date)
                entries.append(entry)
                timeInterval += -3600
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
                let date = NSDate(timeIntervalSinceReferenceDate: timeInterval)
                let entry = getEntryForDate(date)
                entries.append(entry)
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
        var template: CLKComplicationTemplate? = nil
        switch complication.family {
        case .ModularSmall:
            let modularTemplate = CLKComplicationTemplateModularSmallRingText()
            modularTemplate.ringStyle = .Closed
            modularTemplate.textProvider = CLKSimpleTextProvider(text: "0")
            modularTemplate.fillFraction = 0.0
            template = modularTemplate
        case .UtilitarianSmall:
            let utilitarianSmallTemplate = CLKComplicationTemplateUtilitarianSmallRingText()
            utilitarianSmallTemplate.ringStyle = .Closed
            utilitarianSmallTemplate.textProvider = CLKSimpleTextProvider(text: "0")
            utilitarianSmallTemplate.fillFraction = 0.0
            template = utilitarianSmallTemplate
        case .UtilitarianLarge:
            let utilitarianLargeTemplate = CLKComplicationTemplateUtilitarianLargeFlat()
            utilitarianLargeTemplate.textProvider = CLKSimpleTextProvider(text: "0 lists aced", shortText: "0 aced")
            template = utilitarianLargeTemplate
        case .CircularSmall:
            let circularTemplate = CLKComplicationTemplateCircularSmallRingText()
            circularTemplate.fillFraction = 0.0
            circularTemplate.ringStyle = .Closed
            circularTemplate.textProvider = CLKSimpleTextProvider(text: "0")
            template = circularTemplate
        case.ModularLarge:
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
        let headerText = CLKSimpleTextProvider(text: word.word)
        headerText.tintColor = UIColor.ace_redColor()
        template.headerTextProvider = headerText
        let bodyText = CLKSimpleTextProvider(text: word.definition)
        bodyText.tintColor = UIColor.ace_blueColor()
        template.body1TextProvider = bodyText
        return template
        
    }
    
    var numberOfListsAced: Int {
        get {
            let defaults = NSUserDefaults.standardUserDefaults()
            if let lists = defaults.objectForKey("AcedWordLists") as? NSMutableArray {
                return lists.count
            }
            
            return 0
        }
    }
    
    
    
    
    
}
