//
//  AssemblerTests.swift
//  HackAssemblerTests
//
//  Created by 山田良治 on 2019/01/13.
//  Copyright © 2019 山田良治. All rights reserved.
//

import XCTest

class AssemblerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAdd() {
        let testAssembly = """
        // This file is part of www.nand2tetris.org
        // and the book "The Elements of Computing Systems"
        // by Nisan and Schocken, MIT Press.
        // File name: projects/06/max/Max.asm

        // Computes R2 = max(R0, R1)  (R0,R1,R2 refer to RAM[0],RAM[1],RAM[2])

           @R0
           D=M              // D = first number
           @R1
           D=D-M            // D = first number - second number
           @OUTPUT_FIRST
           D;JGT            // if D>0 (first is greater) goto output_first
           @R1
           D=M              // D = second number
           @OUTPUT_D
           0;JMP            // goto output_d
        (OUTPUT_FIRST)
           @R0
           D=M              // D = first number
        (OUTPUT_D)
           @R2
           M=D              // M[2] = D (greatest number)
        (INFINITE_LOOP)
           @INFINITE_LOOP
           0;JMP            // infinite loop
        """
        
        let expectation = """
        0000000000000000
        1111110000010000
        0000000000000001
        1111010011010000
        0000000000001010
        1110001100000001
        0000000000000001
        1111110000010000
        0000000000001100
        1110101010000111
        0000000000000000
        1111110000010000
        0000000000000010
        1110001100001000
        0000000000001110
        1110101010000111
        """
        
        let assembler = Assembler(assembly: testAssembly)
        let assembled = assembler.assembled()
        XCTAssertEqual(assembled, expectation)
    }
    
    func testRect() {
        let testAssembly = """
        // This file is part of www.nand2tetris.org
        // and the book "The Elements of Computing Systems"
        // by Nisan and Schocken, MIT Press.
        // File name: projects/06/rect/Rect.asm

        // Draws a rectangle at the top-left corner of the screen.
        // The rectangle is 16 pixels wide and R0 pixels high.

           @0
           D=M
           @INFINITE_LOOP
           D;JLE
           @counter
           M=D
           @SCREEN
           D=A
           @address
           M=D
        (LOOP)
           @address
           A=M
           M=-1
           @address
           D=M
           @32
           D=D+A
           @address
           M=D
           @counter
           MD=M-1
           @LOOP
           D;JGT
        (INFINITE_LOOP)
           @INFINITE_LOOP
           0;JMP
        """
        
        let expectation = """
        0000000000000000
        1111110000010000
        0000000000010111
        1110001100000110
        0000000000010000
        1110001100001000
        0100000000000000
        1110110000010000
        0000000000010001
        1110001100001000
        0000000000010001
        1111110000100000
        1110111010001000
        0000000000010001
        1111110000010000
        0000000000100000
        1110000010010000
        0000000000010001
        1110001100001000
        0000000000010000
        1111110010011000
        0000000000001010
        1110001100000001
        0000000000010111
        1110101010000111
        """
        
        let assembler = Assembler(assembly: testAssembly)
        let assembled = assembler.assembled()
        XCTAssertEqual(assembled, expectation)
    }

    func testPong() {
        let testBundle = Bundle(for: type(of: self))
        let asmPath = testBundle.path(forResource: "PongAsm", ofType: "txt")!
        let testAssembly = try! String(contentsOfFile: asmPath, encoding: .utf8)
        
        let hackPath = testBundle.path(forResource: "PongHack", ofType: "txt")!
        let hack = try! String(contentsOfFile: hackPath, encoding: .utf8)
        let hackCommnads = hack.components(separatedBy: .newlines)
        
        let assembler = Assembler(assembly: testAssembly)
        let binaryText = assembler.assembled()
        let binaryCommands = binaryText.components(separatedBy: .newlines)
        
        for (index, binaryCommand) in binaryCommands.enumerated() {
            // It is too hard to debug, if I use String or [String] for assert. 
            XCTAssertEqual(binaryCommand, hackCommnads[index], "Problem is occured at \(index)")
        }
    }
    
}
