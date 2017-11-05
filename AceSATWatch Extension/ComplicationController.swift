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
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: (@escaping (CLKComplicationTimelineEntry?) -> Void)) {
        var entry: CLKComplicationTimelineEntry?
        if complication.family == .modularLarge {
            entry = getEntryForDate(Date())
        }
        handler(entry)
        
    }
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: (@escaping ([CLKComplicationTimelineEntry]?) -> Void)) {
        var entries = [CLKComplicationTimelineEntry]()
        switch complication.family {
        case .modularLarge:
            var timeInterval = date.timeIntervalSinceReferenceDate
            while entries.count < limit {
                let currentDate = Date(timeIntervalSinceReferenceDate: timeInterval)
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
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: (@escaping ([CLKComplicationTimelineEntry]?) -> Void)) {
        var entries = [CLKComplicationTimelineEntry]()
        switch complication.family {
        case .modularLarge:
            var timeInterval = date.timeIntervalSinceReferenceDate
            while entries.count < limit {
                let currentDate = Date(timeIntervalSinceReferenceDate: timeInterval)
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
    
    func getTimelineAnimationBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineAnimationBehavior) -> Void) {
        handler(CLKComplicationTimelineAnimationBehavior.always)
        
    }
    
    // MARK: - Update Scheduling
    
    func getNextRequestedUpdateDate(handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    // MARK: - Placeholder Templates
    
    func getPlaceholderTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        var template: CLKComplicationTemplate?
        if complication.family == .modularLarge {
            let modularTemplate = CLKComplicationTemplateModularLargeStandardBody()
            let textProdivder = CLKSimpleTextProvider(text: "Sample word")
            textProdivder.tintColor = UIColor.ace_redColor()
            modularTemplate.headerTextProvider = textProdivder
            modularTemplate.body1TextProvider = CLKSimpleTextProvider(text: "This is a sample definition")
            template = modularTemplate
        }
        handler(template)
    }
    
    func getEntryForDate(_ date: Date) -> CLKComplicationTimelineEntry {
        let seconds = date.timeIntervalSinceReferenceDate
        let secondsRoundedToHour = seconds - (seconds.truncatingRemainder(dividingBy: 3600))
        let hours = Int(seconds/3600)
        let wordIndex = hours % 1000
        let word = WordListManager.sharedManager.allWords[wordIndex]
        let date = Date(timeIntervalSinceReferenceDate: secondsRoundedToHour)
        let template = templateForWord(word)
        return CLKComplicationTimelineEntry(date: date, complicationTemplate: template)
    }
    
    func templateForWord(_ word: Word) -> CLKComplicationTemplate {
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
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        switch complication.family {
        case .modularLarge:
            handler([.backward, .forward])
        default:
            handler(CLKComplicationTimeTravelDirections())
        }
        
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        switch complication.family {
        case .modularLarge:
            let startDate = Date.distantPast
            handler(startDate)
        default:
            handler(nil)
        }
        
        
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        switch complication.family {
        case .modularLarge:
            let startDate = Date.distantFuture
            handler(startDate)
        default:
            handler(nil)
        }
        
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
}
