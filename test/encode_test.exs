defmodule RLP.EncodeTest do
    use ExUnit.Case
    
    @table_tests [
        {"dog",<<0x83,"d","o","g">>}
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
        |> Enum.map(fn {payload,result} -> RLP.Encode.encode(payload) == result  end)
        |> Enum.all?
        |> assert
    end

    test "encode the set theoritical representation of 3" do
        RLP.Encode.encode [[], [[]], [ [], [[]] ]]
    end

    

end