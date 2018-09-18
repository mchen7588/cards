defmodule Cards do
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spade", "Clubs", "Heart", "Diamond"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, file_name) do
    binary = :erlang.term_to_binary(deck)
    File.write(file_name, binary)
  end

  def load(file) do
    # {status, binary} = File.read(file)
    
    # case status do
      #   :ok -> :erlang.binary_to_term binary
      #   :error -> "file not found"
    # end
    
    case File.read(file) do
        {:ok, binary} -> :erlang.binary_to_term binary
        {:error, _reason} -> "file not found"
    end
  end

  def deal_hand(deck, hand_size) do
    deck
      |> Cards.shuffle
      |> Cards.deal(hand_size)
  end
end
