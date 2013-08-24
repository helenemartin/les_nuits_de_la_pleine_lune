#
# Lunar/Moon phases ruby class
#
# Code is based upon Bradley E. Schaefer's moon phase algorithm.
# Ruby version based on JavaScript Phase Calculator by Stephen R. Schmitt
class Moon
  attr_reader :epoch, :phase, :days, :icon, :dist, :ll

  # Return the current (or input a date) moon.
  #   Moon.new
  #   Moon.new(some_day)
  #
  # Methods available:
  #   phase    => Phase of the moon as a sym
  #   days     => Moon days
  #   icon     => An integer from 0 to 29
  #   dist     => Distance in earth radii
  #   ll       => Moon ecliptic lat/lon
  #
  def initialize(epoch=Time.now)
    @epoch = epoch
    do_calc
  end

  def next_full_moon
    found = false

    #keep looping until found a full moon
    while not found
      #try tomorrow
      @epoch = @epoch + 1.day
      do_calc

      #is a full moon
      if phase == :full 
        found = true
      end
    end

    @epoch
  end

  def previous_full_moon
     found = false

    #keep looping until found a full moon
    while not found
      #try tomorrow
      @epoch = @epoch - 1.day
      do_calc

      #is a full moon
      if phase == :full 
        found = true
      end
    end

    @epoch


  end

  private

  def calc_phase(p)
    case p
    when 0       then :new
    when 1..6    then :waxing_crescent
    when 7..9    then :first_quarter
    when 10..12  then :waxing_gibbous
    when 13..16  then :full
    when 17..20  then :waning_gibbous
    when 21..24  then :last_quarter
    when 25..28  then :waning_crescent
    else :new
    end
  end

  def calc_coords(inter, phase)
    phase = phase * 2 * Math::PI
    dp = 2 * Math::PI * normalize((inter -  2451562.2 ) / 27.55454988)
    @dist = 60.4 - 3.3 * Math.cos(dp) - 0.6 * Math.cos(2 * phase - dp) - 0.5 * Math.cos(2 * phase)

    np = 2 * Math::PI * normalize((inter - 2451565.2) / 27.212220817)
    la = 5.1 * Math.sin(np)

    rp = normalize((inter - 2451555.8 ) / 27.321582241)
    lo = 360 * rp + 6.3 * Math.sin(dp) + 1.3 * Math.sin(2 * phase - dp) + 0.7 * Math.sin(2 * phase)
    @ll = [la, lo]
  end

  def do_calc
    c_phase = 29.530588853
    t_year = @epoch.year - ((12 - @epoch.month)/10).to_i
    t_month = (@epoch.month + 9) % 12

    t1 = (365.25 * (t_year + 4712)).to_i
    t2 = (30.6 * t_month + 0.5).to_i
    t3 = (((t_year / 100.0) + 49.0) * 0.75).to_i - 38
    inter = t1 + t2 + @epoch.day + 59
    inter -= t3 if inter > 2299160
    phase = normalize((inter - 2451550.1) / c_phase)
    res = phase * c_phase;

    @days  = (res * 100).to_i / 100
    @icon  = res.to_i % 30
    @phase = calc_phase(@icon)
    calc_coords(inter, phase)
  end

  def normalize(x)
    x %= 1
    x += 1 if x < 0
    x
  end

end
