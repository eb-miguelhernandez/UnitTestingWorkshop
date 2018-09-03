import Foundation

protocol CaseIterable {  // Preliminar Swift 5 support
    static var allCases: [DateDisplay] { get }
}

enum DateDisplay: String, CaseIterable {
    /// 01-01-20
    case shortDate = "dd-MM-yy"
    /// 01-01-2020
    case shortDateLongYear = "dd-MM-yyyy"
    /// Mon, Jan 1
    case dayOfTheWeekMonthAndDay = "EEE, MMM d"
    /// Mon, Jan 1 • 6:52AM
    case fullDay = "EEE, MMM d • h:mma"
    /// Mon, Jan 1 2020 • 6:52AM
    case fullDate = "EEE, MMM d yyyy • h:mma"

    static var allCases: [DateDisplay] { return [.shortDate, .shortDateLongYear, .dayOfTheWeekMonthAndDay, fullDay, fullDate] }
}

extension DateDisplay {
    /// Returns a date string using a DateFormatter.
    /// You may use DateDisplay.formatter(forTimeZone: TimeZone) to get your formatter
    static func text(date: Date, dateFormatter: DateFormatter, timeZone: TimeZone) -> String {
        return dateFormatter.string(from: date)
    }

    /// Returns the right date formatter using the specified time zone.
    func formatter(forTimeZone timeZone: TimeZone) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = self.rawValue
        dateFormatter.timeZone = timeZone
        return dateFormatter
    }

    /// Returns a date string by implicitely creating the date formatter on the go.
    /// Disclaimer: This method can cause perfomance issues. Date formatters are a bit memory expensive.
    /// Prefer DateDisplay.text(date: Date, dateFormatter: DateFormatter, timeZone: TimeZone) over this.
    internal func text(date: Date, timeZone: TimeZone) -> String {
        let formatter = self.formatter(forTimeZone: timeZone)
        return formatter.string(from: date)
    }
}
