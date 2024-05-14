//
//  LoginView.swift
//  NewAPL
//
//  Created by Andre Firmo on 3/11/24.
//

import SwiftUI

struct LoginView: View {
    @State var isPresented = false
    var body: some View {
        
        NavigationView {
            GeometryReader {size in
                ZStack {
                    Image(.casal)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                        .frame(width: size.size.width, height: size.size.height)
                    
                    VStack {
                        Text("Um Banco de vantagens, \nmais simples e seguro\n pra ti")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.white)
                            .lineLimit(3)
                            .frame(width: size.size.width * 0.90, height: 200, alignment: .leading)
                        NavigationLink(destination: APLView(), label: {
                            Text("acessar")
                                .background {
                                    Rectangle()
                                        .fill(Color.orange)
                                        .frame(width: size.size.width * 0.90, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .clipShape(.capsule)
                                }
                                .padding(.bottom, 20)
                        })
                        
                        Button(action: {
                            isPresented.toggle()
                        }, label: {
                            Text("não sou cliente")
                                .font(.headline)
                                .frame(width: size.size.width * 0.90, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(.white)
                                
                            
                        })
                        HStack {
                            HStack(spacing: -10){
                             Image(systemName: "person")
                                    .frame(width: 50, height: 50, alignment: .center)
                                    .foregroundStyle(.white)
                                Text("Pix")
                                    .bold()
                                    .foregroundStyle(.white)
                            }
                            HStack{
                                Image(systemName: "car")
                                    .frame(width: 50, height: 50, alignment: .center)
                                    .foregroundStyle(.white)
                                Text("pix token")
                                    .bold()
                                    .foregroundStyle(.white)
                            }
                            HStack{
                                Image(systemName: "questionmark.square.dashed")
                                    .frame(width: 50, height: 50, alignment: .center)
                                    .foregroundStyle(.white)
                                Text("Ajuda")
                                    .bold()
                                    .foregroundStyle(.white)
                            }
                        }
                        
                    }.frame(width: size.size.width, height: size.size.height, alignment: .bottom)
                }
                
            }
        }
        
    }
}

#Preview {
    LoginView()
}
