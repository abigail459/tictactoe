//
//  ContentView.swift
//  Tic Tac Toe Dimensional
//
//  Created by Abigail Lau on 12/11/24.
//

import SwiftUI

struct Start: View {
    var body: some View {
        NavigationStack {
            
            ZStack {
                Rectangle()
                    .frame(height: 460)
                    .foregroundStyle(.primaryGreen)
                VStack {
                    Text("TIC TAC TOE")
                        .font(.title)
                        .foregroundStyle(Color.white)
                        .bold()
                    Text("Dimentional")
                        .font(.custom("e", size: 65.0))
                        .foregroundStyle(Color.white)

                    
                    Spacer()
                        .frame(height: 60)
                    NavigationLink(destination: Game()) {
                        ZStack {
                            Rectangle()
                                .frame(width: 150, height: 145)
                                .tint(Color.white)
                            Image(systemName: "play.fill")
                                .resizable()
                                .frame(width: 50, height: 55)
                                .tint(.primaryGreen)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    Start()
}
