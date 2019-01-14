//
//  main.swift
//  HackAssembler
//
//  Created by 山田良治 on 2019/01/09.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

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

//    print(hackCommnads.joined(separator: "\n"))
}

main(arguments: CommandLine.arguments)
