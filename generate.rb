###
#  to run use:
#     ruby ./generate.rb


require 'pixelart'


PARTS = {
  background:  { required: true,
                  attributes: [['Yellow', 0.1],
                              ['Purple', 0.1],
                              ['Olive', 0.1],
                              ['Grey', 0.1],
                              ['Turquoise', 0.1],
                              ['LightBlue', 0.1],
                              ['Navy', 0.1],
                              ['Tan', 0.1],
                              ['Orange', 0.1],
                              ['Grey', 0.1]] },
  face:  { required: true,
           attributes: [['Orange', 0.35],
                        ['White', 0.20],
                        ['Blue', 0.20],
                        ['Alien', 0.07],
                        ['Pink', 0.1],
                        ['Trippy', 0.01],
                        ['Zombie', 0.07]] },
  skin:  { required: true,
            attributes: [['Tan', 1.0]] },
  stripes:  { required: true,
            attributes: [['Black', 1.0]] },
  eyes:  { required: true,
           attributes: [['Normal', 0.35],
                        ['Bloodshot', 0.25],
                        ['Dead', 0.15],
                        ['Sleepy', 0.23],
                        ['Laser', 0.02]] },
  cheeks:  { required: false,
           attributes: [['Whiskered', 0.5],
                        ['Freckled', 0.5]] },
  mouth: { required: true,
            attributes: [['Smile', 0.32],
                          ['Tongue Out', 0.30],
                          ['Teeth', 0.10],
                          ['Mask', 0.08],
                          ['Vape', 0.04],
                          ['Cigarette', 0.03],
                          ['Blue Binkie', 0.06],
                          ['Pink Binkie', 0.06]] },
  clothes:  { required: false,
           attributes: [['Black Turtleneck', 0.06],
                        ['Blue Bandana', 0.03],
                        ['Camo Jacket', 0.05],
                        ['Green Turtleneck', 0.05],
                        ['Green Bandana', 0.03],
                        ['Red Bandana', 0.03],
                        ['Leather Jacket', 0.05],
                        ['Prison', 0.03],
                        ['Track Jacket', 0.05],
                        ['White Tee', 0.06],
                        ['Blue Jersey', 0.04],
                        ['Green Jersey', 0.04],
                        ['Grey Jersey', 0.04],
                        ['White Jersey', 0.04],
                        ['Yellow Jersey', 0.04],
                        ['Bow Tie', 0.02],
                        ['Navy Suit', 0.03],
                        ['Dress', 0.03],
                        ['Robe', 0.05],
                        ['Grey Suit', 0.03],
                        ['Flannel', 0.06],
                        ['Black Tee', 0.06],
                        ['Grey Tee', 0.05],
                        ['Safety Vest', 0.03]] },
  accessories: { required: false,
           attributes: [['3D Glasses', 0.7],
                      ['Blue Sunglasses', 0.05],
                      ['Eye Glasses', 0.12],
                      ['Eye Patch', 0.08],
                      ['Gold Chain', 0.9],
                      ['Ruby Earrings', 0.07],
                      ['Robber', 0.7],
                      ['Gold Choker', 0.07],
                      ['VR', 0.05],
                      ['Black Shades', 0.10],
                      ['Orange Lens Shades', 0.10],
                      ['Air Pods', 0.08],
                      ['Gold Hoop Earring', 0.05]] },
  hat:  { required: false,
           attributes: [['Baseball', 0.10],
                        ['Cowbot', 0.08],
                        ['Crown', 0.04],
                        ['Black Mohawk', 0.10],
                        ['Santa', 0.03],
                        ['Pink Mowhawk', 0.04],
                        ['Headband', 0.05],
                        ['Top', 0.11],
                        ['Blonde Mohawk', 0.06],
                        ['Brown Mohawk', 0.08],
                        ['Halo', 0.03],
                        ['Hard', 0.08],
                        ['Fez', 0.05],
                        ['Headphones', 0.06],
                        ['Spinny', 0.07]] }
 }

 $generatedStats = { }

def generate_tiger()
	tiger = Pixelart::Image.new( 56, 56 )

	PARTS.each_with_index do |(key,part),i|
		code  = rand()
		runningProbability = part[:attributes][ 0 ][1]
		for index in 0...PARTS[key][:attributes].size do
			if code <= runningProbability
				attribute = part[:attributes][ index ]
				puts "#{attribute[0]} #{key}"  if attribute[0].size > 0
		
				path = "./parts/#{key}/#{key}#{index+1}.png"
				part = Pixelart::Image.read( path )
				tiger.compose!( part )
				# find in map if not then add
				$generatedStats[attribute[0]] = 0.0 if $generatedStats[attribute[0]].nil? 
				$generatedStats[attribute[0]] += 1.0
				break
			end
			if index+1 < PARTS[key][:attributes].size
				runningProbability += part[:attributes][index+1][1]
			end
		end
	end

	tiger
end


count = 0
tokensToGenerate = 9999

# ensure no duplicates
while count < tokensToGenerate
	count += 1
	tiger = generate_tiger()
	tiger.save( "./tigers/tiger-#{count.to_s.rjust(4,'0')}.png" )

	puts "\n\n"

end

$generatedStats.each do |key,value|
	# percentage = $generatedStats[i][0] / tokensToGenerate
	puts "#{key}: #{(value / tokensToGenerate * 100.0).round(2)}%\t\t\t(#{value} total)\n"
end