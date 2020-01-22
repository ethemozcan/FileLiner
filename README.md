# FileLiner
This Swift package helps you read a file line by line. 

## Installation

## Swift Package Manager

```swift
.package(url: "https://github.com/ethemozcan/FileLiner.git", .upToNextMinor(from: "1.0.0"))
```

## Usage

```swift
        import FileLiner

        do {
            let path = Bundle.main.path(forResource: "TestFile", ofType: "csv")
            let fileLiner = try FileLiner(path: path!)

            while fileLiner.hasLinesToRead {
                print(fileLiner.readLine()!)
            }
        } catch FileLinerError.fileNotExist {
             // Handle Error
        } catch FileLinerError.invalidDelimiter {
            // Handle Error
        } catch FileLinerError.invalidChunk {
            // Handle Error
        } catch {
            // Handle Error
        }
```