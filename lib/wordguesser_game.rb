# Homework for edX CS169.1x / SAAS hw-sinatra-saas-wordguesser.
# Implements the game model; app.rb (Sinatra wiring) is left untouched for
# the official specs plus the controller features already provided there.
class WordGuesserGame
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  attr_reader :word, :guesses, :wrong_guesses

  # 7 wrong guesses lose the game, per the HW spec.
  MAX_WRONG = 7

  def initialize(word)
    @word = word
    @word_letters = @word.split(//)
    @guesses = ''             # every guessed (correct) letter so far
    @wrong_guesses = ''       # every guessed (incorrect) letter so far
    @in_word = {}             # letter -> true, for O(1) letter membership
    @word_letters.each { |letter| @in_word[letter] = true }
  end

  # already_guessed?: check used letters, case-insensitively
  def already_guessed?(letter)
    letter = canonical_letter(letter)
    @guesses.include?(letter) || @wrong_guesses.include?(letter)
  end

  # guess a letter, moving through states; letters must be alphabetic,
  # single characters; returns true/false and never repeats an effect.
  def guess(letter)
    raise ArgumentError, 'no letter' if letter.nil? || !letter.is_a?(String)
    letter = letter.downcase
    raise ArgumentError, 'no letter' if letter.empty? || !letter.match?(/[[:alpha:]]/)

    # everything is case-insensitive
    return false if already_guessed?(letter)

    if @in_word[letter]
      @guesses += letter
    else
      @wrong_guesses += letter
    end
    true
  end

  # word with guesses revealed, non-guessed letters shown as dashes
  def word_with_guesses
    @word_letters.map { |letter| @guesses.include?(letter) ? letter : '-' }.join
  end

  # :win  – every letter in word has been correctly guessed
  # :lose – MAX_WRONG wrong guesses have been made
  # :play – otherwise
  def check_win_or_lose
    if @word_letters.all? { |letter| @guesses.include?(letter) }
      :win
    elsif @wrong_guesses.length >= MAX_WRONG
      :lose
    else
      :play
    end
  end

  private

  # Single-character alphabetics survive; everything else raises.
  def canonical_letter(letter)
    raise ArgumentError, 'no letter' if letter.nil? || !letter.is_a?(String)
    downcased = letter.downcase
    raise ArgumentError, 'no letter' if downcased.empty? || !downcased.match?(/[[:alpha:]]/)
    downcased
  end
end
