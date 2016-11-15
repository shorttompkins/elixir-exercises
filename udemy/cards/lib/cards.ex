defmodule Cards do
  @moduledoc """
    The Cards module is used to generate a deck of playing cards as well as
    methods for handling a deck (i.e. shuffle, deal, load/save, etc.)
  """
  # To generate docs, at cli execute: $ mix docs

  @doc """
    Returns a list of strings representing a deck of playing cards
  """
  def create_deck do
    values = ["Ace", "Jack", "Queen", "King", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    # solution 1:
      # for value <- values do
      #   for suit <- suits do
      #     "#{value} of #{suit}"
      #   end
      # end |> List.flatten |> _shuffle

    # solution 2: (better!)
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
      iex> {hand, _deck} = Cards.deal(deck, 5)
      iex> Cards.contains?(hand, "Ace of Spades")
      true
      iex> Cards.contains?(hand, "Jack of Aces")
      false
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should be returned for
    the hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, _deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
  """
  def deal(deck, hand_size) do
    # returns a tuple { hand, rest_of_deck }
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      { :ok, binary } -> :erlang.binary_to_term(binary)
      { :error, _reason } -> "The file does not exist!"
    end
  end

  def create_hand(hand_size) do
    create_deck
    |> shuffle
    |> deal(hand_size)
  end

end
