import Foundation

protocol FileLinerProtocol {
    func readLine() -> String?
    var hasLinesToRead: Bool { get }
}

class FileLiner: FileLinerProtocol {
    private let file: FileHandle
    private let delimiterData: Data
    private let chunk = 1024
    private let delimiterChar: Character
    private var buffer: Data
    private var endOfFile = false

    init?(path: String, delimiter: String = "\n") {
        guard let file = FileHandle(forReadingAtPath: path),
            let delimiterData = delimiter.data(using: .utf8)
            else { return nil }

        self.file = file
        self.delimiterData = delimiterData
        buffer = Data(capacity: chunk)
        delimiterChar = Character(delimiter)
    }

    deinit {
        file.closeFile()
    }

    var hasLinesToRead: Bool {
        !endOfFile
    }

    func readLine() -> String? {
        let tempData = file.readData(ofLength: chunk)
        buffer.append(tempData)

        let range = buffer.range(of: delimiterData)
        if  range == nil && endOfFile == false && tempData.count > 0 {
            return readLine()
        }

        let lineData = buffer.prefix { uniCode -> Bool in
            let character = Character(UnicodeScalar(uniCode))
            return character != delimiterChar
        }

        if lineData.count > 0 {
            guard let line = String(data: lineData, encoding: .utf8)?.trimmingCharacters(in: .newlines) else { return nil }

            if lineData.endIndex >= buffer.count - 1 {
                buffer.removeAll()
                endOfFile = true
            } else {
                buffer.removeSubrange(Range(uncheckedBounds: (lower: lineData.startIndex, upper: lineData.endIndex + 1)))
            }

            return line
        }

        endOfFile = true
        return nil
    }
}
