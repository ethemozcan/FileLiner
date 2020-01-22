//
//  File.swift
//  
//
//  Created by Ethem Özcan on 21.01.20.
//

import Foundation

public enum FileLinerError: Error {
    case invalidChunk
    case invalidDelimiter
    case fileNotExist
}
