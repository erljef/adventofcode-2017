defmodule Adventofcode2017Test do
  use ExUnit.Case
  doctest Adventofcode2017

  test "solves day 1 first captcha" do
    assert Day1.solve_captcha("1122") == 3
    assert Day1.solve_captcha("1111") == 4
    assert Day1.solve_captcha("1234") == 0
    assert Day1.solve_captcha("91212129") == 9
  end

  test "solves day 1 second captcha" do
    assert Day1.solve_captcha_2("1212") == 6
    assert Day1.solve_captcha_2("1221") == 0
    assert Day1.solve_captcha_2("123425") == 4
    assert Day1.solve_captcha_2("123123") == 12
    assert Day1.solve_captcha_2("12131415") == 4
  end
end
