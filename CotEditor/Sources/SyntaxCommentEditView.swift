//
//  SyntaxCommentEditView.swift
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

struct SyntaxCommentEditView: View {
    
    @Binding var comment: SyntaxDefinition.Comment
    @Binding var highlights: [SyntaxDefinition.Highlight]
    
    
    // MARK: View
    
    var body: some View {
        
        VStack(spacing: 20) {
            CommentDelimitersEditView(comment: $comment)
            SyntaxHighlightEditView(items: $highlights, helpAnchor: "syntax_comment_settings")
        }
    }
}


private struct CommentDelimitersEditView: View {
    
    @Binding var comment: SyntaxDefinition.Comment
    
    
    var body: some View {
        
        HStack(alignment: .firstTextBaseline, spacing: 32) {
            VStack(alignment: .leading) {
                Text("Inline comment:", tableName: "SyntaxEdit", comment: "label")
                Form {
                    TextField(String(localized: "Begin with:", table: "SyntaxEdit", comment: "label"),
                              text: $comment.inline ?? "", prompt: Self.placeholder)
                }
            }
            
            VStack(alignment: .leading) {
                Text("Block comment:", tableName: "SyntaxEdit", comment: "label")
                Form {
                    TextField(String(localized: "Begin with:", table: "SyntaxEdit", comment: "label"),
                              text: $comment.blockBegin ?? "", prompt: Self.placeholder)
                    TextField(String(localized: "End with:", table: "SyntaxEdit", comment: "label"),
                              text: $comment.blockEnd ?? "", prompt: Self.placeholder)
                }
            }
        }
    }
    
    
    private static var placeholder: Text {
        
        Text("Not defined", tableName: "SyntaxEdit", comment: "placeholder")
    }
}



// MARK: - Preview

#Preview {
    @State var comment = SyntaxDefinition.Comment()
    @State var highlights: [SyntaxDefinition.Highlight] = []
    
    return SyntaxCommentEditView(comment: $comment, highlights: $highlights)
        .padding()
}