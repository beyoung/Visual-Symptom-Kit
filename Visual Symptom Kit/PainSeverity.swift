//
//  PainSeverity.swift
//  Visual Symptom Kit
//
//  Created by Afeez Yunus on 08/10/2024.
//

import SwiftUI
import RiveRuntime

struct PainSeverity: View {
    @State var isSelected: Bool = false
    @Binding var selectedSeverity: String
    @Binding var description: String 
    let action: () -> Void
    let severityTypes: [String] = ["Mild", "Moderate", "Severe", "Very severe"]
    @FocusState private var isInputFocused: Bool
    
    var body: some View {
        
        VStack (spacing:24){
            HStack (alignment: .bottom, spacing: 8){
                ForEach(severityTypes, id: \.self) { severityType in
                   
                    VStack {
                        Text(severityType)
                            .foregroundStyle(severityType == selectedSeverity ? Color("text.primary") :.secondary)
                            .fontWeight(severityType == selectedSeverity ? .medium : .regular)
                        
                            
                            HStack {Spacer()
                                if severityType == selectedSeverity {
                                    
                                      Image(systemName:"checkmark")
                                        .fontWeight(.medium)
                                        .foregroundStyle(.white)
                                        .transition(.move(edge: .bottom))
                                }
                                
                                Spacer()
                            }.frame(height: 46)
                            .background(Color("semantic.\(severityType)").opacity( severityType == selectedSeverity ? 1 : 0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 64))
                        
                    }
                    
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.1)){
                            selectedSeverity = severityType
                        }
                        action()
                        
                    }
                }
            }
            
            VStack {
                HStack {
                    Text("Description")
                        .fontWeight(.medium)
                        
                    Spacer()
                    Text("Optional")
                        .foregroundStyle(.secondary)
                }
                TextField("Describe in detail...", text: $description)
                    .tint(Color("text.secondary"))
                    .padding()
                    .background(Color("bg.tertiary"))
                    .clipShape(RoundedRectangle(cornerRadius: 32))
                    .focused($isInputFocused)
                    .submitLabel(.done)
                    .onSubmit {
                        isInputFocused = false
                    }
            }
        }
        .enableInjection()
    }

    #if DEBUG
    @ObserveInjection var forceRedraw
    #endif
}

#Preview {
    PainSeverity(selectedSeverity: Binding.constant("Mild"), description: Binding.constant(""), action: {
        
    })
}
