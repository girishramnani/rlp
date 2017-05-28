defmodule RLP.Encode do
    use Bitwise

    @list 0xc0
    @string 0x80   
    @long_string 0xb7

    def encode("") do
        <<@string>> 
    end
    def encode([]) do
        <<@list>>
    end

    

    def encode(payload) when is_binary(payload) do

        <<byte, _::binary>> = payload 
        
        cond do
            (byte_size(payload) == 1) && Enum.member?(0x00..0x7f,byte) -> <<byte>>
            byte_size(payload) <= 55 ->  << @string + byte_size(payload) >> <> payload          
            byte_size(payload) > 55 -> 
                                    first_byte = int_to_binary(byte_size(payload))
                                    <<@long_string + byte_size(first_byte) >> <> first_byte <> payload     
        end
        
    end

    def int_to_binary(number) do
    
        number
        |> Integer.digits(256) 
        |> Enum.reduce(<<>>,
            fn (number,binary) -> binary <> <<number>> end
            )
    end


   
end