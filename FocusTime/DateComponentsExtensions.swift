//import Foundation
//
//public extension DateComponents {
//    var hence: Date {
//        guard let foundDate = Calendar.current.date(byAdding: self, to: Date()) else {
//            fatalError()
//        }
//        
//        return foundDate
//    }
//    
//    var ago: Date {
//        guard let foundDate = Calendar.current.date(byAdding: -self, to: Date()) else {
//            fatalError()
//        }
//        
//        return foundDate
//    }
//    
//    static prefix func -(rhs: Self) -> DateComponents {
//        .init(
//            year: -rhs.year,
//            month: -rhs.month,
//            day: -rhs.day,
//            hour: -rhs.hour,
//            minute: -rhs.minute,
//            second: -rhs.second
//        )
//    }
//}
