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
    
    func testComp() {
        let testMnemonics: [(String, String)] = [("0",   "0101010"),
                                                 ("1",   "0111111"),
                                                 ("-1",  "0111010"),
                                                 ("D",   "0001100"),
                                                 ("A",   "0110000"),
                                                 ("!D",  "0001101"),
                                                 ("!A",  "0110001"),
                                                 ("-D",  "0001111"),
                                                 ("-A",  "0110011"),
                                                 ("D+1", "0011111"),
                                                 ("A+1", "0110111"),
                                                 ("D-1", "0001110"),
                                                 ("A-1", "0110010"),
                                                 ("D+A", "0000010"),
                                                 ("D-A", "0010011"),
                                                 ("A-D", "0000111"),
                                                 ("D&A", "0000000"),
                                                 ("D|A", "0010101"),
                                                 ("M",   "1110000"),
                                                 ("!M",  "1110001"),
                                                 ("-M",  "1110011"),
                                                 ("M+1", "1110111"),
                                                 ("M-1", "1110010"),
                                                 ("D+M", "1000010"),
                                                 ("D-M", "1010011"),
                                                 ("M-D", "1000111"),
                                                 ("D&M", "1000000"),
                                                 ("D|M", "1010101")]
        
        for (index, result) in testMnemonics.enumerated() {
            let binary = Code.comp(from: result.0)
            XCTAssertEqual(binary, result.1, "index is \(index)")
        }
    }
    
}
