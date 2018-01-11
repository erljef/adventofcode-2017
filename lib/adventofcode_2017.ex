defmodule Adventofcode2017 do
  @moduledoc """
  Documentation for Adventofcode2017.
  """

  def solutions do
    [
      &day1/0,
      &day2/0,
      &day3/0,
      &day4/0,
      &day5/0,
      &day6/0,
      &day7/0,
      &day8/0,
      &day9/0,
      &day10/0,
      &day11/0,
      &day12/0,
      &day13/0,
      &day14/0,
      &day15/0,
      &day16/0,
      &day17/0,
      &day18/0,
      &day19/0,
      &day20/0,
      &day21/0,
      &day22/0,
      &day23/0
    ]
    |> Enum.with_index(1)
    |> Enum.each(fn {f, day} -> {first, second} = f.(); IO.puts(~s"Day #{day}: #{first}, #{second}") end)
  end

  @doc """
  Day 1

  ## Examples

      iex> Adventofcode2017.day1
      {"Captcha 1: 1136", "Captcha 2: 1092"}
  """
  def day1 do
    {
      ~s"Captcha 1: #{
        Day1.solve_captcha(
          "5672987533353956199629683941564528646262567117433461547747793928322958646779832484689174151918261551689221756165598898428736782194511627829355718493723961323272136452517987471351381881946883528248611611258656199812998632682668749683588515362946994415852337196718476219162124978836537348924591957188827929753417884942133844664636969742547717228255739959316351852731598292529837885992781815131876183578461135791315287135243541659853734343376618419952776165544829717676988897684141328138348382882699672957866146524759879236555935723655326743713542931693477824289283542468639522271643257212833248165391957686226311246517978319253977276663825479144321155712866946255992634876158822855382331452649953283788863248192338245943966269197421474555779135168637263279579842885347152287275679811576594376535226167894981226866222987522415785244875882556414956724976341627123557214837873872723618395529735349273241686548287549763993653379539445435319698825465289817663294436458194867278623978745981799283789237555242728291337538498616929817268211698649236646127899982839523784837752863458819965485149812959121884771849954723259365778151788719941888128618552455879369919511319735525621198185634342538848462461833332917986297445388515717463168515123732455576143447454835849565757773325367469763383757677938748319968971312267871619951657267913817242485559771582167295794259441256284168356292785568858527184122231262465193612127961685513913835274823892596923786613299747347259254823531262185328274367529265868856512185135329652635938373266759964119863494798222245536758792389789818646655287856173534479551364115976811459677123592747375296313667253413698823655218254168196162883437389718167743871216373164865426458794239496224858971694877159591215772938396827435289734165853975267521291574436567193473814247981877735223376964125359992555885137816647382139596646856417424617847981855532914872251686719394341764324395254556782277426326331441981737557262581762412544849689472281645835957667217384334435391572985228286537574388834835693416821419655967456137395465649249256572866516984318344482684936625486311718525523265165"
        )
      }",
      ~s"Captcha 2: #{
        Day1.solve_captcha_2(
          "5672987533353956199629683941564528646262567117433461547747793928322958646779832484689174151918261551689221756165598898428736782194511627829355718493723961323272136452517987471351381881946883528248611611258656199812998632682668749683588515362946994415852337196718476219162124978836537348924591957188827929753417884942133844664636969742547717228255739959316351852731598292529837885992781815131876183578461135791315287135243541659853734343376618419952776165544829717676988897684141328138348382882699672957866146524759879236555935723655326743713542931693477824289283542468639522271643257212833248165391957686226311246517978319253977276663825479144321155712866946255992634876158822855382331452649953283788863248192338245943966269197421474555779135168637263279579842885347152287275679811576594376535226167894981226866222987522415785244875882556414956724976341627123557214837873872723618395529735349273241686548287549763993653379539445435319698825465289817663294436458194867278623978745981799283789237555242728291337538498616929817268211698649236646127899982839523784837752863458819965485149812959121884771849954723259365778151788719941888128618552455879369919511319735525621198185634342538848462461833332917986297445388515717463168515123732455576143447454835849565757773325367469763383757677938748319968971312267871619951657267913817242485559771582167295794259441256284168356292785568858527184122231262465193612127961685513913835274823892596923786613299747347259254823531262185328274367529265868856512185135329652635938373266759964119863494798222245536758792389789818646655287856173534479551364115976811459677123592747375296313667253413698823655218254168196162883437389718167743871216373164865426458794239496224858971694877159591215772938396827435289734165853975267521291574436567193473814247981877735223376964125359992555885137816647382139596646856417424617847981855532914872251686719394341764324395254556782277426326331441981737557262581762412544849689472281645835957667217384334435391572985228286537574388834835693416821419655967456137395465649249256572866516984318344482684936625486311718525523265165"
        )
      }"
    }
  end

  def day2 do
    {
      ~s"Checksum 1: #{
        Day2.checksum(
          """
          737	1866	1565	1452	1908	1874	232	1928	201	241	922	281	1651	1740	1012	1001
          339	581	41	127	331	133	51	131	129	95	499	527	518	435	508	494
          1014	575	1166	259	152	631	1152	1010	182	943	163	158	1037	1108	1092	887
          56	491	409	1263	1535	41	1431	1207	1393	700	1133	53	131	466	202	62
          632	403	118	352	253	672	711	135	116	665	724	780	159	133	90	100
          1580	85	1786	1613	1479	100	94	1856	546	76	1687	1769	1284	1422	1909	1548
          479	356	122	372	786	1853	979	116	530	123	1751	887	109	1997	160	1960
          446	771	72	728	109	369	300	746	86	910	566	792	616	84	338	57
          6599	2182	200	2097	4146	7155	7018	1815	1173	4695	201	7808	242	3627	222	7266
          1729	600	651	165	1780	2160	626	1215	149	179	1937	1423	156	129	634	458
          1378	121	146	437	1925	2692	130	557	2374	2538	2920	2791	156	317	139	541
          1631	176	1947	259	2014	153	268	752	2255	347	227	2270	2278	544	2379	349
          184	314	178	242	145	410	257	342	183	106	302	320	288	151	449	127
          175	5396	1852	4565	4775	665	4227	171	4887	181	2098	4408	2211	3884	2482	158
          1717	3629	244	258	281	3635	235	4148	3723	4272	3589	4557	4334	4145	3117	4510
          55	258	363	116	319	49	212	44	303	349	327	330	316	297	313	67
          """
        )
      }",
      ~s"Evenly divisable 1: #{
        Day2.evenly_divisable(
          """
          737	1866	1565	1452	1908	1874	232	1928	201	241	922	281	1651	1740	1012	1001
          339	581	41	127	331	133	51	131	129	95	499	527	518	435	508	494
          1014	575	1166	259	152	631	1152	1010	182	943	163	158	1037	1108	1092	887
          56	491	409	1263	1535	41	1431	1207	1393	700	1133	53	131	466	202	62
          632	403	118	352	253	672	711	135	116	665	724	780	159	133	90	100
          1580	85	1786	1613	1479	100	94	1856	546	76	1687	1769	1284	1422	1909	1548
          479	356	122	372	786	1853	979	116	530	123	1751	887	109	1997	160	1960
          446	771	72	728	109	369	300	746	86	910	566	792	616	84	338	57
          6599	2182	200	2097	4146	7155	7018	1815	1173	4695	201	7808	242	3627	222	7266
          1729	600	651	165	1780	2160	626	1215	149	179	1937	1423	156	129	634	458
          1378	121	146	437	1925	2692	130	557	2374	2538	2920	2791	156	317	139	541
          1631	176	1947	259	2014	153	268	752	2255	347	227	2270	2278	544	2379	349
          184	314	178	242	145	410	257	342	183	106	302	320	288	151	449	127
          175	5396	1852	4565	4775	665	4227	171	4887	181	2098	4408	2211	3884	2482	158
          1717	3629	244	258	281	3635	235	4148	3723	4272	3589	4557	4334	4145	3117	4510
          55	258	363	116	319	49	212	44	303	349	327	330	316	297	313	67
          """
        )
      }"
    }
  end

  def day3 do
    value = Day3.spiral_values
            |> Stream.drop_while(fn x -> x <= 368078 end)
            |> Stream.take(1)
            |> Enum.to_list
            |> hd
    {~s"Distance 1: #{Day3.distance(368078)}", ~s"Value after 368078: #{value}"}
  end

  def day4 do
    {
      ~s"Valid without duplicate: #{Day4.validate_file("day4_input.txt", &Day4.validate_no_duplicates/1)}",
      ~s"Valid without anagrams: #{Day4.validate_file("day4_input.txt", &Day4.validate_no_anagrams/1)}"
    }
  end

  def day5 do
    input = Day5.read_file("day5_input.txt")
    {
      ~s"Steps: #{Day5.traverse(input)}",
      ""
    }
  end

  def day6 do
    input = Day6.read_file("day6_input.txt")
    {
      ~s"Redistributions: #{Day6.redistributions(input)}",
      ~s"Cycles: #{Day6.cycles(input)}"
    }
  end

  def day7 do
    input = Day7.read_file("day7_input.txt")
    root = Day7.find_root(input)[:name]
    correct_weight = Day7.find_unbalanced(input)
    {
      ~s"Parent: #{root}",
      ~s"Weight: #{correct_weight}"
    }
  end

  def day8 do
    input = Day8.read_file("day8_input.txt")
    registers = Day8.process(input)
    {
      ~s"Max: #{registers |> Day8.max_value}",
      ~s"Highest: #{registers |> Day8.highest_value}"
    }
  end

  def day9 do
    input = Day9.read_file("day9_input.txt")
    {
      ~s"Score: #{Day9.score(input)}",
      ~s"Garbage: #{Day9.garbage(input)}"
    }
  end

  def day10 do
    input = 0..255 |> Enum.to_list
    lengths = Day10.read_file("day10_input.txt")
    {
      ~s"Hash: #{Day10.hash(input, Day10.to_integers(lengths))}",
      ~s"Knot Hash: #{Day10.knot_hash(lengths)}"
    }
  end

  def day11 do
    input = Day11.read_file("day11_input.txt") |> Day11.to_directions
    {
      ~s"Steps to destination: #{Day11.steps(input)}",
      ~s"Steps to furthest point: #{Day11.furthest(input)}"
    }
  end

  def day12 do
    input = Day12.read_file("day12_input.txt")
    {
      ~s"Groups connected to 0: #{Day12.contains_group(input, 0)}",
      ~s"Total groups: #{Day12.total_groups(input)}"
    }
  end

  def day13 do
    input = Day13.read_file("day13_input.txt")
    {
      ~s"Severity: #{Day13.severity(input)}",
      ~s"Minimum delay: #{Day13.delay(input)}"
    }
  end

  def day14 do
    grid = Day14.grid("xlqgujun")
    coordinates = grid |> Day14.coordinates
    {
      ~s"Used squares: #{Day14.used_squares(grid)}",
      ~s"Regions: #{Day14.regions(coordinates)}"
    }
  end

  def day15 do
    {
      ~s"Pairs: #{Day15.count_pairs(703, 516)}",
      ~s"Pairs 2: #{Day15.count_pairs_multiples(703, 516)}"
    }
  end

  def day16 do
    list = "abcdefghijklmnop" |> String.graphemes
    instructions = Day16.read_file("day16_input.txt") |> Day16.to_instructions
    {
      ~s"Order: #{Day16.process_instructions(list, instructions) |> Enum.join}",
      ~s"Order 2: #{Day16.process_instructions(list, instructions, 1000000000) |> elem(0) |> Enum.join}"
    }
  end

  def day17 do
    {
      ~s"Value after 2017: #{Day17.fill(382)}",
      ~s"Value after 0: #{Day17.fill2(382)}"
    }
  end

  def day18 do
    {
      ~s"Recovered value: #{Day18.process_file("day18_input.txt")}",
      ~s"Process 1 sent: #{Day18.run("day18_input.txt")}"
    }
  end

  def day19 do
    map = Day19.read_file("day19_input.txt")
    {chars, steps} = Day19.traverse(map)
    {
      ~s"Characters: #{chars}",
      ~s"Steps: #{steps}"
    }
  end

  def day20 do
    particles = Day20.read_file("day20_input.txt")
    Day20.particles_left(particles, 1000)
    {_, index} = Day20.tick(particles, 1000)
    {
      ~s"Closest: #{index}",
      ~s"Particles left: #{Day20.particles_left(particles, 1000)}"
    }
  end

  def day21 do
    {
      ~s"Pixels after 5 iterations: #{Day21.pixels("day21_input.txt", 5)}",
      ~s"Pixels after 18 iterations: #{Day21.pixels("day21_input.txt", 18)}"
    }
  end

  def day22 do
    map = Day22.read_file("day22_input.txt")
    {
      ~s"Infections after 10000 steps: #{Day22.caused_infection(map, 10000)}",
      ~s"Infections after 10000000 steps: #{Day22.caused_infection_part2(map, 10000000)}",
    }
  end

  def day23 do
    %{:mul_invoked => invocations} = Day23.run("day23_input.txt")
    {
      ~s"mul is invoked #{invocations} times",
      ~s"h has the value: #{Day23.run_2()}",
    }
  end
end
