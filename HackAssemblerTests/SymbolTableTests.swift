//
//  SymbolTableTests.swift
//  HackAssemblerTests
//
//  Created by 山田良治 on 2019/01/13.
//  Copyright © 2019 山田良治. All rights reserved.
//

import XCTest

class SymbolTableTests: XCTestCase {
    let symbolTable = SymbolTable()
    
    override func setUp() {
        symbolTable.addEntry(symbol: "testSymbol", address: 80)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testContains() {
        XCTAssertTrue(symbolTable.contains(symbol: "testSymbol"))
    }
    
    func testGetAddress() {
        XCTAssertEqual(symbolTable.getAddress(symbol: "testSymbol"), 80)
    }
    
}
