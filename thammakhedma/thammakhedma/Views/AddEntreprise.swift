//
//  AddEntreprise.swift
//  thammakhedma
//
//  Created by Jasser,monaem on 14/11/2022.
//

import SwiftUI

struct AddEntreprise: View {
    var body: some View {
        
        Home2()
            .preferredColorScheme(.dark)
    }}

struct AddEntreprise_Previews: PreviewProvider {
    static var previews: some View {
        AddEntreprise()
    }
}

struct Home2 : View {
    @State var index = 0
    @ObservedObject var viewModel = EntrepriseViewModel()
    @State var  id:String =  UserViewModel.currentUser?.id ?? ""
    @State private var shouldAnimate = false
    var body: some View{
        VStack{HStack(spacing: 15){}
            .padding()
            HStack(spacing: 20){ZStack(alignment: .bottom) {VStack{HStack{
                            Spacer(minLength: 0)
                            VStack(spacing: 10){
                                Text("Add company location")
                                    .foregroundColor(self.index == 1 ? .white : .gray)
                                    .font(.title)
                                    .fontWeight(.bold)
                                Capsule()
                                    .fill(self.index == 1 ? Color.blue : Color.clear)
                                    .frame(width: 100, height: 200)}}
                        .padding(.top, 30)// for top curve...
                        NavigationLink(destination: EntrepriseLocation().navigationBarBackButtonHidden(true)){
                            Circle()
                                .fill(Color.green)
                                .frame(width: 100, height: 100)
                                .overlay(
                                    ZStack {
                                        Circle()
                                            .stroke(Color.blue, lineWidth: 100)
                                            .scaleEffect(shouldAnimate ? 1 : 0)
                                        Circle()
                                            .stroke(Color.green, lineWidth: 100)
                                            .scaleEffect(shouldAnimate ? 1.5 : 0)
                                        Circle()
                                            .stroke(Color.yellow, lineWidth: 100)
                                            .scaleEffect(shouldAnimate ? 2 : 0)}
                                        .opacity(shouldAnimate ? 0.0 : 0.2)
                                        .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: false)))
                                .onAppear {self.shouldAnimate = true}}
                        VStack{}
                        .padding(.horizontal)
                        .padding(.top, 60)
                        VStack{}
                        .padding(.horizontal)
                        .padding(.top, 60)}
                    .padding()
                    .padding(.bottom, 65)
                    .background(Color("Color2"))
                    .clipShape(CShape2())
                    .contentShape(CShape2())
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: -5)
                    .cornerRadius(35)
                    .padding(.horizontal,20)}}
            .padding(.top,35)
            Spacer(minLength: 0)}
        .background(Color("Color").edgesIgnoringSafeArea(.all))}}
