import Foundation

public extension Date {
    var dayName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: self)
    }
    
    var monthName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        
        return dateFormatter.string(from: self)
    }
    
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        Calendar.current.date(byAdding: 1.day, to: self.startOfDay) ?? self
    }
    
    var startOfMonth: Date {
        Calendar.current.dateInterval(of: .month, for: self)?.start ?? self
    }
    
    func atTime(h: Int, m: Int, s: Int) -> Date {
        Calendar.current.date(byAdding: DateComponents(hour: h, minute: m, second: s), to: self.startOfDay) ?? self
    }
}
