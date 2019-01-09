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
        
        if formatter.text.isEmpty {
            self.commands = []
        } else {
            self.commands = [""] + formatter.text.components(separatedBy: "\n")
        }
    }
    
    var hasMoreCommands: Bool {
        return cursor + 1 < commands.count
    }
    
    func advance() {
        if hasMoreCommands {
            cursor += 1
        }
    }
    
    var commandType: CommnadType {
        let currentCommand = commands[cursor]
        return CommnadType(command: currentCommand)
    }
    
}
