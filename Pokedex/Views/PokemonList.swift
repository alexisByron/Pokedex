//
//  PokemonList.swift
//  Pokedex
//
//  Created by Alexis Moya on 22-08-22.
//

import SwiftUI

struct PokemonList: View {
    @State var pokemonSearched:String = ""
    
    @StateObject var pokemonListObject: PokemonListModelView = PokemonListModelView()
    
    var body: some View {
        ZStack(alignment:.top){
            Color(.gray).opacity(0.7)
            
            VStack{
                Image("pokemonLogo").resizable().frame(width: 200, height: 80)
                HStack{
                    TextField("Busqueda", text: $pokemonSearched).padding().frame( height: 50).background(Color("myblue")).cornerRadius(10)
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
        }.ignoresSafeArea()
        
    }
}

struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList()
    }
}
