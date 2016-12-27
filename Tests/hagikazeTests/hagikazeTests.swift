import XCTest
@testable import hagikaze

class hagikazeTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(hagikaze().text, "Hello, World!")
    }


    static var allTests : [(String, (hagikazeTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
