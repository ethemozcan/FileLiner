import XCTest
@testable import FileLiner

final class FileLinerTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(FileLiner().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
