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

        XCTAssertEqual(parser.commands.first!, "@0")
    }
    
//    func testHasMoreCommands() {
//        let parser = Parser()
//        
//        XCTAssertEqual(parser.hasMoreCommands, false)
//    }
    
    
}
