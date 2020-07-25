//
//  ProfilePage.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 20/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct ProfilePage: View {
    @State var isEditing:Bool = false
    @State var isChangePassword:Bool = false
    @State var isSocialMedia:Bool = false
    @State var isFeedback:Bool = false
    var body: some View {
    ZStack{
        ModalTemplateView(title: "Profile"){
            VStack(alignment: .center){
                ProfileIdentitySection()
                ProfileSection("Account"){
                    ProfileRow(action:
                        {
                            self.isEditing.toggle()
                        },
                       content: "Edit Profile",
                       iconName: "pencil")
                    ProfileRow(
                        action: {
                            self.isChangePassword = true
                        },
                        content: "Change Password",
                        iconName: "lock.fill");
                    ProfileRow(action: {
                            self.isSocialMedia = true
                        },
                        content: "Social Media", iconName: "message.circle")
                }.padding(.bottom, 10)
                ProfileSection("Help"){
                    ProfileRow(
                        action: {self.isFeedback = true},
                        content: "Give Feedback",
                        iconName: "envelope.open")
                }.padding(.bottom, 20)
                ProfileRow(content: "Sign Out", iconName: "power",underline: false, chevron: false)
                    .padding(.horizontal,30)
                    .background(Color.white)
                    .frame(height:50)
                    .foregroundColor(Color.red)
                }
        }.zIndex(1)
            if isEditing {
                EditProfilePage(isActive: $isEditing)
                    .modifier(PageTransition())
            } else if isChangePassword {
                ChangePasswordPage(isActive: $isChangePassword)
                .modifier(PageTransition())
            } else if isSocialMedia {
                SocialMediaPage(isActive: $isSocialMedia)
                   .modifier(PageTransition())
            } else if isFeedback {
                FeedBackPage(isActive: $isFeedback)
                    .modifier(PageTransition())
            }
        }
    }
}

struct PageTransition: ViewModifier {
    var index:Double = 2
    func body(content: Content) -> some View {
        return content
            .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .slide))
            .animation(.easeInOut)
            .zIndex(index)
    }
}



struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}

struct ProfileIdentitySection: View {
    var body: some View {
        HStack(alignment: .center){
            ProfilePicture(name: "people", purpose: .normal)
                .padding(.trailing,20)
            VStack(alignment: .leading){
                TitleText(content: "Real Brad", type: .h1)
                Text("Dungeon Master")
                    .font(.system(size: 19, weight: .regular, design: .rounded))
            }
            Spacer()
        }.padding(.bottom, 15)
        .padding(.horizontal,30)
        .padding(.top,40)
    }
}

struct ProfileRow: View {
    var action:(()->Void)? = nil
    var content:String
    var iconName:String
    var underline:Bool = true
    var chevron:Bool = true

    var body: some View {
        Button(action: {
            if let functional = self.action {
                functional()
            }
        }){
            HStack(alignment: .center){
                Image(systemName: iconName)
                    .font(.system(size: 15, weight: .semibold))
                    .padding(.trailing,13)
                    .multilineTextAlignment(.center)
                ContentText(content: "\(content)",size: .big)
                Spacer()
                chevronChecker()
            }.padding(.bottom, underline ? 15 : 0)
            .padding(.top, underline ? 15 : 0)
            .overlay(dividerChecker(),alignment: .bottom)
                .background(Color.white)
        }.buttonStyle(PlainButtonStyle())
    }
    func dividerChecker()->AnyView{
        return underline ? AnyView(Underline()) : AnyView(Color.clear)
    }
    func chevronChecker()->AnyView{
        return chevron ?
        AnyView(Image(systemName: "chevron.right")
        .font(.system(size: 15, weight: .semibold))
            .multilineTextAlignment(.center)) : AnyView(Color.clear)
    }
}
