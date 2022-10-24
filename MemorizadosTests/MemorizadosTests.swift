//
//  MemorizadosTests.swift
//  MemorizadosTests
//
//  Created by Julio Rodríguez on 24/10/22.
//

import XCTest

class MemorizadosTests: XCTestCase {
    func testMemoryItemModel() throws {
        let stringTest = "Un texto de prueba para probar"
        let stringResult = "__ _____ __ ______ ____ ______"
        let arrayResult = ["Un", "texto", "de", "prueba", "para", "probar"]
        let item = MemoryItem(title: "", text: stringTest)
        
        XCTAssert(item.itemSplitedBySpaces == arrayResult)
        XCTAssert(item.textToShow(blanksRevealed: 0) == stringResult)
        XCTAssert(item.textToShow(blanksRevealed: stringTest.count) == stringTest)
    }
    
    func testParse() throws {
        let memoryItemRepository: MemoryItemsRepository = ViewController()
        let items = try memoryItemRepository.getItems(from: "MemoryItems")
        XCTAssert(!items.isEmpty)
    }
}
