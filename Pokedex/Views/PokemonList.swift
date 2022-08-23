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
    @StateObject var pokemonListObject: PokemonListModelView = PokemonListModelView()
    
    //este podria instanciarlo en pokemon list pero para tener el valor de los pokemones buscados lo instancio aqui
    @StateObject var pokemonModel: PokemonModel = PokemonModel()
    
    @FocusState private var isFocused: Bool
    @State var pokemonSearched:String = ""
    @State var navigateToPokemonView:Bool = false
    @State var url: String = ""
    @State var showFavorites: Bool = false
    
    var layout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
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
                        .focused($isFocused)
                        .animation(.linear(duration: 0.2))
                    
                    Button(action: {
                        if (!pokemonSearched.isEmpty){
                            let urlAux = "https://pokeapi.co/api/v2/pokemon/\(pokemonSearched.lowercased())"
                            self.url = urlAux
                            self.navigateToPokemonView.toggle()
                            self.pokemonSearched = ""
                        }
                    }, label: {
                        Image(systemName: "magnifyingglass").resizable().frame(width: 20, height: 20)
                    })
                }
                
                HStack{
                    VStack(spacing:20){
                        Text(pokemonModel.pokemonsSearched.count > 0 ? "Busquedas Recientes" : "Cuando Realizes una busqueda o selecciones un pokemon lo veras reflejado aqui").font(.title3).fontWeight(.bold).multilineTextAlignment(.center)
                        
                        ScrollView(.vertical){
                            ForEach(pokemonModel.pokemonsSearched.reversed(), id:\.self){ searched in
                                HStack{
                                    Text("\(searched.name)")
                                    Spacer()
                                    AsyncImage(url: URL(string: searched.imageUrl)) { image in
                                        image.resizable().frame(width:50,height: 50)
                                    } placeholder: {
                                        Loader().frame(width:30,height: 30)
                                    }.frame(width:50,height: 50)
                                }.padding(.horizontal,5)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color("myblue"))
                                    .shadow(color: .gray, radius: 8, x: 0, y: 0)
                                    .padding(.vertical,10)
                                    .padding(.horizontal,5)
                                    .onTapGesture(perform: {
                                        let urlAux = "https://pokeapi.co/api/v2/pokemon/\(searched.name)"
                                        self.url = urlAux
                                        self.navigateToPokemonView.toggle()
                                        self.pokemonSearched = ""
                                    })
                            }
                        }.animation(.linear(duration: 0.7))
                        
                    }.padding()
                        .frame(maxWidth: .infinity, maxHeight: isFocused ? .infinity : 0 , alignment: .top)
                        .background(Color("myblue")).cornerRadius(20).animation(.linear(duration: 0.7))
                    
                    //Image(systemName: "magnifyingglass").resizable().frame(width: 20, height: 20).foregroundColor(.clear)
                }.padding(.trailing,30)
                
                
                HStack{
                    Text("Pokedex")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(isFocused ? .clear : Color("goldColor"))
                    
                    VStack{
                        Image(systemName: showFavorites ? "star.fill" : "star")
                        Text("Favoritos")
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundColor(isFocused ? .clear : Color("goldColor"))
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .onTapGesture(perform: {
                        showFavorites.toggle()
                    }).foregroundColor(isFocused ? .clear : Color("goldColor"))
                }.animation(.linear(duration: 0.7))
                
                Spacer()
                
                if(pokemonListObject.pokemonList != nil){
                    ScrollView(.vertical){
                        ScrollViewReader { value in
                            ForEach( Array(pokemonListObject.pokemonList!.results.enumerated()), id:\.offset){ index, pokemonResult in
                                Button(action: {
                                    self.url = pokemonResult.url
                                    self.navigateToPokemonView.toggle()
                                }, label: {
                                    VStack {
                                        Text(pokemonResult.name)
                                            .font(.title3)
                                            .fontWeight(.bold)
                                            .padding()
                                    }.frame(maxWidth: .infinity, alignment: .leading)
                                        .frame(height: 40.0)
                                        .background(Color("myblue")).cornerRadius(10)
                                }).id(index)
                            }
                            
                            HStack{
                                if(pokemonListObject.pokemonList?.previous != nil){
                                    Button(action: {
                                        value.scrollTo(0)
                                        pokemonListObject.getPokemonListFromApi(url: pokemonListObject.pokemonList?.previous ?? "")
                                    }, label: {
                                        HStack{
                                            Image(systemName: "arrow.left").resizable().frame(width: 20, height: 20)
                                            Text("Previo").fontWeight(.bold).font(.title3)
                                        }
                                    })
                                }
                                
                                Spacer()
                                
                                if(pokemonListObject.pokemonList?.next != nil){
                                    Button(action: {
                                        value.scrollTo(0)
                                        pokemonListObject.getPokemonListFromApi(url: pokemonListObject.pokemonList?.next ?? "")
                                    }, label: {
                                        HStack{
                                            Text("Siguente").fontWeight(.bold).font(.title3)
                                            Image(systemName: "arrow.right").resizable().frame(width: 20, height: 20)
                                        }
                                    })
                                }
                            }.padding([.top, .horizontal,.bottom], 20)
                        }
                        
                    }
                    .frame(maxWidth: .infinity,  maxHeight: !showFavorites && !isFocused ? .infinity : 0 ,alignment: .leading)
                    .offset(y: isFocused ? 50 : 0)
                    .animation(.linear(duration: 0.7))
                }
                
                VStack{
                    Text(pokemonListObject.favoritePokemons.count > 0 ? "Tus pokemons favoritos" : "Cuando agregues pokemones favoritos podras consultarlos aqui").font(.title3).fontWeight(.bold).multilineTextAlignment(.center).padding(.top)
                    LazyVGrid(columns: layout) {
                        ForEach(pokemonListObject.favoritePokemons, id:\.self) { favoritePokemon in
                            VStack{
                                AsyncImage(url: URL(string: favoritePokemon.sprites.front_default ?? favoritePokemon.sprites.front_female ?? "")) { image in
                                    image.resizable().frame(width:50,height: 50)
                                } placeholder: {
                                    Loader().frame(width:30,height: 30)
                                }.frame(width:50,height: 50)
                                
                                Text("\(favoritePokemon.name)").font(.caption)
                            }.padding(.horizontal,20)
                                .frame( maxHeight: 90)
                                .background(Color("myblue"))
                                .shadow(color: .gray, radius: 8, x: 0, y: 0)
                                .onTapGesture(perform: {
                                    let urlAux = "https://pokeapi.co/api/v2/pokemon/\(favoritePokemon.name)"
                                    self.url = urlAux
                                    self.navigateToPokemonView.toggle()
                                    self.showFavorites.toggle()
                                })
                        }.padding(.top)
                    }.padding(.horizontal)
                }.frame(maxWidth: .infinity,  maxHeight: showFavorites && !isFocused ? .infinity : 0 ,alignment: .top)
                    .background(Color("myblue"))
                    .cornerRadius(20)
                    .animation(.linear(duration: 0.7))
                
                
            }.foregroundColor(Color("goldColor"))
                .padding(.top, 60)
                .padding(.horizontal, 20)
            
            NavigationLink(
                destination: PokemonView(pokemonModel: self.pokemonModel, pokemonListObject: self.pokemonListObject, url: self.url),
                isActive: $navigateToPokemonView,
                label: {
                    EmptyView()
                }
            )
            
        }.ignoresSafeArea().onTapGesture {
            self.isFocused = false
        }
        
    }
}

struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList()
    }
}
