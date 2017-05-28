defmodule RLP.EncodeTest do
    use ExUnit.Case
    
    @table_tests [
        {"dog",<<0x83,"d","o","g">>},
        {"this world has lot of good blockchain developers in them",
        <<0xb8,56,"t", "h", "i", "s", " ", "w", "o", "r", "l", "d", " ", "h", "a", "s", " ", "l", "o", "t", " ", "o", "f", " ", "g", "o", "o", "d", " ", "b", "l", "o", "c", "k", "c", "h", "a", "i", "n", " ", "d", "e", "v", "e", "l", "o", "p", "e", "r", "s", " ", "i", "n", " ", "t", "h", "e", "m">>}
    ]

    test "encode an empty string" do
         assert RLP.Encode.encode("") == <<0x80>>
    end

    test "encode an empty list" do
        assert RLP.Encode.encode([]) == <<0xc0>>
    end

    test "encode an empty binary" do
        assert RLP.Encode.encode(<<>>) == <<0x80>>
    end

    test "encode different strings" do
        @table_tests
        |> Enum.map(fn {payload,result} -> RLP.Encode.encode(payload) == result end)
        |> Enum.all?
        |> assert
    end


    test "integer to binary list conversion" do
        assert RLP.Encode.int_to_binary(1024) == <<4,0>>
        assert RLP.Encode.int_to_binary(1234) == <<4,210>>
        assert RLP.Encode.int_to_binary(123411) == <<1, 226, 19>>
    end

    

end