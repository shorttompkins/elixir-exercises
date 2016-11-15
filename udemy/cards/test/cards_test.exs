defmodule CardsTest do
  use ExUnit.Case
  doctest Cards # this will run sample code in the docs as tests
  # Note: check cards.ex to see a bunch of sample tests using doctest!

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "create_deck makes 52 cards" do
    deck_length = length(Cards.create_deck)
    assert deck_length === 52
  end

  test "shuffling a deck randomizes it" do
    deck = Cards.create_deck
    assert deck != Cards.shuffle(deck)
    # same thing just avoids negative operator:
    # refute deck == Cards.shuffle(deck)
  end
end
