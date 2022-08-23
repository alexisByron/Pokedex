//
//  Loader.swift
//  Pokedex
//
//  Created by Alexis Moya on 23-08-22.
//

import SwiftUI

struct Loader: View {
    @State var isRuning:Bool = false
    var body: some View {
        Image("loader").resizable()
            .rotationEffect(.degrees(isRuning ? 360 : 0))
            .animation(.easeInOut(duration: 1)
                .repeatCount(100, autoreverses: true))
            .onAppear(perform: {
                isRuning.toggle()
            })
    }
}

struct Loader_Previews: PreviewProvider {
    static var previews: some View {
        Loader()
    }
}
