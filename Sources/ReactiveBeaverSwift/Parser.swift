import Foundation

protocol Unarchiver {
    func unpack(zipArchiveURL: URL, targetDirectoryURL: URL) -> Error?
}

final class Parser {
    typealias ParserCompletion = (Result<Epub, Error>) -> ()
    
    let unpacker: Unarchiver
    
    init(unpacker: Unarchiver) {
        self.unpacker = unpacker
    }
    
    func parse(epubURL: URL, destinationFolderURL: URL, completion: ParserCompletion) {
        guard PathValidator.validate(fileURL: epubURL) else {
            completion(.failure(ErrorType.incorrectSourcePath))
            return
        }
        
        guard PathValidator.validate(directoryURL: destinationFolderURL) else {
            completion(.failure(ErrorType.incorrectDestinationPath))
            return
        }
        
        let error = unpacker.unpack(zipArchiveURL: epubURL, targetDirectoryURL: destinationFolderURL)
        if let error = error {
            completion(.failure(error))
        } else {
            let paths = Paths(epubUnzippedFolderURL: destinationFolderURL)
            if let error = PathValidator.validate(paths: paths).first {
                completion(.failure(error))
            } else {
                completion(.success(createDummyEpub(epubURL: epubURL,
                                                    destinationFolderURL: destinationFolderURL)))
            }
        }
    }
    
    // MARK: Dummy data
    
    func createDummyEpub(epubURL: URL, destinationFolderURL: URL) -> Epub {
        return Epub(
            sha1: "",
            sourcePath: epubURL,
            destinationPath: destinationFolderURL,
            spine: Spine(),
            manifest: Manifest(items: []),
            metadata: Metadata(metadataMap: [:]),
            container: ContainerXML(packageOpfURL: URL(fileURLWithPath: "")),
            coverPath: nil
        )
    }
}
