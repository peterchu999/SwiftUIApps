//
//  TitleText.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 22/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

enum TitleType {
    case h1
    case h2
    case h3
}

struct TitleText: View {
    var content:String
    var type:TitleType = .h2
    var body: some View {
        Text("\(self.content)")
            .font(.system(size: type == TitleType.h1 ? 27 :  type == TitleType.h2 ? 21 : 17, weight: .bold, design: .rounded))
    }
}

struct TitleText_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            TitleText(content: "Example Have Size of 27", type: .h1)
            TitleText(content: "Example Have Size of 22", type: .h2)
            TitleText(content: "Example Have Size of 17", type: .h3)
        }
    }
}
