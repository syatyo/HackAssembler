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
    
    func testGetDefinedSymbolAddress() {
        let sp = symbolTable.getAddress(symbol: "SP")
        XCTAssertEqual(sp, 0)
        
        let lcl = symbolTable.getAddress(symbol: "LCL")
        XCTAssertEqual(lcl, 1)
        
        let arg = symbolTable.getAddress(symbol: "ARG")
        XCTAssertEqual(arg, 2)
        
        let this = symbolTable.getAddress(symbol: "THIS")
        XCTAssertEqual(this, 3)
        
        let that = symbolTable.getAddress(symbol: "THAT")
        XCTAssertEqual(that, 4)
        
        for i in 0...15 {
            let registerName = "R\(i)"
            let address = symbolTable.getAddress(symbol: registerName)
            XCTAssertEqual(address, i)
        }
        
        let screen = symbolTable.getAddress(symbol: "SCREEN")
        XCTAssertEqual(screen, 16384)
        
        let kbd = symbolTable.getAddress(symbol: "KBD")
        XCTAssertEqual(kbd, 24576)
    }
    
}
