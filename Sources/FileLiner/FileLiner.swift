import Foundation

public final class FileLiner: FileLinerProtocol {
    private let handler: FileHandle
    private let delimiterData: Data
    private let chunk: Int
    private let delimiterChar: Character
    private var buffer: Data
    private var endOfFile = false

    public init(path: String, delimiter: String, chunk: Int) throws {
        guard let delimiterCharacter = delimiter.unicodeScalars.first,
            CharacterSet.newlines.contains(delimiterCharacter) != false,
            let delimiterData = delimiter.data(using: .utf8) else {
            throw FileLinerError.invalidDelimiter
        }

        guard let handler = FileHandle(forReadingAtPath: path) else {
            throw FileLinerError.fileNotExist
        }

        if chunk < Defaults.chunk {
            throw FileLinerError.invalidChunk
        }

        self.handler = handler
        self.delimiterData = delimiterData
        self.chunk = chunk
        buffer = Data(capacity: chunk)
        delimiterChar = Character(delimiter)
    }

    convenience public init(path: String) throws {
        try self.init(path: path, delimiter:Defaults.delimiter, chunk:Defaults.chunk)
    }

    deinit {
        handler.closeFile()
    }

    public var hasLinesToRead: Bool {
        !endOfFile
    }

    public func readLine() -> String? {
        let tempData = handler.readData(ofLength: chunk)
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
