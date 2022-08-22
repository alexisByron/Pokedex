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
    @StateObject var pokemonModel: PokemonModel = PokemonModel()
    @State var isFavorite:Bool = false
    @State var stepToShow:StepOfView = StepOfView.stats
    var url: String
    
    var body: some View {
        ZStack(alignment: .top){
            Color("myblue")
            
            HStack{
                Image("pokeball").resizable().frame(width: 250, height: 250).rotationEffect(.degrees(30))
            }.frame(maxWidth: .infinity, alignment: .trailing).offset(x: 30)
            
            VStack{
                HStack{
                    Text(pokemonModel.pokemon?.name ?? "").font(.title).fontWeight(.bold)
                    Spacer()
                    Text("#\(String(pokemonModel.pokemon?.order ?? 0))").font(.title).fontWeight(.bold)
                }.padding(.horizontal).foregroundColor(Color("goldColor"))
          
                //Details
                VStack{
                    ScrollView(.horizontal){
                        HStack(spacing:10){
                            Spacer()
                            Text("info")
                                .fontWeight(stepToShow == StepOfView.info ? .bold : .light)
                                .onTapGesture {
                                    stepToShow = StepOfView.info
                                }
                            Spacer()
                            Text("stats")
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
                            Text("abilities")
                                .fontWeight(stepToShow == StepOfView.abilities ? .bold : .light)
                                .onTapGesture {
                                    stepToShow = StepOfView.abilities
                                }
                            Spacer()
                        }.foregroundColor(Color("myblue")).font(.title3)
                    }.padding(.top, 100)
                    
                    
                    switch(stepToShow){
                        case StepOfView.info: VStack{
                            ScrollView(.vertical){
                                VStack{
                                    Text("name: \(String(pokemonModel.pokemon?.name ?? ""))").frame(maxWidth: .infinity ,alignment: .leading)
                                    Text("weight: \(String(pokemonModel.pokemon?.weight ?? 0))").frame(maxWidth: .infinity ,alignment: .leading)
                                    Text("base_experience: \(String(pokemonModel.pokemon?.base_experience ?? 0))").frame(maxWidth: .infinity ,alignment: .leading)
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
                                        Text("base_stat: \(String(stat.base_stat ))").frame(maxWidth: .infinity ,alignment: .leading)
                                        Text("effort: \(String(stat.effort ))").frame(maxWidth: .infinity ,alignment: .leading)
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
                                                Text("level_learned_at: \(version_group_details.level_learned_at )").frame(maxWidth: .infinity ,alignment: .leading)
                                                Text("move_learn_method.name: \(version_group_details.move_learn_method.name )").frame(maxWidth: .infinity ,alignment: .leading)
                                                Text("version_group.name: \(version_group_details.version_group.name )").frame(maxWidth: .infinity ,alignment: .leading)
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
            
            //para que se vea por encima
            TabView {
                //imagen 1
                VStack{
                    AsyncImage(url: URL(string: pokemonModel.pokemon?.sprites.front_default ?? "")) { image in
                        image.resizable().frame(height: 200)
                    } placeholder: {
                        //TODO: reemplazar carga
                        ProgressView().tint(Color("myblue"))
                    }.frame(height: 250)
                }
                //imagen 2
                VStack{
                    AsyncImage(url: URL(string: pokemonModel.pokemon?.sprites.back_default ?? "")) { image in
                        image.resizable().frame(height: 250)
                    } placeholder: {
                        //TODO: reemplazar carga
                        ProgressView().tint(Color("myblue"))
                    }.frame(height: 250)
                }
            }.tabViewStyle(PageTabViewStyle()).frame(height: 250).padding(.top,60)
            
            //buttons share and like
            VStack(){
                Button(action: {
                    //TODO: agregar a lista de favoritos
                    print("set as favorite or not")
                    isFavorite.toggle()
                }, label: {
                    Image(systemName: isFavorite ? "heart.fill" :"heart").resizable().frame(width: 30, height: 30).foregroundColor(Color("goldColor"))
                })
                Button(action: {
                    //TODO: agregar a lista de favoritos
                    print("share")
                }, label: {
                    Image(systemName:"square.and.arrow.up").resizable().frame(width: 30, height: 30).foregroundColor(Color("goldColor"))
                })
            }.padding(.horizontal).frame(maxWidth: .infinity, alignment: .trailing).padding(.top, 150)
            
        }.onAppear(perform: {
            pokemonModel.getPokemon(url: url)
        }).ignoresSafeArea()
        
    }
}

struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView(url: "https://pokeapi.co/api/v2/pokemon/6")
    }
}
