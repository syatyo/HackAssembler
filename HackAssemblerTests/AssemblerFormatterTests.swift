//
//  CommandFormatterTests.swift
//  HackAssemblerTests
//
//  Created by 山田良治 on 2019/01/09.
//  Copyright © 2019 山田良治. All rights reserved.
//

import XCTest

class AssemblerFormatterTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRemoveComments() {
        let testString = """
        //should be removed
        D=M// D = first number
        // should be removed
        D=D-M// D = first number - second number
        //   should be removed
        """
        let formatter = AssemblerFormatter(source: testString)
        formatter.removeComments()
        
        let expectedString = """

        D=M
        
        D=D-M

        """

        XCTAssertEqual(formatter.text, expectedString)
    }
    
    func testRemoveWhiteSpaces() {
        let testString = """
        a     aa
              bb   b
        """
        let formatter = AssemblerFormatter(source: testString)
        formatter.removeWhiteSpaces()
        
        let expectedString = """
        aaa
        bbb
        """
        
        XCTAssertEqual(formatter.text, expectedString)
    }
    
    func testRemoveEmptyLine() {
        let testString = """

        D=M
        
        D=D-M

        """
        
        let formatter = AssemblerFormatter(source: testString)
        
        let expectedString = """
        D=M
        D=D-M
        """

        formatter.removeEmptyLine()
        
        XCTAssertEqual(formatter.text, expectedString)
    }
    
    // Join test
    func testFormatAssembler() {
        let testString = """
        //should be removed
        a     aa
        // should be removed
              bb   b
        //   should be removed
        """
        
        let formatter = AssemblerFormatter(source: testString)
        formatter.removeComments()
        formatter.removeWhiteSpaces()
        formatter.removeEmptyLine()
        
        let expectedString = """
        aaa
        bbb
        """
        
        XCTAssertEqual(formatter.text, expectedString)

    }
    
}
