//
//  SymbolTable.swift
//  HackAssembler
//
//  Created by 山田良治 on 2019/01/13.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

final class SymbolTable {
    private var table: [String: Int] = [:]
    
    func addEntry(symbol: String, address: Int) {
        table[symbol] = address
    }
    
    func contains(symbol: String) -> Bool {
        return table[symbol] != nil
    }
    
    func getAddress(symbol: String) -> Int {
        let address = table[symbol]
        assert(address != nil)
        
        return address!
    }
    
}
