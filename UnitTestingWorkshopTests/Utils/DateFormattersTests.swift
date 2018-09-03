import XCTest
@testable import UnitTestingWorkshop

class DateFormattersTests: XCTestCase {
    var date: Date!
    var timeZone: TimeZone!
    override func setUp() {
        super.setUp()
        self.date = Date(timeIntervalSince1970: 1514789562)
        self.timeZone = TimeZone(secondsFromGMT: 0)
    }
    override func tearDown() {
        self.date = nil
        self.timeZone = nil
        super.tearDown()
    }

    func testShortDateFormatter() {
        let sut = DateDisplay.shortDate
        let dateFormatter = sut.formatter(forTimeZone: timeZone)
        let text = DateDisplay.text(date: self.date, dateFormatter: dateFormatter, timeZone: self.timeZone)

        XCTAssertEqual(text, "01-01-18")
    }

    func testShortDateAndLongYearFormatter() {
        let sut = DateDisplay.shortDateLongYear
        let dateFormatter = sut.formatter(forTimeZone: timeZone)
        let text = DateDisplay.text(date: self.date, dateFormatter: dateFormatter, timeZone: self.timeZone)

        XCTAssertEqual(text, "01-01-2018")
    }

    func testDayOfTheWeekMonthAndDayFormatter() {
        let sut = DateDisplay.dayOfTheWeekMonthAndDay
        let dateFormatter = sut.formatter(forTimeZone: timeZone)
        let text = DateDisplay.text(date: self.date, dateFormatter: dateFormatter, timeZone: self.timeZone)

        XCTAssertEqual(text, "Mon, Jan 1")
    }

    func testFullDayFormatter() {
        let sut = DateDisplay.fullDay
        let dateFormatter = sut.formatter(forTimeZone: timeZone)
        let text = DateDisplay.text(date: self.date, dateFormatter: dateFormatter, timeZone: self.timeZone)

        XCTAssertEqual(text, "Mon, Jan 1 • 6:52AM")
    }

    func testFullDateFormatter() {
        let sut = DateDisplay.fullDate
        let dateFormatter = sut.formatter(forTimeZone: timeZone)
        let text = DateDisplay.text(date: self.date, dateFormatter: dateFormatter, timeZone: self.timeZone)

        XCTAssertEqual(text, "Mon, Jan 1 2018 • 6:52AM")
    }
}

class DateFormatterPerformanceTests: XCTestCase {
    func testPerformanceOfMultipleDateDisplaysCreatingAsManyDateFormattersAsDateDisplays() {
        let date = Date(timeIntervalSince1970: 1514789562)
        let timeZone: TimeZone! = TimeZone(secondsFromGMT: 0)
        let dateDisplays: [DateDisplay] = DateDisplay.allCases
        self.measure {
            dateDisplays.forEach({ (dateDisplay) in
                let dateFormatter = dateDisplay.formatter(forTimeZone: timeZone)
                _ = DateDisplay.text(date: date, dateFormatter: dateFormatter, timeZone: timeZone)
            })
        }
    }

    func testPerformanceOfMultipleDatesCreatingAsManyDateFormattersAsDates() {
        let dates = (100..<130).map { return Date(timeIntervalSince1970: TimeInterval($0)) }
        let timeZone: TimeZone! = TimeZone(secondsFromGMT: 0)
        let dateDisplay: DateDisplay = DateDisplay.dayOfTheWeekMonthAndDay
        self.measure {
            dates.forEach({ (date) in
                _ = dateDisplay.text(date: date, timeZone: timeZone)
            })
        }
    }

    func testPerformanceForMultipleDatesCreatingASingleDateFormatter() {
        let dates = (100..<130).map { return Date(timeIntervalSince1970: TimeInterval($0)) }
        let timeZone: TimeZone! = TimeZone(secondsFromGMT: 0)
        let dateDisplay: DateDisplay = DateDisplay.dayOfTheWeekMonthAndDay
        let dateFormatter = dateDisplay.formatter(forTimeZone: timeZone)
        self.measure {
            dates.forEach({ (date) in
                _ = DateDisplay.text(date: date, dateFormatter: dateFormatter, timeZone: timeZone)
            })
        }
    }
}
