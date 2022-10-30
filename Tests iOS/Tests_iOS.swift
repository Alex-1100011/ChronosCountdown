//
//  Tests_iOS.swift
//  Tests iOS
//
//  Created by Alessandro Alberti on 20/05/22.
//

import XCTest

class Tests_iOS: XCTestCase {
    var counter = Counter(name: "", date: Date(), color: .blue, symbolName: "")
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //MARK: Counter Components
    func testGetCounterComponents() throws {
        
        //MARK: 1 Week -
        counter.date = Date() + 60 * 60 * 24 * 7
        
        //Testing showOnlyDays
        XCTAssertEqual(
            counter.getCounterComponents(type: .showOnlyDays),
            CounterComponents(days: 7, weeks: 0, months: 0, years: 0)
        )
        //Testing showWeeks
        XCTAssertEqual(
            counter.getCounterComponents(type: .showWeeks),
            CounterComponents(days: 0, weeks: 1, months: 0, years: 0)
        )
        //Testing showYears
        XCTAssertEqual(
            counter.getCounterComponents(type: .showYears),
            CounterComponents(days: 7, weeks: 0, months: 0, years: 0)
        )
        
        //MARK: 4 Weeks -
        counter.date = Date() + 60 * 60 * 24 * 7 * 4
        
        //Testing showOnlyDays
        XCTAssertEqual(
            counter.getCounterComponents(type: .showOnlyDays),
            CounterComponents(days: 28, weeks: 0, months: 0, years: 0)
        )
        //Testing showWeeks
        XCTAssertEqual(
            counter.getCounterComponents(type: .showWeeks),
            CounterComponents(days: 0, weeks: 4, months: 0, years: 0)
        )
        //Testing showYears
        XCTAssertEqual(
            counter.getCounterComponents(type: .showYears),
            CounterComponents(days: 28, weeks: 0, months: 0, years: 0)
        )
        
        //MARK: 1 Month -
        counter.date = Date() + 60 * 60 * 24 * 31
        
        //Testing showOnlyDays
        XCTAssertEqual(
            counter.getCounterComponents(type: .showOnlyDays),
            CounterComponents(days: 31, weeks: 0, months: 0, years: 0)
        )
        //Testing showWeeks
        XCTAssertEqual(
            counter.getCounterComponents(type: .showWeeks),
            CounterComponents(days: 0, weeks: 0, months: 1, years: 0)
        )
        //Testing showYears
        XCTAssertEqual(
            counter.getCounterComponents(type: .showYears),
            CounterComponents(days: 0, weeks: 0, months: 1, years: 0)
        )
        
       
    }
    
    func testNegativeComponents() throws {
        counter.date = Date() - 60 * 60 * 24 * 7
        
        // 7 days
        XCTAssertEqual(
            counter.getCounterComponents(type: .showOnlyDays),
            CounterComponents(days: -7, weeks: 0, months: 0, years: 0)
        )
        // 1 week
        XCTAssertEqual(
            counter.getCounterComponents(type: .showWeeks),
            CounterComponents(days: 0, weeks: -1, months: 0, years: 0)
        )
        
        // Today
        counter.date = Date()
        XCTAssertEqual(
            counter.getCounterComponents(type: .showWeeks),
            CounterComponents(days: 0, weeks: 0, months: 0, years: 0)
        )
        // Yesterday
        counter.date = Date() - 60 * 60 * 24 * 1
        XCTAssertEqual(
            counter.getCounterComponents(type: .showWeeks),
            CounterComponents(days: -1, weeks: 0, months: 0, years: 0)
        )
    }
}
