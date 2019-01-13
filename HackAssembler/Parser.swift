//
//  parser.swift
//  HackAssembler
//
//  Created by 山田良治 on 2019/01/09.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

enum CommnadType {
    case a
    case c
    case l
    
    init(command: String) {
        if command.starts(with: "@") {
            self = .a
        } else if command.starts(with: "(") {
            self = .l
        } else {
            self = .c
        }
    }
}

final class Parser {
    
    let commands: [String]
    var currentCommand: String {
        return commands[cursor]
    }
    private var cursor: Int = 0
    
    init(assembly: String) {
        let formatter = AssemblerFormatter(source: assembly)
        formatter.removeComments()
        formatter.removeWhiteSpaces()
        formatter.removeEmptyLine()
        
        if formatter.text.isEmpty {
            self.commands = []
        } else {
            self.commands = [""] + formatter.text.components(separatedBy: "\n")
        }
    }
    
    var hasMoreCommands: Bool {
        return cursor + 1 < commands.count
    }
    
    func reset() {
        cursor = 0
    }
    
    func advance() {
        precondition(hasMoreCommands == true)
        cursor += 1
    }
    
    var commandType: CommnadType {
        return CommnadType(command: currentCommand)
    }
    
    var symbol: String {
        precondition(commandType != .c)
        
        switch commandType {
        case .a:
            let atIndex = currentCommand.firstIndex(of: "@")!
            return String(currentCommand[currentCommand.index(after: atIndex)...])
            
        case .l:
            let parenthesisStartIndex = currentCommand.firstIndex(of: "(")!
            let parenthesisEndIndex = currentCommand.firstIndex(of: ")")!
            
            let symbolStartIndex = currentCommand.index(after: parenthesisStartIndex)
            let symbolEndIndex = currentCommand.index(before: parenthesisEndIndex)
            
            return String(currentCommand[symbolStartIndex...symbolEndIndex])
        case .c:
            fatalError()
        }
    }
    
    var dest: String {
        precondition(commandType == .c)
        
        if let equalIndex = currentCommand.firstIndex(of: "=") {
            return String(currentCommand[..<equalIndex])
        } else {
            return "null"
        }
        
    }
    
    var comp: String {
        precondition(commandType == .c)
        
        if let equalIndex = currentCommand.firstIndex(of: "=") {
            let compStartIndex = currentCommand.index(after: equalIndex)
            return String(currentCommand[compStartIndex...])
        } else if let semicolonIndex = currentCommand.firstIndex(of: ";") {
            return String(currentCommand[..<semicolonIndex])
        } else {
            fatalError("Undefined")
        }

    }
    
    var jump: String {
        precondition(commandType == .c)
        
        if let semicolonIndex = currentCommand.firstIndex(of: ";") {
            let jumpStartIndex = currentCommand.index(after: semicolonIndex)
            return String(currentCommand[jumpStartIndex...])
        } else {
            return "null"
        }

    }

}
