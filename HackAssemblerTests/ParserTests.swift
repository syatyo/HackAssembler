//
//  ParsetTests.swift
//  HackAssembler
//
//  Created by 山田良治 on 2019/01/09.
//  Copyright © 2019 山田良治. All rights reserved.
//

import XCTest
@testable import HackAssembler

class ParserTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInit() {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "MaxL", ofType: "txt")!
        let text = try! String(contentsOfFile: path, encoding: .utf8)
        let parser = Parser(assembly: text)
        
        XCTAssertEqual(parser.commands.first!, "") // initial command is empty.
        XCTAssertEqual(parser.commands[1], "@0")
        XCTAssertEqual(parser.commands[4], "D=D-M")
        XCTAssertEqual(parser.commands.last!, "0;JMP")
    }
    
    func testHasMoreCommands() {
        let testEmptyString = ""
        let emptyParser = Parser(assembly: testEmptyString)
        
        XCTAssertEqual(emptyParser.hasMoreCommands, false)
        
        let testString = "a"
        let parser = Parser(assembly: testString)
        
        XCTAssertEqual(parser.hasMoreCommands, true)
    }
    
    func testAdvance() {
        let testString = """
        D=D-M
        0;JMP
        """
        let parser = Parser(assembly: testString)
        
        XCTAssertEqual(parser.currentCommand, "")
        parser.advance()
        XCTAssertEqual(parser.currentCommand, "D=D-M")
        parser.advance()
        XCTAssertEqual(parser.currentCommand, "0;JMP")
        parser.advance()
        XCTAssertEqual(parser.currentCommand, "0;JMP")
    }
    
    func testCommandType() {
        let testString = """
            D=D-M
            @0

        (LOOP)
        """
        let parser = Parser(assembly: testString)
        
        parser.advance()
        XCTAssertEqual(parser.commandType, .c)
        parser.advance()
        XCTAssertEqual(parser.commandType, .a)
        parser.advance()
        XCTAssertEqual(parser.commandType, .l)
    }
    
}
