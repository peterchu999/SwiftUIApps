//
//  EditProfilePage.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 22/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct EditProfilePage: View {
    var username:String? = nil
    @Binding var isActive:Bool
    @State var fullname:String = ""
    @State var phone:String = ""
    @State var email:String = ""
    @State var disable:Bool = true
    var body: some View {
        ModalTemplateView(title: "Edit Profile", backButtonFunc: {
            withAnimation(.easeInOut){
                self.isActive.toggle()
            }
        }){
                VStack(alignment: .center){
                    EditProfilePicture()
                    ProfileSection("Account Information",paddingBottomSize: 20){
                        HStack(alignment: .center){
                            ContentText(content: username ?? "Username", size: .big)
                            Spacer()
                        }.padding(.vertical, 10)
                        .overlay(Underline(),alignment: .bottom)
                        .padding(.horizontal, 10)
                        InputWithUnderline(placeholder: "Fullname", input: $fullname)
                    }.padding(.bottom, 10)
                    ProfileSection("Personal Information", paddingBottomSize: 20){
                        InputWithUnderline(placeholder: "Phone", input: $phone, iconName: "phone.fill")
                        InputWithUnderline(placeholder: "Email", input: $email, iconName: "envelope.fill")
                    }.padding(.bottom, 10)
                    ApplicationActionButton(content: "Save", enableFunction: fieldValidation, action: {})
                }
            }
        
    }
    func fieldValidation() -> Bool {
        return self.email.contains("@") && self.fullname.count >= 3
    } // remember to add phone regex
}


struct EditProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        EditProfilePage(isActive: .constant(true))
    }
}

struct InputWithUnderline: View {
    var placeholder:String
    @Binding var input:String
    var iconName:String? = nil
    var body: some View {
        HStack(alignment: .center){
            iconChecker()
            TextField("\(placeholder)", text: $input)
            .font(.system(size: 15))
            Button(action: {
                self.input = ""
            }){
                Image(systemName: "xmark.circle.fill")
                .foregroundColor(Color.gray)
                .font(.system(size: 20))
            }
        }.padding(.vertical, 10)
            .overlay(Underline(),alignment: .bottom)
            .padding(.horizontal, 10)
    }
    func iconChecker()->AnyView {
        if let icon = iconName {
            return AnyView(Image(systemName: "\(icon)")
                .foregroundColor(Color.gray)
                .font(.system(size: 20))
                .padding(.trailing,5)
            )
        }
        return AnyView(EmptyView())
    }
}

struct EditProfilePicture: View {
    var body: some View {
        VStack(alignment: .center){
            ProfilePicture(name: "people", purpose: .normal)
                .padding(.bottom, 5)
            Button(action: {}){
                ContentText(content: "Edit Photo", size: .normal).foregroundColor(Color.black)
            }
        }.padding(.top, 30)
            .padding(.bottom, 15)
    }
}

