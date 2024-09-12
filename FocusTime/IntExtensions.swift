import Foundation

/// For Rails ActiveSupport style readbale date syntax
public extension Int {
    var seconds: DateComponents { .init(second: self) }
    var second: DateComponents { self.seconds }
    
    var minutes: DateComponents { .init(minute: self) }
    var minute: DateComponents { self.minutes }
    
    var hours: DateComponents { .init(hour: self) }
    var hour: DateComponents { self.hours }
    
    var days: DateComponents { .init(day: self) }
    var day: DateComponents { self.days }
    
    var weeks: DateComponents { .init(day: self * 7) }
    var week: DateComponents { self.weeks }
    
    var months: DateComponents { .init(month: self) }
    var month: DateComponents { self.months }
    
    var years: DateComponents { .init(year: self) }
    var year: DateComponents { self.years }
}
