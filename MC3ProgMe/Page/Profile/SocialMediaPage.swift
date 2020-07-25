//
//  SocialMediaPage.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 24/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct SocialMediaPage: View {
    @Binding var isActive:Bool
    @State var youtube = ""
    var body: some View {
        ModalTemplateView(title: "Social Media", backButtonFunc: {
            self.isActive.toggle()
        }){
            ScrollView(.vertical){
                VStack(alignment: .center, spacing: 0){
                    ProfileSection(paddingBottomSize: 20, paddingTopSize: 0){
                        InputSocialMedia(heading: "Youtube", input: $youtube, logoName: "youtubeLGS")
                    }.padding(.bottom,20)
                        .padding(.top,15)
                    ProfileSection(paddingBottomSize: 20, paddingTopSize: 0){
                        InputSocialMedia(heading: "Facebook", input: $youtube, logoName: "facebookLGS")
                    }.padding(.bottom,20)
                    ProfileSection(paddingBottomSize: 20, paddingTopSize: 0){
                        InputSocialMedia(heading: "Instagram", input: $youtube, logoName: "instagramLGS")
                    }.padding(.bottom,20)
                    ProfileSection(paddingBottomSize: 20,paddingTopSize: 0){
                        InputSocialMedia(heading: "Whatsapp", input: $youtube, logoName: "waLGS")
                    }.padding(.bottom,20)
                    ProfileSection(paddingBottomSize: 20, paddingTopSize: 0){
                        InputSocialMedia(heading: "Line", input: $youtube, logoName: "lineLGS")
                    }.padding(.bottom,20)
                    ProfileSection(paddingBottomSize: 20,paddingTopSize: 0){
                        InputSocialMedia(heading: "Discord", input: $youtube, logoName: "discordLGS")
                    }.padding(.bottom,20)
                    ApplicationActionButton(content: "Save",
                        paddingVertical: 0,
                        enableFunction: {return true},
                        action: {
                        // save action
                    })
                }
            }
        }
    }
}

struct InputSocialMedia: View {
    var placeholder:String = ""
    var heading:String
    @Binding var input:String
    var logoName:String
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            ContentText(content: "\(heading)", size: .big)
            HStack(alignment: .center){
                Image(logoName)
                    .resizable()
                    .frame(width: 13, height: 13)
                Underline().frame(height: 13)
                TextField("\(placeholder)", text: $input)
                    .font(.system(size: 13))
                Button(action: {
                    self.input = ""
                }){
                    Image(systemName: "xmark.circle.fill")
                    .foregroundColor(Color.gray)
                    .font(.system(size: 15))
                }
            }.padding(.vertical, 10)
            .overlay(Underline(),alignment: .bottom)
        }.padding(.horizontal, 10)
    }
}

struct SocialMediaPage_Previews: PreviewProvider {
    static var previews: some View {
        SocialMediaPage(isActive: .constant(true))
    }
}
