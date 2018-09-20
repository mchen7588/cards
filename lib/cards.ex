defmodule Cards do
  @moduledoc """
    provides functions for creating and handling a deck of cards
  """

  @doc """
    Returns a list of strings that represent a new unshuffled deck of cards
  """
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


  @doc """
    Determines whether a deck contains a given card

  ## Examples
      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spade")
      true

      iex> Cards.contains?(deck, "Ace of Spa")
      false
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divide the deck into a tuple consisting of 2 lists of strings. 
    The first list is the hand, size is determined by the `hand_size` argument. 
    The second list is the remaining deck

  ## Examples
  
      iex> deck = Cards.create_deck
      iex> {hand, remaining_deck} = Cards.deal(deck, 3)
      iex> hand
      ["Ace of Spade", "Two of Spade", "Three of Spade"]
  """
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
