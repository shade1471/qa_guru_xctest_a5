import XCTest

final class UITestsLaunchTests: XCTestCase {

    let app = XCUIApplication()
    let safari = XCUIApplication(bundleIdentifier: "com.apple.mobilesafari")
    
    var oneButton: XCUIElement!
    var twoButton: XCUIElement!
    var threeButton: XCUIElement!
    var fourButton: XCUIElement!
    var fiveButton: XCUIElement!
    var sixButton: XCUIElement!
    var sevenButton: XCUIElement!
    var eightButton: XCUIElement!
    var nineButton: XCUIElement!
    var equalsButton: XCUIElement!
    var multiplyButton: XCUIElement!
    var subtractionButton: XCUIElement!
    var divisionButton: XCUIElement!
    var deleteButton: XCUIElement!
    var currentText: XCUIElement!
    var resultString: XCUIElement!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
        
        oneButton = app.buttons["oneButton"]
        twoButton = app.buttons["twoButton"]
        threeButton = app.buttons["threeButton"]
        fourButton = app.buttons["fourButton"]
        fiveButton = app.buttons["fiveButton"]
        sixButton = app.buttons["sixButton"]
        sevenButton = app.buttons["sevenButton"]
        eightButton = app.buttons["eightButton"]
        nineButton = app.buttons["nineButton"]
        equalsButton = app.buttons["equalsButton"]
        multiplyButton = app.buttons["multiplyButton"]
        subtractionButton = app.buttons["subtractionButton"]
        divisionButton = app.buttons["divisionButton"]
        deleteButton = app.buttons["deleteButton"]
        currentText = app.staticTexts["currentText"]
        resultString = app.buttons["resultString"]
    }

    func testScreenshot() throws {
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
    
    func testDebugTree() throws {
        print(app.debugDescription)
    }
    
    func testSum9() throws {
        let button4 = app.buttons["4"]
        button4.tap()
        app.buttons["+"].tap()
        app.buttons["5"].tap()
        app.buttons["="].tap()
        XCTAssert(app.buttons["resultString"].staticTexts["9"].exists)
    }
    
    func testSum9Faster() throws {
        app.buttons["4"].firstMatch.tap()
        app.buttons["+"].firstMatch.tap()
        app.buttons["5"].firstMatch.tap()
        app.buttons["="].firstMatch.tap()
        XCTAssert(app.buttons["resultString"].staticTexts["9"].firstMatch.exists)
    }
    
    func testAC() throws {
        app.buttons["7"].tap()
        app.buttons["7"].tap()
        app.buttons["+"].tap()
        app.buttons["ZeroButton"].tap()
        app.buttons["="].tap()
        XCTAssert(app.buttons["resultString"].staticTexts["77"].exists)
        app.buttons["AC"].tap()
        XCTAssert(app.buttons["resultString"].staticTexts["0"].exists)
    }
    
    func testRecorded() throws {
        let button = app.buttons["2"]
        button.tap()
        app.buttons["+"].tap()
        button.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["="]/*[[".buttons[\"=\"].staticTexts[\"=\"]",".staticTexts[\"=\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssert(app.buttons["resultString"].staticTexts["4"].exists)
    }
    
    func testSkip() throws {
        try XCTSkipIf(true, "Так нужно")
    }
    
    func testFail() throws {
        XCTFail("Очень нужно!")
    }
    
    func testSafari() throws {
        safari.launch()
        app.launch()
    }
    
    func testSubtraction() throws {
        fourButton.tap()
        subtractionButton.tap()
        threeButton.tap()
        equalsButton.tap()
        XCTAssert(resultString.staticTexts["1"].exists)
    }
    
    func testDivision() throws {
        nineButton.tap()
        divisionButton.tap()
        threeButton.tap()
        equalsButton.tap()
        XCTAssert(resultString.staticTexts["3"].exists)
    }
    
    func testMultiply() throws {
        oneButton.tap()
        twoButton.tap()
        multiplyButton.tap()
        fourButton.tap()
        equalsButton.tap()
        XCTAssert(resultString.staticTexts["48"].exists)
    }
    
    func testDelete() throws {
        oneButton.tap()
        twoButton.tap()
        threeButton.tap()
        deleteButton.tap()
        XCTAssertEqual(currentText.label, "12")
    }
}
