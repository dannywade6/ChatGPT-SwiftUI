//
//  ContentView.swift
//  ChatGPT
//
//  Created by Danny Wade on 12/01/2023.
//

import SwiftUI
import OpenAISwift

struct ContentView: View {
    
    @ObservedObject var viewModel = ViewModel()
    @State var text = ""
    @State var models = [String]()
    
    var body: some View {
        
        NavigationView {
            ZStack {
                
                Color.gray.opacity(0.3).ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    ScrollView {
                        VStack(alignment: .leading) {
                            ForEach(models, id: \.self) { string in
                                Text(string)
                            }
                        }
                    }
                    .padding()
                    
                    Spacer()
                    
                    Divider()
                    
                    
                    HStack {
                        TextField("Type here...", text: $text)
                            .font(.title3)
                        Button {
                            send()
                        } label: {
                            HStack {
                                Text("Send")
                                Image(systemName: "paperplane.circle.fill")
                            }
                            .font(.title3)
                            .foregroundColor(.green)
                        }
                    }
                    .onAppear {
                        viewModel.setup()
                    }
                    .padding()
                    
                }
            }
            .navigationTitle("ChatGPT")

        }
        
    }
    
    func send() {
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        models.append("Me:\n\(text) \n")
        viewModel.send(text: text) { response in
            DispatchQueue.main.async {
                self.models.append("ChatGPT: " + response + "\n")
                self.text = ""
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
