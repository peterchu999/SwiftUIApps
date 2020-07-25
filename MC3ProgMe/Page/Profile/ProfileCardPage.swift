//
//  ProfileCardPage.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 24/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct Module:Identifiable{
    let id = UUID.init()
    var name:String
    var coverImageName:String
    var addDate:Date
    var difficulty:Difficulty
    
    enum Difficulty {
        case hard
        case normal
        case easy
    }
}

struct ProfileCardPage: View {
    @State var dmName:String = "Example Name"
    @State var secondModalPosition:CGFloat = 460
    @State var modalLastPosition:CGFloat = 30
    @State var modules:[Module] = [
        Module(name: "Dummy", coverImageName: "moduleCover", addDate: Date.init(), difficulty: .hard),
        Module(name: "Extra", coverImageName: "people", addDate: Date.init(timeIntervalSinceNow: 200), difficulty: .normal),
        Module(name: "Dummy", coverImageName: "moduleCover", addDate: Date.init(), difficulty: .hard),
        Module(name: "Extra", coverImageName: "people", addDate: Date.init(timeIntervalSinceNow: 200), difficulty: .normal),
        Module(name: "Dummy", coverImageName: "moduleCover", addDate: Date.init(), difficulty: .hard)
    ]
    var body: some View {
        ZStack{
            Color.init(red: 20/255, green: 22/255, blue: 32/255)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack(alignment: .center, spacing: 0){
                ModalHeading(clickFunc: {
                    
                }, title: "")
                VStack(alignment: .center, spacing: 0){
                    ProfilePicture(name: "people", purpose: .normal).padding(.bottom,25)
                    Text(dmName)
                        .font(.system(size: 29, weight: .bold, design: .rounded))
                        .foregroundColor(Color.white)
                                       
                }.padding(.top,40)
                .padding(.bottom,25)
                ZStack(alignment: .top){
                    ProfileCardModal(bgColor: Color.init(red: 197/255, green: 211/255, blue: 220/255)){
                        TitleText(content: "Social Media", type: .h1).padding(30)
                        Underline()
                        HStack(alignment: .center, spacing: 50){
                            ProfileSocialMediaDisplay(socialMedia: .youtube, username: "brandy")
                            ProfileSocialMediaDisplay(socialMedia: .line, username: "realbrad")
                        }.padding(.leading,35)
                        .padding(.bottom,40)
                            .padding(.top,25)
                        HStack(alignment: .center, spacing: 50){
                            ProfileSocialMediaDisplay(socialMedia: .facebook, username: "urkyStar")
                            ProfileSocialMediaDisplay(socialMedia: .whatsapp, username: "realbrad")
                        }.padding(.leading,35)
                            .padding(.bottom,40)
                        HStack(alignment: .center, spacing: 50){
                            ProfileSocialMediaDisplay(socialMedia: .instagram, username: "brandy")
                            ProfileSocialMediaDisplay(socialMedia: .discord, username: "realbrad")
                        }.padding(.leading,35)
                        .padding(.bottom,40)
                        Spacer()
                    }
                    ProfileCardModal(bgColor: Color.init(red: 232/255, green: 239/255, blue: 248/255)){
                        TitleText(content: "Modules", type: .h1).padding(30)
                        Underline()
                        ScrollView(.vertical){
                            ForEach(modules.indices){ index in
                                moduleRow(module: self.modules[index], last: index == self.modules.count - 1)
                            }
                        }
                        Underline()
                        Spacer()
                    }.offset(x: 0, y: secondModalPosition)
                        .animation(.spring())
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                            if self.secondModalPosition + 30 >= 30 && self.secondModalPosition <= 530 {
                                self.secondModalPosition = gesture.translation.height + self.modalLastPosition
                            }
                            self.dmName = "called"
                        }
                        .onEnded{ pos in
                            if pos.translation.height >= 530/2{
                                self.secondModalPosition = 460
                            } else {
                                self.secondModalPosition = 30
                            }
                            self.modalLastPosition = self.secondModalPosition
                        }
                    )
                }
            }
        }
    }
}

struct ProfileCardPage_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCardPage()
    }
}

struct ProfileCardModal<Content: View>: View {
    var bgColor:Color
    let content: Content
    init(bgColor:Color = Color.white, @ViewBuilder content: () -> Content) {
        self.bgColor = bgColor
        self.content = content()
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            content
        }.frame(width: screen.width, alignment: .leading)
            .background(bgColor)
            .cornerRadius(20)
    }
}

struct moduleRow: View {
    var module:Module
    var last:Bool
    var body: some View {
        HStack(alignment:.center, spacing:0){
            Image(module.coverImageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .cornerRadius(10)
                .clipped()
            VStack(alignment: .leading,spacing:0){
                TitleText(content: "NameExample", type: .h2)
                ContentText(content: "Added on: \(changeDateFormat(date: module.addDate))", size: .normal)
                    .padding(.top,5)
                    .padding(.bottom, 10)
                ContentText(content: "Difficulty: \(module.difficulty == .hard ? "Hard" : module.difficulty == .normal ? "Normal" : "Easy")", size: .big)
            }.padding(.leading,15)
            Spacer()
            Image(systemName: "chevron.right").font(.system(size: 17))
        }.padding(.vertical,15)
        .padding(.trailing,30)
            .overlay(!self.last ? AnyView(Underline()) : AnyView(Text("")),alignment: .bottomTrailing)
            .padding(.leading,30)
    }
    func changeDateFormat(date:Date)->String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/mm/yy"
        let res = dateFormatter.string(from: date)
        return "\(String(describing: res))"
    }
}

enum SocialMediaType{
    case youtube
    case facebook
    case line
    case whatsapp
    case discord
    case instagram
}

struct ProfileSocialMediaDisplay: View {
    var socialMedia: SocialMediaType
    var username:String
    var body: some View {
        HStack(alignment: .center, spacing: 0){
            Image(getSocialMediaLogo(socialMedia))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .padding(.trailing,10)
            ContentText(content: "\(username)", size: .big)
        }
    }
    func getSocialMediaLogo(_ sosmed:SocialMediaType)->String{
        switch sosmed {
        case .discord:
            return "discordLGS"
        case .facebook:
            return "facebookLGS"
        case .line:
            return "lineLGS"
        case .whatsapp:
            return "waLGS"
        case .youtube:
            return "youtubeLGS"
        case .instagram:
            return "instagramLGS"
        }
    }
}
