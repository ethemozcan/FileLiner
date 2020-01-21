//
//  File.swift
//  
//
//  Created by Ethem Özcan on 19.01.20.
//

import Foundation

public protocol FileLinerProtocol {
    init(path: String) throws
    init(path: String, delimiter: String, chunk: Int) throws
    func readLine() -> String?
    var hasLinesToRead: Bool { get }
}
