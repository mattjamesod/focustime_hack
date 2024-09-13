import Foundation

enum UserTiming {
    case focusDuration(Int)
    case breakDuration(Int)
    case workHours(start: Date, end: Date)
    case lunch(start: Date, end: Date)
    
    func fetch(_ key: UserTimingKey) -> UserTiming {
        switch key {
        case .focusDuration: fetchFocusDuration()
        case .breakDuration: fetchBreakDuration()
        case .workHours: fetchWorkHours()
        case .lunch: fetchLunch()
        }
    }
    
    private func fetchFocusDuration() -> UserTiming {
        let defaults = UserDefaults.standard
        
        let value = defaults.integer(forKey: UserTimingKey.focusDuration.rawValue)
        
        return .focusDuration(value)
    }
    
    private func fetchBreakDuration() -> UserTiming {
        let defaults = UserDefaults.standard
        
        let value = defaults.integer(forKey: UserTimingKey.breakDuration.rawValue)
        
        return .breakDuration(value)
    }
    
    private func fetchWorkHours() -> UserTiming {
        let defaults = UserDefaults.standard
        
        let start = defaults.double(forKey: UserTimingKey.workHours.rawValue + "Start")
        let end = defaults.double(forKey: UserTimingKey.workHours.rawValue + "End")
        
        return .workHours(start: Date(timeIntervalSince1970: start), end: Date(timeIntervalSince1970: end))
    }
    
    private func fetchLunch() -> UserTiming {
        let defaults = UserDefaults.standard
        
        let start = defaults.double(forKey: UserTimingKey.workHours.rawValue + "Start")
        let end = defaults.double(forKey: UserTimingKey.workHours.rawValue + "End")
        
        return .lunch(start: Date(timeIntervalSince1970: start), end: Date(timeIntervalSince1970: end))
    }
    
}
