//
//  Game.swift
//  Tic Tac Toe Dimensional
//
//  Created by Abigail Lau on 12/11/24.
//

import SwiftUI

// Define the Players enum
enum Players {
    case one, two
}

// Define the Game structure
struct Game {
    var layers: [[[Players?]]] // 3D array to represent 3x3x3 grid
    var currentPlayer: Players
    var winner: Players?
    var isGameOver: Bool

    init() {
        // Initialize the 3x3x3 grid with nil (empty cells)
        self.layers = Array(repeating: Array(repeating: Array(repeating: nil, count: 3), count: 3), count: 3)
        self.currentPlayer = .one
        self.winner = nil
        self.isGameOver = false
    }

    mutating func move(on layer: Int, row: Int, col: Int) -> Bool {
        // Ensure the move is within bounds and the cell is empty
        guard layer >= 0, layer < 3, row >= 0, row < 3, col >= 0, col < 3, layers[layer][row][col] == nil else {
            return false // Invalid move
        }

        // Make the move
        layers[layer][row][col] = currentPlayer
        
        // Check if the current layer has a winner
        if checkForWin(in: layer) {
            winner = currentPlayer
            isGameOver = true
            return true
        }

        // Check if the entire 3D grid is full (draw condition)
        if isFull() {
            isGameOver = true
            return true
        }

        // Switch player
        currentPlayer = (currentPlayer == .one) ? .two : .one
        return true
    }

    // Check for a win in a specific layer (2D grid)
    func checkForWin(in layer: Int) -> Bool {
        let board = layers[layer]

        // Check rows
        for row in 0..<3 {
            if let player = board[row][0], board[row][1] == player, board[row][2] == player {
                return true
            }
        }

        // Check columns
        for col in 0..<3 {
            if let player = board[0][col], board[1][col] == player, board[2][col] == player {
                return true
            }
        }

        // Check diagonals within the layer
        if let player = board[0][0], board[1][1] == player, board[2][2] == player {
            return true
        }
        if let player = board[0][2], board[1][1] == player, board[2][0] == player {
            return true
        }

        return false
    }

    // Check if the entire 3D grid is full (draw condition)
    func isFull() -> Bool {
        return !layers.flatMap { $0 }.contains { $0.contains { $0 == nil } }
    }
}

// Define the SwiftUI View for TicTacToe3D
struct TicTacToe3DView: View {
    @State private var game = Game()

    // Function to handle a move on a specific layer
    func handleMove(layer: Int, row: Int, col: Int) {
        if !game.isGameOver {
            if game.move(on: layer, row: row, col: col) {
                // Successfully made a move
            }
        }
    }

    // Helper function to display player markers
    func playerMarker(for layer: Int, row: Int, col: Int) -> String {
        if let player = game.layers[layer][row][col] {
            return player == .one ? "X" : "O"
        } else {
            return ""
        }
    }

    var body: some View {
        VStack {
            // Display the 3D Tic-Tac-Toe grid (stack of layers)
            VStack {
                ForEach(0..<3) { layer in
                    VStack {
                        Text("Layer \(layer + 1)")
                            .font(.title)
                            .padding()
                        ForEach(0..<3) { row in
                            HStack {
                                ForEach(0..<3) { col in
                                    Button(action: {
                                        self.handleMove(layer: layer, row: row, col: col)
                                    }) {
                                        Text(self.playerMarker(for: layer, row: row, col: col))
                                            .font(.system(size: 50))
                                            .frame(width: 80, height: 80)
                                            .background(Color.white)
                                            .cornerRadius(10)
                                            .border(Color.black, width: 1)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
            }

            // Game status (whose turn it is, and the winner if game over)
            if game.isGameOver {
                if let winner = game.winner {
                    Text("Player \(winner == .one ? "1" : "2") wins!")
                        .font(.largeTitle)
                        .foregroundColor(.green)
                } else {
                    Text("It's a draw!")
                        .font(.largeTitle)
                        .foregroundColor(.orange)
                }
            } else {
                Text("Player \(game.currentPlayer == .one ? "1" : "2")'s turn")
                    .font(.title)
            }
        }
        .padding()
    }
}


struct ActualGame: View {
    var body: some View {
        TicTacToe3DView()
    }
}

#Preview {
    TicTacToe3DView()
}
