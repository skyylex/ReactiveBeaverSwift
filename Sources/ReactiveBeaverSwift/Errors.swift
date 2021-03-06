//
//  File.swift
//  
//
//  Created by skyylex on 27/12/2019.
//

import Foundation

extension ZipUnarchiver {
    
    enum ErrorType: Error {
        case incorrectDestinationPath
        case incorrectSourcePath
        case incorrectArchive
    }
}

extension ArchiveBeaver {
    
    enum ErrorType: Error {
        case incorrectDestinationPath
        case incorrectSourcePath
        case cannotUnarchive
    }
}

extension ReactiveBeaver {
    
    enum ErrorType: Error {
        case inputParamsValidation
        case noDestinationFolder
        case xmlFileOpening
        case xmlNoFullPathAttribute
        case xmlNoRootFileElement
        case cannotParseOPFFile
        case incorrectContainerXML
    }
    
}

extension PathValidator {
    enum ErrorType: Error {
        case missingFile(URL)
        case missingDirectory(URL)
    }
}

