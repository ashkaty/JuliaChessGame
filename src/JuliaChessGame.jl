module JuliaChessGame

abstract type chessPiece end

mutable struct Player 
    color:: String
    pieces::Array{chessPiece}
    isTurn:: Bool
end

mutable struct  King <: chessPiece
    position::Tuple{Int,Int}
end

mutable struct Queen <: chessPiece
    position::Tuple{Int,Int}
end

mutable struct Rook <: chessPiece
    position::Tuple{Int,Int}
end

mutable struct Bishop <: chessPiece
    position::Tuple{Int,Int}
end

mutable struct Knight <: chessPiece
    position::Tuple{Int,Int}
end

mutable struct Pawn <: chessPiece
    position::Tuple{Int,Int}

end

#i think this is how you do type alias


# None of the movePiece takes into account moves that push the piece outside of the board for some of the positions
function movePiece(piece::King, newPosition::Tuple{Int,Int})
    validMoves = [(piece.position[1] + 1, piece.position[2]), (piece.position[1], piece.position[2] + 1), (piece.position[1] - 1, piece.position[2]), (piece.position[1], piece.position[2] - 1), (piece.position[1] + 1, piece.position[2] + 1), (piece.position[1] - 1, piece.position[2] - 1), (piece.position[1] + 1, piece.position[2] - 1), (piece.position[1] - 1, piece.position[2] + 1)]
    if newPosition in validMoves
        piece.position = newPosition
    end
end

function movePiece(piece::Queen, newPosition::Tuple{Int,Int})
    validMoves = [] 

    for i in 1:8
        if i != piece.position[1]
            push!(validMoves, (i, piece.position[2]))
        end
        if i != piece.position[2]
            push!(validMoves, (piece.position[1], i))
        end
        push!(validMoves, (piece.position[1] + 1, piece.position[2] + 1))
        push!(validMoves, (piece.position[1] - 1, piece.position[2] + 1))
        push!(validMoves, (piece.position[1] + 1, piece.position[2] - 1))
        push!(validMoves, (piece.position[1] - 1, piece.position[2] - 1))

    end
    
    if newPosition in validMoves
        piece.position = newPosition
    end

end

function movePiece(piece::Bishop, newPosition::Tuple{Int,Int})
    validMoves = [] 
    for i in 1:8
        push!(validMoves, (piece.position[1] + 1, piece.position[2] + 1))
        push!(validMoves, (piece.position[1] - 1, piece.position[2] + 1))
        push!(validMoves, (piece.position[1] + 1, piece.position[2] - 1))
        push!(validMoves, (piece.position[1] - 1, piece.position[2] - 1))
    
    end
    if newPosition in validMoves
        piece.position = newPosition
    end
     
end

function movePiece(piece::Rook, newPosition::Tuple{Int,Int})
    validMoves = [] 
    for i in 1:8
        if i != piece.position[1]
            push!(validMoves, (i, piece.position[2]))
        end
        if i != piece.position[2]
            push!(validMoves, (piece.position[1], i))
        end
    end  

    if newPosition in validMoves
        piece.position = newPosition
    end
end


function movePiece(piece::Knight, newPosition::Tuple{Int,Int})
    validMoves = [(piece.position[1] + 2, piece.position[2] + 1), (piece.position[1] + 2, piece.position[2] - 1), (piece.position[1] - 2, piece.position[2] + 1), (piece.position[1] - 2, piece.position[2] - 1)]
    if newPosition in validMoves
        piece.position = newPosition
    end
end

function movePiece(piece::Pawn, newPosition::Tuple{Int, Int}, opponent::Player)
    validMoves = [(piece.position[1] + 1, piece.position[2])]
    for i in opponent.pieces
        if (piece.position[1] + 1, piece.position[2] + 1) == i.position
            push!(validMoves, (piece.position[1] + 1, piece.position[2] + 1))
        end
            if (piece.position[1] + 1, piece.position[2] - 1) == i.position
            push!(validMoves, (piece.position[1] + 1, piece.position[2] - 1))
        end
    end
    if newPosition in validMoves
        piece.position = newPosition
    end
end

function switchTurn(player::Player)
    player.isTurn = !player.isTurn
end


end # module JuliaChessGame
