//
//  SyntaxFileMappingEditView.swift
//
//  CotEditor
//  https://coteditor.com
//
//  Created by 1024jp on 2023-01-18.
//
//  ---------------------------------------------------------------------------
//
//  © 2023-2024 1024jp
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  https://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import SwiftUI

struct SyntaxFileMappingEditView: View {
    
    @Binding var extensions: [SyntaxDefinition.IdentifiedString]
    @Binding var filenames: [SyntaxDefinition.IdentifiedString]
    @Binding var interpreters: [SyntaxDefinition.IdentifiedString]
    
    
    // MARK: View
    
    var body: some View {
        
        Grid(alignment: .leading, horizontalSpacing: 20, verticalSpacing: 20) {
            GridRow {
                EditTable($extensions) {
                    HStack {
                        Text("Extensions:", tableName: "SyntaxEdit", comment: "label for file extensions")
                        Text("(without dot)", tableName: "SyntaxEdit", comment: "additional label to “Extensions:”")
                            .fontWeight(.regular)
                            .foregroundStyle(.secondary)
                    }
                }
                
                EditTable($filenames) {
                    Text("Filenames:", tableName: "SyntaxEdit", comment: "label")
                }
            }
            
            GridRow {
                EditTable($interpreters) {
                    Text("Interpreters:", tableName: "SyntaxEdit", comment: "label")
                }
                
                VStack {
                    Text("The interpreters are used to determine the syntax from the shebang in the document.", tableName: "SyntaxEdit", comment: "description")
                        .controlSize(.small)
                        .padding(.top, 18)
                    Spacer()
                    HStack {
                        Spacer()
                        HelpButton(anchor: "syntax_file_mapping")
                    }
                }
            }
        }
    }
    
    
    struct EditTable<Label: View>: View {
        
        typealias Item = SyntaxDefinition.IdentifiedString
        
        
        @Binding var items: [Item]
        let label: () -> (Label)
        
        @State private var selection: Set<Item.ID> = []
        @FocusState private var focusedField: Item.ID?
        
        
        init(_ items: Binding<[Item]>, @ViewBuilder label: @escaping () -> Label) {
            
            self._items = items
            self.label = label
        }
        
        
        var body: some View {
            
            VStack(alignment: .leading) {
                self.label()
                
                List(selection: $selection) {
                    ForEach($items) {
                        TextField(text: $0.value, label: EmptyView.init)
                            .focused($focusedField, equals: $0.id)
                    }
                    .onMove { (indexes, index) in
                        withAnimation {
                            self.items.move(fromOffsets: indexes, toOffset: index)
                        }
                    }
                }
                .listStyle(.bordered)
                .border(Color(nsColor: .gridColor))
                
                AddRemoveButton($items, selection: $selection, focus: $focusedField)
            }
        }
    }
}



// MARK: - Preview

#Preview {
    @State var extensions: [SyntaxDefinition.IdentifiedString] = [.init(value: "abc")]
    @State var filenames: [SyntaxDefinition.IdentifiedString] = []
    @State var interpreters: [SyntaxDefinition.IdentifiedString] = []
    
    return SyntaxFileMappingEditView(extensions: $extensions,
                                     filenames: $filenames,
                                     interpreters: $interpreters)
    .padding()
}