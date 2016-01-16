require 'pry'

#Rule 1:
#If a word begins with a vowel sound, add an "ay" sound to the end of the word.

#Rule 2:
# If a word begins with a consonant sound, move it to the end of the word,
# and then add an "ay" sound to the end of the word.

class PigLatin
  VOWEL_SOUNDS = %w(a e i o u xr yt)
  ODD_SOUNDS = %w(ch qu thr th sch)
  SUFFIX = 'ay'


  def self.translate(str)
    word_arr = []
    str.split.each { |word| word_arr << translate_word(word) }
    word_arr.join(' ')
  end

  private

  def self.translate_word(str)
    str = move_first_sound_to_end(str) unless start_with_vowel?(str)
    str = move_first_sound_to_end(str) if start_with_qu?(str)
    str += SUFFIX
  end

  def self.start_with_vowel?(str)
    VOWEL_SOUNDS.each do |vowel|
      return true if str.start_with?(vowel)
    end
    false
  end

  def self.start_with_qu?(str)
    str.start_with?('qu')
  end

  def self.start_with_odd_sound?(str)
    ODD_SOUNDS.each do |odd|
      return true if str.start_with?(odd)
    end
    false
  end

  def self.split(str)
    str.split(//)
  end

  def self.move_first_sound_to_end(str)
    return move_odd_sound_to_end(str) if start_with_odd_sound?(str)
    return str if start_with_vowel?(str)
    move_first_letter_to_end(str)
  end

  def self.move_first_letter_to_end(str)
    arr = split(str)
    first_letter = arr.shift
    arr.join + first_letter
  end

  def self.move_odd_sound_to_end(str)
    ODD_SOUNDS.each do |odd|
      if str.start_with?(odd)
        arr = split(str)
        odd.size.times { arr.shift }
        return arr.join + odd
      end
    end
  end
end
