#!/usr/bin/swift

import Foundation

/// Current directory path depends from where the user calls it.
/// That's why it's important to get to the known point which path of the this script file
/// and move up to the repo URL
let currentDirectoryURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
let scriptURL = URL(fileURLWithPath: CommandLine.arguments[0], relativeTo: currentDirectoryURL)
let scriptsFolderURL = scriptURL.deletingLastPathComponent()
let repositoryRootURL = scriptsFolderURL.deletingLastPathComponent()
let testsConfigurationFolderURL = repositoryRootURL.appendingPathComponent("Tests/Configuration")
let booksPathsScriptFileURL = testsConfigurationFolderURL.appendingPathComponent("BooksPaths.swift")

let epubBooksFolderURL = currentDirectoryURL.appendingPathComponent("ReactiveBeaverTestResources/epub-books")
let mobyDickFileURL = epubBooksFolderURL.appendingPathComponent("moby-dick.epub")

let content =
"""
/// This file is generetad and filled with proper paths for testing with real books
/// If paths are empty please check that you've run ./setup.sh

enum BookPaths {
    static let mobyDickPath = "\(mobyDickFileURL.path)"
}
"""

let success: Void? = try? content.write(toFile:booksPathsScriptFileURL.path,
                                        atomically: true,
                                        encoding: String.Encoding.utf8)
if let _ = success {
    print("Successfully generated book paths at: \(booksPathsScriptFileURL.path)")
} else {
    abort()
}



