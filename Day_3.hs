import Data.List

manhattanDistance :: (Int, Int) -> (Int, Int) -> Int
manhattanDistance coordinateA coordinateB = abs (fst coordinateA - fst coordinateB) + abs (snd coordinateA - snd coordinateB)

interpolate' :: Int -> Int -> Double -> Int
interpolate' start goal t = round $ (1.0 - t) * (fromIntegral start) + t * (fromIntegral goal)

interpolate :: Int -> Int -> Int -> Int -> [Int]
interpolate start goal distance t = 
    if t < distance 
        then (interpolate' start goal ((fromIntegral t) / (fromIntegral distance))) : interpolate start goal distance (t+1) 
        else 
            []

interpolateCoordinates :: (Int, Int) -> (Int, Int) -> [(Int, Int)]
interpolateCoordinates coordinateA coordinateB = zip xValues yValues
    where
        distance = (manhattanDistance coordinateA coordinateB)
        xValues = interpolate (fst coordinateA) (fst coordinateB) distance 1
        yValues = interpolate (snd coordinateA) (snd coordinateB) distance 1

convertToCoordinates' :: [String] -> (Int, Int) -> [(Int, Int)]
convertToCoordinates' [] _ = []
convertToCoordinates' (x:xs) previousCoordinate = previousCoordinate : interpolateCoordinates previousCoordinate newCoordinate ++ convertToCoordinates' xs newCoordinate
    where
        direction = head x
        newCoordinate = case direction of
            'U' -> (fst previousCoordinate, snd previousCoordinate + read (tail x) :: Int)
            'D' -> (fst previousCoordinate, snd previousCoordinate - read (tail x) :: Int)
            'L' -> (fst previousCoordinate - read (tail x) :: Int, snd previousCoordinate)
            'R' -> (fst previousCoordinate + read (tail x) :: Int, snd previousCoordinate)

convertToCoordinates :: [String] -> [(Int, Int)]
convertToCoordinates wire = convertToCoordinates' wire (1,1)

findShortestManhattanDistance :: [[String]] -> Int
findShortestManhattanDistance wires = minimum $ (map (\x -> manhattanDistance (1,1) x) (tail $ intersect (convertToCoordinates (head wires)) (convertToCoordinates (last wires))))

countSteps :: [(Int, Int)] -> (Int, Int) -> Int
countSteps wire target = length $ takeWhile (\x -> not (elem x [target])) wire

findFewestSteps :: [[String]] -> Int
findFewestSteps wires = minimum $ [ x+y | (x,y) <- (zip wireASteps wireBSteps)]
    where
        wireA = convertToCoordinates (head wires)
        wireB = convertToCoordinates (last wires)
        intersections = tail $ intersect wireA wireB
        wireASteps = [countSteps wireA x | x <-intersections]
        wireBSteps = [countSteps wireB x | x <-intersections]