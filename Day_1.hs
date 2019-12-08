calcFuelForMass :: Integer -> Integer
calcFuelForMass mass
    | fuelRequired - 2 > 2 = fuelRequired + (calcFuelForMass fuelRequired)
    | fuelRequired <= 0 = 0
    | otherwise = fuelRequired
    where
        fuelRequired = divideByThreeAndFloor mass - 2

divideByThreeAndFloor :: Integer -> Integer
divideByThreeAndFloor num = floor $ ((fromIntegral num) / 3)

calcFuelForMasses :: [Integer] -> Integer
calcFuelForMasses [] = 0
calcFuelForMasses (x:xs) = calcFuelForMass x + calcFuelForMasses xs
