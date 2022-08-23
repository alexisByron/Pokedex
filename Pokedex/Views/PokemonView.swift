//
//  PokemonView.swift
//  Pokedex
//
//  Created by Alexis Moya on 22-08-22.
//

import SwiftUI

enum StepOfView:String{
    case abilities
    case stats
    case moves
    case info
}

struct PokemonView: View {
    @StateObject var pokemonModel: PokemonModel
    var pokemonListObject: PokemonListModelView
    
    @State var stepToShow:StepOfView = StepOfView.info
    var url: String
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var isFavorite:Bool = false
    let showAlert: Bool = false
    
    func isPokemonFavorite()->Bool{
        let arrayAux = pokemonListObject.favoritePokemons.filter{ $0.id == pokemonModel.pokemon?.id}
        return arrayAux.count > 0
    }
    
    func shareButton() {
        let activityController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
    }
    
    var body: some View {
        ZStack(alignment: .top){
            Color("myblue")
            
            HStack{
                Image("pokeball").resizable().frame(width: 250, height: 250).rotationEffect(.degrees(30))
            }.frame(maxWidth: .infinity, alignment: .trailing).offset(x: 30)
            
                .navigationBarHidden(true)
            
            VStack{
                HStack{
                    Text(pokemonModel.pokemon?.name ?? "").font(.title).fontWeight(.bold)
                    Spacer()
                    Text("#\(String(pokemonModel.pokemon?.order ?? 0))").font(.title).fontWeight(.bold)
                }.padding(.horizontal).foregroundColor(Color("goldColor"))
                
                //force reload view
                Text("\(String(isFavorite))").foregroundColor(.clear)
                
                //Details
                VStack{
                    HStack(spacing:10){
                        Spacer()
                        Text("Info")
                            .fontWeight(stepToShow == StepOfView.info ? .bold : .light)
                            .onTapGesture {
                                stepToShow = StepOfView.info
                            }
                        Spacer()
                        Text("Stats")
                            .fontWeight(stepToShow == StepOfView.stats ? .bold : .light)
                            .onTapGesture {
                                stepToShow = StepOfView.stats
                            }
                        Spacer()
                        Text("moves")
                            .fontWeight(stepToShow == StepOfView.moves ? .bold : .light)
                            .onTapGesture {
                                stepToShow = StepOfView.moves
                            }
                        Spacer()
                        Text("Abilities")
                            .fontWeight(stepToShow == StepOfView.abilities ? .bold : .light)
                            .onTapGesture {
                                stepToShow = StepOfView.abilities
                            }
                        Spacer()
                    }.foregroundColor(Color("myblue")).font(.title3).padding(.top, 80)
                    
                    switch(stepToShow){
                        case StepOfView.info: VStack{
                            ScrollView(.vertical){
                                VStack(spacing:10){
                                    Text("name: \(String(pokemonModel.pokemon?.name ?? ""))").frame(maxWidth: .infinity ,alignment: .leading)
                                    Text("weight: \(String(pokemonModel.pokemon?.weight ?? 0))").frame(maxWidth: .infinity ,alignment: .leading)
                                    Text("height: \(String(pokemonModel.pokemon?.height ?? 0))").frame(maxWidth: .infinity ,alignment: .leading)
                                    Text("height: \(pokemonModel.pokemon?.species.name ?? "")").frame(maxWidth: .infinity ,alignment: .leading)
                                    Text("base experience: \(String(pokemonModel.pokemon?.base_experience ?? 0))").frame(maxWidth: .infinity ,alignment: .leading)
                                }.padding([.bottom, .horizontal])
                            }.foregroundColor(Color("myblue"))
                        }
                        case StepOfView.abilities: VStack{
                            ScrollView(.vertical){
                                ForEach(pokemonModel.pokemon?.abilities ?? [], id:\.self){ abilities in
                                    VStack{
                                        Text("ability name: \(abilities.ability.name )").frame(maxWidth: .infinity ,alignment: .leading)
                                        Text("ability slot: \(abilities.slot )").frame(maxWidth: .infinity ,alignment: .leading)
                                        
                                    }.padding([.bottom, .horizontal])
                                }
                            }.foregroundColor(Color("myblue"))
                        }
                        case StepOfView.stats: VStack{
                            ScrollView(.vertical){
                                ForEach(pokemonModel.pokemon?.stats ?? [], id:\.self){ stat in
                                    VStack{
                                        HStack{
                                            Text("base stat: \(stat.base_stat)")
                                            ZStack(alignment: .leading){
                                                RoundedRectangle(cornerRadius: 20)
                                                    .foregroundColor(.gray)
                                                    .frame(width: 200, height: 10)
                                                
                                                RoundedRectangle(cornerRadius: 20)
                                                    .foregroundColor(Color("myblue"))
                                                    .frame(width: Double((200*stat.base_stat)/100), height: 10, alignment: .leading)
                                            }
                                        }.frame(maxWidth: .infinity ,alignment: .leading)
                                        
                                        Text("effort: \(String(stat.effort))").frame(maxWidth: .infinity ,alignment: .leading)
                                        Text("stat: \(stat.stat.name )").frame(maxWidth: .infinity ,alignment: .leading)
                                    }.padding([.bottom, .horizontal])
                                }
                            }.foregroundColor(Color("myblue"))
                        }
                        case StepOfView.moves: VStack{
                            ScrollView(.vertical){
                                ForEach(pokemonModel.pokemon?.moves ?? [], id:\.self){ move in
                                    VStack{
                                        Text("move: \(move.move.name )").frame(maxWidth: .infinity ,alignment: .leading)
                                        
                                        ForEach(move.version_group_details, id:\.self){ version_group_details in
                                            VStack{
                                                Text("level learned at: \(version_group_details.level_learned_at )").frame(maxWidth: .infinity ,alignment: .leading)
                                                Text("move learn_method name: \(version_group_details.move_learn_method.name )").frame(maxWidth: .infinity ,alignment: .leading)
                                                Text("version group name: \(version_group_details.version_group.name )").frame(maxWidth: .infinity ,alignment: .leading)
                                            }.padding([.top,.horizontal], 10)
                                        }
                                        
                                    }.padding([.bottom, .horizontal])
                                }
                            }.foregroundColor(Color("myblue"))
                        }
                    }
                    
                }.frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .top
                ).background(Color("goldColor"))
                    .cornerRadius(30).padding(.top,100)
            }.padding(.top,90)
                .alert("\(pokemonModel.error.message)", isPresented: $pokemonModel.error.isShowin) {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Reintentar")
                    })
                }
            
            //imagen superpuesta
            TabView {
                //imagen 1
                VStack{
                    AsyncImage(url: URL(string: pokemonModel.pokemon?.sprites.front_default ?? "")) { image in
                        image.resizable().frame(height: 200)
                    } placeholder: {
                        Loader().frame(width:100,height: 100).offset( y: 30)
                    }.frame(height: 250)
                }
                //imagen 2
                VStack{
                    AsyncImage(url: URL(string: pokemonModel.pokemon?.sprites.back_default ?? "")) { image in
                        image.resizable().frame(height: 200)
                    } placeholder: {
                        Loader().frame(width:100,height: 100).offset( y: 30)
                    }.frame(height: 250)
                }
            }.tabViewStyle(PageTabViewStyle()).frame(height: 250).padding(.top,80)
            
            //buttons share and like
            VStack(){
                Button(action: {
                    !isPokemonFavorite() ? pokemonListObject.addPokemonFavorite(pokemon: pokemonModel.pokemon!) : pokemonListObject.removePokemonFavorite(pokemon: pokemonModel.pokemon!)
                    isFavorite.toggle()
                }, label: {
                    Image(systemName: isPokemonFavorite() ? "heart.fill" :"heart").resizable().frame(width: 30, height: 30).foregroundColor(Color("goldColor"))
                })
                Button(action: {
                    shareButton()
                }, label: {
                    Image(systemName:"square.and.arrow.up").resizable().frame(width: 30, height: 30).foregroundColor(Color("goldColor"))
                })
            }.padding(.horizontal).frame(maxWidth: .infinity, alignment: .trailing).padding(.top, 150)
            
            //custom button back
            VStack(){
                Button(action: {
                    self.pokemonModel.pokemon = nil
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 35, height: 25)
                        .foregroundColor(Color("goldColor"))
                })
            }.padding(.horizontal).frame(maxWidth: .infinity, alignment: .leading).padding(.top, 50)
            
        }.onAppear(perform: {
            pokemonModel.getPokemon(url: url)
        }).ignoresSafeArea().animation(.linear(duration: 0.7))
        
    }
}

struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView(pokemonModel: PokemonModel(), pokemonListObject: PokemonListModelView(),  url: "https://pokeapi.co/api/v2/pokemon/20" )
    }
}
