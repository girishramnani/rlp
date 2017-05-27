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
            byte_size(payload) < 56 ->  << @string + byte_size(payload) >> <> payload            
        end
        
    end
end