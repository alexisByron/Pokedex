//
//  PokemonList.swift
//  Pokedex
//
//  Created by Alexis Moya on 22-08-22.
//

import SwiftUI

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}

struct PokemonList: View {
    @State var pokemonSearched:String = ""
    
    @StateObject var pokemonListObject: PokemonListModelView = PokemonListModelView()
    @State var navigateToPokemonView:Bool = false
    @State var url: String = ""
    
    var body: some View {
        ZStack(alignment:.top){
            Color(.gray).opacity(0.7)
            
            VStack{
                Image("pokemonLogo").resizable().frame(width: 200, height: 80)
                HStack{
                    TextField("", text: $pokemonSearched)
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .padding()
                        .frame( height: 50)
                        .placeholder(when: pokemonSearched.isEmpty) {
                            Text("Busca a tu Pokemon").foregroundColor(Color("goldColor")).fontWeight(.bold).font(.body).padding(.horizontal)
                        }
                        .background(Color("myblue")).cornerRadius(10)
                    Button(action: {
                        print("buscando... \(pokemonSearched)")
                    }, label: {
                        Image(systemName: "magnifyingglass").resizable().frame(width: 20, height: 20)
                    })
                }
                
                Text("Pokedex")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if(pokemonListObject.pokemonList != nil){
                    ScrollView(.vertical){
                        ForEach(pokemonListObject.pokemonList!.results, id:\.self){pokemonResult in
                            Button(action: {
                                print(pokemonResult)
                                self.url = pokemonResult.url
                                self.navigateToPokemonView=true
                            }, label: {
                                VStack {
                                    Text(pokemonResult.name)
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .padding()
                                }.frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: 40.0)
                                .background(Color("myblue")).cornerRadius(10)
                            })
                        }
                        
                        HStack{
                            if(pokemonListObject.pokemonList?.previous != nil){
                                Button(action: {
                                    print("previous")
                                    pokemonListObject.getPokemonListFromApi(url: pokemonListObject.pokemonList?.previous ?? "")
                                }, label: {
                                    Image(systemName: "arrow.left").resizable().frame(width: 20, height: 20)
                                })
                            }
                            
                            Spacer()
                            
                            if(pokemonListObject.pokemonList?.next != nil){
                                Button(action: {
                                    print("next")
                                    pokemonListObject.getPokemonListFromApi(url: pokemonListObject.pokemonList?.next ?? "")
                                }, label: {
                                    Image(systemName: "arrow.right").resizable().frame(width: 20, height: 20)
                                })
                            }
                        }.padding([.top, .horizontal], 20)
                    }.frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 20)
                }
            }.foregroundColor(Color("goldColor"))
                .padding(.top, 60)
                .padding(.horizontal, 20)
            
            NavigationLink(
                destination: PokemonView(url: self.url),
                isActive: $navigateToPokemonView,
                label: {
                    EmptyView()
                }
            )
            
        }.ignoresSafeArea()
        
    }
}

struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList()
    }
}
