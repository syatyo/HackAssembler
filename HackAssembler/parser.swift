//
//  parser.swift
//  HackAssembler
//
//  Created by 山田良治 on 2019/01/09.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

final class Parser {
    
    let commands: [String]
    private var cursor: Int = 0
    
    init(assembly: String) {
        self.commands = ["@0"]
    }
    
    var hasMoreCommands: Bool {
        return cursor + 1 < commands.count
    }
    
}
