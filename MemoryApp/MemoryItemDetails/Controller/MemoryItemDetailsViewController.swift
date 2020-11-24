//
//  MemoryItemDetailsViewController.swift
//  MemoryApp
//
//  Created by Nikolas Aggelidis on 23/11/20.
//  Copyright © 2020 NAPPS. All rights reserved.
//

import UIKit

class MemoryItemDetailsViewController: UIViewController {
    @IBOutlet weak var memoryItemDetailsTextView: UITextView!
    
    var memoryItem: MemoryItem!
    var blankCounter = 0
    let visibleTextAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "Georgia", size: 28)!, .foregroundColor: UIColor.black]
    let invisibleTextAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "Georgia", size: 28)!, .foregroundColor: UIColor.clear, .strikethroughStyle: 1, .strikethroughColor: UIColor.black]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assert(memoryItem != nil, "You must provide a memory item before trying to show this ViewController.")
        showText()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(wordsTapped))
        memoryItemDetailsTextView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func showText() {
        let words = memoryItem.text.components(separatedBy: " ")
        let output = NSMutableAttributedString()
        let space = NSAttributedString(string: " ", attributes: visibleTextAttributes)
        
        for (index, word) in words.enumerated() {
            if index < blankCounter {
                let attributedWord = NSAttributedString(string: word, attributes: visibleTextAttributes)
                output.append(attributedWord)
            } else {
                var strippedWord = word
                var punctuation: String?
                
                if ".,".contains(word.last!) {
                    punctuation = String(strippedWord.removeLast())
                }
                
                let attributedWord = NSAttributedString(string: strippedWord, attributes: invisibleTextAttributes)
                output.append(attributedWord)
                
                if let symbol = punctuation {
                    let attributedPunctuation = NSAttributedString(string: symbol, attributes: visibleTextAttributes)
                    output.append(attributedPunctuation)
                }
            }
            
            output.append(space)
        }
        
        memoryItemDetailsTextView.attributedText = output
    }
    
    @objc private func wordsTapped() {
        blankCounter += 1
        showText()
    }
}
