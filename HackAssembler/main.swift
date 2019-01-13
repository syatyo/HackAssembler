//
//  main.swift
//  HackAssembler
//
//  Created by 山田良治 on 2019/01/09.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

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

private func main(arguments: [String]) {
//    let arguments = arguments.dropFirst()
//    guard let input = arguments.first else {
//        print("cat file.asm | HackAssembler")
//        return
//    }
    
    let input = """
// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/06/max/MaxL.asm

// Symbol-less version of the Max.asm program.

// * Attention *
// I use .txt as extension to avoid compiling this file as assembler by Xcode.
// .asm file cause compile error.

@0
D=M
@1
D=D-M
@10
D;JGT
@1
D=M
@12
0;JMP
@0
D=M
@2
M=D
@14
0;JMP

"""
    let parser = Parser(assembly: input)
    var hackCommnads: [String] = []
    while parser.hasMoreCommands {
        parser.advance()
        
        if parser.commandType == .a {
            let binarySymbol  = Int16(parser.symbol)!.binaryString
            hackCommnads.append(binarySymbol)
            
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
    print(hackCommnads.joined(separator: "\n"))
}

main(arguments: CommandLine.arguments)
