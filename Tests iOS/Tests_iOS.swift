//
//  Tests_iOS.swift
//  Tests iOS
//
//  Created by Alessandro Alberti on 20/05/22.
//

import XCTest

class Tests_iOS: XCTestCase {
    var dataController = DataController()
    
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
        let context = dataController.container.viewContext
        var counter = Counter(context: context, name: "", date: Date(), color: "", symbolName: "")
        
        
        //MARK: 1 Week -
        counter.date = Date() + 60 * 60 * 24 * 7
        
        //Testing showOnlyDays
        var components = counter.getCounterComponents(type: .showOnlyDays)
        XCTAssert(
            components == (days: 7, weeks: 0, months: 0, years: 0)
        )
        //Testing showWeeks
        components = counter.getCounterComponents(type: .showWeeks)
        XCTAssert(
            components == (days: 0, weeks: 1, months: 0, years: 0)
        )
        //Testing showYears
        components = counter.getCounterComponents(type: .showYears)
        XCTAssert(
            components == (days: 7, weeks: 0, months: 0, years: 0)
        )
        
        
        //MARK: 4 Weeks -
        counter.date = Date() + 60 * 60 * 24 * 7 * 4
        
        //Testing showOnlyDays
        components = counter.getCounterComponents(type: .showOnlyDays)
        XCTAssert(
            components == (days: 28, weeks: 0, months: 0, years: 0)
        )
        //Testing showWeeks
        components = counter.getCounterComponents(type: .showWeeks)
        XCTAssert(
            components == (days: 0, weeks: 4, months: 0, years: 0)
        )
        //Testing showYears
        components = counter.getCounterComponents(type: .showYears)
        XCTAssert(
            components == (days: 28, weeks: 0, months: 0, years: 0)
        )
        
        //MARK: 1 Month -
        counter.date = Date() + 60 * 60 * 24 * 31
        
        //Testing showOnlyDays
        components = counter.getCounterComponents(type: .showOnlyDays)
        XCTAssert(
            components == (days: 31, weeks: 0, months: 0, years: 0)
        )
        //Testing showWeeks
        components = counter.getCounterComponents(type: .showWeeks)
        XCTAssert(
            components == (days: 0, weeks: 0, months: 1, years: 0)
        )
        //Testing showYears
        components = counter.getCounterComponents(type: .showYears)
        XCTAssert(
            components == (days: 0, weeks: 0, months: 1, years: 0)
        )
        
        
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
