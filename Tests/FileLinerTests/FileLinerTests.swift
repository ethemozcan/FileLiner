import XCTest
@testable import FileLiner

final class FileLinerTests: XCTestCase {
    let path = Bundle(for: FileLinerTests.self).path(forResource: "TestFile", ofType: "csv")!

    func testReadLineWithDefaults() {
        let reader = try! FileLiner(path: path)
        
        let line1 = reader.readLine()
        let line2 = reader.readLine()
        let line3 = reader.readLine()

        XCTAssertEqual(line1, "\"First name\",\"Sur name\",\"Some count\",\"Birthday\"")
        XCTAssertEqual(line2, "\"John\",\"Appleseed\",5,\"1774-09-26T00:00:00\"")
        XCTAssertNil(line3)
        XCTAssertFalse(reader.hasLinesToRead)
    }

    func testReadWithSmallChunks() {
        let reader = try! FileLiner(path: path, delimiter: "\n", chunk: 20)

        let line1 = reader.readLine()
        let line2 = reader.readLine()
        let line3 = reader.readLine()

        XCTAssertEqual(line1, "\"First name\",\"Sur name\",\"Some count\",\"Birthday\"")
        XCTAssertEqual(line2, "\"John\",\"Appleseed\",5,\"1774-09-26T00:00:00\"")
        XCTAssertNil(line3)
        XCTAssertFalse(reader.hasLinesToRead)
    }

    func testReadWithLargeChunks() {
        let reader = try! FileLiner(path: path, delimiter: "\n", chunk: 4096)

        let line1 = reader.readLine()
        let line2 = reader.readLine()
        let line3 = reader.readLine()

        XCTAssertEqual(line1, "\"First name\",\"Sur name\",\"Some count\",\"Birthday\"")
        XCTAssertEqual(line2, "\"John\",\"Appleseed\",5,\"1774-09-26T00:00:00\"")
        XCTAssertNil(line3)
        XCTAssertFalse(reader.hasLinesToRead)
    }

    func testInvalidDelimiter() {
        do {
            let _ = try FileLiner(path: path, delimiter: "\\", chunk: 1024)
            XCTAssert(false, "Can't handle invalid delimiter")
        } catch FileLinerError.invalidDelimiter {
            XCTAssert(true)
        } catch {
            XCTAssert(false, "Can't handle invalid delimiter")
        }
    }
}
