//
//  CodeTests.swift
//  HackAssemblerTests
//
//  Created by 山田良治 on 2019/01/10.
//  Copyright © 2019 山田良治. All rights reserved.
//

import XCTest

class CodeTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDest() {
        let testMnemonics = ["null", "M", "D", "MD", "A", "AM", "AD", "AMD"]
        let expectations = ["000", "001", "010", "011", "100", "101", "110", "111"]
        
        for (index, testMnemonic) in testMnemonics.enumerated() {
            let binary = Code.dest(from: testMnemonic)
            XCTAssertEqual(binary, expectations[index])
        }
    }
}
