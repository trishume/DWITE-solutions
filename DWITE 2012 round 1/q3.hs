import Data.List
parseInput :: String -> [[String]]
parseInput = map (words) . lines

compute d = reverse . snd $ foldl person ([],[]) d 
  where
    newConflicts costume costumes conflicts name =
      maybe conflicts (\_ -> name:conflicts) $ find (costume==) costumes
    person (costumes,conflicts) [name,costume] = 
      (costume : costumes,newConflicts costume costumes conflicts name)

answer [] = []
answer ([n]:rest) = (compute d) : (answer nextData)
  where
    num = (read n) :: Int
    (d,nextData) = splitAt num rest

main = do
  inputData <- readFile "DATA3.txt"
  let input = parseInput inputData
      answers = answer input
      answers' = unlines . map (\x -> if null x then "SPOOKY" else unwords x) $ answers
  writeFile "OUT3.txt" answers'
  
