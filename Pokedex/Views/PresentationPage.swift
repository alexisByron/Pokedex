//
//  PresentationPage.swift
//  Pokedex
//
//  Created by Alexis Moya on 23-08-22.
//

import SwiftUI

struct PresentationPage: View {
    @State var navigateToPokemonList:Bool = false
    
    func shareButton() {
        let activityController = UIActivityViewController(activityItems: ["https://www.linkedin.com/in/alexis-moya-yanquis-713455167/"], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
    }
    
    var body: some View {
        ZStack {
            Color("goldColor")
            VStack{
                Spacer()
                Image("pokemonLogo").resizable().frame(width: 300, height: 100)
                Image("alexisMoya").resizable().frame(width: 400, height: 400)
                
                HStack{
                    VStack{
                        Text("Alexis Moya").fontWeight(.bold).foregroundColor(Color("myblue")).frame(maxWidth: .infinity,  alignment: .leading)
                        Text("Desarrollador Ios").fontWeight(.bold).foregroundColor(Color("myblue")).frame(maxWidth: .infinity,  alignment: .leading)
                    }.padding(.leading, 30)
                        .font(.title3)
                        .frame( alignment: .leading)
                    
                    
                    VStack{
                        Image("linkedin")
                            .resizable()
                            
                            .frame(width: 50, height: 50)
                            .onTapGesture {
                                shareButton()
                            }
                    }.frame(maxWidth: .infinity,  alignment: .trailing).padding(.trailing,30)
                    
                }.frame(maxWidth: .infinity,  alignment: .leading)

                Spacer()
                
                Button(action: {
                    navigateToPokemonList.toggle()
                }, label: {
                    Text("Ingresar a Pokedex")
                        .font(.title3)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, maxHeight: 50,  alignment: .center)
                        .foregroundColor(Color("goldColor"))
                        .background(Color("myblue"))
                        .cornerRadius(10)
                }).padding(.horizontal, 50)
                
                Spacer()
            }
            
            NavigationLink(
                destination: PokemonList(),
                isActive: $navigateToPokemonList,
                label: {
                    EmptyView()
                }
            )
            
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading).ignoresSafeArea()
    }
}

struct PresentationPage_Previews: PreviewProvider {
    static var previews: some View {
        PresentationPage()
    }
}
