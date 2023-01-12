//
//  ViewModel.swift
//  ChatGPT
//
//  Created by Danny Wade on 12/01/2023.
//

import Foundation
import OpenAISwift

final class ViewModel: ObservableObject {
    init() {}
    
    private var client: OpenAISwift?
    
    func setup() {
        client = OpenAISwift(authToken: "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")
        
    }
    
    func send(text: String,
              completion: @escaping (String) -> Void) {
        client?.sendCompletion(with: text, maxTokens: 500, completionHandler: { result in
            switch result {
            case .success(let model):
                let output = model.choices.first?.text ?? ""
                completion(output)
            case .failure:
                let output = "Error, please try again!"
                break
            }
        })
        
    }
}
