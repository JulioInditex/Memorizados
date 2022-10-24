//
//  MemoryItem.swift
//  Memorizados
//
//  Created by Julio Rodríguez on 20/10/22.
//

import Foundation

struct MemoryItem: Codable {
    let title: String
    let text: String
    
    var itemSplitedBySpaces: [String] {
        self.text.split(separator: " ").map({ String($0) })
    }
    
    func textToShow(blanksRevealed: Int) -> String {
        guard blanksRevealed <= itemSplitedBySpaces.count else {
            return text
        }
        
        var words: [String] = []
        itemSplitedBySpaces.enumerated().forEach {
            if $0.offset < blanksRevealed {
                words.append($0.element)
            } else {
                words.append($0.element.map({ _ in "_" }).joined())
            }
        }
        
        return words.joined(separator: " ")
    }
}
