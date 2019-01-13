//
//  SymbolTable.swift
//  HackAssembler
//
//  Created by 山田良治 on 2019/01/13.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

final class SymbolTable {
    private(set) var table: [String: Int16] = [:]
    
    init() {
        (0...15).forEach { table["R\($0!)"] = $0 }
        table["SCREEN"] = 16384
        table["KBD"] = 24576
    }
    
    func addEntry(symbol: String, address: Int16) {
        table[symbol] = address
    }
    
    func contains(symbol: String) -> Bool {
        return table[symbol] != nil
    }
    
    func getAddress(symbol: String) -> Int16 {
        switch symbol {
        case "SP":
            return table["R0"]!
            
        case "LCL":
            return table["R1"]!
            
        case "ARG":
            return table["R2"]!
            
        case "THIS":
            return table["R3"]!
            
        case "THAT":
            return table["R4"]!
            
        default:
            let address = table[symbol]
            assert(address != nil)
            
            return address!
        }
    }
    
}
