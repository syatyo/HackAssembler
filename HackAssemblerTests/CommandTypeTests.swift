//
//  CommandTypeTests.swift
//  HackAssemblerTests
//
//  Created by 山田良治 on 2019/01/10.
//  Copyright © 2019 山田良治. All rights reserved.
//

import XCTest

class CommandTypeTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitializes() {
        let testA = "@0"
        XCTAssertEqual(CommnadType(command: testA), .a)
        
        let testC = "D;JGT"
        XCTAssertEqual(CommnadType(command: testC), .c)
        
        let testL = "(LOOP)"
        XCTAssertEqual(CommnadType(command: testL), .l)
    }
}
