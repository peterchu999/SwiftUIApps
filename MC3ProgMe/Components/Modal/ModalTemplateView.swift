//
//  ModalTemplateView.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 22/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct ModalTemplateView<Content: View>:View {
    var backButtonFunc:(()->Void)? = nil
    var title:String
    let content: Content
    
    init(title:String, backButtonFunc:(()->Void)? = nil, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.backButtonFunc = backButtonFunc
        self.title = title
    }
    var body: some View{
        ZStack{
            Color.init(red: 20/255, green: 22/255, blue: 32/255)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack{
                ModalHeading(clickFunc: {
                    if let function = self.backButtonFunc {
                        function()
                    }
                }, title: "\(title)")
                ZStack(alignment: .top){
                    ModalCard()
                    self.content
                }
            }
        }
    }
}

struct ModalTemplateView_Previews: PreviewProvider {
    static var previews: some View {
        ModalTemplateView(title:"Testing"){
            Text("Testing")
        }
    }
}
