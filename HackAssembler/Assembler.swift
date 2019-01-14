//
//  HackAssembler.swift
//  HackAssembler
//
//  Created by 山田良治 on 2019/01/13.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

final class Assembler {
    private let assembly: String
    
    init(assembly: String) {
        self.assembly = assembly
    }
    
    func assembled() -> String {
        
        let parser = Parser(assembly: self.assembly)
        let symbolTable = SymbolTable()
        var initialROMAddress: Int16 = 0
        var hackCommnads: [String] = []
        
        // Make symbol table.
        while parser.hasMoreCommands {
            parser.advance()
            
            if parser.commandType == .l {
                symbolTable.addEntry(symbol: parser.symbol, address: initialROMAddress)
            } else {
                initialROMAddress += 1
            }
            
        }
        
        parser.reset()
        
        var initialRAMAddress: Int16 = 16
        // Translate to binary.
        while parser.hasMoreCommands {
            parser.advance()
            
            if parser.commandType == .a {
                if let value  = Int16(parser.symbol)?.binaryString {
                    hackCommnads.append(value)
                } else {
                    if symbolTable.contains(symbol: parser.symbol) {
                        let value = symbolTable.getAddress(symbol: parser.symbol).binaryString
                        hackCommnads.append(value)
                    } else {
                        symbolTable.addEntry(symbol: parser.symbol, address: initialRAMAddress)
                        hackCommnads.append(initialRAMAddress.binaryString)
                        initialRAMAddress += 1
                    }
                }
                
            } else if parser.commandType == .c {
                let compMnemonic = parser.comp
                let destMnemonic = parser.dest
                let jumpMnemonic = parser.jump
                
                let compBin = Code.comp(from: compMnemonic)
                let destBin = Code.dest(from: destMnemonic)
                let jumpBin = Code.jump(from: jumpMnemonic)
                
                let cInstruction = "111\(compBin)\(destBin)\(jumpBin)"
                hackCommnads.append(cInstruction)
            }
        }
        return hackCommnads.joined(separator: "\n")
    }
    
}

// https://qiita.com/guitar_char/items/54d18a04401154a79e47
extension FixedWidthInteger {
    var binaryString: String {
        var result: [String] = []
        for i in 0..<(Self.bitWidth / 8) {
            // ビットの右側から見ていって、UInt8の8bit(1byte)からはみ出た部分はtruncatiteする。
            // 自身のビット長によって8bitづつ右側ビットシフトをして、右端8bitづつUInt8にしている
            let byte = UInt8(truncatingIfNeeded: self >> (i * 8))
            
            // 2進数文字列に変換
            let byteString = String(byte, radix: 2)
            
            // 8桁(8bit)になるように0 padding
            let padding = String(repeating: "0",
                                 count: 8 - byteString.count)
            // 先頭にパディングを足す
            result.append(padding + byteString)
        }
        
        // 右端の8ビットが配列の先頭に入っているが、joined()するときは左端の8bitが配列の先頭に来ていて欲しいのでreversed()している
        return result.reversed().joined(separator: "")
    }
}
